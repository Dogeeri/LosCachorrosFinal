<?php

namespace App\Http\Requests;

use Illuminate\Foundation\Http\FormRequest;

class CursosRequest extends FormRequest
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
            'cod_curso' => 'required|unique:curso,cod_curso',
            'curso' => 'required',
            'cantidad' => 'required|integer|between:1,30',
        ];
    }
    public function messages(){
        return[
            'cod_curso.required'=>'Codigo necesario',
            'cod_curso.unique'=>'Codigo ya existente',
            
            'curso.required'=>'Nombre necesario',

            'cantidad.required'=>'Cantidad necesario',
            'cantidad.integer'=>'La cantidad debe ser numerica',
            'cantidad.between'=>'La cantidad no es valida',
        ];
    }
}
