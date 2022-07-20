<?php

namespace App\Http\Controllers;

use App\Models\Noticia;
use Illuminate\Http\Request;


class NoticiasController extends Controller
{
    /**
     * Display a listing of the resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function index()
    {
        return Noticia::all();
    }

    /**
     * Store a newly created resource in storage.
     *
     * @param  \Illuminate\Http\Request  $request
     * @return \Illuminate\Http\Response
     */
    public function store(Request $request)
    {
        $noticia = new Noticia();
        $noticia -> cod_noticia = $request -> cod_noticia;
        $noticia -> titulo = $request -> titulo;
        $noticia -> contenido = $request -> contenido;
        $noticia -> fechahora = $request -> fechahora;
        $noticia -> save();
        return $noticia;
    }

    /**
     * Display the specified resource.
     *
     * @param  \App\Models\Noticia  $noticia
     * @return \Illuminate\Http\Response
     */
    public function show(Noticia $noticia)
    {
        return $noticia;
    }

    /**
     * Update the specified resource in storage.
     *
     * @param  \Illuminate\Http\Request  $request
     * @param  \App\Models\Noticia  $noticia
     * @return \Illuminate\Http\Response
     */
    public function update(Request $request, Noticia $noticia)
    {
        $noticia -> titulo = $request -> titulo;
        $noticia -> contenido = $request -> contenido;
        $noticia -> fechahora = $request -> fechahora;
        $noticia -> save();
        return $noticia;
    }

    /**
     * Remove the specified resource from storage.
     *
     * @param  \App\Models\Noticia  $noticia
     * @return \Illuminate\Http\Response
     */
    public function destroy(Noticia $noticia)
    {
        $noticia -> delete();
    }
}
