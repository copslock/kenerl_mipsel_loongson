Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 30 Nov 2007 20:33:12 +0000 (GMT)
Received: from elvis.franken.de ([193.175.24.41]:6547 "EHLO elvis.franken.de")
	by ftp.linux-mips.org with ESMTP id S28579317AbXK3UdD (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Fri, 30 Nov 2007 20:33:03 +0000
Received: from uucp (helo=solo.franken.de)
	by elvis.franken.de with local-bsmtp (Exim 3.36 #1)
	id 1IyCXm-00034l-00; Fri, 30 Nov 2007 21:33:02 +0100
Received: by solo.franken.de (Postfix, from userid 1000)
	id 18ED1C2EAB; Fri, 30 Nov 2007 21:32:59 +0100 (CET)
From:	Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Subject: [RFC] change how IP22/IP28 drivers are selected by Kconfig
To:	linux-mips@linux-mips.org
cc:	ralf@linux-mips.org
Message-Id: <20071130203259.18ED1C2EAB@solo.franken.de>
Date:	Fri, 30 Nov 2007 21:32:59 +0100 (CET)
Return-Path: <tsbogend@alpha.franken.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 17650
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: tsbogend@alpha.franken.de
Precedence: bulk
X-list: linux-mips

Below is patch, which tries to get SGI_IP22 out of the driver Kconfigs
and use special config tags, which could be used by more targets. With
this change I could easily add support for IP26 (IP20 might use some
of that work as well) without sending Kconfig changes to the individual
subsystem maintainers. If there are no objections, I'm going to split
the patch and sent it to the maintainers for inclusion into 2.6.25.
Patch fits on top of my latest IP28 patch.

Thomas.

---

 arch/mips/Kconfig        |   61 +++++++++++++++++++++++++++++++++++++++++++--
 drivers/char/Kconfig     |    2 +-
 drivers/net/Kconfig      |    2 +-
 drivers/scsi/Kconfig     |    2 +-
 drivers/serial/Kconfig   |    8 ++++--
 drivers/watchdog/Kconfig |    2 +-
 fs/partitions/Kconfig    |    2 +-
 7 files changed, 68 insertions(+), 11 deletions(-)

diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index 455bd1f..5870b60 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -122,6 +122,7 @@ config MACH_JAZZ
 	select ARCH_MAY_HAVE_PC_FDC
 	select CEVT_R4K
 	select CSRC_R4K
+	select DEFAULT_SGI_PARTITION if CPU_BIG_ENDIAN
 	select GENERIC_ISA_DMA
 	select IRQ_CPU
 	select I8253
@@ -398,6 +399,7 @@ config SGI_IP22
 	select BOOT_ELF32
 	select CEVT_R4K
 	select CSRC_R4K
+	select DEFAULT_SGI_PARTITION
 	select DMA_NONCOHERENT
 	select HW_HAS_EISA
 	select I8253
@@ -405,6 +407,11 @@ config SGI_IP22
 	select IP22_CPU_SCACHE
 	select IRQ_CPU
 	select GENERIC_ISA_DMA_SUPPORT_BROKEN
+	select SGI_HAS_DS1286
+	select SGI_HAS_INDYDOG
+	select SGI_HAS_SEEQ
+	select SGI_HAS_WD93
+	select SGI_HAS_ZILOG
 	select SWAP_IO_SPACE
 	select SYS_HAS_CPU_R4X00
 	select SYS_HAS_CPU_R5000
@@ -422,6 +429,7 @@ config SGI_IP27
 	select ARC
 	select ARC64
 	select BOOT_ELF64
+	select DEFAULT_SGI_PARTITION
 	select DMA_IP27
 	select SYS_HAS_EARLY_PRINTK
 	select HW_HAS_PCI
@@ -438,6 +446,34 @@ config SGI_IP27
 	  workstations.  To compile a Linux kernel that runs on these, say Y
 	  here.
 
+config SGI_IP28
+	bool "SGI IP28 (Indigo2 R10k) (EXPERIMENTAL)"
+	depends on EXPERIMENTAL
+	select ARC
+	select ARC64
+	select BOOT_ELF64
+	select CEVT_R4K
+	select CSRC_R4K
+	select DEFAULT_SGI_PARTITION
+	select DMA_NONCOHERENT
+	select IRQ_CPU
+	select HW_HAS_EISA
+	select I8253
+	select I8259
+	select SGI_HAS_DS1286
+	select SGI_HAS_INDYDOG
+	select SGI_HAS_SEEQ
+	select SGI_HAS_WD93
+	select SGI_HAS_ZILOG
+	select SWAP_IO_SPACE
+	select SYS_HAS_CPU_R10000
+	select SYS_HAS_EARLY_PRINTK
+	select SYS_SUPPORTS_64BIT_KERNEL
+	select SYS_SUPPORTS_BIG_ENDIAN
+      help
+        This is the SGI Indigo2 with R10000 processor.  To compile a Linux
+        kernel that runs on these, say Y here.
+
 config SGI_IP32
 	bool "SGI IP32 (O2)"
 	select ARC
@@ -577,6 +613,7 @@ config SNI_RM
 	select BOOT_ELF32
 	select CEVT_R4K
 	select CSRC_R4K
+	select DEFAULT_SGI_PARTITION if CPU_BIG_ENDIAN
 	select DMA_NONCOHERENT
 	select GENERIC_ISA_DMA
 	select HW_HAS_EISA
@@ -950,6 +987,24 @@ config EMMA2RH
 config SERIAL_RM9000
 	bool
 
+config SGI_HAS_DS1286
+	bool
+
+config SGI_HAS_INDYDOG
+	bool
+
+config SGI_HAS_SEEQ
+	bool
+
+config SGI_HAS_WD93
+	bool
+
+config SGI_HAS_ZILOG
+	bool
+
+config DEFAULT_SGI_PARTITION
+	bool
+
 config ARC32
 	bool
 
@@ -959,7 +1014,7 @@ config BOOT_ELF32
 config MIPS_L1_CACHE_SHIFT
 	int
 	default "4" if MACH_DECSTATION
-	default "7" if SGI_IP27 || SNI_RM
+	default "7" if SGI_IP27 || SGI_IP28 || SNI_RM
 	default "4" if PMC_MSP4200_EVAL
 	default "5"
 
@@ -968,7 +1023,7 @@ config HAVE_STD_PC_SERIAL_PORT
 
 config ARC_CONSOLE
 	bool "ARC console support"
-	depends on SGI_IP22 || (SNI_RM && CPU_LITTLE_ENDIAN)
+	depends on SGI_IP22 || SGI_IP28 || (SNI_RM && CPU_LITTLE_ENDIAN)
 
 config ARC_MEMORY
 	bool
@@ -977,7 +1032,7 @@ config ARC_MEMORY
 
 config ARC_PROMLIB
 	bool
-	depends on MACH_JAZZ || SNI_RM || SGI_IP22 || SGI_IP32
+	depends on MACH_JAZZ || SNI_RM || SGI_IP22 || SGI_IP28 || SGI_IP32
 	default y
 
 config ARC64
diff --git a/drivers/char/Kconfig b/drivers/char/Kconfig
index a509b8d..06271e8 100644
--- a/drivers/char/Kconfig
+++ b/drivers/char/Kconfig
@@ -777,7 +777,7 @@ config JS_RTC
 
 config SGI_DS1286
 	tristate "SGI DS1286 RTC support"
-	depends on SGI_IP22
+	depends on SGI_HAS_DS1286
 	help
 	  If you say Y here and create a character special file /dev/rtc with
 	  major number 10 and minor number 135 using mknod ("man mknod"), you
diff --git a/drivers/net/Kconfig b/drivers/net/Kconfig
index 7a55bc1..9cbd5de 100644
--- a/drivers/net/Kconfig
+++ b/drivers/net/Kconfig
@@ -1795,7 +1795,7 @@ config DE620
 
 config SGISEEQ
 	tristate "SGI Seeq ethernet controller support"
-	depends on SGI_IP22
+	depends on SGI_HAS_SEEQ
 	help
 	  Say Y here if you have an Seeq based Ethernet network card. This is
 	  used in many Silicon Graphics machines.
diff --git a/drivers/scsi/Kconfig b/drivers/scsi/Kconfig
index a6676be..2a071b0 100644
--- a/drivers/scsi/Kconfig
+++ b/drivers/scsi/Kconfig
@@ -345,7 +345,7 @@ config ISCSI_TCP
 
 config SGIWD93_SCSI
 	tristate "SGI WD93C93 SCSI Driver"
-	depends on SGI_IP22 && SCSI
+	depends on SGI_HAS_WD93 && SCSI
   	help
 	  If you have a Western Digital WD93 SCSI controller on
 	  an SGI MIPS system, say Y.  Otherwise, say N.
diff --git a/drivers/serial/Kconfig b/drivers/serial/Kconfig
index d7e1996..5620243 100644
--- a/drivers/serial/Kconfig
+++ b/drivers/serial/Kconfig
@@ -878,16 +878,18 @@ config SERIAL_SUNHV
 
 config SERIAL_IP22_ZILOG
 	tristate "IP22 Zilog8530 serial support"
-	depends on SGI_IP22
+	depends on SGI_HAS_ZILOG
 	select SERIAL_CORE
+	default y if SGI_IP28
 	help
-	  This driver supports the Zilog8530 serial ports found on SGI IP22
+	This driver supports the Zilog8530 serial ports found on SGI IP22-IP28
 	  systems.  Say Y or M if you want to be able to these serial ports.
 
 config SERIAL_IP22_ZILOG_CONSOLE
-	bool "Console on IP22 Zilog8530 serial port"
+	bool "Console on IP22/IP28 Zilog8530 serial port"
 	depends on SERIAL_IP22_ZILOG=y
 	select SERIAL_CORE_CONSOLE
+	default y if SGI_IP28
 
 config V850E_UART
 	bool "NEC V850E on-chip UART support"
diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
index 2792bc1..1ba30cb 100644
--- a/drivers/watchdog/Kconfig
+++ b/drivers/watchdog/Kconfig
@@ -586,7 +586,7 @@ config SBC_EPX_C3_WATCHDOG
 
 config INDYDOG
 	tristate "Indy/I2 Hardware Watchdog"
-	depends on SGI_IP22
+	depends on SGI_HAS_INDYDOG
 	help
 	  Hardware driver for the Indy's/I2's watchdog. This is a
 	  watchdog timer that will reboot the machine after a 60 second
diff --git a/fs/partitions/Kconfig b/fs/partitions/Kconfig
index a99acd8..cb5f0a3 100644
--- a/fs/partitions/Kconfig
+++ b/fs/partitions/Kconfig
@@ -198,7 +198,7 @@ config LDM_DEBUG
 
 config SGI_PARTITION
 	bool "SGI partition support" if PARTITION_ADVANCED
-	default y if (SGI_IP22 || SGI_IP27 || ((MACH_JAZZ || SNI_RM) && !CPU_LITTLE_ENDIAN))
+	default y if DEFAULT_SGI_PARTITION
 	help
 	  Say Y here if you would like to be able to read the hard disk
 	  partition table format used by SGI machines.
