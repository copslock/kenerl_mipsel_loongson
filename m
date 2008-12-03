Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 03 Dec 2008 23:53:23 +0000 (GMT)
Received: from mail3.caviumnetworks.com ([12.108.191.235]:152 "EHLO
	mail3.caviumnetworks.com") by ftp.linux-mips.org with ESMTP
	id S24087270AbYLCXqF (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 3 Dec 2008 23:46:05 +0000
Received: from exch4.caveonetworks.com (Not Verified[192.168.16.23]) by mail3.caviumnetworks.com with MailMarshal (v6,2,2,3503)
	id <B493719e90004>; Wed, 03 Dec 2008 18:44:41 -0500
Received: from exch4.caveonetworks.com ([192.168.16.23]) by exch4.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Wed, 3 Dec 2008 15:44:40 -0800
Received: from dd1.caveonetworks.com ([64.169.86.201]) by exch4.caveonetworks.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
	 Wed, 3 Dec 2008 15:44:40 -0800
Received: from dd1.caveonetworks.com (localhost.localdomain [127.0.0.1])
	by dd1.caveonetworks.com (8.14.2/8.14.2) with ESMTP id mB3NiZki015670;
	Wed, 3 Dec 2008 15:44:35 -0800
Received: (from ddaney@localhost)
	by dd1.caveonetworks.com (8.14.2/8.14.2/Submit) id mB3NiZh3015669;
	Wed, 3 Dec 2008 15:44:35 -0800
From:	David Daney <ddaney@caviumnetworks.com>
To:	linux-mips@linux-mips.org
Cc:	David Daney <ddaney@caviumnetworks.com>,
	Tomaso Paoletti <tpaoletti@caviumnetworks.com>
Subject: [PATCH 21/21] MIPS: Add Cavium OCTEON to arch/mips/Kconfig
Date:	Wed,  3 Dec 2008 15:44:31 -0800
Message-Id: <1228347871-15563-21-git-send-email-ddaney@caviumnetworks.com>
X-Mailer: git-send-email 1.5.6.5
In-Reply-To: <493718EA.40703@caviumnetworks.com>
References: <493718EA.40703@caviumnetworks.com>
X-OriginalArrivalTime: 03 Dec 2008 23:44:40.0289 (UTC) FILETIME=[1BE57D10:01C955A1]
Return-Path: <David.Daney@caviumnetworks.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 21526
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@caviumnetworks.com
Precedence: bulk
X-list: linux-mips

Signed-off-by: Tomaso Paoletti <tpaoletti@caviumnetworks.com>
Signed-off-by: David Daney <ddaney@caviumnetworks.com>
---
 arch/mips/Kconfig |   65 +++++++++++++++++++++++++++++++++++++++++++++++++++-
 1 files changed, 63 insertions(+), 2 deletions(-)

diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index f4af967..8be48f8 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -595,6 +595,46 @@ config WR_PPMC
 	  This enables support for the Wind River MIPS32 4KC PPMC evaluation
 	  board, which is based on GT64120 bridge chip.
 
+config CAVIUM_OCTEON_SIMULATOR
+	bool "Support for the Cavium Networks Octeon Simulator"
+	select CEVT_R4K
+	select CSRC_R4K
+	select 64BIT_PHYS_ADDR
+	select DMA_COHERENT
+	select SYS_SUPPORTS_64BIT_KERNEL
+	select SYS_SUPPORTS_BIG_ENDIAN
+	select SYS_SUPPORTS_HIGHMEM
+	select CPU_CAVIUM_OCTEON
+	help
+	  The Octeon simulator is software performance model of the Cavium
+	  Octeon Processor. It supports simulating Octeon processors on x86
+	  hardware.
+
+config CAVIUM_OCTEON_REFERENCE_BOARD
+	bool "Support for the Cavium Networks Octeon reference board"
+	select CEVT_R4K
+	select CSRC_R4K
+	select 64BIT_PHYS_ADDR
+	select DMA_COHERENT
+	select SYS_SUPPORTS_64BIT_KERNEL
+	select SYS_SUPPORTS_BIG_ENDIAN
+	select SYS_SUPPORTS_HIGHMEM
+	select SYS_HAS_EARLY_PRINTK
+	select CPU_CAVIUM_OCTEON
+	select SWAP_IO_SPACE
+	help
+	  This option supports all of the Octeon reference boards from Cavium
+	  Networks. It builds a kernel that dynamically determines the Octeon
+	  CPU type and supports all known board reference implementations.
+	  Some of the supported boards are:
+		EBT3000
+		EBH3000
+		EBH3100
+		Thunder
+		Kodama
+		Hikari
+	  Say Y here for most Octeon reference boards.
+
 endchoice
 
 source "arch/mips/alchemy/Kconfig"
@@ -607,6 +647,7 @@ source "arch/mips/sgi-ip27/Kconfig"
 source "arch/mips/sibyte/Kconfig"
 source "arch/mips/txx9/Kconfig"
 source "arch/mips/vr41xx/Kconfig"
+source "arch/mips/cavium-octeon/Kconfig"
 
 endmenu
 
@@ -835,6 +876,9 @@ config IRQ_GT641XX
 config IRQ_GIC
 	bool
 
+config IRQ_CPU_OCTEON
+	bool
+
 config MIPS_BOARDS_GEN
 	bool
 
@@ -924,7 +968,7 @@ config BOOT_ELF32
 config MIPS_L1_CACHE_SHIFT
 	int
 	default "4" if MACH_DECSTATION || MIKROTIK_RB532
-	default "7" if SGI_IP22 || SGI_IP27 || SGI_IP28 || SNI_RM
+	default "7" if SGI_IP22 || SGI_IP27 || SGI_IP28 || SNI_RM || CPU_CAVIUM_OCTEON
 	default "4" if PMC_MSP4200_EVAL
 	default "5"
 
@@ -1185,6 +1229,23 @@ config CPU_SB1
 	select CPU_SUPPORTS_HIGHMEM
 	select WEAK_ORDERING
 
+config CPU_CAVIUM_OCTEON
+	bool "Cavium Octeon processor"
+	select IRQ_CPU
+	select IRQ_CPU_OCTEON
+	select CPU_HAS_PREFETCH
+	select CPU_SUPPORTS_64BIT_KERNEL
+	select SYS_SUPPORTS_SMP
+	select NR_CPUS_DEFAULT_16
+	select WEAK_ORDERING
+	select WEAK_REORDERING_BEYOND_LLSC
+	select CPU_SUPPORTS_HIGHMEM
+	help
+	  The Cavium Octeon processor is a highly integrated chip containing
+	  many ethernet hardware widgets for networking tasks. The processor
+	  can have up to 16 Mips64v2 cores and 8 integrated gigabit ethernets.
+	  Full details can be found at http://www.caviumnetworks.com.
+
 endchoice
 
 config SYS_HAS_CPU_LOONGSON2
@@ -1285,7 +1346,7 @@ config CPU_MIPSR1
 
 config CPU_MIPSR2
 	bool
-	default y if CPU_MIPS32_R2 || CPU_MIPS64_R2
+	default y if CPU_MIPS32_R2 || CPU_MIPS64_R2 || CPU_CAVIUM_OCTEON
 
 config SYS_SUPPORTS_32BIT_KERNEL
 	bool
-- 
1.5.6.5
