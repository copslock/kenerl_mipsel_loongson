Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 26 Apr 2007 11:57:13 +0100 (BST)
Received: from mo32.po.2iij.NET ([210.128.50.17]:14896 "EHLO mo32.po.2iij.net")
	by ftp.linux-mips.org with ESMTP id S20023372AbXDZK5K (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Thu, 26 Apr 2007 11:57:10 +0100
Received: by mo.po.2iij.net (mo32) id l3QAtrfi051556; Thu, 26 Apr 2007 19:55:53 +0900 (JST)
Received: from localhost.localdomain (65.126.232.202.bf.2iij.net [202.232.126.65])
	by mbox.po.2iij.net (mbox31) id l3QAtpai091830
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Thu, 26 Apr 2007 19:55:52 +0900 (JST)
Message-Id: <200704261055.l3QAtpai091830@mbox31.po.2iij.net>
Date:	Thu, 26 Apr 2007 19:53:59 +0900
From:	Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>
To:	ralf@linux-mips.org
Cc:	yoichi_yuasa@tripeaks.co.jp, linux-mips@linux-mips.org
Subject: [PATCH][MIPS] update vr41xx Kconfig
Organization: TriPeaks Corporation
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-Path: <yoichi_yuasa@tripeaks.co.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 14913
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: yoichi_yuasa@tripeaks.co.jp
Precedence: bulk
X-list: linux-mips

Hi Ralf,

This patch has updated vr41xx/Kconfig.

Yoichi

Signed-off-by: Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>

diff -pruN -X vr41xx/Documentation/dontdiff vr41xx-orig/arch/mips/vr41xx/Kconfig vr41xx/arch/mips/vr41xx/Kconfig
--- vr41xx-orig/arch/mips/vr41xx/Kconfig	2007-04-26 19:00:56.387445000 +0900
+++ vr41xx/arch/mips/vr41xx/Kconfig	2007-04-26 19:28:56.296432750 +0900
@@ -1,6 +1,10 @@
-config CASIO_E55
-	bool "Support for CASIO CASSIOPEIA E-10/15/55/65"
+choice
+	prompt "Machine type"
 	depends on MACH_VR41XX
+	default TANBAC_TB022X
+
+config CASIO_E55
+	bool "CASIO CASSIOPEIA E-10/15/55/65"
 	select DMA_NONCOHERENT
 	select IRQ_CPU
 	select ISA
@@ -8,8 +12,7 @@ config CASIO_E55
 	select SYS_SUPPORTS_LITTLE_ENDIAN
 
 config IBM_WORKPAD
-	bool "Support for IBM WorkPad z50"
-	depends on MACH_VR41XX
+	bool "IBM WorkPad z50"
 	select DMA_NONCOHERENT
 	select IRQ_CPU
 	select ISA
@@ -17,26 +20,18 @@ config IBM_WORKPAD
 	select SYS_SUPPORTS_LITTLE_ENDIAN
 
 config NEC_CMBVR4133
-	bool "Support for NEC CMB-VR4133"
-	depends on MACH_VR41XX
+	bool "NEC CMB-VR4133"
 	select DMA_NONCOHERENT
 	select IRQ_CPU
 	select HW_HAS_PCI
 	select SYS_SUPPORTS_32BIT_KERNEL
 	select SYS_SUPPORTS_LITTLE_ENDIAN
 
-config ROCKHOPPER
-	bool "Support for Rockhopper baseboard"
-	depends on NEC_CMBVR4133
-	select I8259
-	select HAVE_STD_PC_SERIAL_PORT
-
 config TANBAC_TB022X
-	bool "Support for TANBAC VR4131 multichip module and TANBAC VR4131DIMM"
-	depends on MACH_VR41XX
+	bool "TANBAC VR4131 multichip module and TANBAC VR4131DIMM"
 	select DMA_NONCOHERENT
-	select HW_HAS_PCI
 	select IRQ_CPU
+	select HW_HAS_PCI
 	select SYS_SUPPORTS_32BIT_KERNEL
 	select SYS_SUPPORTS_LITTLE_ENDIAN
 	help
@@ -46,40 +41,65 @@ config TANBAC_TB022X
 	  Please refer to <http://www.tanbac.co.jp/>
 	  about VR4131 multichip module and VR4131DIMM.
 
-config TANBAC_TB0226
-	bool "Support for TANBAC Mbase(TB0226)"
+config VICTOR_MPC30X
+	bool "Victor MP-C303/304"
+	select DMA_NONCOHERENT
+	select IRQ_CPU
+	select HW_HAS_PCI
+	select PCI_VR41XX
+	select SYS_SUPPORTS_32BIT_KERNEL
+	select SYS_SUPPORTS_LITTLE_ENDIAN
+
+config ZAO_CAPCELLA
+	bool "ZAO Networks Capcella"
+	select DMA_NONCOHERENT
+	select IRQ_CPU
+	select HW_HAS_PCI
+	select PCI_VR41XX
+	select SYS_SUPPORTS_32BIT_KERNEL
+	select SYS_SUPPORTS_LITTLE_ENDIAN
+
+endchoice
+
+config ROCKHOPPER
+	bool "Support for Rockhopper base board"
+	depends on NEC_CMBVR4133
+	select PCI_VR41XX
+	select I8259
+	select HAVE_STD_PC_SERIAL_PORT
+
+choice
+	prompt "Base board type"
 	depends on TANBAC_TB022X
+	default TANBAC_TB0287
+
+config TANBAC_TB0219
+	bool "TANBAC DIMM Evaluation Kit(TB0219)"
 	select GPIO_VR41XX
+	select PCI_VR41XX
+	help
+	  The TANBAC DIMM Evaluation Kit(TB0219) is a MIPS-based platform
+	  manufactured by TANBAC.
+	  Please refer to <http://www.tanbac.co.jp/> about DIMM Evaluation Kit.
+	
+config TANBAC_TB0226
+	bool "TANBAC Mbase(TB0226)"
+	select GPIO_VR41XX
+	select PCI_VR41XX
 	help
 	  The TANBAC Mbase(TB0226) is a MIPS-based platform
 	  manufactured by TANBAC.
 	  Please refer to <http://www.tanbac.co.jp/> about Mbase.
 
 config TANBAC_TB0287
-	bool "Support for TANBAC Mini-ITX DIMM base(TB0287)"
-	depends on TANBAC_TB022X
+	bool "TANBAC Mini-ITX DIMM base(TB0287)"
+	select PCI_VR41XX
 	help
 	  The TANBAC Mini-ITX DIMM base(TB0287) is a MIPS-based platform
 	  manufactured by TANBAC.
 	  Please refer to <http://www.tanbac.co.jp/> about Mini-ITX DIMM base.
 
-config VICTOR_MPC30X
-	bool "Support for Victor MP-C303/304"
-	depends on MACH_VR41XX
-	select DMA_NONCOHERENT
-	select HW_HAS_PCI
-	select IRQ_CPU
-	select SYS_SUPPORTS_32BIT_KERNEL
-	select SYS_SUPPORTS_LITTLE_ENDIAN
-
-config ZAO_CAPCELLA
-	bool "Support for ZAO Networks Capcella"
-	depends on MACH_VR41XX
-	select DMA_NONCOHERENT
-	select HW_HAS_PCI
-	select IRQ_CPU
-	select SYS_SUPPORTS_32BIT_KERNEL
-	select SYS_SUPPORTS_LITTLE_ENDIAN
+endchoice
 
 config PCI_VR41XX
 	bool "Add PCI control unit support of NEC VR4100 series"
