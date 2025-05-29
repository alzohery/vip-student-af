<?php

namespace App\Filament\Resources;

use App\Filament\Resources\RoleResource\Pages;
use App\Filament\Resources\RoleResource\RelationManagers;
use App\Models\Role;
use Filament\Forms;
use Filament\Forms\Form;
use Filament\Resources\Resource;
use Filament\Tables;
use Filament\Tables\Table;
use Illuminate\Database\Eloquent\Builder;
use Illuminate\Database\Eloquent\SoftDeletingScope;
use Filament\Forms\Components\TextInput;
use Filament\Forms\Components\Repeater;

class RoleResource extends Resource
{
    protected static ?string $model = Role::class;

    protected static ?string $navigationIcon = 'heroicon-o-rectangle-stack';

    protected static ?string $modelLabel = 'دور';
    protected static ?string $pluralModelLabel = 'أدوار';

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
                    ])
                    ->defaultItems(2)
                    ->createItemButtonLabel('إضافة ترجمة')
                    ->relationship('translations'),
                TextInput::make('slug')
                    ->required()
                    ->unique()
                    ->label(__('filament.fields.slug')),
                Select::make('permissions')
                    ->multiple()
                    ->label(__('filament.fields.permissions'))
                    ->relationship('permissions', 'name', fn ($query) => $query->where('guard_name', 'api'))
                    ->getOptionLabelFromRecordUsing(fn ($record) => $record->getTranslation('name', app()->getLocale()))
                    ->preload(),
            ]);
    }

    public static function table(Table $table): Table
    {
        return $table
            ->columns([
                Tables\Columns\TextColumn::make('name')
                    ->label(__('filament.fields.name'))
                    ->getStateUsing(fn ($record) => $record->getTranslation('name', app()->getLocale())),
                Tables\Columns\TextColumn::make('slug')
                    ->label(__('filament.fields.slug')),
            ])
            ->filters([
                //
            ])
            ->actions([
                Tables\Actions\EditAction::make(),
            ])
            ->bulkActions([
                Tables\Actions\BulkActionGroup::make([
                    Tables\Actions\DeleteBulkAction::make(),
                ]),
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
            'index' => Pages\ListRoles::route('/'),
            'create' => Pages\CreateRole::route('/create'),
            'edit' => Pages\EditRole::route('/{record}/edit'),
        ];
    }
}
