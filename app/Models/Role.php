<?php

namespace App\Models;

use Astrotomic\Translatable\Contracts\Translatable as TranslatableContract;
use Astrotomic\Translatable\Translatable;
use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Role extends Model implements TranslatableContract
{
    use HasFactory, Translatable;

    public $translatedAttributes = ['name'];

    protected $fillable = ['level'];

    public function users()
    {
        return $this->hasMany(User::class);
    }

    public function addTranslation(string $locale, array $attributes)
    {
        return $this->translations()->create(array_merge(['locale' => $locale], $attributes));
    }
}