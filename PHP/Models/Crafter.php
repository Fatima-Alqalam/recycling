<?php
namespace App\Models;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Foundation\Auth\User as Authenticatable;

class Crafter extends Authenticatable
{
    protected $table = 'crafters';

    public $timestamps = false;

    protected $fillable = [
        'name', 'email', 'password', 'phone', 'address'
    ];

    public function products()
    {
        return $this->hasMany(Product::class, 'crafter_id');
    }

    public function revenue()
    {
        return $this->hasOne(Revenue::class, 'crafter_id');
    }
    public function orders()
    {
        return $this->hasMany(Order::class, 'crafter_id');
    }
//    public function orders()
//    {
//        return $this->hasManyThrough(
//            Order::class,
//            Product::class,
//            'crafter_id',
//            'product_id',
//            'id',
//            'id'
//        );
//    }

}
