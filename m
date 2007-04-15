Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 15 Apr 2007 16:29:12 +0100 (BST)
Received: from [222.92.8.141] ([222.92.8.141]:12761 "HELO lemote.com")
	by ftp.linux-mips.org with SMTP id S20022645AbXDOP1Z (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Sun, 15 Apr 2007 16:27:25 +0100
Received: (qmail 19437 invoked by uid 511); 15 Apr 2007 15:28:06 -0000
Received: from unknown (HELO localhost.localdomain) (192.168.2.197)
  by lemote.com with SMTP; 15 Apr 2007 15:28:06 -0000
From:	tiansm@lemote.com
To:	linux-mips@linux-mips.org
Cc:	Fuxin Zhang <zhangfx@lemote.com>
Subject: [PATCH 3/16] Kconfig update for lemote fulong mini-PC
Date:	Sun, 15 Apr 2007 23:25:52 +0800
Message-Id: <11766507662638-git-send-email-tiansm@lemote.com>
X-Mailer: git-send-email 1.4.4.1
In-Reply-To: <11766507661726-git-send-email-tiansm@lemote.com>
References: <11766507651736-git-send-email-tiansm@lemote.com> <11766507661317-git-send-email-tiansm@lemote.com> <11766507661726-git-send-email-tiansm@lemote.com>
Return-Path: <tiansm@lemote.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 14847
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: tiansm@lemote.com
Precedence: bulk
X-list: linux-mips

From: Fuxin Zhang <zhangfx@lemote.com>


Signed-off-by: Fuxin Zhang <zhangfx@lemote.com>
---
 arch/mips/Kconfig |   38 ++++++++++++++++++++++++++++++++++++++
 1 files changed, 38 insertions(+), 0 deletions(-)

diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index 338bfa3..c18a835 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -16,6 +16,27 @@ choice
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
+        Lemote Fulong mini-PC board, which uses Chinese Loongson-2E CPU and a fpga north bridge
+
+
 config MIPS_MTX1
 	bool "4G Systems MTX-1 board"
 	select DMA_NONCOHERENT
@@ -1142,6 +1163,13 @@ choice
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
@@ -1352,6 +1380,9 @@ config CPU_SB1
 
 endchoice
 
+config SYS_HAS_CPU_LOONGSON2
+	bool
+
 config SYS_HAS_CPU_MIPS32_R1
 	bool
 
@@ -1681,6 +1712,13 @@ config CPU_HAS_SMARTMIPS
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
1.4.4.1
