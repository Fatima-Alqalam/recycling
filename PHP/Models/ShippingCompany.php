<?php
namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class ShippingCompany extends Model
{
    protected $table = 'shipping_company';

    public $timestamps = false;

    protected $fillable = [
        'company_name', 'phone', 'address', 'commercial_register', 'shipping_price'
    ];

}
