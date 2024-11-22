<?php
namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class ProductRequirement extends Model
{
    protected $table = 'product_requirements';

    public $timestamps = false;

    protected $fillable = [
        'product_id', 'description', 'quantity'
    ];

    public function product()
    {
        return $this->belongsTo(Product::class, 'product_id');
    }
}
