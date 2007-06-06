Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 06 Jun 2007 07:59:03 +0100 (BST)
Received: from [222.92.8.141] ([222.92.8.141]:1674 "HELO lemote.com")
	by ftp.linux-mips.org with SMTP id S20021467AbXFFGyP (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 6 Jun 2007 07:54:15 +0100
Received: (qmail 7040 invoked by uid 511); 6 Jun 2007 07:00:18 -0000
Received: from unknown (HELO localhost.localdomain) (192.168.2.233)
  by lemote.com with SMTP; 6 Jun 2007 07:00:18 -0000
From:	tiansm@lemote.com
To:	linux-mips@linux-mips.org
Cc:	Sun Haiyong <sunhy@lemote.com>
Subject: [PATCH 03/15] Kconfig update for lemote fulong miniPC
Date:	Wed,  6 Jun 2007 14:52:40 +0800
Message-Id: <11811127733730-git-send-email-tiansm@lemote.com>
X-Mailer: git-send-email 1.5.2.1
In-Reply-To: <11811127722019-git-send-email-tiansm@lemote.com>
References: <11811127722019-git-send-email-tiansm@lemote.com>
Return-Path: <tiansm@lemote.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 15295
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: tiansm@lemote.com
Precedence: bulk
X-list: linux-mips

From: Sun Haiyong <sunhy@lemote.com>

Signed-off-by: Fuxin Zhang <zhangfx@lemote.com>
Signed-off-by: Sun Haiyong <sunhy@lemote.com>
---
 arch/mips/Kconfig |   36 ++++++++++++++++++++++++++++++++++++
 1 files changed, 36 insertions(+), 0 deletions(-)

diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index c20cd90..16f1861 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -14,6 +14,25 @@ config ZONE_DMA
 choice
 	prompt "System type"
 	default SGI_IP22
+config LEMOTE_FULONG
+	bool "Support for Lemote's fulong mini-PC"
+	select SYS_HAS_CPU_LOONGSON2
+	select DMA_NONCOHERENT
+	select BOOT_ELF32
+	select BOARD_SCACHE
+	select HW_HAS_PCI
+	select I8259
+	select ISA
+	select IRQ_CPU
+	select SYS_SUPPORTS_32BIT_KERNEL
+	select SYS_SUPPORTS_64BIT_KERNEL
+	select SYS_SUPPORTS_LITTLE_ENDIAN
+	select SYS_SUPPORTS_HIGHMEM
+	select SYS_HAS_EARLY_PRINTK
+	select GENERIC_HARDIRQS_NO__DO_IRQ
+	select CPU_HAS_WB
+	help
+         Lemote Fulong mini-PC board, which uses Chinese Loongson-2E CPU and a fpga north bridge
 
 config MACH_ALCHEMY
 	bool "Alchemy processor based machines"
@@ -933,6 +952,13 @@ choice
 	prompt "CPU type"
 	default CPU_R4X00
 
+config CPU_LOONGSON2
+	bool "LOONGSON2"
+	depends on SYS_HAS_CPU_LOONGSON2
+	select CPU_SUPPORTS_32BIT_KERNEL
+	select CPU_SUPPORTS_64BIT_KERNEL
+	select CPU_SUPPORTS_HIGHMEM
+
 config CPU_MIPS32_R1
 	bool "MIPS32 Release 1"
 	depends on SYS_HAS_CPU_MIPS32_R1
@@ -1143,6 +1169,9 @@ config CPU_SB1
 
 endchoice
 
+config SYS_HAS_CPU_LOONGSON2
+	bool
+
 config SYS_HAS_CPU_MIPS32_R1
 	bool
 
@@ -1477,6 +1506,13 @@ config CPU_HAS_SMARTMIPS
 config CPU_HAS_WB
 	bool
 
+config 64BIT_CONTEXT
+	bool "Save 64bit integer registers" if CPU_LOONGSON2 && 32BIT
+	help
+	  Loongson2 CPU is 64bit , when used in 32BIT mode, its integer registers
+	  can still be accessed as 64bit, mainly for multimedia instructions. We must have
+	  all 64bit save/restored to make sure those instructions to get correct result.
+
 #
 # Vectored interrupt mode is an R2 feature
 #
-- 
1.5.2.1
