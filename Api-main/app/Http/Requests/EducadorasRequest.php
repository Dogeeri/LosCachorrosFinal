<?php

namespace App\Http\Requests;

use Illuminate\Foundation\Http\FormRequest;

class EducadorasRequest extends FormRequest
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
            'cod_tia' => 'required|unique:educadoras,cod_tia',
            'nombre' => 'required',
            'telefono' => 'required|integer',
            'cod_curso' => 'required',
        ];
    }

    public function messages(){
        return[
            'cod_tia.required'=>'Codigo necesario',
            'cod_tia.unique'=>'Codigo ya existente',

            'nombre.required'=>'Nombre necesario',
            'telefono.required'=>'Telefono necesario',
            'telefono.integer'=>'El numero debe ser numerico',
            'telefono.between'=>'Faltan numeros',
            'cod_curso.required'=>'Curso necesario',

        ];
    }
}
