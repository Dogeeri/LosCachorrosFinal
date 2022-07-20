<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\SoftDeletes;
class Evento extends Model
{
    use HasFactory, SoftDeletes;
    protected $table = 'eventos';
    protected $primaryKey = 'cod_evento';
    public $incrementing = false;
    protected $keyType = 'integer';
    public $timestamps = false;    
}
