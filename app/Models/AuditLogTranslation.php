<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class AuditLogTranslation extends Model
{
    protected $fillable = ['audit_log_id', 'locale', 'action', 'old_value', 'new_value'];
}