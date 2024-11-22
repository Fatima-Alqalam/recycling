<?php
namespace App\Models;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Foundation\Auth\User as Authenticatable;

class Admin extends Authenticatable
{
    protected $table = 'admins';
    protected $primaryKey = 'id';
    public $timestamps = false;

    protected $fillable = [
        'name', 'email', 'password', 'role', 'phone'
    ];
}
