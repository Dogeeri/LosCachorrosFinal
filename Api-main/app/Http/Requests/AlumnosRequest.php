<?php

namespace App\Http\Requests;

use Illuminate\Foundation\Http\FormRequest;

class AlumnosRequest extends FormRequest
{
    /**
     * Determine if the user is authorized to make this request.
     *
     * @return bool
     */
    public function authorize()
    {
        return true;
    }

    /**
     * Get the validation rules that apply to the request.
     *
     * @return array<string, mixed>
     */
    public function rules()
    {
        return [
            //
            'cod_alumno' => 'required|unique:alumnos,cod_alumno',
            'nom_alumno' => 'required',
            'direccion' => 'required',
            'telefono' => 'required',
            'edad' => 'required|integer|between:1,15',
            'nom_curso' => 'required',
            //'cod_alumno' => 'required',
        ];
    }

    public function messages(){
        return[
            'cod_alumno.required'=>'Codigo necesario',
            'cod_alumno.unique'=>'Codigo ya existente',
            
            'nom_alumno.required'=>'Nombre necesario',
            'direccion.required'=>'Direccion necesario',
            'telefono.required'=>'Telefono necesario',

            'edad.required'=>'Edad necesario',
            'edad.integer'=>'Edad debe ser numero',
            'edad.between'=>'Edad superada',
            'nom_curso.required'=>'Curso necesario',
        ];
    }
}
