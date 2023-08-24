<?php

namespace Tests\Feature;

use Illuminate\Foundation\Testing\RefreshDatabase;
use Illuminate\Foundation\Testing\WithFaker;
use Tests\TestCase;

class UserControllerTest extends TestCase
{
    use RefreshDatabase; // Resets the database after each test

    /**
     * Test creating a new user.
     *
     * @return void
     */
    public function testCreateUser()
    {
        $data = [
            'name' => 'John Doe',
            'email' => 'johndoe@example.com',
            'password' => 'secret123',
            'password_confirmation' => 'secret123',

        ];

        $response = $this->post('/register', $data);

        $response->assertStatus(201); // Check if the response status is 'Created'
        $this->assertDatabaseHas('users', ['email' => 'johndoe@example.com']); // Check if the user is in the database
    }
}
