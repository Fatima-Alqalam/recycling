<?php
namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class Order extends Model
{
    protected $table = 'orders';

    public $timestamps = false;

    protected $fillable = [
        'customer_id', 'crafter_id', 'order_date', 'status', 'points_earned', 'payment_status', 'plactic_amount'
    ];

    public function customer()
    {
        return $this->belongsTo(Customer::class, 'customer_id');
    }

    public function products()
    {
        return $this->belongsToMany(Product::class, OrderProduct::class)->withPivot(['quantity', 'plactic_amount']);
    }

    public function shipping()
    {
        return $this->hasOne(Shipping::class, 'order_id');
    }

    public function payment()
    {
        return $this->hasOne(Payment::class, 'order_id');
    }

    public function crafter()
    {
        return $this->hasOneThrough(Crafter::class, Product::class, 'id', 'id', 'product_id', 'crafter_id');
    }
}
