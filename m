Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 04 Apr 2007 15:35:45 +0100 (BST)
Received: from [222.92.8.141] ([222.92.8.141]:21735 "HELO lemote.com")
	by ftp.linux-mips.org with SMTP id S20021934AbXDDObU (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 4 Apr 2007 15:31:20 +0100
Received: (qmail 16908 invoked by uid 511); 4 Apr 2007 14:30:20 -0000
Received: from unknown (HELO heart.lemote.com) (192.168.2.206)
  by lemote.com with SMTP; 4 Apr 2007 14:30:20 -0000
Message-ID: <510138.627930672-sendEmail@heart>
From:	"zhangfx@lemote.com" <zhangfx@lemote.com>
To:	"linux-mips@linux-mips.org" <linux-mips@linux-mips.org>
Subject:  [PATCH 3/16] Kconfig update for lemote fulong mini-PC
Date:	Wed, 4 Apr 2007 14:38:18 +0000
X-Mailer: sendEmail-1.55
MIME-Version: 1.0
Content-Type: multipart/related; boundary="----MIME delimiter for sendEmail-661401.500533433"
Return-Path: <zhangfx@lemote.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 14802
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: zhangfx@lemote.com
Precedence: bulk
X-list: linux-mips

This is a multi-part message in MIME format. To properly display this message you need a MIME-Version 1.0 compliant Email program.

------MIME delimiter for sendEmail-661401.500533433
Content-Type: text/plain;
        charset="iso-8859-1"
Content-Transfer-Encoding: 7bit


Signed-off-by: Fuxin Zhang <zhangfx@lemote.com>
---
 arch/mips/Kconfig |   37 +++++++++++++++++++++++++++++++++++++
 1 files changed, 37 insertions(+), 0 deletions(-)

diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index 338bfa3..cedb0fa 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -16,6 +16,26 @@ choice
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
+	help
+        Lemote Fulong mini-PC board, which uses Chinese Loongson-2E CPU and a fpga north bridge 
+
+
 config MIPS_MTX1
 	bool "4G Systems MTX-1 board"
 	select DMA_NONCOHERENT
@@ -1142,6 +1162,13 @@ choice
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
@@ -1352,6 +1379,9 @@ config CPU_SB1
 
 endchoice
 
+config SYS_HAS_CPU_LOONGSON2
+	bool
+
 config SYS_HAS_CPU_MIPS32_R1
 	bool
 
@@ -1681,6 +1711,13 @@ config CPU_HAS_SMARTMIPS
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
1.4.4.4



------MIME delimiter for sendEmail-661401.500533433--
