Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 12 Jul 2012 22:03:39 +0200 (CEST)
Received: from forward7.mail.yandex.net ([77.88.61.37]:49198 "EHLO
        forward7.mail.yandex.net" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903847Ab2GLUDf (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 12 Jul 2012 22:03:35 +0200
Received: from web6e.yandex.ru (web6e.yandex.ru [77.88.60.75])
        by forward7.mail.yandex.net (Yandex) with ESMTP id 400A61C1EAA
        for <linux-mips@linux-mips.org>; Fri, 13 Jul 2012 00:03:26 +0400 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail;
        t=1342123406; bh=Zu8Ei40mbe6//n/rloKV6uPg3wagyVcx7uAemWzyixM=;
        h=From:To:Subject:MIME-Version:Message-Id:Date:
         Content-Transfer-Encoding:Content-Type;
        b=mYMlugZU/UrO4ueN0Tr5wbz7H6pFhtverjWmsikZVbD7zjO+vTGbr1eSeaohJhuEO
         nGkNOSDZX37264r+Tvr6VFbeaG8bwm8nqZXPaIEchx8dcvZ3PAkT1f1orF+uhnjPEx
         fppbUOJJwuvhdaOeWKjRRQ8BLzDoiVurHpIGfhRw=
Received: from 127.0.0.1 (localhost.localdomain [127.0.0.1])
        by web6e.yandex.ru (Yandex) with ESMTP id 110AF2F80EA;
        Fri, 13 Jul 2012 00:03:26 +0400 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail;
        t=1342123406; bh=Zu8Ei40mbe6//n/rloKV6uPg3wagyVcx7uAemWzyixM=;
        h=From:To:Subject:MIME-Version:Message-Id:Date:
         Content-Transfer-Encoding:Content-Type;
        b=mYMlugZU/UrO4ueN0Tr5wbz7H6pFhtverjWmsikZVbD7zjO+vTGbr1eSeaohJhuEO
         nGkNOSDZX37264r+Tvr6VFbeaG8bwm8nqZXPaIEchx8dcvZ3PAkT1f1orF+uhnjPEx
         fppbUOJJwuvhdaOeWKjRRQ8BLzDoiVurHpIGfhRw=
Received: from wimax-client.yota.ru (wimax-client.yota.ru [178.176.146.54]) by web6e.yandex.ru with HTTP;
        Fri, 13 Jul 2012 00:03:25 +0400
From:   kr kr <kr-jiffy@yandex.ru>
To:     linux-mips@linux-mips.org
Subject: [mips32r1 cpu] Advice needed: "Machine Check exception - caused by multiple matching entries in the TLB"
MIME-Version: 1.0
Message-Id: <194011342123405@web6e.yandex.ru>
Date:   Fri, 13 Jul 2012 00:03:25 +0400
X-Mailer: Yamail [ http://yandex.ru ] 5.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain
X-archive-position: 33895
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: kr-jiffy@yandex.ru
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
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Status: A

Hi,

I've been trying to run a custom board with mips32 custom cpu (Elvees multicore) with MIPS-I binaries, provided by Debian 'squeeze' release.
So far, I've had "Kernel panic - not syncing: Caught Machine Check exception - caused by multiple matching entries in the TLB".
With a buildroot fs built as mips32 the board runs just fine, with a buildroot fs built as mips-I I've had issues similar to debian MIPS-I fs.
Have I been missing something very obvious?

Is that a completely wrong settings for a MIPS32 cpu to run MIPS-I binaries? I've checked Malta's Cobalt's and Broadcom's kernel configs from Debian *.deb and looks my config settings are plausible,
I mean I don't need to attempt to degrade cpu configuration to CPU_R3000 or do similar weird things? Nothing obviously wrong in my kernel config for a kernel intended to run MIPS-I binaries?

My kernel config contains the next definitions:
CONFIG_MULTICORE=y

CONFIG_CPU_MIPS32_R1=y
CONFIG_SYS_HAS_CPU_MIPS32_R1=y
CONFIG_CPU_MIPS32=y
CONFIG_CPU_MIPSR1=y
CONFIG_SYS_SUPPORTS_32BIT_KERNEL=y
CONFIG_CPU_SUPPORTS_32BIT_KERNEL=y

CONFIG_32BIT=y
CONFIG_PAGE_SIZE_4KB=y 
#CONFIG_PAGE_SIZE_16KB is not set
# CONFIG_PAGE_SIZE_64KB is not set
CONFIG_MIPS_MT_DISABLED=y
# CONFIG_MIPS_MT_SMP is not set
CONFIG_SYS_SUPPORTS_MULTITHREADING=y
# CONFIG_MIPS_VPE_LOADER is not set
# CONFIG_ARCH_PHYS_ADDR_T_64BIT is not set
CONFIG_CPU_HAS_SYNC=y
CONFIG_GENERIC_HARDIRQS=y
CONFIG_GENERIC_IRQ_PROBE=y
CONFIG_CPU_SUPPORTS_HIGHMEM=y
CONFIG_ARCH_FLATMEM_ENABLE=y
CONFIG_ARCH_POPULATES_NODE_MAP=y
CONFIG_SELECT_MEMORY_MODEL=y
CONFIG_FLATMEM_MANUAL=y
CONFIG_FLATMEM=y
CONFIG_FLAT_NODE_MEM_MAP=y
CONFIG_PAGEFLAGS_EXTENDED=y
CONFIG_SPLIT_PTLOCK_CPUS=4
# CONFIG_PHYS_ADDR_T_64BIT is not set
CONFIG_ZONE_DMA_FLAG=0
CONFIG_VIRT_TO_BUS=y


Console output:

[    0.000000] Linux version 2.6.36-multicore (koivu@koivu) (gcc version 4.3.5 (Buildroot 2
011.05) ) #5 Fri Jul 6 22:55:20 MSK 2012
[    0.000000] CPU revision is: 000a2001 (Elvees Multicore)
[    0.000000] FPU revision is: 00030001
[    0.000000] MIPS  clk frequency: 290 MHz, frequency multiplier: 58
[    0.000000] MPORT clk frequency: 100 MHz, frequency multiplier: 20
[    0.000000] Multicore specific initialisation complete
[    0.000000] Determined physical RAM map:
[    0.000000]  memory: 04000000 @ 00000000 (usable)
[    0.000000] Initrd not found or empty - disabling initrd
[    0.000000] Zone PFN ranges:
[    0.000000]   Normal   0x00000000 -> 0x00004000
[    0.000000] Movable zone start PFN for each node
[    0.000000] early_node_map[1] active PFN ranges
[    0.000000]     0: 0x00000000 -> 0x00004000
[    0.000000] Built 1 zonelists in Zone order, mobility grouping on.  Total pages: 16240
[    0.000000] Kernel command line:  console=ttyS0,115200N8 root=/dev/ram0
[    0.000000] PID hash table entries: 256 (order: -2, 1024 bytes)
[    0.000000] Dentry cache hash table entries: 8192 (order: 3, 32768 bytes)
[    0.000000] Inode-cache hash table entries: 4096 (order: 2, 16384 bytes)
[    0.000000] Memory: 60224k/65536k available (1349k kernel code, 5312k reserved, 214k dat
a, 2928k init, 0k highmem)
[    0.000000] NR_IRQS:105
[    0.000000] console [ttyS0] enabled
[    0.004000] Calibrating delay loop... 10.49 BogoMIPS (lpj=20992)
[    0.080000] pid_max: default: 32768 minimum: 301
[    0.084000] Mount-cache hash table entries: 512
[    0.160000] Multicore AMBA bus registered
[    0.176000] bio: create slab <bio-0> at 0
[    0.184000] Switching to clocksource MIPS
[    4.436000] msgmni has been set to 117
[    4.444000] io scheduler noop registered
[    4.448000] io scheduler deadline registered (default)
[    7.944000] Serial: 8250/16550 driver, 4 ports, IRQ sharing disabled
[    7.964000] serial8250: ttyS0 at MMIO 0xb82f3000 (irq = 13) is a 16550
[    7.976000] serial8250: ttyS1 at MMIO 0xb82f3800 (irq = 14) is a 16550
[    8.536000] brd: module loaded
[    8.804000] loop: module loaded
[    9.028000] Freeing unused kernel memory: 2928k freed
Initializing random number generator... done.

Please press Enter to activate this console. 
[   12.560000] Got mcheck at 0044f6a8
[   12.560000] Cpu 0
[   12.560000] $ 0   : 00000000 3000fc00 00000000 004eb02c
[   12.560000] $ 4   : 00000001 00000004 004eb02c 00000000
[   12.560000] $ 8   : 00000000 00000000 8002b6c8 fffffffc
[   12.560000] $12   : fffffffc 00000807 00000800 0044952c
[   12.560000] $16   : 004c1958 0000005c 7ffdf3e8 7ffdf440
[   12.560000] $20   : 00000001 004f0000 ffffffff 004f0000
[   12.560000] $24   : 00000163 004eb02c                  
[   12.560000] $28   : 004f0df0 7ffdf240 004c1934 0044f090
[   12.560000] Hi    : 0000025b
[   12.560000] Lo    : 00035a4f
[   12.560000] epc   : 0044f6a8 0x44f6a8
[   12.560000]     Not tainted
[   12.560000] ra    : 0044f090 0x44f090
[   12.560000] Status: 2020fc13    USER EXL IE 
[   12.560000] Cause : 10000060
[   12.560000] PrId  : 000a2001 (Elvees Multicore)
[   12.560000] Index   : 5
[   12.560000] Pagemask: 0
[   12.560000] EntryHi : 0044e046
[   12.560000] EntryLo0: 00000000
[   12.560000] EntryLo1: 000f7c42
[   12.560000] 
[   12.560000] Index:  0 pgmask=4kb va=2ac38000 asid=46
[   12.560000]  [pa=03eab000 c=3 d=0 v=1 g=0] [pa=03eac000 c=3 d=0 v=1 g=0]
[   12.560000] Index:  1 pgmask=4kb va=00448000 asid=46
[   12.560000]  [pa=00000000 c=3 d=0 v=0 g=0] [pa=03deb000 c=3 d=0 v=1 g=0]
[   12.560000] Index:  2 pgmask=4kb va=2ac3c000 asid=46
[   12.560000]  [pa=03eaf000 c=3 d=0 v=1 g=0] [pa=03eb0000 c=3 d=0 v=1 g=0]
[   12.560000] Index:  3 pgmask=4kb va=2ac3a000 asid=46
[   12.560000]  [pa=03ead000 c=3 d=0 v=1 g=0] [pa=03eae000 c=3 d=0 v=1 g=0]
[   12.560000] Index:  4 pgmask=4kb va=00444000 asid=46
[   12.560000]  [pa=03de6000 c=3 d=0 v=1 g=0] [pa=03de7000 c=3 d=0 v=1 g=0]
[   12.560000] Index:  5 pgmask=4kb va=00446000 asid=46
[   12.560000]  [pa=03de8000 c=3 d=0 v=1 g=0] [pa=00000000 c=3 d=0 v=0 g=0]
[   12.560000] Index:  6 pgmask=4kb va=00440000 asid=46
[   12.560000]  [pa=00000000 c=3 d=0 v=0 g=0] [pa=03de3000 c=3 d=0 v=1 g=0]
[   12.560000] Index:  7 pgmask=4kb va=004ec000 asid=46
[   12.560000]  [pa=00454000 c=3 d=1 v=1 g=0] [pa=00441000 c=3 d=1 v=1 g=0]
[   12.560000] Index:  8 pgmask=4kb va=004c0000 asid=46
[   12.560000]  [pa=03e62000 c=3 d=0 v=1 g=0] [pa=03e63000 c=3 d=0 v=1 g=0]
[   12.560000] Index:  9 pgmask=4kb va=0044e000 asid=46
[   12.560000]  [pa=00000000 c=3 d=0 v=0 g=0] [pa=03df1000 c=3 d=0 v=1 g=0]
[   12.560000] Index: 10 pgmask=4kb va=2ac74000 asid=46
[   12.560000]  [pa=03ee7000 c=3 d=0 v=1 g=0] [pa=03ee8000 c=3 d=0 v=1 g=0]
[   12.560000] Index: 11 pgmask=4kb va=7ffde000 asid=46
[   12.560000]  [pa=00458000 c=3 d=1 v=1 g=0] [pa=0109d000 c=3 d=1 v=1 g=0]
[   12.560000] Index: 12 pgmask=4kb va=0040a000 asid=46
[   12.560000]  [pa=03dac000 c=3 d=0 v=1 g=0] [pa=00000000 c=3 d=0 v=0 g=0]
[   12.560000] Index: 13 pgmask=4kb va=2ac80000 asid=46
[   12.560000]  [pa=00000000 c=3 d=0 v=0 g=0] [pa=03ef4000 c=3 d=0 v=1 g=0]
[   12.560000] Index: 14 pgmask=4kb va=004ea000 asid=46
[   12.560000]  [pa=00000000 c=3 d=0 v=0 g=0] [pa=0049c000 c=3 d=1 v=1 g=0]
[   12.560000] Index: 15 pgmask=4kb va=004e8000 asid=46
[   12.560000]  [pa=00450000 c=3 d=1 v=1 g=0] [pa=0109f000 c=3 d=1 v=1 g=0]
[   12.560000] 
[   12.560000] 
[   12.560000] Code: afa00104  10000235  00000000 <8f85804c> 00000000  8ca50000  00000000  
afa50128  8fb90128 
[   12.560000] Kernel panic - not syncing: Caught Machine Check exception - caused by multiple matching entries in the TLB.

TIA,
Yuri
