<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Astrotomic\Translatable\Contracts\Translatable as TranslatableContract;
use Astrotomic\Translatable\Translatable;
use Spatie\Permission\Traits\HasPermissions;
use Spatie\Permission\Contracts\Role as RoleContract;

class Role extends Model implements TranslatableContract, RoleContract
{
    use HasFactory, Translatable, HasPermissions;

    public $translatedAttributes = ['name'];

    protected $fillable = ['level', 'guard_name', 'slug'];

    public function permissions(): \Illuminate\Database\Eloquent\Relations\BelongsToMany
    {
        return $this->belongsToMany(
            config('permission.models.permission', \App\Models\Permission::class),
            config('permission.table_names.role_has_permissions', 'role_permissions'),
            'role_id',
            'permission_id'
        );
    }

    public function getNameAttribute()
    {
        return $this->translate(app()->getLocale())->name;
    }

    public function getGuardNameAttribute()
    {
        return $this->attributes['guard_name'] ?? 'web';
    }

    public function getKeyName()
    {
        return 'id';
    }

    public static function findByName(string $name, ?string $guardName = null): RoleContract
    {
        $locale = app()->getLocale();
        $role = static::whereHas('translations', function ($query) use ($name, $locale) {
            $query->where('name', $name)->where('locale', $locale);
        })->first();

        if (!$role) {
            throw new \Spatie\Permission\Exceptions\RoleDoesNotExist();
        }

        return $role;
    }

    public static function findById(string|int $id, ?string $guardName = null): RoleContract
    {
        $role = static::find($id);

        if (!$role) {
            throw new \Spatie\Permission\Exceptions\RoleDoesNotExist();
        }

        return $role;
    }

    public static function findBySlug(string $slug, ?string $guardName = null): RoleContract
    {
        $role = static::where('slug', $slug)->first();

        if (!$role) {
            throw new \Spatie\Permission\Exceptions\RoleDoesNotExist();
        }

        return $role;
    }

    public static function findOrCreate(string $name, ?string $guardName = null): RoleContract
    {
        $locale = app()->getLocale();
        $role = static::whereHas('translations', function ($query) use ($name, $locale) {
            $query->where('name', $name)->where('locale', $locale);
        })->first();

        if (!$role) {
            $role = static::create([
                'level' => 1,
                'guard_name' => $guardName ?? 'web',
                'slug' => \Illuminate\Support\Str::slug($name),
            ]);
            $role->translateOrNew($locale)->name = $name;
            $role->save();
        }

        return $role;
    }
}