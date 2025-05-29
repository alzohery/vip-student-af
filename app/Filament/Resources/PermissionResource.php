<?php

namespace App\Filament\Resources;

use App\Filament\Resources\PermissionResource\Pages;
use App\Filament\Resources\PermissionResource\RelationManagers;
use App\Models\Permission;
use Filament\Forms;
use Filament\Forms\Form;
use Filament\Resources\Resource;
use Filament\Tables;
use Filament\Tables\Table;
use Illuminate\Database\Eloquent\Builder;
use Illuminate\Database\Eloquent\SoftDeletingScope;
use Filament\Forms\Components\Repeater;
use Filament\Forms\Components\TextInput;

class PermissionResource extends Resource

{
    protected static ?string $model = Permission::class;

    protected static ?string $navigationIcon = 'heroicon-o-rectangle-stack';

    
    // protected static ?string $navigationIcon = 'heroicon-o-key';
    protected static ?string $modelLabel = 'صلاحية';
    protected static ?string $pluralModelLabel = 'صلاحيات';

    public static function form(Form $form): Form
    {
        return $form
            ->schema([
                Repeater::make('translations')
                    ->schema([
                        TextInput::make('locale')
                            ->required()
                            ->label(__('filament.fields.locale'))
                            ->disabled()
                            ->default(fn () => app()->getLocale()),
                        TextInput::make('name')
                            ->required()
                            ->label(__('filament.fields.name')),
                        TextInput::make('description')
                            ->label(__('filament.fields.description')),
                    ])
                    ->defaultItems(2)
                    ->createItemButtonLabel('إضافة ترجمة')
                    ->relationship('translations'),
                TextInput::make('guard_name')
                    ->default('api')
                    ->required()
                    ->label(__('filament.fields.guard_name')),
            ]);
    }

    public static function table(Table $table): Table
    {
        return $table
            ->columns([
                Tables\Columns\TextColumn::make('name')
                    ->label(__('filament.fields.name'))
                    ->getStateUsing(fn ($record) => $record->getTranslation('name', app()->getLocale())),
                Tables\Columns\TextColumn::make('guard_name')
                    ->label(__('filament.fields.guard_name')),
            ])
            ->filters([
                //
            ])
            ->actions([
                Tables\Actions\EditAction::make(),
            ])
            ->bulkActions([
                Tables\Actions\DeleteBulkAction::make(),
            ]);
    }

    public static function getRelations(): array
    {
        return [
            //
        ];
    }

    public static function getPages(): array
    {
        return [
            'index' => Pages\ListPermissions::route('/'),
            'create' => Pages\CreatePermission::route('/create'),
            'edit' => Pages\EditPermission::route('/{record}/edit'),
        ];
    }
}
