<?php

use Illuminate\Http\Request;
use Illuminate\Support\Facades\Route;
use App\Http\Controllers\CursoController;
use App\Http\Controllers\AlumnosController;
use App\Http\Controllers\EducadorasController;
use App\Http\Controllers\EventosController;
use App\Http\Controllers\NoticiasController;
/*
|--------------------------------------------------------------------------
| API Routes
|--------------------------------------------------------------------------
|
| Here is where you can register API routes for your application. These
| routes are loaded by the RouteServiceProvider within a group which
| is assigned the "api" middleware group. Enjoy building your API!
|
*/

Route::middleware('auth:sanctum')->get('/user', function (Request $request) {
    return $request->user();
});

Route::apiResource('/curso', CursoController::class);

Route::apiResource('/alumnos',AlumnosController::class);
Route::get('/alumno/{curso}', [AlumnosController::class, 'cur']);

Route::apiResource('/educadoras', EducadorasController::class);
Route::get('/educadora/{curso}', [EducadorasController::class, 'cursos']);

Route::apiResource('/eventos', EventosController::class);
Route::apiResource('/noticias', NoticiasController::Class);

