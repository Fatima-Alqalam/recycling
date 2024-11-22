<?php
namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class Shipping extends Model
{
    protected $table = 'shipments';

    public $timestamps = false;

    protected $fillable = [
        'order_id', 'address', 'phone', 'email', 'shipping_date', 'delivery_date', 'delivery_time', 'shipping_company_id', 'shipping_price'
    ];

    public function order()
    {
        return $this->belongsTo(Order::class, 'order_id');
    }

    public function company()
    {
        return $this->belongsTo(ShippingCompany::class, 'shipping_company_id');
    }
}
