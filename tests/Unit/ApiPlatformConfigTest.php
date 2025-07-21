<?php

declare(strict_types=1);

namespace App\Tests\Unit;

use ApiPlatform\Symfony\Bundle\ApiPlatformBundle;
use Symfony\Bundle\FrameworkBundle\Test\KernelTestCase;

class ApiPlatformConfigTest extends KernelTestCase
{
    public function testApiPlatformBundleIsLoaded(): void
    {
        self::bootKernel();
        $kernel = self::$kernel;

        $bundles = $kernel->getBundles();

        $this->assertArrayHasKey('ApiPlatformBundle', $bundles);
        $this->assertInstanceOf(ApiPlatformBundle::class, $bundles['ApiPlatformBundle']);
    }

    public function testApiPlatformConfigIsLoaded(): void
    {
        self::bootKernel();
        $container = self::getContainer();

        // Test that API Platform services are registered
        $this->assertTrue($container->has('api_platform.resource_class_resolver'));
        $this->assertTrue($container->has('api_platform.metadata.operation.metadata_factory'));
    }

    public function testApiPlatformDefaultConfiguration(): void
    {
        self::bootKernel();
        $container = self::getContainer();

        // Get API Platform configuration
        $config = $container->getParameter('api_platform.defaults');

        $this->assertIsArray($config);
        $this->assertTrue($config['stateless']);
        $this->assertArrayHasKey('cache_headers', $config);
    }
}
