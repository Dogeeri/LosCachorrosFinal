<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\SoftDeletes;

class Noticia extends Model
{
    use HasFactory, SoftDeletes;
    protected $table = 'noticias';
    protected $primaryKey = 'cod_noticia';
    public $incrementing = false;
    protected $keyType = 'integer';
    public $timestamps = false;    
}