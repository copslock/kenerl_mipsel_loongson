Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 29 Jul 2008 14:09:45 +0100 (BST)
Received: from mba.ocn.ne.jp ([122.1.235.107]:40140 "HELO smtp.mba.ocn.ne.jp")
	by ftp.linux-mips.org with SMTP id S20026194AbYG2NJk (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 29 Jul 2008 14:09:40 +0100
Received: from localhost (p7108-ipad203funabasi.chiba.ocn.ne.jp [222.146.86.108])
	by smtp.mba.ocn.ne.jp (Postfix) with ESMTP
	id 6F129A9FC; Tue, 29 Jul 2008 22:09:35 +0900 (JST)
Date:	Tue, 29 Jul 2008 22:11:33 +0900 (JST)
Message-Id: <20080729.221133.44100292.anemo@mba.ocn.ne.jp>
To:	linux-mips@linux-mips.org
Cc:	ralf@linux-mips.org
Subject: [PATCH 3/3] txx9: Kconfig cleanup
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
X-Fingerprint: 6ACA 1623 39BD 9A94 9B1A  B746 CA77 FE94 2874 D52F
X-Pgp-Public-Key: http://wwwkeys.pgp.net/pks/lookup?op=get&search=0x2874D52F
X-Mailer: Mew version 5.2 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-Path: <anemo@mba.ocn.ne.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 20016
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

Unify some entries in txx9/Kconfig.

Signed-off-by: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
---
This patch can be applied on top of my txx9 patch series and mips-kgdb patches.

 arch/mips/txx9/Kconfig |   60 ++++++++++++++++++++---------------------------
 1 files changed, 26 insertions(+), 34 deletions(-)

diff --git a/arch/mips/txx9/Kconfig b/arch/mips/txx9/Kconfig
index caec917..840fe75 100644
--- a/arch/mips/txx9/Kconfig
+++ b/arch/mips/txx9/Kconfig
@@ -1,3 +1,27 @@
+config MACH_TX39XX
+	bool
+	select MACH_TXX9
+	select SYS_HAS_CPU_TX39XX
+
+config MACH_TX49XX
+	bool
+	select MACH_TXX9
+	select CEVT_R4K
+	select CSRC_R4K
+	select IRQ_CPU
+	select SYS_HAS_CPU_TX49XX
+	select SYS_SUPPORTS_64BIT_KERNEL
+
+config MACH_TXX9
+	bool
+	select DMA_NONCOHERENT
+	select SWAP_IO_SPACE
+	select SYS_HAS_EARLY_PRINTK
+	select SYS_SUPPORTS_32BIT_KERNEL
+	select SYS_SUPPORTS_LITTLE_ENDIAN
+	select SYS_SUPPORTS_BIG_ENDIAN
+	select GENERIC_HARDIRQS_NO__DO_IRQ
+
 config TOSHIBA_JMR3927
 	bool "Toshiba JMR-TX3927 board"
 	depends on MACH_TX39XX
@@ -24,69 +48,37 @@ config TOSHIBA_RBTX4938
 config SOC_TX3927
 	bool
 	select CEVT_TXX9
-	select DMA_NONCOHERENT
 	select HAS_TXX9_SERIAL
 	select HW_HAS_PCI
 	select IRQ_TXX9
-	select SWAP_IO_SPACE
-	select SYS_HAS_CPU_TX39XX
-	select SYS_HAS_EARLY_PRINTK
-	select SYS_SUPPORTS_32BIT_KERNEL
-	select SYS_SUPPORTS_LITTLE_ENDIAN
-	select SYS_SUPPORTS_BIG_ENDIAN
-	select GENERIC_HARDIRQS_NO__DO_IRQ
 	select GPIO_TXX9
 
 config SOC_TX4927
 	bool
-	select CEVT_R4K
-	select CSRC_R4K
 	select CEVT_TXX9
-	select DMA_NONCOHERENT
 	select HAS_TXX9_SERIAL
 	select HW_HAS_PCI
-	select IRQ_CPU
 	select IRQ_TXX9
 	select PCI_TX4927
-	select SWAP_IO_SPACE
-	select SYS_HAS_CPU_TX49XX
-	select SYS_HAS_EARLY_PRINTK
-	select SYS_SUPPORTS_32BIT_KERNEL
-	select SYS_SUPPORTS_64BIT_KERNEL
-	select SYS_SUPPORTS_LITTLE_ENDIAN
-	select SYS_SUPPORTS_BIG_ENDIAN
-	select GENERIC_HARDIRQS_NO__DO_IRQ
 	select GPIO_TXX9
 
 config SOC_TX4938
 	bool
-	select CEVT_R4K
-	select CSRC_R4K
 	select CEVT_TXX9
-	select DMA_NONCOHERENT
 	select HAS_TXX9_SERIAL
 	select HW_HAS_PCI
-	select IRQ_CPU
 	select IRQ_TXX9
 	select PCI_TX4927
-	select SWAP_IO_SPACE
-	select SYS_HAS_CPU_TX49XX
-	select SYS_HAS_EARLY_PRINTK
-	select SYS_SUPPORTS_32BIT_KERNEL
-	select SYS_SUPPORTS_64BIT_KERNEL
-	select SYS_SUPPORTS_LITTLE_ENDIAN
-	select SYS_SUPPORTS_BIG_ENDIAN
-	select GENERIC_HARDIRQS_NO__DO_IRQ
 	select GPIO_TXX9
 
 config TOSHIBA_FPCIB0
 	bool "FPCIB0 Backplane Support"
-	depends on PCI && (MACH_TX39XX || MACH_TX49XX)
+	depends on PCI && MACH_TXX9
 	select I8259
 
 config PICMG_PCI_BACKPLANE_DEFAULT
 	bool "Support for PICMG PCI Backplane"
-	depends on PCI && (MACH_TX39XX || MACH_TX49XX)
+	depends on PCI && MACH_TXX9
 	default y if !TOSHIBA_FPCIB0
 
 if TOSHIBA_RBTX4938
-- 
1.5.5.5
