<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\SoftDeletes;

class Educadora extends Model
{
    use HasFactory,SoftDeletes;
    protected $table='educadoras';
    protected $primaryKey = 'cod_tia';
    public $incrementing = false;
    protected $keyType = 'string';
    public $timestamps = false;
}
