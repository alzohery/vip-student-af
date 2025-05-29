<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Astrotomic\Translatable\Contracts\Translatable as TranslatableContract;
use Astrotomic\Translatable\Translatable;
use Spatie\Permission\Contracts\Permission as PermissionContract;

class Permission extends Model implements TranslatableContract, PermissionContract
{
    use HasFactory, Translatable;

    public $translatedAttributes = ['name', 'description'];
    
    protected $fillable = ['guard_name'];

    public function roles(): \Illuminate\Database\Eloquent\Relations\BelongsToMany
    {
        return $this->belongsToMany(
            config('permission.models.role', \App\Models\Role::class),
            config('permission.table_names.role_has_permissions', 'role_permissions'),
            'permission_id',
            'role_id'
        );
    }

    // public function getNameAttribute()
    // {
    //     return $this->translate(app()->getLocale())->name;
    // }

    public function getNameAttribute()
    {
        return $this->translate(app()->getLocale())?->name ?? $this->attributes['name'] ?? '';
    }

    public function getGuardNameAttribute()
    {
        return $this->attributes['guard_name'] ?? 'api';
    }

    public function getKeyName()
    {
        return 'id';
    }

    public static function findByName(string $name, ?string $guardName = null): PermissionContract
    {
        $locale = app()->getLocale();
        $permission = static::whereHas('translations', function ($query) use ($name, $locale) {
            $query->where('name', $name)->where('locale', $locale);
        })->first();

        if (!$permission) {
            throw new \Spatie\Permission\Exceptions\PermissionDoesNotExist();
        }

        return $permission;
    }

    public static function findById(string|int $id, ?string $guardName = null): PermissionContract
    {
        $permission = static::find($id);

        if (!$permission) {
            throw new \Spatie\Permission\Exceptions\PermissionDoesNotExist();
        }

        return $permission;
    }

    public static function findOrCreate(string $name, ?string $guardName = null): PermissionContract
    {
        $locale = app()->getLocale();
        $permission = static::whereHas('translations', function ($query) use ($name, $locale) {
            $query->where('name', $name)->where('locale', $locale);
        })->first();

        if (!$permission) {
            // $permission = static::create([]);
            // $permission->translateOrNew($locale)->name = $name;
            // $permission->save();
            
            $permission = static::create([
                'guard_name' => $guardName ?? config('auth.defaults.guard'), // أو 'api'
            ]);
            $permission->translateOrNew($locale)->name = $name;
            $permission->save();


        }

        return $permission;
    }
}