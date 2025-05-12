<?php
namespace Tests\Feature;
use Illuminate\Foundation\Testing\RefreshDatabase;
use Tests\TestCase;
class EnvironmentTest extends TestCase
{
    public function test_welcome_page_is_accessible()
    {
        $response = $this->get('/');
        $response->assertStatus(200);
    }
}