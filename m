Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 06 Oct 2006 16:55:08 +0100 (BST)
Received: from mo30.po.2iij.net ([210.128.50.53]:58637 "EHLO mo30.po.2iij.net")
	by ftp.linux-mips.org with ESMTP id S20039470AbWJFPzC (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Fri, 6 Oct 2006 16:55:02 +0100
Received: by mo.po.2iij.net (mo30) id k96Ft0Mi030615; Sat, 7 Oct 2006 00:55:00 +0900 (JST)
Received: from localhost.localdomain (34.26.30.125.dy.iij4u.or.jp [125.30.26.34])
	by mbox.po.2iij.net (mbox33) id k96FsrRb036290
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Sat, 7 Oct 2006 00:54:54 +0900 (JST)
Date:	Sat, 7 Oct 2006 00:54:52 +0900
From:	Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>
To:	Ralf Baechle <ralf@linux-mips.org>
Cc:	yoichi_yuasa@tripeaks.co.jp, linux-mips <linux-mips@linux-mips.org>
Subject: [PATCH] add "depends on BROKEN" to broken boards support
Message-Id: <20061007005452.45b50d8c.yoichi_yuasa@tripeaks.co.jp>
Organization: TriPeaks Corporation
X-Mailer: Sylpheed version 1.0.6 (GTK+ 1.2.10; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-Path: <yoichi_yuasa@tripeaks.co.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 12819
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: yoichi_yuasa@tripeaks.co.jp
Precedence: bulk
X-list: linux-mips

Hi Ralf,

This patch has added "depends on BROKEN" to broken boards support.
These boards cannot build now.

Yoichi

Signed-off-by: Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>

diff -pruN -X mips/Documentation/dontdiff mips-orig/arch/mips/Kconfig mips/arch/mips/Kconfig
--- mips-orig/arch/mips/Kconfig	2006-10-05 22:29:18.893785250 +0900
+++ mips/arch/mips/Kconfig	2006-10-05 22:30:34.042481750 +0900
@@ -121,6 +121,7 @@ config MIPS_MIRAGE
 
 config BASLER_EXCITE
 	bool "Basler eXcite smart camera support"
+	depends on BROKEN
 	select DMA_COHERENT
 	select HW_HAS_PCI
 	select IRQ_CPU
@@ -188,7 +189,7 @@ config MACH_DECSTATION
 
 config MIPS_EV64120
 	bool "Galileo EV64120 Evaluation board (EXPERIMENTAL)"
-	depends on EXPERIMENTAL
+	depends on BROKEN
 	select DMA_NONCOHERENT
 	select HW_HAS_PCI
 	select MIPS_GT64120
@@ -343,6 +344,7 @@ config MIPS_SIM
 
 config MOMENCO_JAGUAR_ATX
 	bool "Momentum Jaguar board"
+	depends on BROKEN
 	select BOOT_ELF32
 	select DMA_NONCOHERENT
 	select HW_HAS_PCI
@@ -363,6 +365,7 @@ config MOMENCO_JAGUAR_ATX
 
 config MOMENCO_OCELOT
 	bool "Momentum Ocelot board"
+	depends on BROKEN
 	select DMA_NONCOHERENT
 	select HW_HAS_PCI
 	select IRQ_CPU
@@ -380,6 +383,7 @@ config MOMENCO_OCELOT
 
 config MOMENCO_OCELOT_3
 	bool "Momentum Ocelot-3 board"
+	depends on BROKEN
 	select BOOT_ELF32
 	select DMA_NONCOHERENT
 	select HW_HAS_PCI
@@ -399,6 +403,7 @@ config MOMENCO_OCELOT_3
 
 config MOMENCO_OCELOT_C
 	bool "Momentum Ocelot-C board"
+	depends on BROKEN
 	select DMA_NONCOHERENT
 	select HW_HAS_PCI
 	select IRQ_CPU
@@ -416,6 +421,7 @@ config MOMENCO_OCELOT_C
 
 config MOMENCO_OCELOT_G
 	bool "Momentum Ocelot-G board"
+	depends on BROKEN
 	select DMA_NONCOHERENT
 	select HW_HAS_PCI
 	select IRQ_CPU
@@ -511,6 +517,7 @@ config QEMU
 
 config MARKEINS
 	bool "Support for NEC EMMA2RH Mark-eins"
+	depends on BROKEN
 	select DMA_NONCOHERENT
 	select HW_HAS_PCI
 	select IRQ_CPU
@@ -717,6 +724,7 @@ config SNI_RM200_PCI
 
 config TOSHIBA_JMR3927
 	bool "Toshiba JMR-TX3927 board"
+	depends on BROKEN
 	select DMA_NONCOHERENT
 	select HW_HAS_PCI
 	select MIPS_TX3927
@@ -728,6 +736,7 @@ config TOSHIBA_JMR3927
 
 config TOSHIBA_RBTX4927
 	bool "Toshiba TBTX49[23]7 board"
+	depends on BROKEN
 	select DMA_NONCOHERENT
 	select HAS_TXX9_SERIAL
 	select HW_HAS_PCI
@@ -745,6 +754,7 @@ config TOSHIBA_RBTX4927
 
 config TOSHIBA_RBTX4938
 	bool "Toshiba RBTX4938 board"
+	depends on BROKEN
 	select HAVE_STD_PC_SERIAL_PORT
 	select DMA_NONCOHERENT
 	select GENERIC_ISA_DMA
