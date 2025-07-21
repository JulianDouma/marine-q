<?php

declare(strict_types=1);

namespace App\Tests\Integration;

use Symfony\Bundle\FrameworkBundle\Test\WebTestCase;

class ApiPlatformTest extends WebTestCase
{
    public function testApiPlatformIsAccessible(): void
    {
        $kernelBrowser = static::createClient();

        // Test API Platform entrypoint
        $kernelBrowser->request('GET', '/api');

        $this->assertResponseIsSuccessful();
        $this->assertResponseHeaderSame('Content-Type', 'application/ld+json; charset=utf-8');
    }

    public function testApiPlatformReturnsValidJsonLD(): void
    {
        $kernelBrowser = static::createClient();

        $kernelBrowser->request('GET', '/api');

        $content = $kernelBrowser->getResponse()->getContent();
        $data = json_decode($content, true);

        $this->assertIsArray($data);
        // Entrypoint returns JSON-LD metadata by design
        $this->assertArrayHasKey('@context', $data);
        $this->assertArrayHasKey('@id', $data);
        $this->assertArrayHasKey('@type', $data);
        $this->assertSame('Entrypoint', $data['@type']);
    }

    public function testApiPlatformDocsAreAccessible(): void
    {
        $kernelBrowser = static::createClient();

        // Test that API documentation endpoint works
        $kernelBrowser->request('GET', '/api/docs');

        $this->assertResponseIsSuccessful();
        $this->assertResponseHeaderSame('Content-Type', 'application/json; charset=utf-8');

        $content = $kernelBrowser->getResponse()->getContent();
        $data = json_decode($content, true);

        $this->assertIsArray($data);
        $this->assertArrayHasKey('title', $data);
        $this->assertSame('Marine-Q API', $data['title']);
        $this->assertArrayHasKey('version', $data);
        $this->assertSame('0.0.1-alpha', $data['version']);
    }
}
