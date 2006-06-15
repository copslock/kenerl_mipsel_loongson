Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 15 Jun 2006 15:29:53 +0100 (BST)
Received: from mo32.po.2iij.net ([210.128.50.17]:43317 "EHLO mo32.po.2iij.net")
	by ftp.linux-mips.org with ESMTP id S8134062AbWFOO3o (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Thu, 15 Jun 2006 15:29:44 +0100
Received: by mo.po.2iij.net (mo32) id k5FETfqH029443; Thu, 15 Jun 2006 23:29:41 +0900 (JST)
Received: from localhost.localdomain (225.29.30.125.dy.iij4u.or.jp [125.30.29.225])
	by mbox.po.2iij.net (mbox32) id k5FETcbT088509
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Thu, 15 Jun 2006 23:29:39 +0900 (JST)
Date:	Thu, 15 Jun 2006 23:29:37 +0900
From:	Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>
To:	Ralf Baechle <ralf@linux-mips.org>
Cc:	linux-mips@linux-mips.org
Subject: [PATCH] vr41xx: remove unnecessay items from vr41xx/Kconfig
Message-Id: <20060615232937.54908d91.yoichi_yuasa@tripeaks.co.jp>
Organization: TriPeaks Corporation
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-Path: <yoichi_yuasa@tripeaks.co.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 11737
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: yoichi_yuasa@tripeaks.co.jp
Precedence: bulk
X-list: linux-mips

Hi Ralf,

This patch removes unnecessary items from vr41xx/Kconfig.
SYS_HA_CPU_VR41XX has already been selected by MACH_VR41XX.

Yoichi

Signed-off-by: Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>

diff -pruN -X mips-rc6/Documentation/dontdiff mips-rc6-orig/arch/mips/vr41xx/Kconfig mips-rc6/arch/mips/vr41xx/Kconfig
--- mips-rc6-orig/arch/mips/vr41xx/Kconfig	2006-06-13 19:08:29.234587000 +0900
+++ mips-rc6/arch/mips/vr41xx/Kconfig	2006-06-14 09:48:08.362847750 +0900
@@ -4,7 +4,6 @@ config CASIO_E55
 	select DMA_NONCOHERENT
 	select IRQ_CPU
 	select ISA
-	select SYS_HAS_CPU_VR41XX
 	select SYS_SUPPORTS_32BIT_KERNEL
 	select SYS_SUPPORTS_LITTLE_ENDIAN
 
@@ -14,18 +13,15 @@ config IBM_WORKPAD
 	select DMA_NONCOHERENT
 	select IRQ_CPU
 	select ISA
-	select SYS_HAS_CPU_VR41XX
 	select SYS_SUPPORTS_32BIT_KERNEL
 	select SYS_SUPPORTS_LITTLE_ENDIAN
 
 config NEC_CMBVR4133
 	bool "Support for NEC CMB-VR4133"
 	depends on MACH_VR41XX
-	select CPU_VR41XX
 	select DMA_NONCOHERENT
 	select IRQ_CPU
 	select HW_HAS_PCI
-	select SYS_HAS_CPU_VR41XX
 	select SYS_SUPPORTS_32BIT_KERNEL
 	select SYS_SUPPORTS_LITTLE_ENDIAN
 
@@ -41,7 +37,6 @@ config TANBAC_TB022X
 	select DMA_NONCOHERENT
 	select HW_HAS_PCI
 	select IRQ_CPU
-	select SYS_HAS_CPU_VR41XX
 	select SYS_SUPPORTS_32BIT_KERNEL
 	select SYS_SUPPORTS_LITTLE_ENDIAN
 	help
@@ -74,7 +69,6 @@ config VICTOR_MPC30X
 	select DMA_NONCOHERENT
 	select HW_HAS_PCI
 	select IRQ_CPU
-	select SYS_HAS_CPU_VR41XX
 	select SYS_SUPPORTS_32BIT_KERNEL
 	select SYS_SUPPORTS_LITTLE_ENDIAN
 
@@ -84,7 +78,6 @@ config ZAO_CAPCELLA
 	select DMA_NONCOHERENT
 	select HW_HAS_PCI
 	select IRQ_CPU
-	select SYS_HAS_CPU_VR41XX
 	select SYS_SUPPORTS_32BIT_KERNEL
 	select SYS_SUPPORTS_LITTLE_ENDIAN
 
