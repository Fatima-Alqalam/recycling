<?php
namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class Revenue extends Model
{
    protected $table = 'revenues';

    public $timestamps = false;

    protected $fillable = [
        'crafter_id', 'system_share', 'crafter_share', 'total_revenue'
    ];

    public function crafter()
    {
        return $this->belongsTo(Crafter::class, 'crafter_id');
    }
}
