<?php
namespace App\Models;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Foundation\Auth\User as Authenticatable;

class Customer extends Authenticatable
{
    protected $table = 'customers';

    public $timestamps = false;

    protected $fillable = [
        'name', 'email', 'password', 'phone', 'address', 'reward_points'
    ];

    public function orders()
    {
        return $this->hasMany(Order::class, 'customer_id');
    }

    public function plasticCollections()
    {
        return $this->hasOne(PlasticCollection::class, 'customer_id');
    }

    public function rewards()
    {
        return $this->hasMany(Reward::class, 'customer_id');
    }

    function getBalanceAttribute()
    {
        return $this->plasticCollections ? $this->plasticCollections->quantity : 0;
    }
}
