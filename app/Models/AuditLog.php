<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class AuditLog extends Model
{
    protected $fillable = ['table_name', 'record_id', 'changed_by', 'changed_at'];

    public function translations()
    {
        return $this->hasMany(AuditLogTranslation::class);
    }
}