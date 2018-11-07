Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 07 Nov 2018 01:10:18 +0100 (CET)
Received: (from localhost user: 'macro', uid#1010) by eddie.linux-mips.org
        with ESMTP id S23992852AbeKGAIbp0GjY (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 7 Nov 2018 01:08:31 +0100
Date:   Wed, 7 Nov 2018 00:08:31 +0000 (GMT)
From:   "Maciej W. Rozycki" <macro@linux-mips.org>
To:     Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>
cc:     Christoph Hellwig <hch@lst.de>, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] MIPS: SiByte: Enable swiotlb for SWARM and BigSur
Message-ID: <alpine.LFD.2.21.1811050501010.20378@eddie.linux-mips.org>
User-Agent: Alpine 2.21 (LFD 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 67114
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@linux-mips.org
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

The Broadcom SiByte BCM1250, BCM1125, and BCM1125H SOCs have an onchip 
DRAM controller that supports memory amounts of up to 16GiB, and due to 
how the address decoder has been wired in the SOC any memory beyond 1GiB 
is actually mapped starting from 4GiB physical up, that is beyond the 
32-bit addressable limit.  Consequently if the maximum amount of memory 
has been installed, then it will span up to 19GiB.

Many of the evaluation boards we support that are based on one of these 
SOCs have their memory soldered and the amount present fits in the 
32-bit address range.  The BCM91250A SWARM board however has actual DIMM 
slots and accepts, depending on the peripherals revision of the SOC, up 
to 4GiB or 8GiB of memory in commercially available JEDEC modules[2].  
I believe this is also the case with the BCM91250C2 LittleSur board. 
This means that up to either 3GiB or 7GiB of memory requires 64-bit 
addressing to access.

I believe the BCM91480B BigSur board, which has the BCM1480 SOC instead, 
accepts at least as much memory, although I have no documentation or 
actual hardware available to verify that.

Both systems have PCI slots installed for use by any PCI option boards, 
including ones that only support 32-bit addressing (additionally the 
32-bit PCI host bridge of the BCM1250, BCM1125, and BCM1125H SOCs limits 
addressing to 32-bits), and there is no IOMMU available.  Therefore for 
PCI DMA to work in the presence of memory beyond enable swiotlb for the
affected systems.

All the other SOC onchip DMA devices use 40-bit addressing and therefore 
can address the whole memory, so only enable swiotlb if PCI support and 
support for DMA beyond 4GiB have been both enabled in the configuration 
of the kernel.

This shows up as follows:

Broadcom SiByte BCM1250 B2 @ 800 MHz (SB1 rev 2)
Board type: SiByte BCM91250A (SWARM)
Determined physical RAM map:
 memory: 000000000fe7fe00 @ 0000000000000000 (usable)
 memory: 000000001ffffe00 @ 0000000080000000 (usable)
 memory: 000000000ffffe00 @ 00000000c0000000 (usable)
 memory: 0000000087fffe00 @ 0000000100000000 (usable)
software IO TLB: mapped [mem 0xcbffc000-0xcfffc000] (64MB)

in the bootstrap log and removes failures like these:

defxx 0000:02:00.0: dma_direct_map_page: overflow 0x0000000185bc6080+4608 of device mask ffffffff bus mask 0
fddi0: Receive buffer allocation failed
fddi0: Adapter open failed!
IP-Config: Failed to open fddi0
defxx 0000:09:08.0: dma_direct_map_page: overflow 0x0000000185bc6080+4608 of device mask ffffffff bus mask ffffffff
fddi1: Receive buffer allocation failed
fddi1: Adapter open failed!
IP-Config: Failed to open fddi1

when memory beyond 4GiB is handed out to devices that can only do 32-bit 
addressing.

This updates commit cce335ae47e2 ("[MIPS] 64-bit Sibyte kernels need 
DMA32.").

References:

[1] "BCM1250/BCM1125/BCM1125H User Manual", Revision 1250_1125-UM100-R, 
    Broadcom Corporation, 21 Oct 2002, Section 3: "System Overview", 
    "Memory Map", pp. 34-38

[2] "BCM91250A User Manual", Revision 91250A-UM100-R, Broadcom 
    Corporation, 18 May 2004, Section 3: "Physical Description", 
    "Supported DRAM", p. 23

Signed-off-by: Maciej W. Rozycki <macro@linux-mips.org>
References: cce335ae47e2 ("[MIPS] 64-bit Sibyte kernels need DMA32.")
---
Hi,

 I have also built LittleSur and BigSur configurations, however I have no 
way to verify them at run time.

 Also I don't know why LittleSur does not select ZONE_DMA32, but it looks 
to me like an oversight; and overall, given the observations made above, I 
suspect ZONE_DMA32 selection should depend on PCI too.

  Maciej
---
 arch/mips/Kconfig                |    3 +++
 arch/mips/sibyte/common/Makefile |    1 +
 arch/mips/sibyte/common/dma.c    |   19 +++++++++++++++++++
 3 files changed, 23 insertions(+)

linux-mips-sibyte-swiotlb.diff
Index: linux-20181104-swarm64-eb/arch/mips/Kconfig
===================================================================
--- linux-20181104-swarm64-eb.orig/arch/mips/Kconfig
+++ linux-20181104-swarm64-eb/arch/mips/Kconfig
@@ -794,6 +794,7 @@ config SIBYTE_SWARM
 	select SYS_SUPPORTS_HIGHMEM
 	select SYS_SUPPORTS_LITTLE_ENDIAN
 	select ZONE_DMA32 if 64BIT
+	select SWIOTLB if ARCH_DMA_ADDR_T_64BIT && PCI
 
 config SIBYTE_LITTLESUR
 	bool "Sibyte BCM91250C2-LittleSur"
@@ -805,6 +806,7 @@ config SIBYTE_LITTLESUR
 	select SYS_SUPPORTS_BIG_ENDIAN
 	select SYS_SUPPORTS_HIGHMEM
 	select SYS_SUPPORTS_LITTLE_ENDIAN
+	select SWIOTLB if ARCH_DMA_ADDR_T_64BIT && PCI
 
 config SIBYTE_SENTOSA
 	bool "Sibyte BCM91250E-Sentosa"
@@ -826,6 +828,7 @@ config SIBYTE_BIGSUR
 	select SYS_SUPPORTS_HIGHMEM
 	select SYS_SUPPORTS_LITTLE_ENDIAN
 	select ZONE_DMA32 if 64BIT
+	select SWIOTLB if ARCH_DMA_ADDR_T_64BIT && PCI
 
 config SNI_RM
 	bool "SNI RM200/300/400"
Index: linux-20181104-swarm64-eb/arch/mips/sibyte/common/Makefile
===================================================================
--- linux-20181104-swarm64-eb.orig/arch/mips/sibyte/common/Makefile
+++ linux-20181104-swarm64-eb/arch/mips/sibyte/common/Makefile
@@ -1,4 +1,5 @@
 obj-y := cfe.o
+obj-$(CONFIG_SWIOTLB)			+= dma.o
 obj-$(CONFIG_SIBYTE_BUS_WATCHER)	+= bus_watcher.o
 obj-$(CONFIG_SIBYTE_CFE_CONSOLE)	+= cfe_console.o
 obj-$(CONFIG_SIBYTE_TBPROF)		+= sb_tbprof.o
Index: linux-20181104-swarm64-eb/arch/mips/sibyte/common/dma.c
===================================================================
--- /dev/null
+++ linux-20181104-swarm64-eb/arch/mips/sibyte/common/dma.c
@@ -0,0 +1,19 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ *	DMA support for Broadcom SiByte platforms.
+ *
+ *	Copyright (c) 2018  Maciej W. Rozycki
+ *
+ *	This program is free software; you can redistribute it and/or
+ *	modify it under the terms of the GNU General Public License
+ *	as published by the Free Software Foundation; either version
+ *	2 of the License, or (at your option) any later version.
+ */
+
+#include <linux/swiotlb.h>
+#include <asm/bootinfo.h>
+
+void __init plat_swiotlb_setup(void)
+{
+	swiotlb_init(1);
+}
