<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Foundation\Auth\User as Authenticatable;
use Illuminate\Notifications\Notifiable;
use Spatie\Permission\Traits\HasRoles;
use Illuminate\Support\Facades\Hash;
use Laravel\Sanctum\HasApiTokens;

class User extends Authenticatable
{
    use HasFactory, Notifiable, HasRoles, HasApiTokens;

    // protected $guard_name = 'web';

    protected $fillable = [
        'name',
        'email',
        'password',
        'role_id',
        'institute_id',
        'profile_picture',
        'birthdate',
        'city_id',
        'country',
        'zip_code',
        'phone',
        'timezone',
        'last_login_at',
    ];

    protected $hidden = [
        'password',
        'remember_token',
    ];

    protected $casts = [
        'email_verified_at' => 'datetime',
        'birthdate' => 'date',
        // 'password' => 'hashed',
    ];

    public function guardName(): string
    {
        return 'web';
    }

    // public function setPasswordAttribute($value)
    // {
    //     $this->attributes['password'] = Hash::make($value);
    // }

    public function setPasswordAttribute($value)
    {
        if (\Illuminate\Support\Facades\Hash::needsRehash($value)) {
            $this->attributes['password'] = \Illuminate\Support\Facades\Hash::make($value);
        } else {
            $this->attributes['password'] = $value;
        }
    }

    public function role()
    {
        return $this->belongsTo(Role::class, 'role_id');
    }
    public function getGuardNameAttribute(): string
    {
        return 'web';
    }
}