<?php
namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class PlasticCollection extends Model
{
    protected $table = 'plastic_collection';

    public $timestamps = false;

    protected $fillable = [
        'customer_id', 'quantity', 'collection_date'
    ];

    public function customer()
    {
        return $this->belongsTo(Customer::class, 'customer_id');
    }
}
