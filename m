Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 24 Oct 2008 02:01:48 +0100 (BST)
Received: from mail3.caviumnetworks.com ([12.108.191.235]:38246 "EHLO
	mail3.caviumnetworks.com") by ftp.linux-mips.org with ESMTP
	id S22251739AbYJXA57 (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 24 Oct 2008 01:57:59 +0100
Received: from exch4.caveonetworks.com (Not Verified[192.168.16.23]) by mail3.caviumnetworks.com with MailMarshal (v6,2,2,3503)
	id <B49011d660003>; Thu, 23 Oct 2008 20:57:10 -0400
Received: from exch4.caveonetworks.com ([192.168.16.23]) by exch4.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Thu, 23 Oct 2008 17:57:09 -0700
Received: from dd1.caveonetworks.com ([64.169.86.201]) by exch4.caveonetworks.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
	 Thu, 23 Oct 2008 17:57:08 -0700
Received: from dd1.caveonetworks.com (localhost.localdomain [127.0.0.1])
	by dd1.caveonetworks.com (8.14.2/8.14.2) with ESMTP id m9O0v4vi005609;
	Thu, 23 Oct 2008 17:57:04 -0700
Received: (from ddaney@localhost)
	by dd1.caveonetworks.com (8.14.2/8.14.2/Submit) id m9O0v3eV005608;
	Thu, 23 Oct 2008 17:57:03 -0700
From:	ddaney@caviumnetworks.com
To:	linux-mips@linux-mips.org
Cc:	David Daney <ddaney@caviumnetworks.com>,
	Tomaso Paoletti <tpaoletti@caviumnetworks.com>
Subject: [PATCH 12/37] Add Cavium OCTEON to arch/mips/Kconfig
Date:	Thu, 23 Oct 2008 17:56:36 -0700
Message-Id: <1224809821-5532-13-git-send-email-ddaney@caviumnetworks.com>
X-Mailer: git-send-email 1.5.5.1
In-Reply-To: <1224809821-5532-1-git-send-email-ddaney@caviumnetworks.com>
References: <1224809821-5532-1-git-send-email-ddaney@caviumnetworks.com>
X-OriginalArrivalTime: 24 Oct 2008 00:57:08.0673 (UTC) FILETIME=[70CC7B10:01C93573]
Return-Path: <David.Daney@caviumnetworks.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 20892
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@caviumnetworks.com
Precedence: bulk
X-list: linux-mips

From: David Daney <ddaney@caviumnetworks.com>

Signed-off-by: Tomaso Paoletti <tpaoletti@caviumnetworks.com>
Signed-off-by: David Daney <ddaney@caviumnetworks.com>
---
 arch/mips/Kconfig |   70 +++++++++++++++++++++++++++++++++++++++++++++++++++-
 1 files changed, 68 insertions(+), 2 deletions(-)

diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index 5f832ee..70b16ad 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -597,6 +597,50 @@ config WR_PPMC
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
+	select ISA
+	select GENERIC_ISA_DMA
+	select ARCH_MAY_HAVE_PC_FDC
+	help
+	  This option supports all of the Octeon reference boards from Cavium
+	  Networks. It builds a kernel that dynamically determines the Octeon
+	  CPU type and supports all known board reference implementations.
+	  Some of the supported boards are:
+		EBT3000
+		EBH3000
+		EBH3100
+		Asus NA-038
+		Thunder
+		Kodama
+		Hikari
+	  Say Y here for most Octeon reference boards.
+
 endchoice
 
 source "arch/mips/alchemy/Kconfig"
@@ -608,6 +652,7 @@ source "arch/mips/sgi-ip27/Kconfig"
 source "arch/mips/sibyte/Kconfig"
 source "arch/mips/txx9/Kconfig"
 source "arch/mips/vr41xx/Kconfig"
+source "arch/mips/cavium-octeon/Kconfig"
 
 endmenu
 
@@ -840,6 +885,9 @@ config IRQ_GT641XX
 config IRQ_GIC
 	bool
 
+config IRQ_CPU_OCTEON
+	bool
+
 config MIPS_BOARDS_GEN
 	bool
 
@@ -914,7 +962,7 @@ config BOOT_ELF32
 config MIPS_L1_CACHE_SHIFT
 	int
 	default "4" if MACH_DECSTATION || MIKROTIK_RB532
-	default "7" if SGI_IP22 || SGI_IP27 || SGI_IP28 || SNI_RM
+	default "7" if SGI_IP22 || SGI_IP27 || SGI_IP28 || SNI_RM || CPU_CAVIUM_OCTEON
 	default "4" if PMC_MSP4200_EVAL
 	default "5"
 
@@ -1165,6 +1213,24 @@ config CPU_SB1
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
+	select MIPS_DISABLE_BOOT_CPU_ZERO
+	help
+	  The Cavium Octeon processor is a highly integrated chip containing
+	  many ethernet hardware widgets for networking tasks. The processor
+	  can have up to 16 Mips64v2 cores and 8 integrated gigabit ethernets.
+	  Full details can be found at http://www.caviumnetworks.com.
+
 endchoice
 
 config SYS_HAS_CPU_LOONGSON2
@@ -1262,7 +1328,7 @@ config CPU_MIPSR1
 
 config CPU_MIPSR2
 	bool
-	default y if CPU_MIPS32_R2 || CPU_MIPS64_R2
+	default y if CPU_MIPS32_R2 || CPU_MIPS64_R2 || CPU_CAVIUM_OCTEON
 
 config SYS_SUPPORTS_32BIT_KERNEL
 	bool
-- 
1.5.5.1
