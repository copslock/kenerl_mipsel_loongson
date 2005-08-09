Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 09 Aug 2005 16:05:32 +0100 (BST)
Received: from mo00.iij4u.or.jp ([IPv6:::ffff:210.130.0.19]:6655 "EHLO
	mo00.iij4u.or.jp") by linux-mips.org with ESMTP id <S8225201AbVHIPFN>;
	Tue, 9 Aug 2005 16:05:13 +0100
Received: MO(mo00)id j79F92ZZ026512; Wed, 10 Aug 2005 00:09:02 +0900 (JST)
Received: MDO(mdo00) id j79F92iQ027005; Wed, 10 Aug 2005 00:09:02 +0900 (JST)
Received: from stratos (h009.p499.iij4u.or.jp [210.149.243.9])
	by mbox.iij4u.or.jp (4U-MR/mbox01) id j79F90AK007159
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NOT);
	Wed, 10 Aug 2005 00:09:01 +0900 (JST)
Date:	Wed, 10 Aug 2005 00:08:59 +0900
From:	Yoichi Yuasa <yuasa@hh.iij4u.or.jp>
To:	Ralf Baechle <ralf@linux-mips.org>
Cc:	yuasa@hh.iij4u.or.jp, linux-mips <linux-mips@linux-mips.org>
Subject: [PATCH 2.6][1/2] vr41xx: combine TB0225 with TB0229
Message-Id: <20050810000859.7458588b.yuasa@hh.iij4u.or.jp>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-Path: <yuasa@hh.iij4u.or.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 8712
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: yuasa@hh.iij4u.or.jp
Precedence: bulk
X-list: linux-mips

Hi Ralf,

This patch has combined TB0225 with TB0229 in arch/mips/vr41xx/Kconfig.
Please apply this patch.

Yoichi

Signed-off-by: Yoichi Yuasa <yuasa@hh.iij4u.or.jp>

diff -urN -X dontdiff a-orig/arch/mips/Makefile a/arch/mips/Makefile
--- a-orig/arch/mips/Makefile	2005-07-30 01:10:26.000000000 +0900
+++ a/arch/mips/Makefile	2005-08-09 23:35:48.000000000 +0900
@@ -554,14 +554,9 @@
 load-$(CONFIG_CASIO_E55)	+= 0xffffffff80004000
 
 #
-# TANBAC TB0226 Mbase (VR4131)
+# TANBAC TB0225 VR4131 Multi-chip module/TB0229 VR4131DIMM (VR4131)
 #
-load-$(CONFIG_TANBAC_TB0226)	+= 0xffffffff80000000
-
-#
-# TANBAC TB0229 VR4131DIMM (VR4131)
-#
-load-$(CONFIG_TANBAC_TB0229)	+= 0xffffffff80000000
+load-$(CONFIG_TANBAC_TB022X)	+= 0xffffffff80000000
 
 #
 # Common Philips PNX8550
diff -urN -X dontdiff a-orig/arch/mips/vr41xx/Kconfig a/arch/mips/vr41xx/Kconfig
--- a-orig/arch/mips/vr41xx/Kconfig	2005-07-16 04:16:55.000000000 +0900
+++ a/arch/mips/vr41xx/Kconfig	2005-08-09 23:58:10.000000000 +0900
@@ -38,8 +38,8 @@
 	select SYS_SUPPORTS_64BIT_KERNEL if EXPERIMENTAL
 	select SYS_SUPPORTS_LITTLE_ENDIAN
 
-config TANBAC_TB0226
-	bool "Support for TANBAC TB0226 (Mbase)"
+config TANBAC_TB022X
+	bool "Support for TANBAC TB0225 (VR4131 multichip module) and TB0229 (VR4131DIMM)"
 	depends on MACH_VR41XX
 	select DMA_NONCOHERENT
 	select HW_HAS_PCI
@@ -48,22 +48,19 @@
 	select SYS_SUPPORTS_64BIT_KERNEL if EXPERIMENTAL
 	select SYS_SUPPORTS_LITTLE_ENDIAN
 	help
-	  The TANBAC TB0226 (Mbase) is a MIPS-based platform manufactured by
-	  TANBAC.  Please refer to <http://www.tanbac.co.jp/> about Mbase.
+	  The TANBAC TB0225 (VR4131 multichip module) and TB0229 (VR4131DIMM)
+	  are MIPS-based platforms manufactured by TANBAC.
+	  Please refer to <http://www.tanbac.co.jp/> about
+	  VR4131 Multi-chip module and VR4131DIMM.
 
-config TANBAC_TB0229
-	bool "Support for TANBAC TB0229 (VR4131DIMM)"
-	depends on MACH_VR41XX
-	select DMA_NONCOHERENT
-	select HW_HAS_PCI
-	select IRQ_CPU
-	select SYS_SUPPORTS_32BIT_KERNEL
-	select SYS_SUPPORTS_64BIT_KERNEL if EXPERIMENTAL
-	select SYS_SUPPORTS_LITTLE_ENDIAN
+config TANBAC_TB0226
+	bool "Support for TANBAC TB0226 (Mbase)"
+	depends on TANBAC_TB022X
+	select PCI
+	select PCI_VR41XX
 	help
-	  The TANBAC TB0229 (VR4131DIMM) is a MIPS-based platform manufactured
-	  by TANBAC.  Please refer to <http://www.tanbac.co.jp/> about
-	  VR4131DIMM.
+	  The TANBAC TB0226 (Mbase) is a MIPS-based platform manufactured by
+	  TANBAC.  Please refer to <http://www.tanbac.co.jp/> about Mbase.
 
 config VICTOR_MPC30X
 	bool "Support for Victor MP-C303/304"
diff -urN -X dontdiff a-orig/drivers/char/Kconfig a/drivers/char/Kconfig
--- a-orig/drivers/char/Kconfig	2005-08-03 19:23:09.000000000 +0900
+++ a/drivers/char/Kconfig	2005-08-09 23:37:29.000000000 +0900
@@ -886,8 +886,14 @@
 	  module will be called sonypi.
 
 config TANBAC_TB0219
-	tristate "TANBAC TB0219 base board support"
-	depends TANBAC_TB0229
+	tristate "TANBAC TB0219 (VR4131DIMM-EK) Evaluation board support"
+	depends TANBAC_TB022X
+	select PCI
+	select PCI_VR41XX
+	help
+	  The TANBAC TB0219 (VR4131DIMM-EK) is a Evaluation board for VR4131DIMM
+	  manufactured by TANBAC.
+	  Please refer to <http://www.tanbac.co.jp/> about VR4131DIMM-EK.
 
 
 menu "Ftape, the floppy tape device driver"
