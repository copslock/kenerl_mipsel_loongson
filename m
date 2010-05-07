Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 08 May 2010 00:17:19 +0200 (CEST)
Received: from sj-iport-1.cisco.com ([171.71.176.70]:58674 "EHLO
        sj-iport-1.cisco.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S1492261Ab0EGWRM (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 8 May 2010 00:17:12 +0200
Authentication-Results: sj-iport-1.cisco.com; dkim=neutral (message not signed) header.i=none
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: AvsEAEUu5EurR7Ht/2dsb2JhbACeHHGmDpk4glEFgj8Eg0I
X-IronPort-AV: E=Sophos;i="4.52,350,1270425600"; 
   d="scan'208";a="324111618"
Received: from sj-core-1.cisco.com ([171.71.177.237])
  by sj-iport-1.cisco.com with ESMTP; 07 May 2010 22:17:02 +0000
Received: from dvomlehn-lnx2.corp.sa.net ([64.101.20.155])
        by sj-core-1.cisco.com (8.13.8/8.14.3) with ESMTP id o47MH1j3007812;
        Fri, 7 May 2010 22:17:01 GMT
Date:   Fri, 7 May 2010 15:17:02 -0700
From:   David VomLehn <dvomlehn@cisco.com>
To:     to@dvomlehn-lnx2.corp.sa.net,
        "linux-mips@linux-mips.org"@cisco.com, linux-mips@linux-mips.org
Cc:     ralf@linux-mips.org
Subject: [PATCH] Clean up tables for bootmem allocation
Message-ID: <20100507221702.GA17837@dvomlehn-lnx2.corp.sa.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.18 (2008-05-17)
Return-Path: <dvomlehn@cisco.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 26644
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dvomlehn@cisco.com
Precedence: bulk
X-list: linux-mips

Modifications to the boot memory allocation structures to make them easier
to read and maintain. Note that this will not pass checkpatch because
it wants a structure element initializer to be enclosed in a
do {...} while(...), which is obvious nonsensical.

Signed-off-by: David VomLehn <dvomlehn@cisco.com>
---
 arch/mips/powertv/asic/prealloc-calliope.c   |  675 +++++++++-----------------
 arch/mips/powertv/asic/prealloc-cronus.c     |  670 ++++++++------------------
 arch/mips/powertv/asic/prealloc-cronuslite.c |  304 ++++--------
 arch/mips/powertv/asic/prealloc-zeus.c       |  507 +++++++-------------
 arch/mips/powertv/asic/prealloc.h            |   72 +++
 5 files changed, 767 insertions(+), 1461 deletions(-)

diff --git a/arch/mips/powertv/asic/prealloc-calliope.c b/arch/mips/powertv/asic/prealloc-calliope.c
old mode 100644
new mode 100755
index cd5b76a..218b0da
--- a/arch/mips/powertv/asic/prealloc-calliope.c
+++ b/arch/mips/powertv/asic/prealloc-calliope.c
@@ -1,4 +1,6 @@
 /*
+ *				prealloc-calliope.c
+ *
  * Memory pre-allocations for Calliope boxes.
  *
  * Copyright (C) 2005-2009 Scientific-Atlanta, Inc.
@@ -22,7 +24,9 @@
  */
 
 #include <linux/init.h>
+#include <linux/ioport.h>
 #include <asm/mach-powertv/asic.h>
+#include "prealloc.h"
 
 /*
  * NON_DVR_CAPABLE CALLIOPE RESOURCES
@@ -32,432 +36,234 @@ struct resource non_dvr_calliope_resources[] __initdata =
 	/*
 	 * VIDEO / LX1
 	 */
-	{
-		.name   = "ST231aImage",     	/* Delta-Mu 1 image and ram */
-		.start  = 0x24000000,
-		.end    = 0x24200000 - 1,	/*2MiB */
-		.flags  = IORESOURCE_MEM,
-	},
-	{
-		.name   = "ST231aMonitor",   /*8KiB block ST231a monitor */
-		.start  = 0x24200000,
-		.end    = 0x24202000 - 1,
-		.flags  = IORESOURCE_MEM,
-	},
-	{
-		.name   = "MediaMemory1",
-		.start  = 0x24202000,
-		.end    = 0x26700000 - 1, /*~36.9MiB (32MiB - (2MiB + 8KiB)) */
-		.flags  = IORESOURCE_MEM,
-	},
+	/* Delta-Mu 1 image (2MiB) */
+	PREALLOC_NORMAL("ST231aImage", 0x24000000, 0x24200000-1,
+		IORESOURCE_MEM)
+	/* Delta-Mu 1 monitor (8KiB) */
+	PREALLOC_NORMAL("ST231aMonitor", 0x24200000, 0x24202000-1,
+		IORESOURCE_MEM)
+	/* Delta-Mu 1 RAM (~36.9MiB (32MiB - (2MiB + 8KiB))) */
+	PREALLOC_NORMAL("MediaMemory1", 0x24202000, 0x26700000-1,
+		IORESOURCE_MEM)
+
 	/*
 	 * Sysaudio Driver
 	 */
-	{
-		.name   = "DSP_Image_Buff",
-		.start  = 0x00000000,
-		.end    = 0x000FFFFF,
-		.flags  = IORESOURCE_MEM,
-	},
-	{
-		.name   = "ADSC_CPU_PCM_Buff",
-		.start  = 0x00000000,
-		.end    = 0x00009FFF,
-		.flags  = IORESOURCE_MEM,
-	},
-	{
-		.name   = "ADSC_AUX_Buff",
-		.start  = 0x00000000,
-		.end    = 0x00003FFF,
-		.flags  = IORESOURCE_MEM,
-	},
-	{
-		.name   = "ADSC_Main_Buff",
-		.start  = 0x00000000,
-		.end    = 0x00003FFF,
-		.flags  = IORESOURCE_MEM,
-	},
+	/* DSP code and data images (1MiB) */
+	PREALLOC_NORMAL("DSP_Image_Buff", 0x00000000, 0x00100000-1,
+		(IORESOURCE_MEM|IORESOURCE_PTV_RES_LOEXT))
+	/* ADSC CPU PCM buffer (40KiB) */
+	PREALLOC_NORMAL("ADSC_CPU_PCM_Buff", 0x00000000, 0x0000A000-1,
+		(IORESOURCE_MEM|IORESOURCE_PTV_RES_LOEXT))
+	/* ADSC AUX buffer (128KiB) */
+	PREALLOC_NORMAL("ADSC_AUX_Buff", 0x00000000, 0x00020000-1,
+		(IORESOURCE_MEM|IORESOURCE_PTV_RES_LOEXT))
+	/* ADSC Main buffer (128KiB) */
+	PREALLOC_NORMAL("ADSC_Main_Buff", 0x00000000, 0x00020000-1,
+		(IORESOURCE_MEM|IORESOURCE_PTV_RES_LOEXT))
+
 	/*
 	 * STAVEM driver/STAPI
 	 */
-	{
-		.name   = "AVMEMPartition0",
-		.start  = 0x00000000,
-		.end    = 0x00600000 - 1,	/* 6 MB total */
-		.flags  = IORESOURCE_MEM,
-	},
+	/* 6MiB */
+	PREALLOC_NORMAL("AVMEMPartition0", 0x00000000, 0x00600000-1,
+		(IORESOURCE_MEM|IORESOURCE_PTV_RES_LOEXT))
+
 	/*
 	 * DOCSIS Subsystem
 	 */
-	{
-		.name   = "Docsis",
-		.start  = 0x22000000,
-		.end    = 0x22700000 - 1,
-		.flags  = IORESOURCE_MEM,
-	},
+	/* 7MiB */
+	PREALLOC_DOCSIS("Docsis", 0x27500000, 0x27c00000-1, IORESOURCE_MEM)
+
 	/*
 	 * GHW HAL Driver
 	 */
-	{
-		.name   = "GraphicsHeap",
-		.start  = 0x22700000,
-		.end    = 0x23500000 - 1,	/* 14 MB total */
-		.flags  = IORESOURCE_MEM,
-	},
+	/* PowerTV Graphics Heap (14MiB) */
+	PREALLOC_NORMAL("GraphicsHeap", 0x26700000, 0x26700000+(14*1048576)-1,
+		IORESOURCE_MEM)
+
 	/*
 	 * multi com buffer area
 	 */
-	{
-		.name   = "MulticomSHM",
-		.start  = 0x23700000,
-		.end    = 0x23720000 - 1,
-		.flags  = IORESOURCE_MEM,
-	},
+	/* 128KiB */
+	PREALLOC_NORMAL("MulticomSHM", 0x23700000, 0x23720000-1,
+		IORESOURCE_MEM)
+
 	/*
 	 * DMA Ring buffer (don't need recording buffers)
 	 */
-	{
-		.name   = "BMM_Buffer",
-		.start  = 0x00000000,
-		.end    = 0x000AA000 - 1,
-		.flags  = IORESOURCE_MEM,
-	},
+	/* 680KiB */
+	PREALLOC_NORMAL("BMM_Buffer", 0x00000000, 0x000AA000-1,
+		(IORESOURCE_MEM|IORESOURCE_PTV_RES_LOEXT))
+
 	/*
 	 * Display bins buffer for unit0
 	 */
-	{
-		.name   = "DisplayBins0",
-		.start  = 0x00000000,
-		.end    = 0x00000FFF,		/* 4 KB total */
-		.flags  = IORESOURCE_MEM,
-	},
+	/* 4KiB */
+	PREALLOC_NORMAL("DisplayBins0", 0x00000000, 0x00001000-1,
+		(IORESOURCE_MEM|IORESOURCE_PTV_RES_LOEXT))
+
 	/*
-	 *
 	 * AVFS: player HAL memory
-	 *
-	 *
 	 */
-	{
-		.name   = "AvfsDmaMem",
-		.start  = 0x00000000,
-		.end    = 0x002c4c00 - 1,	/* 945K * 3 for playback */
-		.flags  = IORESOURCE_MEM,
-	},
+	/* 945K * 3 for playback */
+	PREALLOC_NORMAL("AvfsDmaMem", 0x00000000, 0x002c4c00-1,
+		(IORESOURCE_MEM|IORESOURCE_PTV_RES_LOEXT))
+
 	/*
 	 * PMEM
 	 */
-	{
-		.name   = "DiagPersistentMemory",
-		.start  = 0x00000000,
-		.end    = 0x10000 - 1,
-		.flags  = IORESOURCE_MEM,
-	},
+	/* Persistent memory for diagnostics (64KiB) */
+	PREALLOC_PMEM("DiagPersistentMemory", 0x00000000, 0x10000-1,
+	     (IORESOURCE_MEM|IORESOURCE_PTV_RES_LOEXT))
+
 	/*
 	 * Smartcard
 	 */
-	{
-		.name   = "SmartCardInfo",
-		.start  = 0x00000000,
-		.end    = 0x2800 - 1,
-		.flags  = IORESOURCE_MEM,
-	},
+	/* Read and write buffers for Internal/External cards (10KiB) */
+	PREALLOC_NORMAL("SmartCardInfo", 0x00000000, 0x2800-1,
+		(IORESOURCE_MEM|IORESOURCE_PTV_RES_LOEXT))
+
 	/*
 	 * NAND Flash
 	 */
-	{
-		.name   = "NandFlash",
-		.start  = NAND_FLASH_BASE,
-		.end    = NAND_FLASH_BASE + 0x400 - 1,
-		.flags  = IORESOURCE_IO,
-	},
+	/* 10KiB */
+	PREALLOC_NORMAL("NandFlash", NAND_FLASH_BASE, NAND_FLASH_BASE+0x400-1,
+		IORESOURCE_MEM)
+
 	/*
 	 * Synopsys GMAC Memory Region
 	 */
-	{
-		.name   = "GMAC",
-		.start  = 0x00000000,
-		.end    = 0x00010000 - 1,
-		.flags  = IORESOURCE_MEM,
-	},
+	/* 64KiB */
+	PREALLOC_NORMAL("GMAC", 0x00000000, 0x00010000-1,
+		(IORESOURCE_MEM|IORESOURCE_PTV_RES_LOEXT))
+
 	/*
-	 * Add other resources here
+	 * TFTPBuffer
 	 *
+	 *  This buffer is used in some minimal configurations (e.g. two-way
+	 *  loader) for storing software images
 	 */
-	{ },
-};
+	PREALLOC_TFTP("TFTPBuffer", 0x00000000, MEBIBYTE(80)-1,
+		(IORESOURCE_MEM|IORESOURCE_PTV_RES_LOEXT))
 
-struct resource non_dvr_vz_calliope_resources[] __initdata =
-{
 	/*
-	 * VIDEO / LX1
-	 */
-	{
-		.name   = "ST231aImage",	/* Delta-Mu 1 image and ram */
-		.start  = 0x24000000,
-		.end    = 0x24200000 - 1, /*2 Meg */
-		.flags  = IORESOURCE_MEM,
-	},
-	{
-		.name   = "ST231aMonitor",	/* 8k block ST231a monitor */
-		.start  = 0x24200000,
-		.end    = 0x24202000 - 1,
-		.flags  = IORESOURCE_MEM,
-	},
-	{
-		.name   = "MediaMemory1",
-		.start  = 0x22202000,
-		.end    = 0x22C20B85 - 1,	/* 10.12 Meg */
-		.flags  = IORESOURCE_MEM,
-	},
-	/*
-	 * Sysaudio Driver
-	 */
-	{
-		.name   = "DSP_Image_Buff",
-		.start  = 0x00000000,
-		.end    = 0x000FFFFF,
-		.flags  = IORESOURCE_MEM,
-	},
-	{
-		.name   = "ADSC_CPU_PCM_Buff",
-		.start  = 0x00000000,
-		.end    = 0x00009FFF,
-		.flags  = IORESOURCE_MEM,
-	},
-	{
-		.name   = "ADSC_AUX_Buff",
-		.start  = 0x00000000,
-		.end    = 0x00003FFF,
-		.flags  = IORESOURCE_MEM,
-	},
-	{
-		.name   = "ADSC_Main_Buff",
-		.start  = 0x00000000,
-		.end    = 0x00003FFF,
-		.flags  = IORESOURCE_MEM,
-	},
-	/*
-	 * STAVEM driver/STAPI
-	 */
-	{
-		.name   = "AVMEMPartition0",
-		.start  = 0x20300000,
-		.end    = 0x20620000-1,  /*3.125 MB total */
-		.flags  = IORESOURCE_MEM,
-	},
-	/*
-	 * GHW HAL Driver
-	 */
-	{
-		.name   = "GraphicsHeap",
-		.start  = 0x20100000,
-		.end    = 0x20300000 - 1,
-		.flags  = IORESOURCE_MEM,
-	},
-	/*
-	 * multi com buffer area
-	 */
-	{
-		.name   = "MulticomSHM",
-		.start  = 0x23900000,
-		.end    = 0x23920000 - 1,
-		.flags  = IORESOURCE_MEM,
-	},
-	/*
-	 * DMA Ring buffer
-	 */
-	{
-		.name   = "BMM_Buffer",
-		.start  = 0x00000000,
-		.end    = 0x000AA000 - 1,
-		.flags  = IORESOURCE_MEM,
-	},
-	/*
-	 * Display bins buffer for unit0
-	 */
-	{
-		.name   = "DisplayBins0",
-		.start  = 0x00000000,
-		.end    = 0x00000FFF,
-		.flags  = IORESOURCE_MEM,
-	},
-	/*
-	 * PMEM
-	 */
-	{
-		.name   = "DiagPersistentMemory",
-		.start  = 0x00000000,
-		.end    = 0x10000 - 1,
-		.flags  = IORESOURCE_MEM,
-	},
-	/*
-	 * Smartcard
-	 */
-	{
-		.name   = "SmartCardInfo",
-		.start  = 0x00000000,
-		.end    = 0x2800 - 1,
-		.flags  = IORESOURCE_MEM,
-	},
-	/*
-	 * NAND Flash
+	 * Add other resources here
 	 */
-	{
-		.name   = "NandFlash",
-		.start  = NAND_FLASH_BASE,
-		.end    = NAND_FLASH_BASE+0x400 - 1,
-		.flags  = IORESOURCE_IO,
-	},
+
 	/*
-	 * Synopsys GMAC Memory Region
+	 * End of Resource marker
 	 */
 	{
-		.name   = "GMAC",
-		.start  = 0x00000000,
-		.end    = 0x00010000 - 1,
-		.flags  = IORESOURCE_MEM,
+		.flags  = 0,
 	},
-	/*
-	 * Add other resources here
-	 */
-	{ },
 };
 
+
 struct resource non_dvr_vze_calliope_resources[] __initdata =
 {
 	/*
 	 * VIDEO / LX1
 	 */
-	{
-		.name   = "ST231aImage",	/* Delta-Mu 1 image and ram */
-		.start  = 0x22000000,
-		.end    = 0x22200000 - 1,	/*2  Meg */
-		.flags  = IORESOURCE_MEM,
-	},
-	{
-		.name   = "ST231aMonitor",	/* 8k block ST231a monitor */
-		.start  = 0x22200000,
-		.end    = 0x22202000 - 1,
-		.flags  = IORESOURCE_MEM,
-	},
-	{
-		.name   = "MediaMemory1",
-		.start  = 0x22202000,
-		.end    = 0x22C20B85 - 1,	/* 10.12 Meg */
-		.flags  = IORESOURCE_MEM,
-	},
+	/* Delta-Mu 1 image (2MiB) */
+	PREALLOC_NORMAL("ST231aImage", 0x22000000, 0x22200000-1,
+		IORESOURCE_MEM)
+	/* Delta-Mu 1 monitor (8KiB) */
+	PREALLOC_NORMAL("ST231aMonitor", 0x22200000, 0x22202000-1,
+		IORESOURCE_MEM)
+	/* Delta-Mu 1 RAM (10.12MiB) */
+	PREALLOC_NORMAL("MediaMemory1", 0x22202000, 0x22C20B85-1,
+		IORESOURCE_MEM)
+
 	/*
 	 * Sysaudio Driver
 	 */
-	{
-		.name   = "DSP_Image_Buff",
-		.start  = 0x00000000,
-		.end    = 0x000FFFFF,
-		.flags  = IORESOURCE_MEM,
-	},
-	{
-		.name   = "ADSC_CPU_PCM_Buff",
-		.start  = 0x00000000,
-		.end    = 0x00009FFF,
-		.flags  = IORESOURCE_MEM,
-	},
-	{
-		.name   = "ADSC_AUX_Buff",
-		.start  = 0x00000000,
-		.end    = 0x00003FFF,
-		.flags  = IORESOURCE_MEM,
-	},
-	{
-		.name   = "ADSC_Main_Buff",
-		.start  = 0x00000000,
-		.end    = 0x00003FFF,
-		.flags  = IORESOURCE_MEM,
-	},
+	/* DSP code and data images (1MiB) */
+	PREALLOC_NORMAL("DSP_Image_Buff", 0x00000000, 0x00100000-1,
+		(IORESOURCE_MEM|IORESOURCE_PTV_RES_LOEXT))
+	/* ADSC CPU PCM buffer (40KiB) */
+	PREALLOC_NORMAL("ADSC_CPU_PCM_Buff", 0x00000000, 0x0000A000-1,
+		(IORESOURCE_MEM|IORESOURCE_PTV_RES_LOEXT))
+	/* ADSC AUX buffer (16KiB) */
+	PREALLOC_NORMAL("ADSC_AUX_Buff", 0x00000000, 0x00004000-1,
+		(IORESOURCE_MEM|IORESOURCE_PTV_RES_LOEXT))
+	/* ADSC Main buffer (16KiB) */
+	PREALLOC_NORMAL("ADSC_Main_Buff", 0x00000000, 0x00004000-1,
+		(IORESOURCE_MEM|IORESOURCE_PTV_RES_LOEXT))
+
 	/*
 	 * STAVEM driver/STAPI
 	 */
-	{
-		.name   = "AVMEMPartition0",
-		.start  = 0x20396000,
-		.end    = 0x206B6000 - 1,		/* 3.125 MB total */
-		.flags  = IORESOURCE_MEM,
-	},
+	/* 3.125MiB */
+	PREALLOC_NORMAL("AVMEMPartition0", 0x20396000, 0x206B6000-1,
+		IORESOURCE_MEM)
+
 	/*
 	 * GHW HAL Driver
 	 */
-	{
-		.name   = "GraphicsHeap",
-		.start  = 0x20100000,
-		.end    = 0x20396000 - 1,
-		.flags  = IORESOURCE_MEM,
-	},
+	/* PowerTV Graphics Heap (2.59MiB) */
+	PREALLOC_NORMAL("GraphicsHeap", 0x20100000, 0x20396000-1,
+		IORESOURCE_MEM)
+
 	/*
 	 * multi com buffer area
 	 */
-	{
-		.name   = "MulticomSHM",
-		.start  = 0x206B6000,
-		.end    = 0x206D6000 - 1,
-		.flags  = IORESOURCE_MEM,
-	},
+	/* 128KiB */
+	PREALLOC_NORMAL("MulticomSHM", 0x206B6000, 0x206D6000-1,
+		IORESOURCE_MEM)
+
 	/*
-	 * DMA Ring buffer
+	 * DMA Ring buffer (don't need recording buffers)
 	 */
-	{
-		.name   = "BMM_Buffer",
-		.start  = 0x00000000,
-		.end    = 0x000AA000 - 1,
-		.flags  = IORESOURCE_MEM,
-	},
+	/* 680KiB */
+	PREALLOC_NORMAL("BMM_Buffer", 0x00000000, 0x000AA000-1,
+		(IORESOURCE_MEM|IORESOURCE_PTV_RES_LOEXT))
+
 	/*
 	 * Display bins buffer for unit0
 	 */
-	{
-		.name   = "DisplayBins0",
-		.start  = 0x00000000,
-		.end    = 0x00000FFF,
-		.flags  = IORESOURCE_MEM,
-	},
+	/* 4KiB */
+	PREALLOC_NORMAL("DisplayBins0", 0x00000000, 0x00001000-1,
+		(IORESOURCE_MEM|IORESOURCE_PTV_RES_LOEXT))
+
 	/*
 	 * PMEM
 	 */
-	{
-		.name   = "DiagPersistentMemory",
-		.start  = 0x00000000,
-		.end    = 0x10000 - 1,
-		.flags  = IORESOURCE_MEM,
-	},
+	/* Persistent memory for diagnostics (64KiB) */
+	PREALLOC_PMEM("DiagPersistentMemory", 0x00000000, 0x10000-1,
+	     (IORESOURCE_MEM|IORESOURCE_PTV_RES_LOEXT))
+
 	/*
 	 * Smartcard
 	 */
-	{
-		.name   = "SmartCardInfo",
-		.start  = 0x00000000,
-		.end    = 0x2800 - 1,
-		.flags  = IORESOURCE_MEM,
-	},
+	/* Read and write buffers for Internal/External cards (10KiB) */
+	PREALLOC_NORMAL("SmartCardInfo", 0x00000000, 0x2800-1,
+		(IORESOURCE_MEM|IORESOURCE_PTV_RES_LOEXT))
+
 	/*
 	 * NAND Flash
 	 */
-	{
-		.name   = "NandFlash",
-		.start  = NAND_FLASH_BASE,
-		.end    = NAND_FLASH_BASE+0x400 - 1,
-		.flags  = IORESOURCE_MEM,
-	},
+	/* 10KiB */
+	PREALLOC_NORMAL("NandFlash", NAND_FLASH_BASE, NAND_FLASH_BASE+0x400-1,
+		IORESOURCE_MEM)
+
 	/*
 	 * Synopsys GMAC Memory Region
 	 */
-	{
-		.name   = "GMAC",
-		.start  = 0x00000000,
-		.end    = 0x00010000 - 1,
-		.flags  = IORESOURCE_MEM,
-	},
+	/* 64KiB */
+	PREALLOC_NORMAL("GMAC", 0x00000000, 0x00010000-1,
+		(IORESOURCE_MEM|IORESOURCE_PTV_RES_LOEXT))
+
 	/*
 	 * Add other resources here
 	 */
-	{ },
+
+	/*
+	 * End of Resource marker
+	 */
+	{
+		.flags  = 0,
+	},
 };
 
 struct resource non_dvr_vzf_calliope_resources[] __initdata =
@@ -465,156 +271,117 @@ struct resource non_dvr_vzf_calliope_resources[] __initdata =
 	/*
 	 * VIDEO / LX1
 	 */
-	{
-		.name   = "ST231aImage",	/*Delta-Mu 1 image and ram */
-		.start  = 0x24000000,
-		.end    = 0x24200000 - 1,	/*2MiB */
-		.flags  = IORESOURCE_MEM,
-	},
-	{
-		.name   = "ST231aMonitor",	/*8KiB block ST231a monitor */
-		.start  = 0x24200000,
-		.end    = 0x24202000 - 1,
-		.flags  = IORESOURCE_MEM,
-	},
-	{
-		.name   = "MediaMemory1",
-		.start  = 0x24202000,
-		/* ~19.4 (21.5MiB - (2MiB + 8KiB)) */
-		.end    = 0x25580000 - 1,
-		.flags  = IORESOURCE_MEM,
-	},
+	/* Delta-Mu 1 image (2MiB) */
+	PREALLOC_NORMAL("ST231aImage", 0x24000000, 0x24200000-1,
+		IORESOURCE_MEM)
+	/* Delta-Mu 1 monitor (8KiB) */
+	PREALLOC_NORMAL("ST231aMonitor", 0x24200000, 0x24202000-1,
+		IORESOURCE_MEM)
+	/* Delta-Mu 1 RAM (~19.4 (21.5MiB - (2MiB + 8KiB))) */
+	PREALLOC_NORMAL("MediaMemory1", 0x24202000, 0x25580000-1,
+		IORESOURCE_MEM)
+
 	/*
 	 * Sysaudio Driver
 	 */
-	{
-		.name   = "DSP_Image_Buff",
-		.start  = 0x00000000,
-		.end    = 0x000FFFFF,
-		.flags  = IORESOURCE_MEM,
-	},
-	{
-		.name   = "ADSC_CPU_PCM_Buff",
-		.start  = 0x00000000,
-		.end    = 0x00009FFF,
-		.flags  = IORESOURCE_MEM,
-	},
-	{
-		.name   = "ADSC_AUX_Buff",
-		.start  = 0x00000000,
-		.end    = 0x00003FFF,
-		.flags  = IORESOURCE_MEM,
-	},
-	{
-		.name   = "ADSC_Main_Buff",
-		.start  = 0x00000000,
-		.end    = 0x00003FFF,
-		.flags  = IORESOURCE_MEM,
-	},
+	/* DSP code and data images (1MiB) */
+	PREALLOC_NORMAL("DSP_Image_Buff", 0x00000000, 0x00100000-1,
+		(IORESOURCE_MEM|IORESOURCE_PTV_RES_LOEXT))
+	/* ADSC CPU PCM buffer (40KiB) */
+	PREALLOC_NORMAL("ADSC_CPU_PCM_Buff", 0x00000000, 0x0000A000-1,
+		(IORESOURCE_MEM|IORESOURCE_PTV_RES_LOEXT))
+	/* ADSC AUX buffer (128KiB) */
+	PREALLOC_NORMAL("ADSC_AUX_Buff", 0x00000000, 0x00020000-1,
+		(IORESOURCE_MEM|IORESOURCE_PTV_RES_LOEXT))
+	/* ADSC Main buffer (128KiB) */
+	PREALLOC_NORMAL("ADSC_Main_Buff", 0x00000000, 0x00020000-1,
+		(IORESOURCE_MEM|IORESOURCE_PTV_RES_LOEXT))
+
 	/*
 	 * STAVEM driver/STAPI
 	 */
-	{
-		.name   = "AVMEMPartition0",
-		.start  = 0x00000000,
-		.end    = 0x00480000 - 1,  /* 4.5 MB total */
-		.flags  = IORESOURCE_MEM,
-	},
+	/* 4.5MiB */
+	PREALLOC_NORMAL("AVMEMPartition0", 0x00000000, 0x00480000-1,
+		(IORESOURCE_MEM|IORESOURCE_PTV_RES_LOEXT))
+
 	/*
 	 * GHW HAL Driver
 	 */
-	{
-		.name   = "GraphicsHeap",
-		.start  = 0x22700000,
-		.end    = 0x23500000 - 1, /* 14 MB total */
-		.flags  = IORESOURCE_MEM,
-	},
+	/* PowerTV Graphics Heap (14MiB) */
+	PREALLOC_NORMAL("GraphicsHeap", 0x25600000, 0x25600000+(14*1048576)-1,
+		IORESOURCE_MEM)
+
 	/*
 	 * multi com buffer area
 	 */
-	{
-		.name   = "MulticomSHM",
-		.start  = 0x23700000,
-		.end    = 0x23720000 - 1,
-		.flags  = IORESOURCE_MEM,
-	},
+	/* 128KiB */
+	PREALLOC_NORMAL("MulticomSHM", 0x23700000, 0x23720000-1,
+		IORESOURCE_MEM)
+
 	/*
 	 * DMA Ring buffer (don't need recording buffers)
 	 */
-	{
-		.name   = "BMM_Buffer",
-		.start  = 0x00000000,
-		.end    = 0x000AA000 - 1,
-		.flags  = IORESOURCE_MEM,
-	},
+	/* 680KiB */
+	PREALLOC_NORMAL("BMM_Buffer", 0x00000000, 0x000AA000-1,
+		(IORESOURCE_MEM|IORESOURCE_PTV_RES_LOEXT))
+
 	/*
 	 * Display bins buffer for unit0
 	 */
-	{
-		.name   = "DisplayBins0",
-		.start  = 0x00000000,
-		.end    = 0x00000FFF,  /* 4 KB total */
-		.flags  = IORESOURCE_MEM,
-	},
+	/* 4KiB */
+	PREALLOC_NORMAL("DisplayBins0", 0x00000000, 0x00001000-1,
+		(IORESOURCE_MEM|IORESOURCE_PTV_RES_LOEXT))
+
 	/*
 	 * Display bins buffer for unit1
 	 */
-	{
-		.name   = "DisplayBins1",
-		.start  = 0x00000000,
-		.end    = 0x00000FFF,  /* 4 KB total */
-		.flags  = IORESOURCE_MEM,
-	},
+	/* 4KiB */
+	PREALLOC_NORMAL("DisplayBins1", 0x00000000, 0x00001000-1,
+		(IORESOURCE_MEM|IORESOURCE_PTV_RES_LOEXT))
+
 	/*
-	 *
 	 * AVFS: player HAL memory
-	 *
-	 *
 	 */
-	{
-		.name   = "AvfsDmaMem",
-		.start  = 0x00000000,
-		.end    = 0x002c4c00 - 1,  /* 945K * 3 for playback */
-		.flags  = IORESOURCE_MEM,
-	},
+	/* 945K * 3 for playback */
+	PREALLOC_NORMAL("AvfsDmaMem", 0x00000000, 0x002c4c00-1,
+		(IORESOURCE_MEM|IORESOURCE_PTV_RES_LOEXT))
+
 	/*
 	 * PMEM
 	 */
-	{
-		.name   = "DiagPersistentMemory",
-		.start  = 0x00000000,
-		.end    = 0x10000 - 1,
-		.flags  = IORESOURCE_MEM,
-	},
+	/* Persistent memory for diagnostics (64KiB) */
+	PREALLOC_PMEM("DiagPersistentMemory", 0x00000000, 0x10000-1,
+	     (IORESOURCE_MEM|IORESOURCE_PTV_RES_LOEXT))
+
 	/*
 	 * Smartcard
 	 */
-	{
-		.name   = "SmartCardInfo",
-		.start  = 0x00000000,
-		.end    = 0x2800 - 1,
-		.flags  = IORESOURCE_MEM,
-	},
+	/* Read and write buffers for Internal/External cards (10KiB) */
+	PREALLOC_NORMAL("SmartCardInfo", 0x00000000, 0x2800-1,
+		(IORESOURCE_MEM|IORESOURCE_PTV_RES_LOEXT))
+
 	/*
 	 * NAND Flash
 	 */
-	{
-		.name   = "NandFlash",
-		.start  = NAND_FLASH_BASE,
-		.end    = NAND_FLASH_BASE + 0x400 - 1,
-		.flags  = IORESOURCE_MEM,
-	},
+	/* 10KiB */
+	PREALLOC_NORMAL("NandFlash", NAND_FLASH_BASE, NAND_FLASH_BASE+0x400-1,
+		IORESOURCE_MEM)
+
 	/*
 	 * Synopsys GMAC Memory Region
 	 */
-	{
-		.name   = "GMAC",
-		.start  = 0x00000000,
-		.end    = 0x00010000 - 1,
-		.flags  = IORESOURCE_MEM,
-	},
+	/* 64KiB */
+	PREALLOC_NORMAL("GMAC", 0x00000000, 0x00010000-1,
+		(IORESOURCE_MEM|IORESOURCE_PTV_RES_LOEXT))
+
 	/*
 	 * Add other resources here
 	 */
-	{ },
+
+	/*
+	 * End of Resource marker
+	 */
+	{
+		.flags  = 0,
+	},
 };
diff --git a/arch/mips/powertv/asic/prealloc-cronus.c b/arch/mips/powertv/asic/prealloc-cronus.c
old mode 100644
new mode 100755
index 45a5c3e..291f237
--- a/arch/mips/powertv/asic/prealloc-cronus.c
+++ b/arch/mips/powertv/asic/prealloc-cronus.c
@@ -1,4 +1,6 @@
 /*
+ *				prealloc-cronus.c
+ *
  * Memory pre-allocations for Cronus boxes.
  *
  * Copyright (C) 2005-2009 Scientific-Atlanta, Inc.
@@ -22,7 +24,9 @@
  */
 
 #include <linux/init.h>
+#include <linux/ioport.h>
 #include <asm/mach-powertv/asic.h>
+#include "prealloc.h"
 
 /*
  * DVR_CAPABLE CRONUS RESOURCES
@@ -30,305 +34,161 @@
 struct resource dvr_cronus_resources[] __initdata =
 {
 	/*
-	 *
 	 * VIDEO1 / LX1
-	 *
 	 */
-	{
-		.name   = "ST231aImage",	/* Delta-Mu 1 image and ram */
-		.start  = 0x24000000,
-		.end    = 0x241FFFFF,		/* 2MiB */
-		.flags  = IORESOURCE_MEM,
-	},
-	{
-		.name   = "ST231aMonitor",	/* 8KiB block ST231a monitor */
-		.start  = 0x24200000,
-		.end    = 0x24201FFF,
-		.flags  = IORESOURCE_MEM,
-	},
-	{
-		.name   = "MediaMemory1",
-		.start  = 0x24202000,
-		.end    = 0x25FFFFFF, /*~29.9MiB (32MiB - (2MiB + 8KiB)) */
-		.flags  = IORESOURCE_MEM,
-	},
+	/* Delta-Mu 1 image (2MiB) */
+	PREALLOC_NORMAL("ST231aImage", 0x24000000, 0x24200000-1,
+		IORESOURCE_MEM)
+	/* Delta-Mu 1 monitor (8KiB) */
+	PREALLOC_NORMAL("ST231aMonitor", 0x24200000, 0x24202000-1,
+		IORESOURCE_MEM)
+	/* Delta-Mu 1 RAM (~29.9MiB (32MiB - (2MiB + 8KiB))) */
+	PREALLOC_NORMAL("MediaMemory1", 0x24202000, 0x26000000-1,
+		IORESOURCE_MEM)
+
 	/*
-	 *
 	 * VIDEO2 / LX2
-	 *
 	 */
-	{
-		.name   = "ST231bImage",	/* Delta-Mu 2 image and ram */
-		.start  = 0x60000000,
-		.end    = 0x601FFFFF,		/* 2MiB */
-		.flags  = IORESOURCE_IO,
-	},
-	{
-		.name   = "ST231bMonitor",	/* 8KiB block ST231b monitor */
-		.start  = 0x60200000,
-		.end    = 0x60201FFF,
-		.flags  = IORESOURCE_IO,
-	},
-	{
-		.name   = "MediaMemory2",
-		.start  = 0x60202000,
-		.end    = 0x61FFFFFF, /*~29.9MiB (32MiB - (2MiB + 8KiB)) */
-		.flags  = IORESOURCE_IO,
-	},
+	/* Delta-Mu 2 image (2MiB) */
+	PREALLOC_NORMAL("ST231bImage", 0x60000000, 0x60200000-1,
+		IORESOURCE_MEM)
+	/* Delta-Mu 2 monitor (8KiB) */
+	PREALLOC_NORMAL("ST231bMonitor", 0x60200000, 0x60202000-1,
+		IORESOURCE_MEM)
+	/* Delta-Mu 2 RAM (~29.9MiB (32MiB - (2MiB + 8KiB))) */
+	PREALLOC_NORMAL("MediaMemory2", 0x60202000, 0x62000000-1,
+		IORESOURCE_MEM)
+
 	/*
-	 *
 	 * Sysaudio Driver
-	 *
-	 * This driver requires:
-	 *
-	 * Arbitrary Based Buffers:
-	 *  DSP_Image_Buff - DSP code and data images (1MB)
-	 *  ADSC_CPU_PCM_Buff - ADSC CPU PCM buffer (40KB)
-	 *  ADSC_AUX_Buff - ADSC AUX buffer (16KB)
-	 *  ADSC_Main_Buff - ADSC Main buffer (16KB)
-	 *
 	 */
-	{
-		.name   = "DSP_Image_Buff",
-		.start  = 0x00000000,
-		.end    = 0x000FFFFF,
-		.flags  = IORESOURCE_MEM,
-	},
-	{
-		.name   = "ADSC_CPU_PCM_Buff",
-		.start  = 0x00000000,
-		.end    = 0x00009FFF,
-		.flags  = IORESOURCE_MEM,
-	},
-	{
-		.name   = "ADSC_AUX_Buff",
-		.start  = 0x00000000,
-		.end    = 0x00003FFF,
-		.flags  = IORESOURCE_MEM,
-	},
-	{
-		.name   = "ADSC_Main_Buff",
-		.start  = 0x00000000,
-		.end    = 0x00003FFF,
-		.flags  = IORESOURCE_MEM,
-	},
+	/* DSP code and data images (1MiB) */
+	PREALLOC_NORMAL("DSP_Image_Buff", 0x00000000, 0x00100000-1,
+		(IORESOURCE_MEM|IORESOURCE_PTV_RES_LOEXT))
+	/* ADSC CPU PCM buffer (40KiB) */
+	PREALLOC_NORMAL("ADSC_CPU_PCM_Buff", 0x00000000, 0x0000A000-1,
+		(IORESOURCE_MEM|IORESOURCE_PTV_RES_LOEXT))
+	/* ADSC AUX buffer (128KiB) */
+	PREALLOC_NORMAL("ADSC_AUX_Buff", 0x00000000, 0x00020000-1,
+		(IORESOURCE_MEM|IORESOURCE_PTV_RES_LOEXT))
+	/* ADSC Main buffer (128KiB) */
+	PREALLOC_NORMAL("ADSC_Main_Buff", 0x00000000, 0x00020000-1,
+		(IORESOURCE_MEM|IORESOURCE_PTV_RES_LOEXT))
+
 	/*
-	 *
 	 * STAVEM driver/STAPI
 	 *
-	 * This driver requires:
-	 *
-	 * Arbitrary Based Buffers:
 	 *  This memory area is used for allocating buffers for Video decoding
 	 *  purposes.  Allocation/De-allocation within this buffer is managed
 	 *  by the STAVMEM driver of the STAPI.  They could be Decimated
 	 *  Picture Buffers, Intermediate Buffers, as deemed necessary for
 	 *  video decoding purposes, for any video decoders on Zeus.
-	 *
 	 */
-	{
-		.name   = "AVMEMPartition0",
-		.start  = 0x63580000,
-		.end    = 0x64180000 - 1,  /* 12 MB total */
-		.flags  = IORESOURCE_IO,
-	},
+	/* 12MiB */
+	PREALLOC_NORMAL("AVMEMPartition0", 0x00000000, 0x00c00000-1,
+		IORESOURCE_MEM)
+
 	/*
-	 *
 	 * DOCSIS Subsystem
-	 *
-	 * This driver requires:
-	 *
-	 * Arbitrary Based Buffers:
-	 *  Docsis -
-	 *
 	 */
-	{
-		.name   = "Docsis",
-		.start  = 0x62000000,
-		.end    = 0x62700000 - 1,	/* 7 MB total */
-		.flags  = IORESOURCE_IO,
-	},
+	/* 7MiB */
+	PREALLOC_DOCSIS("Docsis", 0x67500000, 0x67c00000-1, IORESOURCE_MEM)
+
 	/*
-	 *
 	 * GHW HAL Driver
-	 *
-	 * This driver requires:
-	 *
-	 * Arbitrary Based Buffers:
-	 *  GraphicsHeap - PowerTV Graphics Heap
-	 *
 	 */
-	{
-		.name   = "GraphicsHeap",
-		.start  = 0x62700000,
-		.end    = 0x63500000 - 1,	/* 14 MB total */
-		.flags  = IORESOURCE_IO,
-	},
+	/* PowerTV Graphics Heap (14MiB) */
+	PREALLOC_NORMAL("GraphicsHeap", 0x62700000, 0x63500000-1,
+		IORESOURCE_MEM)
+
 	/*
-	 *
 	 * multi com buffer area
-	 *
-	 * This driver requires:
-	 *
-	 * Arbitrary Based Buffers:
-	 *  Docsis -
-	 *
 	 */
-	{
-		.name   = "MulticomSHM",
-		.start  = 0x26000000,
-		.end    = 0x26020000 - 1,
-		.flags  = IORESOURCE_MEM,
-	},
+	/* 128KiB */
+	PREALLOC_NORMAL("MulticomSHM", 0x26000000, 0x26020000-1,
+		IORESOURCE_MEM)
+
 	/*
-	 *
 	 * DMA Ring buffer
-	 *
-	 * This driver requires:
-	 *
-	 * Arbitrary Based Buffers:
-	 *  Docsis -
-	 *
 	 */
-	{
-		.name   = "BMM_Buffer",
-		.start  = 0x00000000,
-		.end    = 0x00280000 - 1,
-		.flags  = IORESOURCE_MEM,
-	},
+	PREALLOC_NORMAL("BMM_Buffer", 0x00000000, 0x002EA000-1,
+		(IORESOURCE_MEM|IORESOURCE_PTV_RES_LOEXT))
+
 	/*
-	 *
 	 * Display bins buffer for unit0
-	 *
-	 * This driver requires:
-	 *
-	 * Arbitrary Based Buffers:
-	 *  Display Bins for unit0
-	 *
 	 */
-	{
-		.name   = "DisplayBins0",
-		.start  = 0x00000000,
-		.end    = 0x00000FFF,		/* 4 KB total */
-		.flags  = IORESOURCE_MEM,
-	},
+	/* 4KiB */
+	PREALLOC_NORMAL("DisplayBins0", 0x00000000, 0x00001000-1,
+		(IORESOURCE_MEM|IORESOURCE_PTV_RES_LOEXT))
+
 	/*
-	 *
-	 * Display bins buffer
-	 *
-	 * This driver requires:
-	 *
-	 * Arbitrary Based Buffers:
-	 *  Display Bins for unit1
-	 *
+	 * Display bins buffer for unit1
 	 */
-	{
-		.name   = "DisplayBins1",
-		.start  = 0x64AD4000,
-		.end    = 0x64AD5000 - 1,  /* 4 KB total */
-		.flags  = IORESOURCE_IO,
-	},
+	/* 4KiB */
+	PREALLOC_NORMAL("DisplayBins1", 0x00000000, 0x00001000-1,
+		IORESOURCE_MEM)
+
 	/*
-	 *
 	 * ITFS
-	 *
-	 * This driver requires:
-	 *
-	 * Arbitrary Based Buffers:
-	 *  Docsis -
-	 *
 	 */
-	{
-		.name   = "ITFS",
-		.start  = 0x64180000,
-		/* 815,104 bytes each for 2 ITFS partitions. */
-		.end    = 0x6430DFFF,
-		.flags  = IORESOURCE_IO,
-	},
+	/* 815,104 bytes each for 2 ITFS partitions. */
+	PREALLOC_NORMAL("ITFS", 0x00000000, 0x0018E000-1, IORESOURCE_MEM)
+
 	/*
-	 *
 	 * AVFS
-	 *
-	 * This driver requires:
-	 *
-	 * Arbitrary Based Buffers:
-	 *  Docsis -
-	 *
 	 */
-	{
-		.name   = "AvfsDmaMem",
-		.start  = 0x6430E000,
-		/* (945K * 8) = (128K *3) 5 playbacks / 3 server */
-		.end    = 0x64AD0000 - 1,
-		.flags  = IORESOURCE_IO,
-	},
-	{
-		.name   = "AvfsFileSys",
-		.start  = 0x64AD0000,
-		.end    = 0x64AD1000 - 1,  /* 4K */
-		.flags  = IORESOURCE_IO,
-	},
+	/* (945K * 8) = (128K * 3) 5 playbacks / 3 server */
+	PREALLOC_NORMAL("AvfsDmaMem", 0x00000000, 0x007c2000-1,
+		IORESOURCE_MEM)
+
+	/* 4KiB */
+	PREALLOC_NORMAL("AvfsFileSys", 0x00000000, 0x00001000-1,
+		IORESOURCE_MEM)
+
 	/*
-	 *
 	 * PMEM
-	 *
-	 * This driver requires:
-	 *
-	 * Arbitrary Based Buffers:
-	 *  Persistent memory for diagnostics.
-	 *
 	 */
-	{
-		.name   = "DiagPersistentMemory",
-		.start  = 0x00000000,
-		.end    = 0x10000 - 1,
-		.flags  = IORESOURCE_MEM,
-	},
+	/* Persistent memory for diagnostics (64KiB) */
+	PREALLOC_PMEM("DiagPersistentMemory", 0x00000000, 0x10000-1,
+	     (IORESOURCE_MEM|IORESOURCE_PTV_RES_LOEXT))
+
 	/*
-	 *
 	 * Smartcard
-	 *
-	 * This driver requires:
-	 *
-	 * Arbitrary Based Buffers:
-	 *  Read and write buffers for Internal/External cards
-	 *
 	 */
-	{
-		.name   = "SmartCardInfo",
-		.start  = 0x64AD1000,
-		.end    = 0x64AD3800 - 1,
-		.flags  = IORESOURCE_IO,
-	},
+	/* Read and write buffers for Internal/External cards (10KiB) */
+	PREALLOC_NORMAL("SmartCardInfo", 0x00000000, 0x2800-1,
+		IORESOURCE_MEM)
+
 	/*
-	 *
 	 * KAVNET
-	 *    NP Reset Vector - must be of the form xxCxxxxx
-	 *	   NP Image - must be video bank 1
-	 *	   NP IPC - must be video bank 2
 	 */
-	{
-		.name   = "NP_Reset_Vector",
-		.start  = 0x27c00000,
-		.end    = 0x27c01000 - 1,
-		.flags  = IORESOURCE_MEM,
-	},
-	{
-		.name   = "NP_Image",
-		.start  = 0x27020000,
-		.end    = 0x27060000 - 1,
-		.flags  = IORESOURCE_MEM,
-	},
-	{
-		.name   = "NP_IPC",
-		.start  = 0x63500000,
-		.end    = 0x63580000 - 1,
-		.flags  = IORESOURCE_IO,
-	},
+	/* NP Reset Vector - must be of the form xxCxxxxx (4KiB) */
+	PREALLOC_NORMAL("NP_Reset_Vector", 0x27c00000, 0x27c01000-1,
+		IORESOURCE_MEM)
+	/* NP Image - must be video bank 1 (320KiB) */
+	PREALLOC_NORMAL("NP_Image", 0x27020000, 0x27070000-1, IORESOURCE_MEM)
+	/* NP IPC - must be video bank 2 (512KiB) */
+	PREALLOC_NORMAL("NP_IPC", 0x63500000, 0x63580000-1, IORESOURCE_MEM)
+
+	/*
+	 * TFTPBuffer
+	 *
+	 *  This buffer is used in some minimal configurations (e.g. two-way
+	 *  loader) for storing software images
+	 */
+	PREALLOC_TFTP("TFTPBuffer", 0x00000000, MEBIBYTE(80)-1,
+		(IORESOURCE_MEM|IORESOURCE_PTV_RES_LOEXT))
+
 	/*
 	 * Add other resources here
 	 */
-	{ },
+
+	/*
+	 * End of Resource marker
+	 */
+	{
+		.flags  = 0,
+	},
 };
 
 /*
@@ -337,272 +197,146 @@ struct resource dvr_cronus_resources[] __initdata =
 struct resource non_dvr_cronus_resources[] __initdata =
 {
 	/*
-	 *
 	 * VIDEO1 / LX1
-	 *
 	 */
-	{
-		.name   = "ST231aImage",	/* Delta-Mu 1 image and ram */
-		.start  = 0x24000000,
-		.end    = 0x241FFFFF,		/* 2MiB */
-		.flags  = IORESOURCE_MEM,
-	},
-	{
-		.name   = "ST231aMonitor",	/* 8KiB block ST231a monitor */
-		.start  = 0x24200000,
-		.end    = 0x24201FFF,
-		.flags  = IORESOURCE_MEM,
-	},
-	{
-		.name   = "MediaMemory1",
-		.start  = 0x24202000,
-		.end    = 0x25FFFFFF, /*~29.9MiB (32MiB - (2MiB + 8KiB)) */
-		.flags  = IORESOURCE_MEM,
-	},
+	/* Delta-Mu 1 image (2MiB) */
+	PREALLOC_NORMAL("ST231aImage", 0x24000000, 0x24200000-1,
+		IORESOURCE_MEM)
+	/* Delta-Mu 1 monitor (8KiB) */
+	PREALLOC_NORMAL("ST231aMonitor", 0x24200000, 0x24202000-1,
+		IORESOURCE_MEM)
+	/* Delta-Mu 1 RAM (~29.9MiB (32MiB - (2MiB + 8KiB))) */
+	PREALLOC_NORMAL("MediaMemory1", 0x24202000, 0x26000000-1,
+		IORESOURCE_MEM)
+
 	/*
-	 *
 	 * VIDEO2 / LX2
-	 *
 	 */
-	{
-		.name   = "ST231bImage",	/* Delta-Mu 2 image and ram */
-		.start  = 0x60000000,
-		.end    = 0x601FFFFF,		/* 2MiB */
-		.flags  = IORESOURCE_IO,
-	},
-	{
-		.name   = "ST231bMonitor",	/* 8KiB block ST231b monitor */
-		.start  = 0x60200000,
-		.end    = 0x60201FFF,
-		.flags  = IORESOURCE_IO,
-	},
-	{
-		.name   = "MediaMemory2",
-		.start  = 0x60202000,
-		.end    = 0x61FFFFFF, /*~29.9MiB (32MiB - (2MiB + 8KiB)) */
-		.flags  = IORESOURCE_IO,
-	},
+	/* Delta-Mu 2 image (2MiB) */
+	PREALLOC_NORMAL("ST231bImage", 0x60000000, 0x60200000-1,
+		IORESOURCE_MEM)
+	/* Delta-Mu 2 monitor (8KiB) */
+	PREALLOC_NORMAL("ST231bMonitor", 0x60200000, 0x60202000-1,
+		IORESOURCE_MEM)
+	/* Delta-Mu 2 RAM (~29.9MiB (32MiB - (2MiB + 8KiB))) */
+	PREALLOC_NORMAL("MediaMemory2", 0x60202000, 0x62000000-1,
+		IORESOURCE_MEM)
+
 	/*
-	 *
 	 * Sysaudio Driver
-	 *
-	 * This driver requires:
-	 *
-	 * Arbitrary Based Buffers:
-	 *  DSP_Image_Buff - DSP code and data images (1MB)
-	 *  ADSC_CPU_PCM_Buff - ADSC CPU PCM buffer (40KB)
-	 *  ADSC_AUX_Buff - ADSC AUX buffer (16KB)
-	 *  ADSC_Main_Buff - ADSC Main buffer (16KB)
-	 *
 	 */
-	{
-		.name   = "DSP_Image_Buff",
-		.start  = 0x00000000,
-		.end    = 0x000FFFFF,
-		.flags  = IORESOURCE_MEM,
-	},
-	{
-		.name   = "ADSC_CPU_PCM_Buff",
-		.start  = 0x00000000,
-		.end    = 0x00009FFF,
-		.flags  = IORESOURCE_MEM,
-	},
-	{
-		.name   = "ADSC_AUX_Buff",
-		.start  = 0x00000000,
-		.end    = 0x00003FFF,
-		.flags  = IORESOURCE_MEM,
-	},
-	{
-		.name   = "ADSC_Main_Buff",
-		.start  = 0x00000000,
-		.end    = 0x00003FFF,
-		.flags  = IORESOURCE_MEM,
-	},
+	/* DSP code and data images (1MiB) */
+	PREALLOC_NORMAL("DSP_Image_Buff", 0x00000000, 0x00100000-1,
+		(IORESOURCE_MEM|IORESOURCE_PTV_RES_LOEXT))
+	/* ADSC CPU PCM buffer (40KiB) */
+	PREALLOC_NORMAL("ADSC_CPU_PCM_Buff", 0x00000000, 0x0000A000-1,
+		(IORESOURCE_MEM|IORESOURCE_PTV_RES_LOEXT))
+	/* ADSC AUX buffer (128KiB) */
+	PREALLOC_NORMAL("ADSC_AUX_Buff", 0x00000000, 0x00020000-1,
+		(IORESOURCE_MEM|IORESOURCE_PTV_RES_LOEXT))
+	/* ADSC Main buffer (128KiB) */
+	PREALLOC_NORMAL("ADSC_Main_Buff", 0x00000000, 0x00020000-1,
+		(IORESOURCE_MEM|IORESOURCE_PTV_RES_LOEXT))
+
 	/*
-	 *
 	 * STAVEM driver/STAPI
 	 *
-	 * This driver requires:
-	 *
-	 * Arbitrary Based Buffers:
 	 *  This memory area is used for allocating buffers for Video decoding
 	 *  purposes.  Allocation/De-allocation within this buffer is managed
 	 *  by the STAVMEM driver of the STAPI.  They could be Decimated
 	 *  Picture Buffers, Intermediate Buffers, as deemed necessary for
 	 *  video decoding purposes, for any video decoders on Zeus.
-	 *
 	 */
-	{
-		.name   = "AVMEMPartition0",
-		.start  = 0x63580000,
-		.end    = 0x64180000 - 1,  /* 12 MB total */
-		.flags  = IORESOURCE_IO,
-	},
+	/* 12MiB */
+	PREALLOC_NORMAL("AVMEMPartition0", 0x00000000, 0x00c00000-1,
+		IORESOURCE_MEM)
+
 	/*
-	 *
 	 * DOCSIS Subsystem
-	 *
-	 * This driver requires:
-	 *
-	 * Arbitrary Based Buffers:
-	 *  Docsis -
-	 *
 	 */
-	{
-		.name   = "Docsis",
-		.start  = 0x62000000,
-		.end    = 0x62700000 - 1,	/* 7 MB total */
-		.flags  = IORESOURCE_IO,
-	},
+	/* 7MiB */
+	PREALLOC_DOCSIS("Docsis", 0x67500000, 0x67c00000-1, IORESOURCE_MEM)
+
 	/*
-	 *
 	 * GHW HAL Driver
-	 *
-	 * This driver requires:
-	 *
-	 * Arbitrary Based Buffers:
-	 *  GraphicsHeap - PowerTV Graphics Heap
-	 *
 	 */
-	{
-		.name   = "GraphicsHeap",
-		.start  = 0x62700000,
-		.end    = 0x63500000 - 1,	/* 14 MB total */
-		.flags  = IORESOURCE_IO,
-	},
+	/* PowerTV Graphics Heap (14MiB) */
+	PREALLOC_NORMAL("GraphicsHeap", 0x62700000, 0x63500000-1,
+		IORESOURCE_MEM)
+
 	/*
-	 *
 	 * multi com buffer area
-	 *
-	 * This driver requires:
-	 *
-	 * Arbitrary Based Buffers:
-	 *  Docsis -
-	 *
 	 */
-	{
-		.name   = "MulticomSHM",
-		.start  = 0x26000000,
-		.end    = 0x26020000 - 1,
-		.flags  = IORESOURCE_MEM,
-	},
+	/* 128KiB */
+	PREALLOC_NORMAL("MulticomSHM", 0x26000000, 0x26020000-1,
+		IORESOURCE_MEM)
+
 	/*
-	 *
-	 * DMA Ring buffer
-	 *
-	 * This driver requires:
-	 *
-	 * Arbitrary Based Buffers:
-	 *  Docsis -
-	 *
+	 * DMA Ring buffer (don't need recording buffers)
 	 */
-	{
-		.name   = "BMM_Buffer",
-		.start  = 0x00000000,
-		.end    = 0x000AA000 - 1,
-		.flags  = IORESOURCE_MEM,
-	},
+	/* 680KiB */
+	PREALLOC_NORMAL("BMM_Buffer", 0x00000000, 0x000AA000-1,
+		(IORESOURCE_MEM|IORESOURCE_PTV_RES_LOEXT))
+
 	/*
-	 *
 	 * Display bins buffer for unit0
-	 *
-	 * This driver requires:
-	 *
-	 * Arbitrary Based Buffers:
-	 *  Display Bins for unit0
-	 *
 	 */
-	{
-		.name   = "DisplayBins0",
-		.start  = 0x00000000,
-		.end    = 0x00000FFF,		/* 4 KB total */
-		.flags  = IORESOURCE_MEM,
-	},
+	/* 4KiB */
+	PREALLOC_NORMAL("DisplayBins0", 0x00000000, 0x00001000-1,
+		(IORESOURCE_MEM|IORESOURCE_PTV_RES_LOEXT))
+
 	/*
-	 *
-	 * Display bins buffer
-	 *
-	 * This driver requires:
-	 *
-	 * Arbitrary Based Buffers:
-	 *  Display Bins for unit1
-	 *
+	 * Display bins buffer for unit1
 	 */
-	{
-		.name   = "DisplayBins1",
-		.start  = 0x64AD4000,
-		.end    = 0x64AD5000 - 1,  /* 4 KB total */
-		.flags  = IORESOURCE_IO,
-	},
+	/* 4KiB */
+	PREALLOC_NORMAL("DisplayBins1", 0x00000000, 0x00001000-1,
+		IORESOURCE_MEM)
+
 	/*
-	 *
 	 * AVFS: player HAL memory
-	 *
-	 *
 	 */
-	{
-		.name   = "AvfsDmaMem",
-		.start  = 0x6430E000,
-		.end    = 0x645D2C00 - 1,  /* 945K * 3 for playback */
-		.flags  = IORESOURCE_IO,
-	},
+	/* 945K * 3 for playback */
+	PREALLOC_NORMAL("AvfsDmaMem", 0x00000000, 0x002c4c00-1, IORESOURCE_MEM)
+
 	/*
-	 *
 	 * PMEM
-	 *
-	 * This driver requires:
-	 *
-	 * Arbitrary Based Buffers:
-	 *  Persistent memory for diagnostics.
-	 *
 	 */
-	{
-		.name   = "DiagPersistentMemory",
-		.start  = 0x00000000,
-		.end    = 0x10000 - 1,
-		.flags  = IORESOURCE_MEM,
-	},
+	/* Persistent memory for diagnostics (64KiB) */
+	PREALLOC_PMEM("DiagPersistentMemory", 0x00000000, 0x10000-1,
+	     (IORESOURCE_MEM|IORESOURCE_PTV_RES_LOEXT))
+
 	/*
-	 *
 	 * Smartcard
-	 *
-	 * This driver requires:
-	 *
-	 * Arbitrary Based Buffers:
-	 *  Read and write buffers for Internal/External cards
-	 *
 	 */
-	{
-		.name   = "SmartCardInfo",
-		.start  = 0x64AD1000,
-		.end    = 0x64AD3800 - 1,
-		.flags  = IORESOURCE_IO,
-	},
+	/* Read and write buffers for Internal/External cards (10KiB) */
+	PREALLOC_NORMAL("SmartCardInfo", 0x00000000, 0x2800-1, IORESOURCE_MEM)
+
 	/*
-	 *
 	 * KAVNET
-	 *    NP Reset Vector - must be of the form xxCxxxxx
-	 *	   NP Image - must be video bank 1
-	 *	   NP IPC - must be video bank 2
+	 */
+	/* NP Reset Vector - must be of the form xxCxxxxx (4KiB) */
+	PREALLOC_NORMAL("NP_Reset_Vector", 0x27c00000, 0x27c01000-1,
+		IORESOURCE_MEM)
+	/* NP Image - must be video bank 1 (320KiB) */
+	PREALLOC_NORMAL("NP_Image", 0x27020000, 0x27070000-1, IORESOURCE_MEM)
+	/* NP IPC - must be video bank 2 (512KiB) */
+	PREALLOC_NORMAL("NP_IPC", 0x63500000, 0x63580000-1, IORESOURCE_MEM)
+
+	/*
+	 * NAND Flash
+	 */
+	/* 10KiB */
+	PREALLOC_NORMAL("NandFlash", NAND_FLASH_BASE, NAND_FLASH_BASE+0x400-1,
+		IORESOURCE_MEM)
+
+	/*
+	 * Add other resources here
+	 */
+
+	/*
+	 * End of Resource marker
 	 */
 	{
-		.name   = "NP_Reset_Vector",
-		.start  = 0x27c00000,
-		.end    = 0x27c01000 - 1,
-		.flags  = IORESOURCE_MEM,
-	},
-	{
-		.name   = "NP_Image",
-		.start  = 0x27020000,
-		.end    = 0x27060000 - 1,
-		.flags  = IORESOURCE_MEM,
-	},
-	{
-		.name   = "NP_IPC",
-		.start  = 0x63500000,
-		.end    = 0x63580000 - 1,
-		.flags  = IORESOURCE_IO,
+		.flags  = 0,
 	},
-	{ },
 };
diff --git a/arch/mips/powertv/asic/prealloc-cronuslite.c b/arch/mips/powertv/asic/prealloc-cronuslite.c
old mode 100644
new mode 100755
index 23a9056..1e7419d
--- a/arch/mips/powertv/asic/prealloc-cronuslite.c
+++ b/arch/mips/powertv/asic/prealloc-cronuslite.c
@@ -1,4 +1,6 @@
 /*
+ *				prealloc-cronuslite.c
+ *
  * Memory pre-allocations for Cronus Lite boxes.
  *
  * Copyright (C) 2005-2009 Scientific-Atlanta, Inc.
@@ -22,7 +24,9 @@
  */
 
 #include <linux/init.h>
+#include <linux/ioport.h>
 #include <asm/mach-powertv/asic.h>
+#include "prealloc.h"
 
 /*
  * NON_DVR_CAPABLE CRONUSLITE RESOURCES
@@ -30,261 +34,143 @@
 struct resource non_dvr_cronuslite_resources[] __initdata =
 {
 	/*
-	 *
 	 * VIDEO2 / LX2
-	 *
 	 */
-	{
-		.name   = "ST231aImage",	/* Delta-Mu 2 image and ram */
-		.start  = 0x60000000,
-		.end    = 0x601FFFFF,		/* 2MiB */
-		.flags  = IORESOURCE_IO,
-	},
-	{
-		.name   = "ST231aMonitor",	/* 8KiB block ST231b monitor */
-		.start  = 0x60200000,
-		.end    = 0x60201FFF,
-		.flags  = IORESOURCE_IO,
-	},
-	{
-		.name   = "MediaMemory1",
-		.start  = 0x60202000,
-		.end    = 0x61FFFFFF, /*~29.9MiB (32MiB - (2MiB + 8KiB)) */
-		.flags  = IORESOURCE_IO,
-	},
+	/* Delta-Mu 1 image (2MiB) */
+	PREALLOC_NORMAL("ST231aImage", 0x60000000, 0x60200000-1,
+		IORESOURCE_MEM)
+	/* Delta-Mu 1 monitor (8KiB) */
+	PREALLOC_NORMAL("ST231aMonitor", 0x60200000, 0x60202000-1,
+		IORESOURCE_MEM)
+	/* Delta-Mu 1 RAM (~29.9MiB (32MiB - (2MiB + 8KiB))) */
+	PREALLOC_NORMAL("MediaMemory1", 0x60202000, 0x62000000-1,
+		IORESOURCE_MEM)
+
 	/*
-	 *
 	 * Sysaudio Driver
-	 *
-	 * This driver requires:
-	 *
-	 * Arbitrary Based Buffers:
-	 *  DSP_Image_Buff - DSP code and data images (1MB)
-	 *  ADSC_CPU_PCM_Buff - ADSC CPU PCM buffer (40KB)
-	 *  ADSC_AUX_Buff - ADSC AUX buffer (16KB)
-	 *  ADSC_Main_Buff - ADSC Main buffer (16KB)
-	 *
 	 */
-	{
-		.name   = "DSP_Image_Buff",
-		.start  = 0x00000000,
-		.end    = 0x000FFFFF,
-		.flags  = IORESOURCE_MEM,
-	},
-	{
-		.name   = "ADSC_CPU_PCM_Buff",
-		.start  = 0x00000000,
-		.end    = 0x00009FFF,
-		.flags  = IORESOURCE_MEM,
-	},
-	{
-		.name   = "ADSC_AUX_Buff",
-		.start  = 0x00000000,
-		.end    = 0x00003FFF,
-		.flags  = IORESOURCE_MEM,
-	},
-	{
-		.name   = "ADSC_Main_Buff",
-		.start  = 0x00000000,
-		.end    = 0x00003FFF,
-		.flags  = IORESOURCE_MEM,
-	},
+	/* DSP code and data images (1MiB) */
+	PREALLOC_NORMAL("DSP_Image_Buff", 0x00000000, 0x00100000-1,
+		(IORESOURCE_MEM|IORESOURCE_PTV_RES_LOEXT))
+	/* ADSC CPU PCM buffer (40KiB) */
+	PREALLOC_NORMAL("ADSC_CPU_PCM_Buff", 0x00000000, 0x0000A000-1,
+		(IORESOURCE_MEM|IORESOURCE_PTV_RES_LOEXT))
+	/* ADSC AUX buffer (128KiB) */
+	PREALLOC_NORMAL("ADSC_AUX_Buff", 0x00000000, 0x00020000-1,
+		(IORESOURCE_MEM|IORESOURCE_PTV_RES_LOEXT))
+	/* ADSC Main buffer (128KiB) */
+	PREALLOC_NORMAL("ADSC_Main_Buff", 0x00000000, 0x00020000-1,
+		(IORESOURCE_MEM|IORESOURCE_PTV_RES_LOEXT))
+
 	/*
-	 *
 	 * STAVEM driver/STAPI
 	 *
-	 * This driver requires:
-	 *
-	 * Arbitrary Based Buffers:
 	 *  This memory area is used for allocating buffers for Video decoding
 	 *  purposes.  Allocation/De-allocation within this buffer is managed
 	 *  by the STAVMEM driver of the STAPI.  They could be Decimated
 	 *  Picture Buffers, Intermediate Buffers, as deemed necessary for
 	 *  video decoding purposes, for any video decoders on Zeus.
-	 *
 	 */
-	{
-		.name   = "AVMEMPartition0",
-		.start  = 0x63580000,
-		.end    = 0x63B80000 - 1,  /* 6 MB total */
-		.flags  = IORESOURCE_IO,
-	},
+	/* 6MiB */
+	PREALLOC_NORMAL("AVMEMPartition0", 0x00000000, 0x00600000-1,
+		IORESOURCE_MEM)
+
 	/*
-	 *
 	 * DOCSIS Subsystem
-	 *
-	 * This driver requires:
-	 *
-	 * Arbitrary Based Buffers:
-	 *  Docsis -
-	 *
 	 */
-	{
-		.name   = "Docsis",
-		.start  = 0x62000000,
-		.end    = 0x62700000 - 1,	/* 7 MB total */
-		.flags  = IORESOURCE_IO,
-	},
+	/* 7MiB */
+	PREALLOC_DOCSIS("Docsis", 0x67500000, 0x67c00000-1, IORESOURCE_MEM)
+
 	/*
-	 *
 	 * GHW HAL Driver
-	 *
-	 * This driver requires:
-	 *
-	 * Arbitrary Based Buffers:
-	 *  GraphicsHeap - PowerTV Graphics Heap
-	 *
 	 */
-	{
-		.name   = "GraphicsHeap",
-		.start  = 0x62700000,
-		.end    = 0x63500000 - 1,	/* 14 MB total */
-		.flags  = IORESOURCE_IO,
-	},
+	/* PowerTV Graphics Heap (14MiB) */
+	PREALLOC_NORMAL("GraphicsHeap", 0x62700000, 0x63500000-1,
+		IORESOURCE_MEM)
+
 	/*
-	 *
 	 * multi com buffer area
-	 *
-	 * This driver requires:
-	 *
-	 * Arbitrary Based Buffers:
-	 *  Docsis -
-	 *
 	 */
-	{
-		.name   = "MulticomSHM",
-		.start  = 0x26000000,
-		.end    = 0x26020000 - 1,
-		.flags  = IORESOURCE_MEM,
-	},
+	/* 128KiB */
+	PREALLOC_NORMAL("MulticomSHM", 0x26000000, 0x26020000-1,
+		IORESOURCE_MEM)
+
 	/*
-	 *
-	 * DMA Ring buffer
-	 *
-	 * This driver requires:
-	 *
-	 * Arbitrary Based Buffers:
-	 *  Docsis -
-	 *
+	 * DMA Ring buffer (don't need recording buffers)
 	 */
-	{
-		.name   = "BMM_Buffer",
-		.start  = 0x00000000,
-		.end    = 0x000AA000 - 1,
-		.flags  = IORESOURCE_MEM,
-	},
+	/* 680KiB */
+	PREALLOC_NORMAL("BMM_Buffer", 0x00000000, 0x000AA000-1,
+		(IORESOURCE_MEM|IORESOURCE_PTV_RES_LOEXT))
+
 	/*
-	 *
 	 * Display bins buffer for unit0
-	 *
-	 * This driver requires:
-	 *
-	 * Arbitrary Based Buffers:
-	 *  Display Bins for unit0
-	 *
 	 */
-	{
-		.name   = "DisplayBins0",
-		.start  = 0x00000000,
-		.end    = 0x00000FFF,		/* 4 KB total */
-		.flags  = IORESOURCE_MEM,
-	},
+	/* 4KiB */
+	PREALLOC_NORMAL("DisplayBins0", 0x00000000, 0x00001000-1,
+		(IORESOURCE_MEM|IORESOURCE_PTV_RES_LOEXT))
+
 	/*
-	 *
-	 * Display bins buffer
-	 *
-	 * This driver requires:
-	 *
-	 * Arbitrary Based Buffers:
-	 *  Display Bins for unit1
-	 *
+	 * Display bins buffer for unit1
 	 */
-	{
-		.name   = "DisplayBins1",
-		.start  = 0x63B83000,
-		.end    = 0x63B84000 - 1,  /* 4 KB total */
-		.flags  = IORESOURCE_IO,
-	},
+	/* 4KiB */
+	PREALLOC_NORMAL("DisplayBins1", 0x00000000, 0x00001000-1,
+		IORESOURCE_MEM)
+
 	/*
-	 *
 	 * AVFS: player HAL memory
-	 *
-	 *
 	 */
-	{
-		.name   = "AvfsDmaMem",
-		.start  = 0x63B84000,
-		.end    = 0x63E48C00 - 1,  /* 945K * 3 for playback */
-		.flags  = IORESOURCE_IO,
-	},
+	/* 945K * 3 for playback */
+	PREALLOC_NORMAL("AvfsDmaMem", 0x00000000, 0x002c4c00-1,
+		(IORESOURCE_MEM|IORESOURCE_PTV_RES_LOEXT))
+
 	/*
-	 *
 	 * PMEM
-	 *
-	 * This driver requires:
-	 *
-	 * Arbitrary Based Buffers:
-	 *  Persistent memory for diagnostics.
-	 *
 	 */
-	{
-		.name   = "DiagPersistentMemory",
-		.start  = 0x00000000,
-		.end    = 0x10000 - 1,
-		.flags  = IORESOURCE_MEM,
-	},
+	/* Persistent memory for diagnostics (64KiB) */
+	PREALLOC_PMEM("DiagPersistentMemory", 0x00000000, 0x10000-1,
+	     (IORESOURCE_MEM|IORESOURCE_PTV_RES_LOEXT))
+
 	/*
-	 *
 	 * Smartcard
-	 *
-	 * This driver requires:
-	 *
-	 * Arbitrary Based Buffers:
-	 *  Read and write buffers for Internal/External cards
-	 *
 	 */
-	{
-		.name   = "SmartCardInfo",
-		.start  = 0x63B80000,
-		.end    = 0x63B82800 - 1,
-		.flags  = IORESOURCE_IO,
-	},
+	/* Read and write buffers for Internal/External cards (10KiB) */
+	PREALLOC_NORMAL("SmartCardInfo", 0x00000000, 0x2800-1, IORESOURCE_MEM)
+
 	/*
-	 *
 	 * KAVNET
-	 *    NP Reset Vector - must be of the form xxCxxxxx
-	 *	   NP Image - must be video bank 1
-	 *	   NP IPC - must be video bank 2
 	 */
-	{
-		.name   = "NP_Reset_Vector",
-		.start  = 0x27c00000,
-		.end    = 0x27c01000 - 1,
-		.flags  = IORESOURCE_MEM,
-	},
-	{
-		.name   = "NP_Image",
-		.start  = 0x27020000,
-		.end    = 0x27060000 - 1,
-		.flags  = IORESOURCE_MEM,
-	},
-	{
-		.name   = "NP_IPC",
-		.start  = 0x63500000,
-		.end    = 0x63580000 - 1,
-		.flags  = IORESOURCE_IO,
-	},
+	/* NP Reset Vector - must be of the form xxCxxxxx (4KiB) */
+	PREALLOC_NORMAL("NP_Reset_Vector", 0x27c00000, 0x27c01000-1,
+		IORESOURCE_MEM)
+	/* NP Image - must be video bank 1 (320KiB) */
+	PREALLOC_NORMAL("NP_Image", 0x27020000, 0x27070000-1, IORESOURCE_MEM)
+	/* NP IPC - must be video bank 2 (512KiB) */
+	PREALLOC_NORMAL("NP_IPC", 0x63500000, 0x63580000-1, IORESOURCE_MEM)
+
 	/*
 	 * NAND Flash
 	 */
-	{
-		.name   = "NandFlash",
-		.start  = NAND_FLASH_BASE,
-		.end    = NAND_FLASH_BASE + 0x400 - 1,
-		.flags  = IORESOURCE_IO,
-	},
+	/* 10KiB */
+	PREALLOC_NORMAL("NandFlash", NAND_FLASH_BASE, NAND_FLASH_BASE+0x400-1,
+		IORESOURCE_MEM)
+
+	/*
+	 * TFTPBuffer
+	 *
+	 *  This buffer is used in some minimal configurations (e.g. two-way
+	 *  loader) for storing software images
+	 */
+	PREALLOC_TFTP("TFTPBuffer", 0x00000000, MEBIBYTE(80)-1,
+		(IORESOURCE_MEM|IORESOURCE_PTV_RES_LOEXT))
+
 	/*
 	 * Add other resources here
 	 */
-	{ },
+
+	/*
+	 * End of Resource marker
+	 */
+	{
+		.flags  = 0,
+	},
 };
diff --git a/arch/mips/powertv/asic/prealloc-zeus.c b/arch/mips/powertv/asic/prealloc-zeus.c
old mode 100644
new mode 100755
index 018d451..4333572
--- a/arch/mips/powertv/asic/prealloc-zeus.c
+++ b/arch/mips/powertv/asic/prealloc-zeus.c
@@ -1,4 +1,6 @@
 /*
+ *				prealloc-zeus.c
+ *
  * Memory pre-allocations for Zeus boxes.
  *
  * Copyright (C) 2005-2009 Scientific-Atlanta, Inc.
@@ -22,7 +24,9 @@
  */
 
 #include <linux/init.h>
+#include <linux/ioport.h>
 #include <asm/mach-powertv/asic.h>
+#include "prealloc.h"
 
 /*
  * DVR_CAPABLE RESOURCES
@@ -30,280 +34,151 @@
 struct resource dvr_zeus_resources[] __initdata =
 {
 	/*
-	 *
 	 * VIDEO1 / LX1
-	 *
 	 */
-	{
-		.name   = "ST231aImage",	/* Delta-Mu 1 image and ram */
-		.start  = 0x20000000,
-		.end    = 0x201FFFFF,		/* 2MiB */
-		.flags  = IORESOURCE_IO,
-	},
-	{
-		.name   = "ST231aMonitor",	/* 8KiB block ST231a monitor */
-		.start  = 0x20200000,
-		.end    = 0x20201FFF,
-		.flags  = IORESOURCE_IO,
-	},
-	{
-		.name   = "MediaMemory1",
-		.start  = 0x20202000,
-		.end    = 0x21FFFFFF, /*~29.9MiB (32MiB - (2MiB + 8KiB)) */
-		.flags  = IORESOURCE_IO,
-	},
+	/* Delta-Mu 1 image (2MiB) */
+	PREALLOC_NORMAL("ST231aImage", 0x20000000, 0x20200000-1,
+		IORESOURCE_MEM)
+	/* Delta-Mu 1 monitor (8KiB) */
+	PREALLOC_NORMAL("ST231aMonitor", 0x20200000, 0x20202000-1,
+		IORESOURCE_MEM)
+	/* Delta-Mu 1 RAM (~29.9MiB (32MiB - (2MiB + 8KiB))) */
+	PREALLOC_NORMAL("MediaMemory1", 0x20202000, 0x22000000-1,
+		IORESOURCE_MEM)
+
 	/*
-	 *
 	 * VIDEO2 / LX2
-	 *
 	 */
-	{
-		.name   = "ST231bImage",	/* Delta-Mu 2 image and ram */
-		.start  = 0x30000000,
-		.end    = 0x301FFFFF,		/* 2MiB */
-		.flags  = IORESOURCE_IO,
-	},
-	{
-		.name   = "ST231bMonitor",	/* 8KiB block ST231b monitor */
-		.start  = 0x30200000,
-		.end    = 0x30201FFF,
-		.flags  = IORESOURCE_IO,
-	},
-	{
-		.name   = "MediaMemory2",
-		.start  = 0x30202000,
-		.end    = 0x31FFFFFF, /*~29.9MiB (32MiB - (2MiB + 8KiB)) */
-		.flags  = IORESOURCE_IO,
-	},
+	/* Delta-Mu 2 image (2MiB) */
+	PREALLOC_NORMAL("ST231bImage", 0x30000000, 0x30200000-1,
+		IORESOURCE_MEM)
+	/* Delta-Mu 2 monitor (8KiB) */
+	PREALLOC_NORMAL("ST231bMonitor", 0x30200000, 0x30202000-1,
+		IORESOURCE_MEM)
+	/* Delta-Mu 2 RAM (~29.9MiB (32MiB - (2MiB + 8KiB))) */
+	PREALLOC_NORMAL("MediaMemory2", 0x30202000, 0x32000000-1,
+		IORESOURCE_MEM)
+
 	/*
-	 *
 	 * Sysaudio Driver
-	 *
-	 * This driver requires:
-	 *
-	 * Arbitrary Based Buffers:
-	 *  DSP_Image_Buff - DSP code and data images (1MB)
-	 *  ADSC_CPU_PCM_Buff - ADSC CPU PCM buffer (40KB)
-	 *  ADSC_AUX_Buff - ADSC AUX buffer (16KB)
-	 *  ADSC_Main_Buff - ADSC Main buffer (16KB)
-	 *
 	 */
-	{
-		.name   = "DSP_Image_Buff",
-		.start  = 0x00000000,
-		.end    = 0x000FFFFF,
-		.flags  = IORESOURCE_MEM,
-	},
-	{
-		.name   = "ADSC_CPU_PCM_Buff",
-		.start  = 0x00000000,
-		.end    = 0x00009FFF,
-		.flags  = IORESOURCE_MEM,
-	},
-	{
-		.name   = "ADSC_AUX_Buff",
-		.start  = 0x00000000,
-		.end    = 0x00003FFF,
-		.flags  = IORESOURCE_MEM,
-	},
-	{
-		.name   = "ADSC_Main_Buff",
-		.start  = 0x00000000,
-		.end    = 0x00003FFF,
-		.flags  = IORESOURCE_MEM,
-	},
+	/* DSP code and data images (1MiB) */
+	PREALLOC_NORMAL("DSP_Image_Buff", 0x00000000, 0x00100000-1,
+		(IORESOURCE_MEM|IORESOURCE_PTV_RES_LOEXT))
+	/* ADSC CPU PCM buffer (40KiB) */
+	PREALLOC_NORMAL("ADSC_CPU_PCM_Buff", 0x00000000, 0x0000A000-1,
+		(IORESOURCE_MEM|IORESOURCE_PTV_RES_LOEXT))
+	/* ADSC AUX buffer (16KiB) */
+	PREALLOC_NORMAL("ADSC_AUX_Buff", 0x00000000, 0x00004000-1,
+		(IORESOURCE_MEM|IORESOURCE_PTV_RES_LOEXT))
+	/* ADSC Main buffer (16KiB) */
+	PREALLOC_NORMAL("ADSC_Main_Buff", 0x00000000, 0x00004000-1,
+		(IORESOURCE_MEM|IORESOURCE_PTV_RES_LOEXT))
+
 	/*
-	 *
 	 * STAVEM driver/STAPI
 	 *
-	 * This driver requires:
-	 *
-	 * Arbitrary Based Buffers:
 	 *  This memory area is used for allocating buffers for Video decoding
 	 *  purposes.  Allocation/De-allocation within this buffer is managed
 	 *  by the STAVMEM driver of the STAPI.  They could be Decimated
 	 *  Picture Buffers, Intermediate Buffers, as deemed necessary for
 	 *  video decoding purposes, for any video decoders on Zeus.
-	 *
 	 */
-	{
-		.name   = "AVMEMPartition0",
-		.start  = 0x00000000,
-		.end    = 0x00c00000 - 1,	/* 12 MB total */
-		.flags  = IORESOURCE_MEM,
-	},
+	/* 12MiB */
+	PREALLOC_NORMAL("AVMEMPartition0", 0x00000000, 0x00c00000-1,
+		(IORESOURCE_MEM|IORESOURCE_PTV_RES_LOEXT))
+
 	/*
-	 *
 	 * DOCSIS Subsystem
-	 *
-	 * This driver requires:
-	 *
-	 * Arbitrary Based Buffers:
-	 *  Docsis -
-	 *
 	 */
-	{
-		.name   = "Docsis",
-		.start  = 0x40100000,
-		.end    = 0x407fffff,
-		.flags  = IORESOURCE_MEM,
-	},
+	/* 7MiB */
+	PREALLOC_DOCSIS("Docsis", 0x40100000, 0x40800000-1, IORESOURCE_MEM)
+
 	/*
-	 *
 	 * GHW HAL Driver
-	 *
-	 * This driver requires:
-	 *
-	 * Arbitrary Based Buffers:
-	 *  GraphicsHeap - PowerTV Graphics Heap
-	 *
 	 */
-	{
-		.name   = "GraphicsHeap",
-		.start  = 0x46900000,
-		.end    = 0x47700000 - 1,	/* 14 MB total */
-		.flags  = IORESOURCE_MEM,
-	},
+	/* PowerTV Graphics Heap (14MiB) */
+	PREALLOC_NORMAL("GraphicsHeap", 0x46900000, 0x47700000-1,
+		IORESOURCE_MEM)
+
 	/*
-	 *
 	 * multi com buffer area
-	 *
-	 * This driver requires:
-	 *
-	 * Arbitrary Based Buffers:
-	 *  Docsis -
-	 *
 	 */
-	{
-		.name   = "MulticomSHM",
-		.start  = 0x47900000,
-		.end    = 0x47920000 - 1,
-		.flags  = IORESOURCE_MEM,
-	},
+	/* 128KiB */
+	PREALLOC_NORMAL("MulticomSHM", 0x47900000, 0x47920000-1,
+		IORESOURCE_MEM)
+
 	/*
-	 *
 	 * DMA Ring buffer
-	 *
-	 * This driver requires:
-	 *
-	 * Arbitrary Based Buffers:
-	 *  Docsis -
-	 *
 	 */
-	{
-		.name   = "BMM_Buffer",
-		.start  = 0x00000000,
-		.end    = 0x00280000 - 1,
-		.flags  = IORESOURCE_MEM,
-	},
+	/* 2.5MiB */
+	PREALLOC_NORMAL("BMM_Buffer", 0x00000000, 0x00280000-1,
+		(IORESOURCE_MEM|IORESOURCE_PTV_RES_LOEXT))
+
 	/*
-	 *
 	 * Display bins buffer for unit0
-	 *
-	 * This driver requires:
-	 *
-	 * Arbitrary Based Buffers:
-	 *  Display Bins for unit0
-	 *
 	 */
-	{
-		.name   = "DisplayBins0",
-		.start  = 0x00000000,
-		.end    = 0x00000FFF,	/* 4 KB total */
-		.flags  = IORESOURCE_MEM,
-	},
+	/* 4KiB */
+	PREALLOC_NORMAL("DisplayBins0", 0x00000000, 0x00001000-1,
+		(IORESOURCE_MEM|IORESOURCE_PTV_RES_LOEXT))
+
 	/*
-	 *
-	 * Display bins buffer
-	 *
-	 * This driver requires:
-	 *
-	 * Arbitrary Based Buffers:
-	 *  Display Bins for unit1
-	 *
+	 * Display bins buffer for unit1
 	 */
-	{
-		.name   = "DisplayBins1",
-		.start  = 0x00000000,
-		.end    = 0x00000FFF,	/* 4 KB total */
-		.flags  = IORESOURCE_MEM,
-	},
+	/* 4KiB */
+	PREALLOC_NORMAL("DisplayBins1", 0x00000000, 0x00001000-1,
+		(IORESOURCE_MEM|IORESOURCE_PTV_RES_LOEXT))
+
 	/*
-	 *
 	 * ITFS
-	 *
-	 * This driver requires:
-	 *
-	 * Arbitrary Based Buffers:
-	 *  Docsis -
-	 *
 	 */
-	{
-		.name   = "ITFS",
-		.start  = 0x00000000,
-		/* 815,104 bytes each for 2 ITFS partitions. */
-		.end    = 0x0018DFFF,
-		.flags  = IORESOURCE_MEM,
-	},
+	/* 815,104 bytes each for 2 ITFS partitions. */
+	PREALLOC_NORMAL("ITFS", 0x00000000, 0x0018E000-1,
+		(IORESOURCE_MEM|IORESOURCE_PTV_RES_LOEXT))
+
 	/*
-	 *
 	 * AVFS
-	 *
-	 * This driver requires:
-	 *
-	 * Arbitrary Based Buffers:
-	 *  Docsis -
-	 *
 	 */
-	{
-		.name   = "AvfsDmaMem",
-		.start  = 0x00000000,
-		/* (945K * 8) = (128K * 3) 5 playbacks / 3 server */
-		.end    = 0x007c2000 - 1,
-		.flags  = IORESOURCE_MEM,
-	},
-	{
-		.name   = "AvfsFileSys",
-		.start  = 0x00000000,
-		.end    = 0x00001000 - 1,  /* 4K */
-		.flags  = IORESOURCE_MEM,
-	},
+	/* (945K * 8) = (128K * 3) 5 playbacks / 3 server */
+	PREALLOC_NORMAL("AvfsDmaMem", 0x00000000, 0x007c2000-1,
+		(IORESOURCE_MEM|IORESOURCE_PTV_RES_LOEXT))
+	/* 4KiB */
+	PREALLOC_NORMAL("AvfsFileSys", 0x00000000, 0x00001000-1,
+		(IORESOURCE_MEM|IORESOURCE_PTV_RES_LOEXT))
+
 	/*
-	 *
 	 * PMEM
-	 *
-	 * This driver requires:
-	 *
-	 * Arbitrary Based Buffers:
-	 *  Persistent memory for diagnostics.
-	 *
 	 */
-	{
-		.name   = "DiagPersistentMemory",
-		.start  = 0x00000000,
-		.end    = 0x10000 - 1,
-		.flags  = IORESOURCE_MEM,
-	},
+	/* Persistent memory for diagnostics (64KiB) */
+	PREALLOC_PMEM("DiagPersistentMemory", 0x00000000, 0x10000-1,
+	     (IORESOURCE_MEM|IORESOURCE_PTV_RES_LOEXT))
+
 	/*
-	 *
 	 * Smartcard
+	 */
+	/* Read and write buffers for Internal/External cards (10KiB) */
+	PREALLOC_NORMAL("SmartCardInfo", 0x00000000, 0x2800-1,
+		(IORESOURCE_MEM|IORESOURCE_PTV_RES_LOEXT))
+
+	/*
+	 * TFTPBuffer
 	 *
-	 * This driver requires:
-	 *
-	 * Arbitrary Based Buffers:
-	 *  Read and write buffers for Internal/External cards
-	 *
+	 *  This buffer is used in some minimal configurations (e.g. two-way
+	 *  loader) for storing software images
 	 */
-	{
-		.name   = "SmartCardInfo",
-		.start  = 0x00000000,
-		.end    = 0x2800 - 1,
-		.flags  = IORESOURCE_MEM,
-	},
+	PREALLOC_TFTP("TFTPBuffer", 0x00000000, MEBIBYTE(80)-1,
+		(IORESOURCE_MEM|IORESOURCE_PTV_RES_LOEXT))
+
 	/*
 	 * Add other resources here
 	 */
-	{ },
+
+	/*
+	 * End of Resource marker
+	 */
+	{
+		.flags  = 0,
+	},
 };
 
 /*
@@ -314,146 +189,118 @@ struct resource non_dvr_zeus_resources[] __initdata =
 	/*
 	 * VIDEO1 / LX1
 	 */
-	{
-		.name   = "ST231aImage",	/* Delta-Mu 1 image and ram */
-		.start  = 0x20000000,
-		.end    = 0x201FFFFF,		/* 2MiB */
-		.flags  = IORESOURCE_IO,
-	},
-	{
-		.name   = "ST231aMonitor",	/* 8KiB block ST231a monitor */
-		.start  = 0x20200000,
-		.end    = 0x20201FFF,
-		.flags  = IORESOURCE_IO,
-	},
-	{
-		.name   = "MediaMemory1",
-		.start  = 0x20202000,
-		.end    = 0x21FFFFFF, /*~29.9MiB (32MiB - (2MiB + 8KiB)) */
-		.flags  = IORESOURCE_IO,
-	},
+	/* Delta-Mu 1 image (2MiB) */
+	PREALLOC_NORMAL("ST231aImage", 0x20000000, 0x20200000-1,
+		IORESOURCE_MEM)
+	/* Delta-Mu 1 monitor (8KiB) */
+	PREALLOC_NORMAL("ST231aMonitor", 0x20200000, 0x20202000-1,
+		IORESOURCE_MEM)
+	/* Delta-Mu 1 RAM (~29.9MiB (32MiB - (2MiB + 8KiB))) */
+	PREALLOC_NORMAL("MediaMemory1", 0x20202000, 0x22000000-1,
+		IORESOURCE_MEM)
+
 	/*
 	 * Sysaudio Driver
 	 */
-	{
-		.name   = "DSP_Image_Buff",
-		.start  = 0x00000000,
-		.end    = 0x000FFFFF,
-		.flags  = IORESOURCE_MEM,
-	},
-	{
-		.name   = "ADSC_CPU_PCM_Buff",
-		.start  = 0x00000000,
-		.end    = 0x00009FFF,
-		.flags  = IORESOURCE_MEM,
-	},
-	{
-		.name   = "ADSC_AUX_Buff",
-		.start  = 0x00000000,
-		.end    = 0x00003FFF,
-		.flags  = IORESOURCE_MEM,
-	},
-	{
-		.name   = "ADSC_Main_Buff",
-		.start  = 0x00000000,
-		.end    = 0x00003FFF,
-		.flags  = IORESOURCE_MEM,
-	},
+	/* DSP code and data images (1MiB) */
+	PREALLOC_NORMAL("DSP_Image_Buff", 0x00000000, 0x00100000-1,
+		(IORESOURCE_MEM|IORESOURCE_PTV_RES_LOEXT))
+	/* ADSC CPU PCM buffer (40KiB) */
+	PREALLOC_NORMAL("ADSC_CPU_PCM_Buff", 0x00000000, 0x0000A000-1,
+		(IORESOURCE_MEM|IORESOURCE_PTV_RES_LOEXT))
+	/* ADSC AUX buffer (16KiB) */
+	PREALLOC_NORMAL("ADSC_AUX_Buff", 0x00000000, 0x00004000-1,
+		(IORESOURCE_MEM|IORESOURCE_PTV_RES_LOEXT))
+	/* ADSC Main buffer (16KiB) */
+	PREALLOC_NORMAL("ADSC_Main_Buff", 0x00000000, 0x00004000-1,
+		(IORESOURCE_MEM|IORESOURCE_PTV_RES_LOEXT))
+
 	/*
 	 * STAVEM driver/STAPI
 	 */
-	{
-		.name   = "AVMEMPartition0",
-		.start  = 0x00000000,
-		.end    = 0x00600000 - 1,	/* 6 MB total */
-		.flags  = IORESOURCE_MEM,
-	},
+	/* 6MiB */
+	PREALLOC_NORMAL("AVMEMPartition0", 0x00000000, 0x00600000-1,
+		(IORESOURCE_MEM|IORESOURCE_PTV_RES_LOEXT))
+
 	/*
 	 * DOCSIS Subsystem
 	 */
-	{
-		.name   = "Docsis",
-		.start  = 0x40100000,
-		.end    = 0x407fffff,
-		.flags  = IORESOURCE_MEM,
-	},
+	/* 7MiB */
+	PREALLOC_DOCSIS("Docsis", 0x40100000, 0x40800000-1, IORESOURCE_MEM)
+
 	/*
 	 * GHW HAL Driver
 	 */
-	{
-		.name   = "GraphicsHeap",
-		.start  = 0x46900000,
-		.end    = 0x47700000 - 1,	/* 14 MB total */
-		.flags  = IORESOURCE_MEM,
-	},
+	/* PowerTV Graphics Heap (14MiB) */
+	PREALLOC_NORMAL("GraphicsHeap", 0x46900000, 0x47700000-1,
+		IORESOURCE_MEM)
+
 	/*
 	 * multi com buffer area
 	 */
-	{
-		.name   = "MulticomSHM",
-		.start  = 0x47900000,
-		.end    = 0x47920000 - 1,
-		.flags  = IORESOURCE_MEM,
-	},
+	/* 128KiB */
+	PREALLOC_NORMAL("MulticomSHM", 0x47900000, 0x47920000-1,
+		IORESOURCE_MEM)
+
 	/*
 	 * DMA Ring buffer
 	 */
-	{
-		.name   = "BMM_Buffer",
-		.start  = 0x00000000,
-		.end    = 0x00280000 - 1,
-		.flags  = IORESOURCE_MEM,
-	},
+	/* 2.5MiB */
+	PREALLOC_NORMAL("BMM_Buffer", 0x00000000, 0x00280000-1,
+		(IORESOURCE_MEM|IORESOURCE_PTV_RES_LOEXT))
+
 	/*
 	 * Display bins buffer for unit0
 	 */
-	{
-		.name   = "DisplayBins0",
-		.start  = 0x00000000,
-		.end    = 0x00000FFF,		/* 4 KB total */
-		.flags  = IORESOURCE_MEM,
-	},
+	/* 4KiB */
+	PREALLOC_NORMAL("DisplayBins0", 0x00000000, 0x00001000-1,
+		(IORESOURCE_MEM|IORESOURCE_PTV_RES_LOEXT))
+
 	/*
-	 *
 	 * AVFS: player HAL memory
-	 *
-	 *
 	 */
-	{
-		.name   = "AvfsDmaMem",
-		.start  = 0x00000000,
-		.end    = 0x002c4c00 - 1,	/* 945K * 3 for playback */
-		.flags  = IORESOURCE_MEM,
-	},
+	/* 945K * 3 for playback */
+	PREALLOC_NORMAL("AvfsDmaMem", 0x00000000, 0x002c4c00-1,
+		(IORESOURCE_MEM|IORESOURCE_PTV_RES_LOEXT))
+
 	/*
 	 * PMEM
 	 */
-	{
-		.name   = "DiagPersistentMemory",
-		.start  = 0x00000000,
-		.end    = 0x10000 - 1,
-		.flags  = IORESOURCE_MEM,
-	},
+	/* Persistent memory for diagnostics (64KiB) */
+	PREALLOC_PMEM("DiagPersistentMemory", 0x00000000, 0x10000-1,
+	     (IORESOURCE_MEM|IORESOURCE_PTV_RES_LOEXT))
+
 	/*
 	 * Smartcard
 	 */
-	{
-		.name   = "SmartCardInfo",
-		.start  = 0x00000000,
-		.end    = 0x2800 - 1,
-		.flags  = IORESOURCE_MEM,
-	},
+	/* Read and write buffers for Internal/External cards (10KiB) */
+	PREALLOC_NORMAL("SmartCardInfo", 0x00000000, 0x2800-1,
+		(IORESOURCE_MEM|IORESOURCE_PTV_RES_LOEXT))
+
 	/*
 	 * NAND Flash
 	 */
-	{
-		.name   = "NandFlash",
-		.start  = NAND_FLASH_BASE,
-		.end    = NAND_FLASH_BASE + 0x400 - 1,
-		.flags  = IORESOURCE_IO,
-	},
+	/* 10KiB */
+	PREALLOC_NORMAL("NandFlash", NAND_FLASH_BASE, NAND_FLASH_BASE+0x400-1,
+		IORESOURCE_MEM)
+
+	/*
+	 * TFTPBuffer
+	 *
+	 *  This buffer is used in some minimal configurations (e.g. two-way
+	 *  loader) for storing software images
+	 */
+	PREALLOC_TFTP("TFTPBuffer", 0x00000000, MEBIBYTE(80)-1,
+		(IORESOURCE_MEM|IORESOURCE_PTV_RES_LOEXT))
+
 	/*
 	 * Add other resources here
 	 */
-	{ },
+
+	/*
+	 * End of Resource marker
+	 */
+	{
+		.flags  = 0,
+	},
 };
diff --git a/arch/mips/powertv/asic/prealloc.h b/arch/mips/powertv/asic/prealloc.h
new file mode 100755
index 0000000..bc9588b
--- /dev/null
+++ b/arch/mips/powertv/asic/prealloc.h
@@ -0,0 +1,72 @@
+/*
+ *				prealloc.h
+ *
+ * Definitions for memory preallocations
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
+ */
+
+#ifndef _ARCH_MIPS_POWERTV_ASIC_PREALLOC_H
+#define _ARCH_MIPS_POWERTV_ASIC_PREALLOC_H
+
+#define KIBIBYTE(n) ((n) * 1024)    /* Number of kibibytes */
+#define MEBIBYTE(n) ((n) * KIBIBYTE(1024)) /* Number of mebibytes */
+
+/* "struct resource" array element definition */
+#define PREALLOC(NAME, START, END, FLAGS) {	\
+		.name = (NAME),			\
+		.start = (START),		\
+		.end = (END),			\
+		.flags = (FLAGS)		\
+	},
+
+/* Individual resources in the preallocated resource arrays are defined using
+ *  macros.  These macros are conditionally defined based on their
+ *  corresponding kernel configuration flag:
+ *    - CONFIG_PREALLOC_NORMAL: preallocate resources for a normal settop box
+ *    - CONFIG_PREALLOC_TFTP: preallocate the TFTP download resource
+ *    - CONFIG_PREALLOC_DOCSIS: preallocate the DOCSIS resource
+ *    - CONFIG_PREALLOC_PMEM: reserve space for persistent memory
+ */
+#ifdef CONFIG_PREALLOC_NORMAL
+#define PREALLOC_NORMAL(name, start, end, flags) \
+   PREALLOC(name, start, end, flags)
+#else
+#define PREALLOC_NORMAL(name, start, end, flags)
+#endif
+
+#ifdef CONFIG_PREALLOC_TFTP
+#define PREALLOC_TFTP(name, start, end, flags) \
+   PREALLOC(name, start, end, flags)
+#else
+#define PREALLOC_TFTP(name, start, end, flags)
+#endif
+
+#ifdef CONFIG_PREALLOC_DOCSIS
+#define PREALLOC_DOCSIS(name, start, end, flags) \
+   PREALLOC(name, start, end, flags)
+#else
+#define PREALLOC_DOCSIS(name, start, end, flags)
+#endif
+
+#ifdef CONFIG_PREALLOC_PMEM
+#define PREALLOC_PMEM(name, start, end, flags) \
+   PREALLOC(name, start, end, flags)
+#else
+#define PREALLOC_PMEM(name, start, end, flags)
+#endif
+#endif
