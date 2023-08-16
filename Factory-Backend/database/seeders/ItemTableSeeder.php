<?php

namespace Database\Seeders;

use App\Models\Item;
use Illuminate\Database\Seeder;
use App\Models\ItemCategory;
use Carbon\Carbon;
use Faker\Generator as Faker;

class ItemTableSeeder extends Seeder
{
    /**
     * Run the database seeds.
     *
     * @return void
     */
    public function run(Faker $faker)
    {
        $items = [];

        for ($i = 1; $i <= 500; $i++) {
            $item = [
                'uid' => $faker->uuid,
                'name' => $faker->firstName(),
                'barcode' => $faker->ean13,
                'cost' => $faker->randomFloat(2, 0, 100),
                'price' => $faker->randomFloat(2, 0, 100),
                'quantity' => rand(5, 50),
                'item_category_id' => rand(1, 10),
                'image_id' => 1,
                'status' => rand(0, 1),
                'created_at' => Carbon::now()->addMinutes($i),
                'updated_at' => Carbon::now()->addMinutes($i),
            ];

            array_push($items, $item);
        }

        Item::insert($items);
    }
}
