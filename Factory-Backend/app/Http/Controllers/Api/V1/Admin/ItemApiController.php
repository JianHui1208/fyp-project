<?php

namespace App\Http\Controllers\Api\V1\Admin;

use App\Http\Controllers\BaseController;
use App\Http\Controllers\Controller;
use App\Models\StockHistory;
use App\Models\Item;
use App\Http\Requests\ApiRequests\StoreItemApiRequest;
use App\Http\Requests\ApiRequests\UpdateItemApiRequest;
use App\Models\ItemCategory;
use Carbon\Carbon;
use Illuminate\Support\Facades\Log;
use Illuminate\Support\Facades\DB;
use Exception;
use Illuminate\Http\Request;

class ItemApiController extends BaseController
{
    /**
     * Display a listing of the resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function index()
    {
        $items = Item::with(['item_category', 'image'])->get();

        return parent::resFormat(1102, null, ['items' => $items]);
    }

    /**
     * Store a newly created resource in storage.
     *
     * @param  \App\Http\Requests\ApiRequests\StoreItemApiRequest  $request
     * @return \Illuminate\Http\Response
     */
    public function store(StoreItemApiRequest $request)
    {
        DB::beginTransaction();

        try {
            $request['uid'] = $this->generateUID('ITEM', 4);
            Item::create($request->all());

            DB::commit();
            return parent::resFormat(1101);
        } catch (Exception $e) {
            DB::rollBack();
            Log::channel("api")->error("Item Store 出错", ["request" => $request->validated(), 'error' => $e->getMessage()]);
            return parent::error();
        }
    }

    /**
     * Display the specified resource.
     *
     * @param  \App\Models\Item  $item
     * @return \Illuminate\Http\Response
     */
    public function show($id)
    {
        $item = Item::with(['item_category', 'image'])->where('id', $id)->first();

        if ($item->image) {
            $item['image_url'] = $item->image->document->url ?? null;
            $item['image_thumbnail'] = $item->image->document->thumbnail ?? null;
            $item['image_preview'] = $item->image->document->preview ?? null;
        }

        $item->makeHidden([
            'image', 'media'
        ]);

        return parent::resFormat(1103, null, ['item' => $item]);
    }

    /**
     * Update the specified resource in storage.
     *
     * @param  \App\Http\Requests\ApiRequests\UpdateItemApiRequest  $request
     * @param  \App\Models\Item  $item
     * @return \Illuminate\Http\Response
     */
    public function update(UpdateItemApiRequest $request, $id)
    {
        DB::beginTransaction();

        try {
            $item = Item::where('id', $id)->first();
            $item->update($request->all());

            DB::commit();
            return parent::resFormat(1104);
        } catch (Exception $e) {
            DB::rollBack();
            Log::channel("api")->error("Item Update 出错", ["request" => $request->validated(), 'error' => $e->getMessage()]);
            return parent::error();
        }
    }

    /**
     * Remove the specified resource from storage.
     *
     * @param  \App\Models\Item  $item
     * @return \Illuminate\Http\Response
     */
    public function destroy($id)
    {
        Item::where('id', $id)->delete();
        return parent::resFormat(1105);
    }

    /**
     * Active the specified resource from storage.
     *
     * @param  \App\Models\Item  $item
     * @return \Illuminate\Http\Response
     */
    public function activeItem($id)
    {
        DB::beginTransaction();
        try {
            $item = Item::where('id', $id)->first();
            $data = ['status' => 1];

            if ($item->status) {
                $data = ['status' => 0];
            }

            $item->update($data);
            DB::commit();
            return parent::resFormat(1106);
        } catch (Exception $e) {
            DB::rollback();
            Log::channel("api")->error("Active Item Function Error", ["id" => $id, 'error' => $e->getMessage()]);
            return parent::resFormat(-1);
        }
    }

    public function searchItem(Request $request)
    {
        // type 1: search by item category name and id
        // type 0: search by item name and barcode
        if ($request->type) {
            // search by the item category name
            $items = Item::with(['item_category', 'image'])
                ->where('item_category_id', $request->keyword)
                ->whereHas('item_category', function ($query) use ($request) {
                    $query->where('name', 'like', "%$request->keyword%");
                })->get();
        } else {
            $items = Item::with(['item_category', 'image'])
                ->where('name', 'like', "%$request->keyword%")
                ->orWhere('barcode', $request->keyword)
                ->get();
        }

        return parent::resFormat(1107, null, ['result' => $items]);
    }

    public function getItemByItemCategory($id)
    {
        $items = Item::with(['item_category', 'image'])->where('item_category_id', $id)->get();

        foreach ($items as $item) {
            if ($item->image) {
                $item['image_url'] = $item->image->document->url ?? null;
                $item['image_thumbnail'] = $item->image->document->thumbnail ?? null;
                $item['image_preview'] = $item->image->document->preview ?? null;
            }
        }

        $items->makeHidden([
            'item_category_id', 'created_at', 'updated_at',
            'uid', 'status', 'cost', 'price', 'image_id',
            'deleted_at', 'barcode', 'warehouse_id',
            'supplier_id', 'item_category', 'image',
        ]);
        return parent::resFormat(1108, null, ['items' => $items]);
    }

    public function countQuantityItem()
    {
        $items_quantity = Item::sum('quantity');
        $stockOut_quantity = StockHistory::where('in_or_out', 1)->whereDate('created_at', Carbon::now())->sum('total_quantity');
        $stockIn_quantity = StockHistory::where('in_or_out', 0)->whereDate('created_at', Carbon::now())->sum('total_quantity');

        return parent::resFormat(1109, null, [
            'items_quantity' => (int) $items_quantity,
            'stockOut_quantity' => (int) $stockOut_quantity,
            'stockIn_quantity' => (int) $stockIn_quantity
        ]);
    }
}
