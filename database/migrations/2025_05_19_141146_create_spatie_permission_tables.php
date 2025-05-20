<?php

  use Illuminate\Database\Migrations\Migration;
  use Illuminate\Database\Schema\Blueprint;
  use Illuminate\Support\Facades\Schema;

  class CreateSpatiePermissionTables extends Migration
  {
      public function up()
      {
          Schema::create('model_has_permissions', function (Blueprint $table) {
              $table->foreignId('permission_id')->constrained()->onDelete('cascade');
              $table->morphs('model');
              $table->primary(['permission_id', 'model_id', 'model_type']);
          });

          Schema::create('model_has_roles', function (Blueprint $table) {
              $table->foreignId('role_id')->constrained()->onDelete('cascade');
              $table->morphs('model');
              $table->primary(['role_id', 'model_id', 'model_type']);
          });
      }

      public function down()
      {
          Schema::dropIfExists('model_has_permissions');
          Schema::dropIfExists('model_has_roles');
      }
  }