Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 11 May 2007 12:44:38 +0100 (BST)
Received: from mo31.po.2iij.NET ([210.128.50.54]:14651 "EHLO mo31.po.2iij.net")
	by ftp.linux-mips.org with ESMTP id S20022578AbXEKLoe (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Fri, 11 May 2007 12:44:34 +0100
Received: by mo.po.2iij.net (mo31) id l4BBiWCZ054972; Fri, 11 May 2007 20:44:32 +0900 (JST)
Received: from localhost.localdomain (65.126.232.202.bf.2iij.net [202.232.126.65])
	by mbox.po.2iij.net (mbox33) id l4BBiUZV027211
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Fri, 11 May 2007 20:44:31 +0900 (JST)
Date:	Fri, 11 May 2007 20:44:30 +0900
From:	Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>
To:	Ralf Baechle <ralf@linux-mips.org>
Cc:	yoichi_yuasa@tripeaks.co.jp, linux-mips <linux-mips@linux-mips.org>
Subject: [PATCH][MIPS] separate Alchemy processor based boards config
Message-Id: <20070511204430.2c23a537.yoichi_yuasa@tripeaks.co.jp>
Organization: TriPeaks Corporation
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-Path: <yoichi_yuasa@tripeaks.co.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 15034
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: yoichi_yuasa@tripeaks.co.jp
Precedence: bulk
X-list: linux-mips

Hi Ralf,

This patch has separated Alchemy processor based boards config to arch/mips/au1000/Kconfig.

Yoichi

Signed-off-by: Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>

diff -pruN -X mips/Documentation/dontdiff mips-orig/arch/mips/Kconfig mips/arch/mips/Kconfig
--- mips-orig/arch/mips/Kconfig	2007-05-11 10:25:49.171990500 +0900
+++ mips/arch/mips/Kconfig	2007-05-11 10:30:18.756838500 +0900
@@ -15,121 +15,8 @@ choice
 	prompt "System type"
 	default SGI_IP22
 
-config MIPS_MTX1
-	bool "4G Systems MTX-1 board"
-	select DMA_NONCOHERENT
-	select HW_HAS_PCI
-	select RESOURCES_64BIT if PCI
-	select SOC_AU1500
-	select SYS_HAS_CPU_MIPS32_R1
-	select SYS_SUPPORTS_LITTLE_ENDIAN
-
-config MIPS_BOSPORUS
-	bool "AMD Alchemy Bosporus board"
-	select SOC_AU1500
-	select DMA_NONCOHERENT
-	select SYS_HAS_CPU_MIPS32_R1
-	select SYS_SUPPORTS_LITTLE_ENDIAN
-
-config MIPS_PB1000
-	bool "AMD Alchemy PB1000 board"
-	select SOC_AU1000
-	select DMA_NONCOHERENT
-	select HW_HAS_PCI
-	select RESOURCES_64BIT if PCI
-	select SWAP_IO_SPACE
-	select SYS_HAS_CPU_MIPS32_R1
-	select SYS_SUPPORTS_LITTLE_ENDIAN
-
-config MIPS_PB1100
-	bool "AMD Alchemy PB1100 board"
-	select SOC_AU1100
-	select DMA_NONCOHERENT
-	select HW_HAS_PCI
-	select RESOURCES_64BIT if PCI
-	select SWAP_IO_SPACE
-	select SYS_HAS_CPU_MIPS32_R1
-	select SYS_SUPPORTS_LITTLE_ENDIAN
-
-config MIPS_PB1500
-	bool "AMD Alchemy PB1500 board"
-	select SOC_AU1500
-	select DMA_NONCOHERENT
-	select HW_HAS_PCI
-	select RESOURCES_64BIT if PCI
-	select SYS_HAS_CPU_MIPS32_R1
-	select SYS_SUPPORTS_LITTLE_ENDIAN
-
-config MIPS_PB1550
-	bool "AMD Alchemy PB1550 board"
-	select SOC_AU1550
-	select DMA_NONCOHERENT
-	select HW_HAS_PCI
-	select MIPS_DISABLE_OBSOLETE_IDE
-	select RESOURCES_64BIT if PCI
-	select SYS_HAS_CPU_MIPS32_R1
-	select SYS_SUPPORTS_LITTLE_ENDIAN
-
-config MIPS_PB1200
-	bool "AMD Alchemy PB1200 board"
-	select SOC_AU1200
-	select DMA_NONCOHERENT
-	select MIPS_DISABLE_OBSOLETE_IDE
-	select RESOURCES_64BIT if PCI
-	select SYS_HAS_CPU_MIPS32_R1
-	select SYS_SUPPORTS_LITTLE_ENDIAN
-
-config MIPS_DB1000
-	bool "AMD Alchemy DB1000 board"
-	select SOC_AU1000
-	select DMA_NONCOHERENT
-	select HW_HAS_PCI
-	select RESOURCES_64BIT if PCI
-	select SYS_HAS_CPU_MIPS32_R1
-	select SYS_SUPPORTS_LITTLE_ENDIAN
-
-config MIPS_DB1100
-	bool "AMD Alchemy DB1100 board"
-	select SOC_AU1100
-	select DMA_NONCOHERENT
-	select SYS_HAS_CPU_MIPS32_R1
-	select SYS_SUPPORTS_LITTLE_ENDIAN
-
-config MIPS_DB1500
-	bool "AMD Alchemy DB1500 board"
-	select SOC_AU1500
-	select DMA_NONCOHERENT
-	select HW_HAS_PCI
-	select MIPS_DISABLE_OBSOLETE_IDE
-	select RESOURCES_64BIT if PCI
-	select SYS_HAS_CPU_MIPS32_R1
-	select SYS_SUPPORTS_BIG_ENDIAN
-	select SYS_SUPPORTS_LITTLE_ENDIAN
-
-config MIPS_DB1550
-	bool "AMD Alchemy DB1550 board"
-	select SOC_AU1550
-	select HW_HAS_PCI
-	select DMA_NONCOHERENT
-	select MIPS_DISABLE_OBSOLETE_IDE
-	select RESOURCES_64BIT if PCI
-	select SYS_HAS_CPU_MIPS32_R1
-	select SYS_SUPPORTS_LITTLE_ENDIAN
-
-config MIPS_DB1200
-	bool "AMD Alchemy DB1200 board"
-	select SOC_AU1200
-	select DMA_COHERENT
-	select MIPS_DISABLE_OBSOLETE_IDE
-	select SYS_HAS_CPU_MIPS32_R1
-	select SYS_SUPPORTS_LITTLE_ENDIAN
-
-config MIPS_MIRAGE
-	bool "AMD Alchemy Mirage board"
-	select DMA_NONCOHERENT
-	select SOC_AU1500
-	select SYS_HAS_CPU_MIPS32_R1
-	select SYS_SUPPORTS_LITTLE_ENDIAN
+config MACH_ALCHEMY
+	bool "Alchemy processor based machines"
 
 config BASLER_EXCITE
 	bool "Basler eXcite smart camera"
@@ -424,12 +311,6 @@ config MOMENCO_OCELOT_C
 	  The Ocelot is a MIPS-based Single Board Computer (SBC) made by
 	  Momentum Computer <http://www.momenco.com/>.
 
-config MIPS_XXS1500
-	bool "MyCable XXS1500 board"
-	select DMA_NONCOHERENT
-	select SOC_AU1500
-	select SYS_SUPPORTS_LITTLE_ENDIAN
-
 config PNX8550_JBS
 	bool "Philips PNX8550 based JBS board"
 	select PNX8550
@@ -777,6 +658,7 @@ config TOSHIBA_RBTX4938
 
 endchoice
 
+source "arch/mips/au1000/Kconfig"
 source "arch/mips/ddb5xxx/Kconfig"
 source "arch/mips/gt64120/ev64120/Kconfig"
 source "arch/mips/jazz/Kconfig"
@@ -965,33 +847,6 @@ config MIPS_RM9122
 config PCI_MARVELL
 	bool
 
-config SOC_AU1000
-	bool
-	select SOC_AU1X00
-
-config SOC_AU1100
-	bool
-	select SOC_AU1X00
-
-config SOC_AU1500
-	bool
-	select SOC_AU1X00
-
-config SOC_AU1550
-	bool
-	select SOC_AU1X00
-
-config SOC_AU1200
-	bool
-	select SOC_AU1X00
-
-config SOC_AU1X00
-	bool
-	select SYS_HAS_CPU_MIPS32_R1
-	select SYS_SUPPORTS_32BIT_KERNEL
-	select SYS_SUPPORTS_APM_EMULATION
-	select SYS_SUPPORTS_KGDB
-
 config SERIAL_RM9000
 	bool
 
diff -pruN -X mips/Documentation/dontdiff mips-orig/arch/mips/au1000/Kconfig mips/arch/mips/au1000/Kconfig
--- mips-orig/arch/mips/au1000/Kconfig	1970-01-01 09:00:00.000000000 +0900
+++ mips/arch/mips/au1000/Kconfig	2007-05-11 10:30:18.784840250 +0900
@@ -0,0 +1,142 @@
+choice
+	prompt "Machine type"
+	depends on MACH_ALCHEMY
+	default MIPS_DB1000
+
+config MIPS_MTX1
+	bool "4G Systems MTX-1 board"
+	select DMA_NONCOHERENT
+	select HW_HAS_PCI
+	select RESOURCES_64BIT if PCI
+	select SOC_AU1500
+	select SYS_SUPPORTS_LITTLE_ENDIAN
+
+config MIPS_BOSPORUS
+	bool "Alchemy Bosporus board"
+	select SOC_AU1500
+	select DMA_NONCOHERENT
+	select SYS_SUPPORTS_LITTLE_ENDIAN
+
+config MIPS_DB1000
+	bool "Alchemy DB1000 board"
+	select SOC_AU1000
+	select DMA_NONCOHERENT
+	select HW_HAS_PCI
+	select RESOURCES_64BIT if PCI
+	select SYS_SUPPORTS_LITTLE_ENDIAN
+
+config MIPS_DB1100
+	bool "Alchemy DB1100 board"
+	select SOC_AU1100
+	select DMA_NONCOHERENT
+	select SYS_SUPPORTS_LITTLE_ENDIAN
+
+config MIPS_DB1200
+	bool "Alchemy DB1200 board"
+	select SOC_AU1200
+	select DMA_COHERENT
+	select MIPS_DISABLE_OBSOLETE_IDE
+	select SYS_SUPPORTS_LITTLE_ENDIAN
+
+config MIPS_DB1500
+	bool "Alchemy DB1500 board"
+	select SOC_AU1500
+	select DMA_NONCOHERENT
+	select HW_HAS_PCI
+	select MIPS_DISABLE_OBSOLETE_IDE
+	select RESOURCES_64BIT if PCI
+	select SYS_SUPPORTS_BIG_ENDIAN
+	select SYS_SUPPORTS_LITTLE_ENDIAN
+
+config MIPS_DB1550
+	bool "Alchemy DB1550 board"
+	select SOC_AU1550
+	select HW_HAS_PCI
+	select DMA_NONCOHERENT
+	select MIPS_DISABLE_OBSOLETE_IDE
+	select RESOURCES_64BIT if PCI
+	select SYS_SUPPORTS_LITTLE_ENDIAN
+
+config MIPS_MIRAGE
+	bool "Alchemy Mirage board"
+	select DMA_NONCOHERENT
+	select SOC_AU1500
+	select SYS_SUPPORTS_LITTLE_ENDIAN
+
+config MIPS_PB1000
+	bool "Alchemy PB1000 board"
+	select SOC_AU1000
+	select DMA_NONCOHERENT
+	select HW_HAS_PCI
+	select RESOURCES_64BIT if PCI
+	select SWAP_IO_SPACE
+	select SYS_SUPPORTS_LITTLE_ENDIAN
+
+config MIPS_PB1100
+	bool "Alchemy PB1100 board"
+	select SOC_AU1100
+	select DMA_NONCOHERENT
+	select HW_HAS_PCI
+	select RESOURCES_64BIT if PCI
+	select SWAP_IO_SPACE
+	select SYS_SUPPORTS_LITTLE_ENDIAN
+
+config MIPS_PB1200
+	bool "Alchemy PB1200 board"
+	select SOC_AU1200
+	select DMA_NONCOHERENT
+	select MIPS_DISABLE_OBSOLETE_IDE
+	select RESOURCES_64BIT if PCI
+	select SYS_SUPPORTS_LITTLE_ENDIAN
+
+config MIPS_PB1500
+	bool "Alchemy PB1500 board"
+	select SOC_AU1500
+	select DMA_NONCOHERENT
+	select HW_HAS_PCI
+	select RESOURCES_64BIT if PCI
+	select SYS_SUPPORTS_LITTLE_ENDIAN
+
+config MIPS_PB1550
+	bool "Alchemy PB1550 board"
+	select SOC_AU1550
+	select DMA_NONCOHERENT
+	select HW_HAS_PCI
+	select MIPS_DISABLE_OBSOLETE_IDE
+	select RESOURCES_64BIT if PCI
+	select SYS_SUPPORTS_LITTLE_ENDIAN
+
+config MIPS_XXS1500
+	bool "MyCable XXS1500 board"
+	select DMA_NONCOHERENT
+	select SOC_AU1500
+	select SYS_SUPPORTS_LITTLE_ENDIAN
+
+endchoice
+
+config SOC_AU1000
+	bool
+	select SOC_AU1X00
+
+config SOC_AU1100
+	bool
+	select SOC_AU1X00
+
+config SOC_AU1500
+	bool
+	select SOC_AU1X00
+
+config SOC_AU1550
+	bool
+	select SOC_AU1X00
+
+config SOC_AU1200
+	bool
+	select SOC_AU1X00
+
+config SOC_AU1X00
+	bool
+	select SYS_HAS_CPU_MIPS32_R1
+	select SYS_SUPPORTS_32BIT_KERNEL
+	select SYS_SUPPORTS_APM_EMULATION
+	select SYS_SUPPORTS_KGDB
diff -pruN -X mips/Documentation/dontdiff mips-orig/arch/mips/configs/db1000_defconfig mips/arch/mips/configs/db1000_defconfig
--- mips-orig/arch/mips/configs/db1000_defconfig	2007-05-11 10:25:50.292060500 +0900
+++ mips/arch/mips/configs/db1000_defconfig	2007-05-11 10:31:17.380502250 +0900
@@ -9,6 +9,7 @@ CONFIG_MIPS=y
 # Machine selection
 #
 CONFIG_ZONE_DMA=y
+CONFIG_MACH_ALCHEMY=y
 # CONFIG_MIPS_MTX1 is not set
 # CONFIG_MIPS_BOSPORUS is not set
 # CONFIG_MIPS_PB1000 is not set
diff -pruN -X mips/Documentation/dontdiff mips-orig/arch/mips/configs/db1100_defconfig mips/arch/mips/configs/db1100_defconfig
--- mips-orig/arch/mips/configs/db1100_defconfig	2007-05-11 10:25:50.328062750 +0900
+++ mips/arch/mips/configs/db1100_defconfig	2007-05-11 10:31:36.193678000 +0900
@@ -9,6 +9,7 @@ CONFIG_MIPS=y
 # Machine selection
 #
 CONFIG_ZONE_DMA=y
+CONFIG_MACH_ALCHEMY=y
 # CONFIG_MIPS_MTX1 is not set
 # CONFIG_MIPS_BOSPORUS is not set
 # CONFIG_MIPS_PB1000 is not set
diff -pruN -X mips/Documentation/dontdiff mips-orig/arch/mips/configs/db1200_defconfig mips/arch/mips/configs/db1200_defconfig
--- mips-orig/arch/mips/configs/db1200_defconfig	2007-05-11 10:25:50.336063250 +0900
+++ mips/arch/mips/configs/db1200_defconfig	2007-05-11 10:31:51.778652000 +0900
@@ -9,6 +9,7 @@ CONFIG_MIPS=y
 # Machine selection
 #
 CONFIG_ZONE_DMA=y
+CONFIG_MACH_ALCHEMY=y
 # CONFIG_MIPS_MTX1 is not set
 # CONFIG_MIPS_BOSPORUS is not set
 # CONFIG_MIPS_PB1000 is not set
diff -pruN -X mips/Documentation/dontdiff mips-orig/arch/mips/configs/db1500_defconfig mips/arch/mips/configs/db1500_defconfig
--- mips-orig/arch/mips/configs/db1500_defconfig	2007-05-11 10:25:50.408067750 +0900
+++ mips/arch/mips/configs/db1500_defconfig	2007-05-11 10:32:08.383689750 +0900
@@ -9,6 +9,7 @@ CONFIG_MIPS=y
 # Machine selection
 #
 CONFIG_ZONE_DMA=y
+CONFIG_MACH_ALCHEMY=y
 # CONFIG_MIPS_MTX1 is not set
 # CONFIG_MIPS_BOSPORUS is not set
 # CONFIG_MIPS_PB1000 is not set
diff -pruN -X mips/Documentation/dontdiff mips-orig/arch/mips/configs/db1550_defconfig mips/arch/mips/configs/db1550_defconfig
--- mips-orig/arch/mips/configs/db1550_defconfig	2007-05-11 10:25:50.408067750 +0900
+++ mips/arch/mips/configs/db1550_defconfig	2007-05-11 10:32:21.552512750 +0900
@@ -9,6 +9,7 @@ CONFIG_MIPS=y
 # Machine selection
 #
 CONFIG_ZONE_DMA=y
+CONFIG_MACH_ALCHEMY=y
 # CONFIG_MIPS_MTX1 is not set
 # CONFIG_MIPS_BOSPORUS is not set
 # CONFIG_MIPS_PB1000 is not set
diff -pruN -X mips/Documentation/dontdiff mips-orig/arch/mips/configs/pb1100_defconfig mips/arch/mips/configs/pb1100_defconfig
--- mips-orig/arch/mips/configs/pb1100_defconfig	2007-05-11 10:25:50.516074500 +0900
+++ mips/arch/mips/configs/pb1100_defconfig	2007-05-11 10:32:48.718210500 +0900
@@ -9,6 +9,7 @@ CONFIG_MIPS=y
 # Machine selection
 #
 CONFIG_ZONE_DMA=y
+CONFIG_MACH_ALCHEMY=y
 # CONFIG_MIPS_MTX1 is not set
 # CONFIG_MIPS_BOSPORUS is not set
 # CONFIG_MIPS_PB1000 is not set
diff -pruN -X mips/Documentation/dontdiff mips-orig/arch/mips/configs/pb1500_defconfig mips/arch/mips/configs/pb1500_defconfig
--- mips-orig/arch/mips/configs/pb1500_defconfig	2007-05-11 10:25:50.516074500 +0900
+++ mips/arch/mips/configs/pb1500_defconfig	2007-05-11 10:33:05.211241250 +0900
@@ -9,6 +9,7 @@ CONFIG_MIPS=y
 # Machine selection
 #
 CONFIG_ZONE_DMA=y
+CONFIG_MACH_ALCHEMY=y
 # CONFIG_MIPS_MTX1 is not set
 # CONFIG_MIPS_BOSPORUS is not set
 # CONFIG_MIPS_PB1000 is not set
diff -pruN -X mips/Documentation/dontdiff mips-orig/arch/mips/configs/pb1550_defconfig mips/arch/mips/configs/pb1550_defconfig
--- mips-orig/arch/mips/configs/pb1550_defconfig	2007-05-11 10:25:50.656083250 +0900
+++ mips/arch/mips/configs/pb1550_defconfig	2007-05-11 10:33:21.948287250 +0900
@@ -9,6 +9,7 @@ CONFIG_MIPS=y
 # Machine selection
 #
 CONFIG_ZONE_DMA=y
+CONFIG_MACH_ALCHEMY=y
 # CONFIG_MIPS_MTX1 is not set
 # CONFIG_MIPS_BOSPORUS is not set
 # CONFIG_MIPS_PB1000 is not set
