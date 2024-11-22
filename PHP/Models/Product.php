<?php
namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class Product extends Model
{
    protected $table = 'products';

    public $timestamps = false;

    protected $fillable = [
        'name', 'description', 'crafter_id', 'stock_quantity', 'required_plastic_quantity', 'image'
    ];

    public function crafter()
    {
        return $this->belongsTo(Crafter::class, 'crafter_id');
    }

    public function orders()
    {
        return $this->belongsToMany(Order::class, 'order_product');
    }

    public function requirements()
    {
        return $this->hasMany(ProductRequirement::class, 'product_id');
    }

    public function rewards()
    {
        return $this->hasMany(Reward::class, 'reward_product_id');
    }

    public function getImgAttribute()
    {
        $img = $this->image;
        if(!$img || !file_exists(public_path($img))){
            return url('website/customer/images/default.png');
        }
        return url($img);
    }
}
