Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 28 Jul 2014 23:02:56 +0200 (CEST)
Received: from test.hauke-m.de ([5.39.93.123]:37822 "EHLO test.hauke-m.de"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6815804AbaG1VCw0lhH0 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 28 Jul 2014 23:02:52 +0200
Received: from [IPv6:2001:470:7259:0:9dcd:2485:6d06:4d01] (unknown [IPv6:2001:470:7259:0:9dcd:2485:6d06:4d01])
        by test.hauke-m.de (Postfix) with ESMTPSA id B673D200D8;
        Mon, 28 Jul 2014 23:02:51 +0200 (CEST)
Message-ID: <53D6BA7A.5050903@hauke-m.de>
Date:   Mon, 28 Jul 2014 23:02:50 +0200
From:   Hauke Mehrtens <hauke@hauke-m.de>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.0
MIME-Version: 1.0
To:     =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>,
        linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>
Subject: Re: [PATCH 2/2] MIPS: BCM47XX: Detect more then 128 MiB of RAM (HIGHMEM)
References: <1405632393-17960-1-git-send-email-zajec5@gmail.com> <1405632393-17960-2-git-send-email-zajec5@gmail.com>
In-Reply-To: <1405632393-17960-2-git-send-email-zajec5@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-Path: <hauke@hauke-m.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 41721
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: hauke@hauke-m.de
Precedence: bulk
List-help: <mailto:ecartis@linux-mips.org?Subject=help>
List-unsubscribe: <mailto:ecartis@linux-mips.org?subject=unsubscribe%20linux-mips>
List-software: Ecartis version 1.0.0
List-Id: linux-mips <linux-mips.eddie.linux-mips.org>
X-List-ID: linux-mips <linux-mips.eddie.linux-mips.org>
List-subscribe: <mailto:ecartis@linux-mips.org?subject=subscribe%20linux-mips>
List-owner: <mailto:ralf@linux-mips.org>
List-post: <mailto:linux-mips@linux-mips.org>
List-archive: <http://www.linux-mips.org/archives/linux-mips/>
X-list: linux-mips

On 07/17/2014 11:26 PM, Rafał Miłecki wrote:
> So far BCM47XX can only detect amount of HIGHMEM. It still requires
> adding (registering) and well-testing before enabling by default.
> 
> Signed-off-by: Rafał Miłecki <zajec5@gmail.com>
> ---
> Changes since RFC:
> 1) Use pgtable-32.h instead of ugly "extern" in .c file
> 2) Make it clear it needs work & testing before enabling

NACK

I tested this on my ASUS RT-66U with 256 MB ram and it panics. These
patches are looking similar to the code the Broadcom SDK, but I do not
know where the error is.


CFE> boot -tftp -elf
192.168.1.195:/brcm47xx/openwrt-brcm47xx-mips74k-vmlinux-initramfs.elf
Loader:elf Filesys:tftp Dev:eth0
File:192.168.1.195:/brcm47xx/openwrt-brcm47xx-mips74k-vmlinux-initramfs.elf
Options:(null)
Loading: TFTP Client.
0x80001000/4741212 0x8048685c/285684 Entry at 0x80005690
Closing network.
Starting program at 0x80005690
[    0.000000] Linux version 3.10.44 (hauke@hauke-desktop) (gcc version
4.8.3 (OpenWrt/Linaro GCC 4.8-2014.04 r41527) ) #6 Thu Jul 17 21:40:16
CEST 2014
[    0.000000] CPU revision is: 00019749 (MIPS 74Kc)
[    0.000000] bcm47xx: using bcma bus
[    0.000000] bcma: bus0: Found chip with id 0x5300, rev 0x01 and
package 0x00
[    0.000000] bcma: bus0: Core 0 found: BCM4706 ChipCommon (manuf
0x4BF, id 0x500, rev 0x1F, class 0x0)
[    0.000000] bcma: bus0: Core 3 found: MIPS 74K (manuf 0x4A7, id
0x82C, rev 0x00, class 0x0)
[    0.000000] bcma: bus0: Early bus registered
[    0.000000] MIPS: machine is Asus RT-N66U
[    0.000000] Determined physical RAM map:
[    0.000000]  memory: 07fff000 @ 00000000 (usable)
[    0.000000]  memory: 07fff000 @ 87fff000 (usable)
[    0.000000] Initrd not found or empty - disabling initrd
[    0.000000] Zone ranges:
[    0.000000]   Normal   [mem 0x00000000-0x1fffffff]
[    0.000000]   HighMem  [mem 0x20000000-0x8fffdfff]
[    0.000000] Movable zone start for each node
[    0.000000] Early memory node ranges
[    0.000000]   node   0: [mem 0x00000000-0x07ffefff]
[    0.000000]   node   0: [mem 0x87fff000-0x8fffdfff]
[    0.000000] Primary instruction cache 32kB, VIPT, 4-way, linesize 32
bytes.
[    0.000000] Primary data cache 32kB, 4-way, VIPT, cache aliases,
linesize 32 bytes
[    0.000000] Built 1 zonelists in Zone order, mobility grouping on.
Total pages: 64510
[    0.000000] Kernel command line:  noinitrd console=ttyS0,115200
[    0.000000] PID hash table entries: 512 (order: -1, 2048 bytes)
[    0.000000] Dentry cache hash table entries: 16384 (order: 4, 65536
bytes)
[    0.000000] Inode-cache hash table entries: 8192 (order: 3, 32768 bytes)
[    0.000000] Writing ErrCtl register=80000ff0
[    0.000000] Readback ErrCtl register=80000ff0
[    0.000000] Cache parity protection enabled
[    0.000000] Crashlog failed to allocate RAM at address 0x1ff00000
[    0.000000] Memory: 238596k/131068k available (2239k kernel code,
23540k reserved, 565k data, 1860k init, 131068k highmem)
[    0.000000] NR_IRQS:128
[    0.000000] Setting up vectored interrupts
[    0.070000] Calibrating delay loop... 299.82 BogoMIPS (lpj=1499136)
[    0.070000] pid_max: default: 32768 minimum: 301
[    0.070000] Mount-cache hash table entries: 512
[    0.070000] NET: Registered protocol family 16
[    0.080000] bio: create slab <bio-0> at 0
[    0.080000] Switching to clocksource MIPS
[    0.090000] NET: Registered protocol family 2
[    0.090000] TCP established hash table entries: 1024 (order: 1, 8192
bytes)
[    0.090000] TCP bind hash table entries: 1024 (order: 0, 4096 bytes)
[    0.090000] TCP: Hash tables configured (established 1024 bind 1024)
[    0.090000] TCP: reno registered
[    0.090000] UDP hash table entries: 256 (order: 0, 4096 bytes)
[    0.090000] UDP-Lite hash table entries: 256 (order: 0, 4096 bytes)
[    0.090000] NET: Registered protocol family 1
[    1.810000] bcma: bus0: Core 1 found: BCM4706 GBit MAC (manuf 0x4BF,
id 0x52D, rev 0x00, class 0x0)
[    1.810000] bcma: bus0: Core 2 found: BCM4706 GBit MAC (manuf 0x4BF,
id 0x52D, rev 0x00, class 0x0)
[    1.810000] bcma: bus0: Core 4 found: USB 2.0 Host (manuf 0x4BF, id
0x819, rev 0x04, class 0x0)
[    1.810000] bcma: bus0: Core 5 found: PCIe (manuf 0x4BF, id 0x820,
rev 0x0E, class 0x0)
[    1.810000] bcma: bus0: Core 6 found: PCIe (manuf 0x4BF, id 0x820,
rev 0x0E, class 0x0)
[    1.810000] bcma: bus0: Core 7 found: AMEMC (DDR) (manuf 0x4BF, id
0x52E, rev 0x00, class 0x0)
[    1.810000] bcma: bus0: Core 8 found: BCM4706 SOC RAM (manuf 0x4BF,
id 0x50E, rev 0x05, class 0x0)
[    1.810000] bcma: bus0: Core 9 found: ALTA (I2S) (manuf 0x4BF, id
0x534, rev 0x00, class 0x0)
[    1.810000] bcma: bus0: Core 10 found: BCM4706 GBit MAC Common (manuf
0x43B, id 0x5DC, rev 0x00, class 0x0)
[    1.990000] bcma: bus0: PCIEcore in host mode found
[    2.170000] PCI host bridge to bus 0000:00
[    2.170000] pci_bus 0000:00: root bus resource [mem
0x08000000-0x0bffffff]
[    2.170000] pci_bus 0000:00: root bus resource [io  0x0100-0x047f]
[    2.170000] pci_bus 0000:00: No busn resource found for root bus,
will use [bus 00-ff]
[    2.170000] bcma: PCI: Fixing up bridge 0000:00:00.0
[    2.170000] bcma: PCI: Fixing up device 0000:00:00.0
[    2.170000] bcma: PCI: Fixing up bridge 0000:00:00.1
[    2.170000] bcma: PCI: Fixing up device 0000:00:00.1
[    2.170000] bcma: PCI: Fixing up addresses 0000:00:01.0
[    2.170000] pci 0000:00:01.0: BAR 0: assigned [mem
0x08000000-0x08003fff 64bit]
[    2.170000] PCI: Enabling device 0000:00:01.0 (0000 -> 0002)
[    2.170000] bcma: PCI: Fixing up device 0000:00:01.0
[    2.170000] bcma: change PCIe max read request size from 512 to 128
[    2.170000] bcma: bus1: Found chip with id 0x4331, rev 0x02 and
package 0x08
[    2.170000] bcma: bus1: Core 0 found: ChipCommon (manuf 0x4BF, id
0x800, rev 0x25, class 0x0)
[    2.170000] bcma: bus1: Core 1 found: IEEE 802.11 (manuf 0x4BF, id
0x812, rev 0x1D, class 0x0)
[    2.170000] bcma: bus1: Core 2 found: PCIe (manuf 0x4BF, id 0x820,
rev 0x13, class 0x0)
[    2.250000] bcma: bus1: Invalid SPROM read from the PCIe card, trying
to use fallback SPROM
[    2.440000] bcma: bus1: Bus registered
[    2.440000] bcma: bus0: PCIEcore in host mode found
[    2.620000] PCI host bridge to bus 0000:01
[    2.620000] pci_bus 0000:01: root bus resource [mem
0x40000000-0x43ffffff]
[    2.620000] pci_bus 0000:01: root bus resource [io  0x0480-0x07ff]
[    2.620000] pci_bus 0000:01: No busn resource found for root bus,
will use [bus 01-ff]
[    2.620000] bcma: PCI: Fixing up bridge 0000:01:00.0
[    2.620000] bcma: PCI: Fixing up device 0000:01:00.0
[    2.620000] bcma: PCI: Fixing up bridge 0000:01:00.1
[    2.620000] bcma: PCI: Fixing up device 0000:01:00.1
[    2.620000] bcma: PCI: Fixing up addresses 0000:01:01.0
[    2.620000] pci 0000:01:01.0: BAR 0: assigned [mem
0x40000000-0x40003fff 64bit]
[    2.630000] PCI: Enabling device 0000:01:01.0 (0000 -> 0002)
[    2.630000] bcma: PCI: Fixing up device 0000:01:01.0
[    2.630000] bcma: change PCIe max read request size from 512 to 128
[    2.630000] bcma: bus2: Found chip with id 0x4331, rev 0x02 and
package 0x08
[    2.630000] bcma: bus2: Core 0 found: ChipCommon (manuf 0x4BF, id
0x800, rev 0x25, class 0x0)
[    2.630000] bcma: bus2: Core 1 found: IEEE 802.11 (manuf 0x4BF, id
0x812, rev 0x1D, class 0x0)
[    2.630000] bcma: bus2: Core 2 found: PCIe (manuf 0x4BF, id 0x820,
rev 0x13, class 0x0)
[    2.710000] bcma: bus2: Invalid SPROM read from the PCIe card, trying
to use fallback SPROM
[    2.880000] bcma: bus2: Bus registered
[    2.880000] bcma: bus0: Bus registered
[    2.880000] bounce pool size: 64 pages
[    2.880000] squashfs: version 4.0 (2009/01/31) Phillip Lougher
[    2.880000] jffs2: version 2.2 (NAND) (SUMMARY) (LZMA) (RTIME)
(CMODE_PRIORITY) (c) 2001-2006 Red Hat, Inc.
[    2.880000] msgmni has been set to 210
[    2.880000] io scheduler noop registered
[    2.880000] io scheduler deadline registered (default)
[    2.890000] Serial: 8250/16550 driver, 2 ports, IRQ sharing enabled
[    2.910000] serial8250.0: ttyS0 at MMIO 0xb8000300 (irq = 2) is a
U6_16550A
[    3.600000] console [ttyS0] enabled
[    3.630000] serial8250.0: ttyS1 at MMIO 0xb8000400 (irq = 2) is a
U6_16550A
[    3.640000] physmap platform flash device: 02000001 at 1c000000
[    3.640000] physmap-flash.0: Found 1 x16 devices at 0x0 in 16-bit
bank. Manufacturer ID 0x000001 Chip ID 0x002201
[    3.650000] Amd/Fujitsu Extended Query Table at 0x0040
[    3.660000]   Amd/Fujitsu Extended Query version 1.3.
[    3.660000] number of CFI chips: 1
[    3.700000] 5 bcm47xxpart partitions found on MTD device physmap-flash.0
[    3.710000] Creating 5 MTD partitions on "physmap-flash.0":
[    3.710000] 0x000000000000-0x000000040000 : "boot"
[    3.720000] 0x000000040000-0x000001fe0000 : "firmware"
[    3.730000] 0x00000004001c-0x000000174b0c : "linux"
[    3.730000] mtd: partition "linux" must either start or end on erase
block boundary or be smaller than an erase block -- forcing read-only
[    3.750000] 0x000000174b0c-0x000001fe0000 : "rootfs"
[    3.750000] mtd: partition "rootfs" must either start or end on erase
block boundary or be smaller than an erase block -- forcing read-only
[    3.770000] mtd: device 3 (rootfs) set to be root filesystem
[    3.770000] mtdsplit: no squashfs found in "physmap-flash.0"
[    3.780000] 0x000001fe0000-0x000002000000 : "nvram"
[    3.780000] bcm47xxnflash: Chip reset not implemented yet
[    3.790000] bcm47xxnflash: Requested invalid id_data: 32
[    3.800000] No NAND device found
[    3.800000] bcm47xxnflash: Could not scan NAND flash: -19
[    3.800000] bcm47xxnflash: Initialization failed: -19
[    3.810000] bgmac bcma0:0: Found PHY addr: 30 (NOREGS)
[    3.820000] bgmac bcma0:0: Support for Roboswitch not implemented
[    3.830000] libphy: bgmac mii bus: probed
[    3.910000] b53_common: found switch: BCM53125, rev 4
[    3.920000] bgmac: Broadcom 47xx GBit MAC driver loaded
[    3.920000] bcm47xx-wdt bcm47xx-wdt.0: BCM47xx Watchdog Timer enabled
(30 seconds)
[    3.930000] TCP: cubic registered
[    3.940000] NET: Registered protocol family 17
[    3.940000] 8021q: 802.1Q VLAN Support v1.8
[    3.950000] Freeing unused kernel memory: 1860K (802bf000 - 80490000)
[    3.960000] Kernel bug detected[#1]:
[    3.960000] CPU: 0 PID: 1 Comm: swapper Not tainted 3.10.44 #6
[    3.960000] task: 87821958 ti: 87822000 task.ti: 87822000
[    3.960000] $ 0   : 00000000 8025cbf6 00000001 00000290
[    3.960000] $ 4   : 00000520 802aa9e0 00000290 81000000
[    3.960000] $ 8   : 0074696e 00000002 00000002 696e692f
[    3.960000] $12   : 821fff74 802aaca8 00000000 41525449
[    3.960000] $16   : 820fffe0 00000000 00000006 7fff7ff6
[    3.960000] $20   : 8792c280 8025cbf0 820fffe0 ffffffff
[    3.960000] $24   : 00000000 800152b4
[    3.960000] $28   : 87822000 87823e60 7fff7000 8008b8a8
[    3.960000] Hi    : 00000000
[    3.960000] Lo    : ec08ce00
[    3.960000] epc   : 8008b6cc copy_strings+0x1d4/0x398
[    3.960000]     Not tainted
[    3.960000] ra    : 8008b8a8 copy_strings_kernel+0x18/0x2c
[    3.960000] Status: 11008403 KERNEL EXL IE
[    3.960000] Cause : 00800034
[    3.960000] PrId  : 00019749 (MIPS 74Kc)
[    3.960000] Modules linked in:
[    3.960000] Process swapper (pid: 1, threadinfo=87822000,
task=87821958, tls=00000000)
[    3.960000] Stack : 00000000 00000000 00000000 ffffffff 00000017
87823e80 00000000 00000000
          820fffe0 87a645f8 fe001000 00000ff6 00000000 0000004e 87a645f8
00000000
          87a62de0 87a62de0 87a62e1c 00000001 802ab3ac 8008b8a8 87a62de0
8792c330
          8792c280 00000080 8792c280 8008c580 80490000 8005d9b8 00000007
8026077c
          87821a7c 00000000 00000303 000001b6 80490000 00000000 00000000
00000000
          ...
[    3.960000] Call Trace:
[    3.960000] [<8008b6cc>] copy_strings+0x1d4/0x398
[    3.960000] [<8008b8a8>] copy_strings_kernel+0x18/0x2c
[    3.960000] [<8008c580>] do_execve+0x2e4/0x494
[    3.960000] [<800057e4>] kernel_init+0x44/0x10c
[    3.960000] [<80001478>] ret_from_kernel_thread+0x14/0x1c
[    3.960000]
[    3.960000]
Code: 08022db3  2c420001  24020001 <00020336> 0c00531e  02002021
0c018523  02002021  08022e18
[    4.140000] ---[ end trace 657437cc286ac3a9 ]---
[    4.140000] ------------[ cut here ]------------
[    4.150000] WARNING: at lib/vsprintf.c:1426 vsnprintf+0x5c/0x3a0()
[    4.150000] Modules linked in:
[    4.160000] CPU: 0 PID: 1 Comm: swapper Tainted: G      D      3.10.44 #6
[    4.160000] Stack : 00000000 00000000 00000000 00000000 8049d512
0000003d 87821b00 804c0000
          8025f9bc 802ab4fb 00000001 8049ccbc 87821b00 804c0000 8ee79aeb
ffffffff
          7fff7000 8001aa54 00000003 8001844c 802793fc 804c0000 802612f8
87823b14
          00000000 00000000 00000000 00000000 00000000 00000000 00000000
00000000
          00000000 00000000 00000000 00000000 00000000 00000000 00000000
87823aa0
          ...
[    4.200000] Call Trace:
[    4.200000] [<8001028c>] show_stack+0x48/0x70
[    4.210000] [<800185bc>] warn_slowpath_common+0x78/0xa8
[    4.210000] [<80018674>] warn_slowpath_null+0x18/0x24
[    4.220000] [<80118f50>] vsnprintf+0x5c/0x3a0
[    4.220000] [<80119744>] vscnprintf+0x14/0x34
[    4.230000] [<80055808>] crashlog_printf+0x50/0x6c
[    4.230000] [<80055878>] crashlog_do_dump+0x54/0x138
[    4.240000] [<8001b96c>] kmsg_dump+0xe4/0x120
[    4.240000] [<80010420>] die+0xb8/0x110
[    4.250000] [<800105e0>] do_trap_or_bp+0x120/0x184
[    4.250000] [<80001420>] ret_from_exception+0x0/0x10
[    4.260000] [<8008b6cc>] copy_strings+0x1d4/0x398
[    4.260000] [<8008b8a8>] copy_strings_kernel+0x18/0x2c
[    4.270000] [<8008c580>] do_execve+0x2e4/0x494
[    4.270000] [<800057e4>] kernel_init+0x44/0x10c
[    4.280000] [<80001478>] ret_from_kernel_thread+0x14/0x1c
[    4.280000]

> ---
>  arch/mips/bcm47xx/bcm47xx_private.h |  3 ++
>  arch/mips/bcm47xx/prom.c            | 68 ++++++++++++++++++++++++++++++++++++-
>  arch/mips/bcm47xx/setup.c           |  3 ++
>  arch/mips/include/asm/pgtable-32.h  |  2 ++
>  arch/mips/mm/tlb-r4k.c              |  2 +-
>  5 files changed, 76 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/mips/bcm47xx/bcm47xx_private.h b/arch/mips/bcm47xx/bcm47xx_private.h
> index 0194c3b..f1cc9d0 100644
> --- a/arch/mips/bcm47xx/bcm47xx_private.h
> +++ b/arch/mips/bcm47xx/bcm47xx_private.h
> @@ -3,6 +3,9 @@
>  
>  #include <linux/kernel.h>
>  
> +/* prom.c */
> +void __init bcm47xx_prom_highmem_init(void);
> +
>  /* buttons.c */
>  int __init bcm47xx_buttons_register(void);
>  
> diff --git a/arch/mips/bcm47xx/prom.c b/arch/mips/bcm47xx/prom.c
> index 1a03a2f..1b170bf 100644
> --- a/arch/mips/bcm47xx/prom.c
> +++ b/arch/mips/bcm47xx/prom.c
> @@ -51,6 +51,8 @@ __init void bcm47xx_set_system_type(u16 chip_id)
>  		 chip_id);
>  }
>  
> +static unsigned long lowmem __initdata;
> +
>  static __init void prom_init_mem(void)
>  {
>  	unsigned long mem;
> @@ -87,6 +89,7 @@ static __init void prom_init_mem(void)
>  		if (!memcmp(prom_init, prom_init + mem, 32))
>  			break;
>  	}
> +	lowmem = mem;
>  
>  	/* Ignoring the last page when ddr size is 128M. Cached
>  	 * accesses to last page is causing the processor to prefetch
> @@ -95,7 +98,6 @@ static __init void prom_init_mem(void)
>  	 */
>  	if (c->cputype == CPU_74K && (mem == (128  << 20)))
>  		mem -= 0x1000;
> -
>  	add_memory_region(0, mem, BOOT_MEM_RAM);
>  }
>  
> @@ -114,3 +116,67 @@ void __init prom_init(void)
>  void __init prom_free_prom_memory(void)
>  {
>  }
> +
> +#if defined(CONFIG_BCM47XX_BCMA) && defined(CONFIG_HIGHMEM)
> +
> +#define EXTVBASE	0xc0000000
> +#define ENTRYLO(x)	((pte_val(pfn_pte((x) >> _PFN_SHIFT, PAGE_KERNEL_UNCACHED)) >> 6) | 1)
> +
> +#include <asm/tlbflush.h>
> +
> +/* Stripped version of tlb_init, with the call to build_tlb_refill_handler
> + * dropped. Calling it at this stage causes a hang.
> + */
> +void __cpuinit early_tlb_init(void)
> +{
> +	write_c0_pagemask(PM_DEFAULT_MASK);
> +	write_c0_wired(0);
> +	temp_tlb_entry = current_cpu_data.tlbsize - 1;
> +	local_flush_tlb_all();
> +}
> +
> +void __init bcm47xx_prom_highmem_init(void)
> +{
> +	unsigned long off = (unsigned long)prom_init;
> +	unsigned long extmem = 0;
> +	bool highmem_region = false;
> +
> +	if (WARN_ON(bcm47xx_bus_type != BCM47XX_BUS_TYPE_BCMA))
> +		return;
> +
> +	if (bcm47xx_bus.bcma.bus.chipinfo.id == BCMA_CHIP_ID_BCM4706)
> +		highmem_region = true;
> +
> +	if (lowmem != 128 << 20 || !highmem_region)
> +		return;
> +
> +	early_tlb_init();
> +
> +	/* Add one temporary TLB entry to map SDRAM Region 2.
> +	 *      Physical        Virtual
> +	 *      0x80000000      0xc0000000      (1st: 256MB)
> +	 *      0x90000000      0xd0000000      (2nd: 256MB)
> +	 */
> +	add_temporary_entry(ENTRYLO(0x80000000),
> +			    ENTRYLO(0x80000000 + (256 << 20)),
> +			    EXTVBASE, PM_256M);
> +
> +	off = EXTVBASE + __pa(off);
> +	for (extmem = 128 << 20; extmem < 512 << 20; extmem <<= 1) {
> +		if (!memcmp(prom_init, (void *)(off + extmem), 16))
> +			break;
> +	}
> +	extmem -= lowmem;
> +
> +	early_tlb_init();
> +
> +	if (!extmem)
> +		return;
> +
> +	pr_warn("Found %lu MiB of extra memory, but highmem is unsupported yet!\n",
> +		extmem >> 20);
> +
> +	/* TODO: Register extra memory */
> +}
> +
> +#endif /* defined(CONFIG_BCM47XX_BCMA) && defined(CONFIG_HIGHMEM) */
> diff --git a/arch/mips/bcm47xx/setup.c b/arch/mips/bcm47xx/setup.c
> index 63a4b0e..8c8e7cd 100644
> --- a/arch/mips/bcm47xx/setup.c
> +++ b/arch/mips/bcm47xx/setup.c
> @@ -218,6 +218,9 @@ void __init plat_mem_setup(void)
>  		bcm47xx_bus_type = BCM47XX_BUS_TYPE_BCMA;
>  		bcm47xx_register_bcma();
>  		bcm47xx_set_system_type(bcm47xx_bus.bcma.bus.chipinfo.id);
> +#ifdef CONFIG_HIGHMEM
> +		bcm47xx_prom_highmem_init();
> +#endif
>  #endif
>  	} else {
>  		printk(KERN_INFO "bcm47xx: using ssb bus\n");
> diff --git a/arch/mips/include/asm/pgtable-32.h b/arch/mips/include/asm/pgtable-32.h
> index 2b11332..cd7d606 100644
> --- a/arch/mips/include/asm/pgtable-32.h
> +++ b/arch/mips/include/asm/pgtable-32.h
> @@ -18,6 +18,8 @@
>  
>  #include <asm-generic/pgtable-nopmd.h>
>  
> +extern int temp_tlb_entry __cpuinitdata;
> +
>  /*
>   * - add_temporary_entry() add a temporary TLB entry. We use TLB entries
>   *	starting at the top and working down. This is for populating the
> diff --git a/arch/mips/mm/tlb-r4k.c b/arch/mips/mm/tlb-r4k.c
> index 04feeb5..92c9efdb 100644
> --- a/arch/mips/mm/tlb-r4k.c
> +++ b/arch/mips/mm/tlb-r4k.c
> @@ -397,7 +397,7 @@ int __init has_transparent_hugepage(void)
>   * lifetime of the system
>   */
>  
> -static int temp_tlb_entry __cpuinitdata;
> +int temp_tlb_entry __cpuinitdata;
>  
>  __init int add_temporary_entry(unsigned long entrylo0, unsigned long entrylo1,
>  			       unsigned long entryhi, unsigned long pagemask)
> 
