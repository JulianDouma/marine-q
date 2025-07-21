<?php

declare(strict_types=1);

namespace App\Tests\Unit;

use App\Kernel;
use PHPUnit\Framework\TestCase;

class KernelTest extends TestCase
{
    public function testKernelInstantiation(): void
    {
        $kernel = new Kernel('test', false);

        $this->assertInstanceOf(Kernel::class, $kernel);
        $this->assertEquals('test', $kernel->getEnvironment());
        $this->assertFalse($kernel->isDebug());
    }

    public function testKernelDebugMode(): void
    {
        $kernel = new Kernel('test', true);

        $this->assertTrue($kernel->isDebug());
    }
}
