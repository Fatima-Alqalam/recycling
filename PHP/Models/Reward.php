<?php
namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class Reward extends Model
{
    protected $table = 'rewards';

    public $timestamps = false;

    protected $fillable = [
        'customer_id', 'reward_points', 'reward_date', 'order_id'
    ];

    public function customer()
    {
        return $this->belongsTo(Customer::class, 'customer_id');
    }

    public function rewardProduct()
    {
        return $this->belongsTo(Product::class, 'reward_product_id');
    }
}
