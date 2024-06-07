<?php

namespace Database\Seeders;

// use Illuminate\Database\Console\Seeds\WithoutModelEvents;
use Illuminate\Database\Seeder;

class DatabaseSeeder extends Seeder
{
    /**
     * Seed the application's database.
     */
    public function run(): void
    {
        // \App\Models\User::factory(10)->create();
        $data = [
            [
                'name' => 'Rendi Fajri',
                'email' => 'rendi@gmail.com',
                'role' => 'dokter',
                'password' => bcrypt("secretpass"),
                'salt' => "secretpass",
                ],
                [
                'name' => 'Ariliana',
                'email' => 'ariliana@gmail.com',
                'role' => 'dokter',
                'password' => bcrypt("secretpass"),
                'salt' => "secretpass",
                ],
                [
                'name' => 'Irianto',
                'email' => 'irianto@gmail.com',
                'role' => 'dokter',
                'password' => bcrypt("secretpass"),
                'salt' => "secretpass",
                ],
                [
                'name' => 'Lukman Hajime',
                'email' => 'lukman@gmail.com',
                'role' => 'dokter',
                'password' => bcrypt("secretpass"),
                'salt' => "secretpass",
                ],
                [
                'name' => 'Fuji Nami',
                'email' => 'fuji@gmail.com',
                'role' => 'dokter',
                'password' => bcrypt("secretpass"),
                'salt' => "secretpass",
                ],
                [
                'name' => 'Wijaya',
                'email' => 'wijaya@gmail.com',
                'role' => 'dokter',
                'password' => bcrypt("secretpass"),
                'salt' => "secretpass",
                ]
            ];

            foreach ($data as $key => $value) {
                \App\Models\User::factory()->create(
                  $value  
                );
            }
    }
}
