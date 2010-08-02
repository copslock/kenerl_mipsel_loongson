Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 02 Aug 2010 20:44:25 +0200 (CEST)
Received: from sj-iport-5.cisco.com ([171.68.10.87]:31711 "EHLO
        sj-iport-5.cisco.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S1492744Ab0HBSoP (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 2 Aug 2010 20:44:15 +0200
Authentication-Results: sj-iport-5.cisco.com; dkim=neutral (message not signed) header.i=none
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: AvsEAAqvVkyrR7Hu/2dsb2JhbACgA3GpF5tGgmiCUQSEFg
X-IronPort-AV: E=Sophos;i="4.55,304,1278288000"; 
   d="scan'208";a="234311169"
Received: from sj-core-5.cisco.com ([171.71.177.238])
  by sj-iport-5.cisco.com with ESMTP; 02 Aug 2010 18:43:59 +0000
Received: from dvomlehn-lnx2.corp.sa.net (dhcp-171-71-47-241.cisco.com [171.71.47.241])
        by sj-core-5.cisco.com (8.13.8/8.14.3) with ESMTP id o72IhxJM021638;
        Mon, 2 Aug 2010 18:43:59 GMT
Date:   Mon, 2 Aug 2010 11:44:00 -0700
From:   David VomLehn <dvomlehn@cisco.com>
To:     linux-mips@linux-mips.org
Cc:     ralf@linux-mips.org
Subject: [PATCH][MIPS] PowerTV: add Gaia platform definitions
Message-ID: <20100802184359.GA10915@dvomlehn-lnx2.corp.sa.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.18 (2008-05-17)
Return-Path: <dvomlehn@cisco.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 27537
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dvomlehn@cisco.com
Precedence: bulk
X-list: linux-mips

Add definitions to support the Gaia platform

Define ASIC address, memory preallocations, and initialization code for the
Gaia platform.

Signed-off-by: David VomLehn <dvomlehn@cisco.com>
---
 arch/mips/include/asm/mach-powertv/asic.h      |    4 +
 arch/mips/include/asm/mach-powertv/asic_regs.h |    4 +-
 arch/mips/powertv/asic/Makefile                |    6 +-
 arch/mips/powertv/asic/asic-gaia.c             |   96 ++++
 arch/mips/powertv/asic/asic_devices.c          |   20 +-
 arch/mips/powertv/asic/prealloc-gaia.c         |  589 ++++++++++++++++++++++++
 6 files changed, 708 insertions(+), 11 deletions(-)

diff --git a/arch/mips/include/asm/mach-powertv/asic.h b/arch/mips/include/asm/mach-powertv/asic.h
index bcad43a..df33d93 100644
--- a/arch/mips/include/asm/mach-powertv/asic.h
+++ b/arch/mips/include/asm/mach-powertv/asic.h
@@ -40,19 +40,23 @@ enum family_type {
 	FAMILY_8600VZB,
 	FAMILY_1500VZE,
 	FAMILY_1500VZF,
+	FAMILY_8700,
 	FAMILIES
 };
 
 /* Register maps for each ASIC */
 extern const struct register_map calliope_register_map;
 extern const struct register_map cronus_register_map;
+extern const struct register_map gaia_register_map;
 extern const struct register_map zeus_register_map;
 
 extern struct resource dvr_cronus_resources[];
+extern struct resource dvr_gaia_resources[];
 extern struct resource dvr_zeus_resources[];
 extern struct resource non_dvr_calliope_resources[];
 extern struct resource non_dvr_cronus_resources[];
 extern struct resource non_dvr_cronuslite_resources[];
+extern struct resource non_dvr_gaia_resources[];
 extern struct resource non_dvr_vz_calliope_resources[];
 extern struct resource non_dvr_vze_calliope_resources[];
 extern struct resource non_dvr_vzf_calliope_resources[];
diff --git a/arch/mips/include/asm/mach-powertv/asic_regs.h b/arch/mips/include/asm/mach-powertv/asic_regs.h
index 1e11236..2657ae6 100644
--- a/arch/mips/include/asm/mach-powertv/asic_regs.h
+++ b/arch/mips/include/asm/mach-powertv/asic_regs.h
@@ -27,7 +27,8 @@ enum asic_type {
 	ASIC_CALLIOPE,
 	ASIC_CRONUS,
 	ASIC_CRONUSLITE,
-	ASICS
+	ASIC_GAIA,
+	ASICS			/* Number of supported ASICs */
 };
 
 /* hardcoded values read from Chip Version registers */
@@ -37,6 +38,7 @@ enum asic_type {
 
 #define NAND_FLASH_BASE		0x03000000
 #define CALLIOPE_IO_BASE	0x08000000
+#define GAIA_IO_BASE		0x09000000
 #define CRONUS_IO_BASE		0x09000000
 #define ZEUS_IO_BASE		0x09000000
 
diff --git a/arch/mips/powertv/asic/Makefile b/arch/mips/powertv/asic/Makefile
index bebfdcf..f0e95dc 100644
--- a/arch/mips/powertv/asic/Makefile
+++ b/arch/mips/powertv/asic/Makefile
@@ -16,8 +16,8 @@
 # Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
 #
 
-obj-y += asic-calliope.o asic-cronus.o asic-zeus.o asic_devices.o asic_int.o \
-	 irq_asic.o prealloc-calliope.o prealloc-cronus.o \
-	 prealloc-cronuslite.o prealloc-zeus.o
+obj-y += asic-calliope.o asic-cronus.o asic-gaia.o asic-zeus.o \
+	asic_devices.o asic_int.o irq_asic.o prealloc-calliope.o \
+	prealloc-cronus.o prealloc-cronuslite.o prealloc-gaia.o prealloc-zeus.o
 
 EXTRA_CFLAGS += -Wall -Werror
diff --git a/arch/mips/powertv/asic/asic-gaia.c b/arch/mips/powertv/asic/asic-gaia.c
new file mode 100644
index 0000000..91dda68
--- /dev/null
+++ b/arch/mips/powertv/asic/asic-gaia.c
@@ -0,0 +1,96 @@
+/*
+ * Locations of devices in the Gaia ASIC
+ *
+ * Copyright (C) 2005-2009 Scientific-Atlanta, Inc.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301 USA
+ *
+ * Author:       David VomLehn
+ */
+
+#include <linux/init.h>
+#include <asm/mach-powertv/asic.h>
+
+const struct register_map gaia_register_map __initdata = {
+	.eic_slow0_strt_add = {.phys = GAIA_IO_BASE + 0x000000},
+	.eic_cfg_bits = {.phys = GAIA_IO_BASE + 0x000038},
+	.eic_ready_status = {.phys = GAIA_IO_BASE + 0x00004C},
+
+	.chipver3 = {.phys = GAIA_IO_BASE + 0x2A0800},
+	.chipver2 = {.phys = GAIA_IO_BASE + 0x2A0804},
+	.chipver1 = {.phys = GAIA_IO_BASE + 0x2A0808},
+	.chipver0 = {.phys = GAIA_IO_BASE + 0x2A080C},
+
+	/* The registers of IRBlaster */
+	.uart1_intstat = {.phys = GAIA_IO_BASE + 0x2A1800},
+	.uart1_inten = {.phys = GAIA_IO_BASE + 0x2A1804},
+	.uart1_config1 = {.phys = GAIA_IO_BASE + 0x2A1808},
+	.uart1_config2 = {.phys = GAIA_IO_BASE + 0x2A180C},
+	.uart1_divisorhi = {.phys = GAIA_IO_BASE + 0x2A1810},
+	.uart1_divisorlo = {.phys = GAIA_IO_BASE + 0x2A1814},
+	.uart1_data = {.phys = GAIA_IO_BASE + 0x2A1818},
+	.uart1_status = {.phys = GAIA_IO_BASE + 0x2A181C},
+
+	.int_stat_3 = {.phys = GAIA_IO_BASE + 0x2A2800},
+	.int_stat_2 = {.phys = GAIA_IO_BASE + 0x2A2804},
+	.int_stat_1 = {.phys = GAIA_IO_BASE + 0x2A2808},
+	.int_stat_0 = {.phys = GAIA_IO_BASE + 0x2A280C},
+	.int_config = {.phys = GAIA_IO_BASE + 0x2A2810},
+	.int_int_scan = {.phys = GAIA_IO_BASE + 0x2A2818},
+	.ien_int_3 = {.phys = GAIA_IO_BASE + 0x2A2830},
+	.ien_int_2 = {.phys = GAIA_IO_BASE + 0x2A2834},
+	.ien_int_1 = {.phys = GAIA_IO_BASE + 0x2A2838},
+	.ien_int_0 = {.phys = GAIA_IO_BASE + 0x2A283C},
+	.int_level_3_3 = {.phys = GAIA_IO_BASE + 0x2A2880},
+	.int_level_3_2 = {.phys = GAIA_IO_BASE + 0x2A2884},
+	.int_level_3_1 = {.phys = GAIA_IO_BASE + 0x2A2888},
+	.int_level_3_0 = {.phys = GAIA_IO_BASE + 0x2A288C},
+	.int_level_2_3 = {.phys = GAIA_IO_BASE + 0x2A2890},
+	.int_level_2_2 = {.phys = GAIA_IO_BASE + 0x2A2894},
+	.int_level_2_1 = {.phys = GAIA_IO_BASE + 0x2A2898},
+	.int_level_2_0 = {.phys = GAIA_IO_BASE + 0x2A289C},
+	.int_level_1_3 = {.phys = GAIA_IO_BASE + 0x2A28A0},
+	.int_level_1_2 = {.phys = GAIA_IO_BASE + 0x2A28A4},
+	.int_level_1_1 = {.phys = GAIA_IO_BASE + 0x2A28A8},
+	.int_level_1_0 = {.phys = GAIA_IO_BASE + 0x2A28AC},
+	.int_level_0_3 = {.phys = GAIA_IO_BASE + 0x2A28B0},
+	.int_level_0_2 = {.phys = GAIA_IO_BASE + 0x2A28B4},
+	.int_level_0_1 = {.phys = GAIA_IO_BASE + 0x2A28B8},
+	.int_level_0_0 = {.phys = GAIA_IO_BASE + 0x2A28BC},
+	.int_docsis_en = {.phys = GAIA_IO_BASE + 0x2A28F4},
+
+	.mips_pll_setup = {.phys = GAIA_IO_BASE + 0x1C0000},
+	.fs432x4b4_usb_ctl = {.phys = GAIA_IO_BASE + 0x1C0024},
+	.test_bus = {.phys = GAIA_IO_BASE + 0x1C00CC},
+	.crt_spare = {.phys = GAIA_IO_BASE + 0x1c0108},
+	.usb2_ohci_int_mask = {.phys = GAIA_IO_BASE + 0x20000C},
+	.usb2_strap = {.phys = GAIA_IO_BASE + 0x200014},
+	.ehci_hcapbase = {.phys = GAIA_IO_BASE + 0x21FE00},
+	.ohci_hc_revision = {.phys = GAIA_IO_BASE + 0x21fc00},
+	.bcm1_bs_lmi_steer = {.phys = GAIA_IO_BASE + 0x2E0004},
+	.usb2_control = {.phys = GAIA_IO_BASE + 0x2E004C},
+	.usb2_stbus_obc = {.phys = GAIA_IO_BASE + 0x21FF00},
+	.usb2_stbus_mess_size = {.phys = GAIA_IO_BASE + 0x21FF04},
+	.usb2_stbus_chunk_size = {.phys = GAIA_IO_BASE + 0x21FF08},
+
+	.pcie_regs = {.phys = GAIA_IO_BASE + 0x220000},
+	.tim_ch = {.phys = GAIA_IO_BASE + 0x2A2C10},
+	.tim_cl = {.phys = GAIA_IO_BASE + 0x2A2C14},
+	.gpio_dout = {.phys = GAIA_IO_BASE + 0x2A2C20},
+	.gpio_din = {.phys = GAIA_IO_BASE + 0x2A2C24},
+	.gpio_dir = {.phys = GAIA_IO_BASE + 0x2A2C2C},
+	.watchdog = {.phys = GAIA_IO_BASE + 0x2A2C30},
+	.front_panel = {.phys = GAIA_IO_BASE + 0x2A3800},
+};
diff --git a/arch/mips/powertv/asic/asic_devices.c b/arch/mips/powertv/asic/asic_devices.c
index 006285c..095a887 100644
--- a/arch/mips/powertv/asic/asic_devices.c
+++ b/arch/mips/powertv/asic/asic_devices.c
@@ -1,7 +1,6 @@
 /*
- *                   ASIC Device List Intialization
  *
- * Description:  Defines the platform resources for the SA settop.
+ * Description:  Defines the platform resources for Gaia-based settops.
  *
  * Copyright (C) 2005-2009 Scientific-Atlanta, Inc.
  *
@@ -19,11 +18,6 @@
  * along with this program; if not, write to the Free Software
  * Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301 USA
  *
- * Author:       Ken Eppinett
- *               David Schleef <ds@schleef.org>
- *
- * Description:  Defines the platform resources for the SA settop.
- *
  * NOTE: The bootloader allocates persistent memory at an address which is
  * 16 MiB below the end of the highest address in KSEG0. All fixed
  * address memory reservations must avoid this region.
@@ -289,6 +283,9 @@ static __init noinline void platform_set_family(void)
 	case BOOTLDRFAMILY('F', '1'):
 		platform_family = FAMILY_1500VZF;
 		break;
+	case BOOTLDRFAMILY('8', '7'):
+		platform_family = FAMILY_8700;
+		break;
 	default:
 		platform_family = -1;
 	}
@@ -526,6 +523,15 @@ void __init configure_platform(void)
 			"DVR_CAPABLE\n");
 		break;
 
+	case FAMILY_8700:
+		platform_features = FFS_CAPABLE | PCIE_CAPABLE;
+		asic = ASIC_GAIA;
+		set_register_map(GAIA_IO_BASE, &gaia_register_map);
+		gp_resources = dvr_gaia_resources;
+
+		pr_info("Platform: 8700 - GAIA, DVR_CAPABLE\n");
+		break;
+
 	default:
 		pr_crit("Platform:  UNKNOWN PLATFORM\n");
 		break;
diff --git a/arch/mips/powertv/asic/prealloc-gaia.c b/arch/mips/powertv/asic/prealloc-gaia.c
new file mode 100644
index 0000000..8ac8c7a
--- /dev/null
+++ b/arch/mips/powertv/asic/prealloc-gaia.c
@@ -0,0 +1,589 @@
+/*
+ * Memory pre-allocations for Gaia boxes.
+ *
+ * Copyright (C) 2005-2009 Scientific-Atlanta, Inc.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301 USA
+ *
+ * Author:       David VomLehn
+ */
+
+#include <linux/init.h>
+#include <asm/mach-powertv/asic.h>
+
+/*
+ * DVR_CAPABLE GAIA RESOURCES
+ */
+struct resource dvr_gaia_resources[] __initdata = {
+	/*
+	 *
+	 * VIDEO1 / LX1
+	 *
+	 */
+	{
+		.name   = "ST231aImage",	/* Delta-Mu 1 image and ram */
+		.start  = 0x24000000,
+		.end    = 0x241FFFFF,		/* 2MiB */
+		.flags  = IORESOURCE_MEM,
+	},
+	{
+		.name   = "ST231aMonitor",	/* 8KiB block ST231a monitor */
+		.start  = 0x24200000,
+		.end    = 0x24201FFF,
+		.flags  = IORESOURCE_MEM,
+	},
+	{
+		.name   = "MediaMemory1",
+		.start  = 0x24202000,
+		.end    = 0x25FFFFFF, /*~29.9MiB (32MiB - (2MiB + 8KiB)) */
+		.flags  = IORESOURCE_MEM,
+	},
+	/*
+	 *
+	 * VIDEO2 / LX2
+	 *
+	 */
+	{
+		.name   = "ST231bImage",	/* Delta-Mu 2 image and ram */
+		.start  = 0x60000000,
+		.end    = 0x601FFFFF,		/* 2MiB */
+		.flags  = IORESOURCE_IO,
+	},
+	{
+		.name   = "ST231bMonitor",	/* 8KiB block ST231b monitor */
+		.start  = 0x60200000,
+		.end    = 0x60201FFF,
+		.flags  = IORESOURCE_IO,
+	},
+	{
+		.name   = "MediaMemory2",
+		.start  = 0x60202000,
+		.end    = 0x61FFFFFF, /*~29.9MiB (32MiB - (2MiB + 8KiB)) */
+		.flags  = IORESOURCE_IO,
+	},
+	/*
+	 *
+	 * Sysaudio Driver
+	 *
+	 * This driver requires:
+	 *
+	 * Arbitrary Based Buffers:
+	 *  DSP_Image_Buff - DSP code and data images (1MB)
+	 *  ADSC_CPU_PCM_Buff - ADSC CPU PCM buffer (40KB)
+	 *  ADSC_AUX_Buff - ADSC AUX buffer (16KB)
+	 *  ADSC_Main_Buff - ADSC Main buffer (16KB)
+	 *
+	 */
+	{
+		.name   = "DSP_Image_Buff",
+		.start  = 0x00000000,
+		.end    = 0x000FFFFF,
+		.flags  = IORESOURCE_MEM,
+	},
+	{
+		.name   = "ADSC_CPU_PCM_Buff",
+		.start  = 0x00000000,
+		.end    = 0x00009FFF,
+		.flags  = IORESOURCE_MEM,
+	},
+	{
+		.name   = "ADSC_AUX_Buff",
+		.start  = 0x00000000,
+		.end    = 0x00003FFF,
+		.flags  = IORESOURCE_MEM,
+	},
+	{
+		.name   = "ADSC_Main_Buff",
+		.start  = 0x00000000,
+		.end    = 0x00003FFF,
+		.flags  = IORESOURCE_MEM,
+	},
+	/*
+	 *
+	 * STAVEM driver/STAPI
+	 *
+	 * This driver requires:
+	 *
+	 * Arbitrary Based Buffers:
+	 *  This memory area is used for allocating buffers for Video decoding
+	 *  purposes.  Allocation/De-allocation within this buffer is managed
+	 *  by the STAVMEM driver of the STAPI.  They could be Decimated
+	 *  Picture Buffers, Intermediate Buffers, as deemed necessary for
+	 *  video decoding purposes, for any video decoders on Zeus.
+	 *
+	 */
+	{
+		.name   = "AVMEMPartition0",
+		.start  = 0x63580000,
+		.end    = 0x64180000 - 1,  /* 12 MB total */
+		.flags  = IORESOURCE_IO,
+	},
+	/*
+	 *
+	 * DOCSIS Subsystem
+	 *
+	 * This driver requires:
+	 *
+	 * Arbitrary Based Buffers:
+	 *  Docsis -
+	 *
+	 */
+	{
+		.name   = "Docsis",
+		.start  = 0x62000000,
+		.end    = 0x62700000 - 1,	/* 7 MB total */
+		.flags  = IORESOURCE_IO,
+	},
+	/*
+	 *
+	 * GHW HAL Driver
+	 *
+	 * This driver requires:
+	 *
+	 * Arbitrary Based Buffers:
+	 *  GraphicsHeap - PowerTV Graphics Heap
+	 *
+	 */
+	{
+		.name   = "GraphicsHeap",
+		.start  = 0x62700000,
+		.end    = 0x63500000 - 1,	/* 14 MB total */
+		.flags  = IORESOURCE_IO,
+	},
+	/*
+	 *
+	 * multi com buffer area
+	 *
+	 * This driver requires:
+	 *
+	 * Arbitrary Based Buffers:
+	 *  Docsis -
+	 *
+	 */
+	{
+		.name   = "MulticomSHM",
+		.start  = 0x26000000,
+		.end    = 0x26020000 - 1,
+		.flags  = IORESOURCE_MEM,
+	},
+	/*
+	 *
+	 * DMA Ring buffer
+	 *
+	 * This driver requires:
+	 *
+	 * Arbitrary Based Buffers:
+	 *  Docsis -
+	 *
+	 */
+	{
+		.name   = "BMM_Buffer",
+		.start  = 0x00000000,
+		.end    = 0x00280000 - 1,
+		.flags  = IORESOURCE_MEM,
+	},
+	/*
+	 *
+	 * Display bins buffer for unit0
+	 *
+	 * This driver requires:
+	 *
+	 * Arbitrary Based Buffers:
+	 *  Display Bins for unit0
+	 *
+	 */
+	{
+		.name   = "DisplayBins0",
+		.start  = 0x00000000,
+		.end    = 0x00000FFF,		/* 4 KB total */
+		.flags  = IORESOURCE_MEM,
+	},
+	/*
+	 *
+	 * Display bins buffer
+	 *
+	 * This driver requires:
+	 *
+	 * Arbitrary Based Buffers:
+	 *  Display Bins for unit1
+	 *
+	 */
+	{
+		.name   = "DisplayBins1",
+		.start  = 0x64AD4000,
+		.end    = 0x64AD5000 - 1,  /* 4 KB total */
+		.flags  = IORESOURCE_IO,
+	},
+	/*
+	 *
+	 * ITFS
+	 *
+	 * This driver requires:
+	 *
+	 * Arbitrary Based Buffers:
+	 *  Docsis -
+	 *
+	 */
+	{
+		.name   = "ITFS",
+		.start  = 0x64180000,
+		/* 815,104 bytes each for 2 ITFS partitions. */
+		.end    = 0x6430DFFF,
+		.flags  = IORESOURCE_IO,
+	},
+	/*
+	 *
+	 * AVFS
+	 *
+	 * This driver requires:
+	 *
+	 * Arbitrary Based Buffers:
+	 *  Docsis -
+	 *
+	 */
+	{
+		.name   = "AvfsDmaMem",
+		.start  = 0x6430E000,
+		/* (945K * 8) = (128K *3) 5 playbacks / 3 server */
+		.end    = 0x64AD0000 - 1,
+		.flags  = IORESOURCE_IO,
+	},
+	{
+		.name   = "AvfsFileSys",
+		.start  = 0x64AD0000,
+		.end    = 0x64AD1000 - 1,  /* 4K */
+		.flags  = IORESOURCE_IO,
+	},
+	/*
+	 *
+	 * Smartcard
+	 *
+	 * This driver requires:
+	 *
+	 * Arbitrary Based Buffers:
+	 *  Read and write buffers for Internal/External cards
+	 *
+	 */
+	{
+		.name   = "SmartCardInfo",
+		.start  = 0x64AD1000,
+		.end    = 0x64AD3800 - 1,
+		.flags  = IORESOURCE_IO,
+	},
+	/*
+	 *
+	 * KAVNET
+	 *    NP Reset Vector - must be of the form xxCxxxxx
+	 *	   NP Image - must be video bank 1
+	 *	   NP IPC - must be video bank 2
+	 */
+	{
+		.name   = "NP_Reset_Vector",
+		.start  = 0x27c00000,
+		.end    = 0x27c01000 - 1,
+		.flags  = IORESOURCE_MEM,
+	},
+	{
+		.name   = "NP_Image",
+		.start  = 0x27020000,
+		.end    = 0x27060000 - 1,
+		.flags  = IORESOURCE_MEM,
+	},
+	{
+		.name   = "NP_IPC",
+		.start  = 0x63500000,
+		.end    = 0x63580000 - 1,
+		.flags  = IORESOURCE_IO,
+	},
+	/*
+	 * Add other resources here
+	 */
+	{ },
+};
+
+/*
+ * NON_DVR_CAPABLE GAIA RESOURCES
+ */
+struct resource non_dvr_gaia_resources[] __initdata = {
+	/*
+	 *
+	 * VIDEO1 / LX1
+	 *
+	 */
+	{
+		.name   = "ST231aImage",	/* Delta-Mu 1 image and ram */
+		.start  = 0x24000000,
+		.end    = 0x241FFFFF,		/* 2MiB */
+		.flags  = IORESOURCE_MEM,
+	},
+	{
+		.name   = "ST231aMonitor",	/* 8KiB block ST231a monitor */
+		.start  = 0x24200000,
+		.end    = 0x24201FFF,
+		.flags  = IORESOURCE_MEM,
+	},
+	{
+		.name   = "MediaMemory1",
+		.start  = 0x24202000,
+		.end    = 0x25FFFFFF, /*~29.9MiB (32MiB - (2MiB + 8KiB)) */
+		.flags  = IORESOURCE_MEM,
+	},
+	/*
+	 *
+	 * VIDEO2 / LX2
+	 *
+	 */
+	{
+		.name   = "ST231bImage",	/* Delta-Mu 2 image and ram */
+		.start  = 0x60000000,
+		.end    = 0x601FFFFF,		/* 2MiB */
+		.flags  = IORESOURCE_IO,
+	},
+	{
+		.name   = "ST231bMonitor",	/* 8KiB block ST231b monitor */
+		.start  = 0x60200000,
+		.end    = 0x60201FFF,
+		.flags  = IORESOURCE_IO,
+	},
+	{
+		.name   = "MediaMemory2",
+		.start  = 0x60202000,
+		.end    = 0x61FFFFFF, /*~29.9MiB (32MiB - (2MiB + 8KiB)) */
+		.flags  = IORESOURCE_IO,
+	},
+	/*
+	 *
+	 * Sysaudio Driver
+	 *
+	 * This driver requires:
+	 *
+	 * Arbitrary Based Buffers:
+	 *  DSP_Image_Buff - DSP code and data images (1MB)
+	 *  ADSC_CPU_PCM_Buff - ADSC CPU PCM buffer (40KB)
+	 *  ADSC_AUX_Buff - ADSC AUX buffer (16KB)
+	 *  ADSC_Main_Buff - ADSC Main buffer (16KB)
+	 *
+	 */
+	{
+		.name   = "DSP_Image_Buff",
+		.start  = 0x00000000,
+		.end    = 0x000FFFFF,
+		.flags  = IORESOURCE_MEM,
+	},
+	{
+		.name   = "ADSC_CPU_PCM_Buff",
+		.start  = 0x00000000,
+		.end    = 0x00009FFF,
+		.flags  = IORESOURCE_MEM,
+	},
+	{
+		.name   = "ADSC_AUX_Buff",
+		.start  = 0x00000000,
+		.end    = 0x00003FFF,
+		.flags  = IORESOURCE_MEM,
+	},
+	{
+		.name   = "ADSC_Main_Buff",
+		.start  = 0x00000000,
+		.end    = 0x00003FFF,
+		.flags  = IORESOURCE_MEM,
+	},
+	/*
+	 *
+	 * STAVEM driver/STAPI
+	 *
+	 * This driver requires:
+	 *
+	 * Arbitrary Based Buffers:
+	 *  This memory area is used for allocating buffers for Video decoding
+	 *  purposes.  Allocation/De-allocation within this buffer is managed
+	 *  by the STAVMEM driver of the STAPI.  They could be Decimated
+	 *  Picture Buffers, Intermediate Buffers, as deemed necessary for
+	 *  video decoding purposes, for any video decoders on Zeus.
+	 *
+	 */
+	{
+		.name   = "AVMEMPartition0",
+		.start  = 0x63580000,
+		.end    = 0x64180000 - 1,  /* 12 MB total */
+		.flags  = IORESOURCE_IO,
+	},
+	/*
+	 *
+	 * DOCSIS Subsystem
+	 *
+	 * This driver requires:
+	 *
+	 * Arbitrary Based Buffers:
+	 *  Docsis -
+	 *
+	 */
+	{
+		.name   = "Docsis",
+		.start  = 0x62000000,
+		.end    = 0x62700000 - 1,	/* 7 MB total */
+		.flags  = IORESOURCE_IO,
+	},
+	/*
+	 *
+	 * GHW HAL Driver
+	 *
+	 * This driver requires:
+	 *
+	 * Arbitrary Based Buffers:
+	 *  GraphicsHeap - PowerTV Graphics Heap
+	 *
+	 */
+	{
+		.name   = "GraphicsHeap",
+		.start  = 0x62700000,
+		.end    = 0x63500000 - 1,	/* 14 MB total */
+		.flags  = IORESOURCE_IO,
+	},
+	/*
+	 *
+	 * multi com buffer area
+	 *
+	 * This driver requires:
+	 *
+	 * Arbitrary Based Buffers:
+	 *  Docsis -
+	 *
+	 */
+	{
+		.name   = "MulticomSHM",
+		.start  = 0x26000000,
+		.end    = 0x26020000 - 1,
+		.flags  = IORESOURCE_MEM,
+	},
+	/*
+	 *
+	 * DMA Ring buffer
+	 *
+	 * This driver requires:
+	 *
+	 * Arbitrary Based Buffers:
+	 *  Docsis -
+	 *
+	 */
+	{
+		.name   = "BMM_Buffer",
+		.start  = 0x00000000,
+		.end    = 0x000AA000 - 1,
+		.flags  = IORESOURCE_MEM,
+	},
+	/*
+	 *
+	 * Display bins buffer for unit0
+	 *
+	 * This driver requires:
+	 *
+	 * Arbitrary Based Buffers:
+	 *  Display Bins for unit0
+	 *
+	 */
+	{
+		.name   = "DisplayBins0",
+		.start  = 0x00000000,
+		.end    = 0x00000FFF,		/* 4 KB total */
+		.flags  = IORESOURCE_MEM,
+	},
+	/*
+	 *
+	 * Display bins buffer
+	 *
+	 * This driver requires:
+	 *
+	 * Arbitrary Based Buffers:
+	 *  Display Bins for unit1
+	 *
+	 */
+	{
+		.name   = "DisplayBins1",
+		.start  = 0x64AD4000,
+		.end    = 0x64AD5000 - 1,  /* 4 KB total */
+		.flags  = IORESOURCE_IO,
+	},
+	/*
+	 *
+	 * AVFS: player HAL memory
+	 *
+	 *
+	 */
+	{
+		.name   = "AvfsDmaMem",
+		.start  = 0x6430E000,
+		.end    = 0x645D2C00 - 1,  /* 945K * 3 for playback */
+		.flags  = IORESOURCE_IO,
+	},
+	/*
+	 *
+	 * PMEM
+	 *
+	 * This driver requires:
+	 *
+	 * Arbitrary Based Buffers:
+	 *  Persistent memory for diagnostics.
+	 *
+	 */
+	{
+		.name   = "DiagPersistentMemory",
+		.start  = 0x00000000,
+		.end    = 0x10000 - 1,
+		.flags  = IORESOURCE_MEM,
+	},
+	/*
+	 *
+	 * Smartcard
+	 *
+	 * This driver requires:
+	 *
+	 * Arbitrary Based Buffers:
+	 *  Read and write buffers for Internal/External cards
+	 *
+	 */
+	{
+		.name   = "SmartCardInfo",
+		.start  = 0x64AD1000,
+		.end    = 0x64AD3800 - 1,
+		.flags  = IORESOURCE_IO,
+	},
+	/*
+	 *
+	 * KAVNET
+	 *    NP Reset Vector - must be of the form xxCxxxxx
+	 *	   NP Image - must be video bank 1
+	 *	   NP IPC - must be video bank 2
+	 */
+	{
+		.name   = "NP_Reset_Vector",
+		.start  = 0x27c00000,
+		.end    = 0x27c01000 - 1,
+		.flags  = IORESOURCE_MEM,
+	},
+	{
+		.name   = "NP_Image",
+		.start  = 0x27020000,
+		.end    = 0x27060000 - 1,
+		.flags  = IORESOURCE_MEM,
+	},
+	{
+		.name   = "NP_IPC",
+		.start  = 0x63500000,
+		.end    = 0x63580000 - 1,
+		.flags  = IORESOURCE_IO,
+	},
+	{ },
+};
