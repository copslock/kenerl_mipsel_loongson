Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 10 Feb 2003 11:01:56 +0000 (GMT)
Received: from r-bu.iij4u.or.jp ([IPv6:::ffff:210.130.0.89]:28894 "EHLO
	r-bu.iij4u.or.jp") by linux-mips.org with ESMTP id <S8225196AbTBJLBy>;
	Mon, 10 Feb 2003 11:01:54 +0000
Received: from pudding.montavista.co.jp (gatekeeper.montavista.co.jp [202.232.97.130])
	by r-bu.iij4u.or.jp (8.11.6+IIJ/8.11.6) with SMTP id h1AB1jN10267;
	Mon, 10 Feb 2003 20:01:46 +0900 (JST)
Date: Mon, 10 Feb 2003 19:56:13 +0900
From: Yoichi Yuasa <yoichi_yuasa@montavista.co.jp>
To: ralf@linux-mips.org
Cc: yoichi_yuasa@montavista.co.jp, linux-mips@linux-mips.org
Subject: [patch] TANBAC TB0226(NEC VR4131) for 2.5
Message-Id: <20030210195613.53bb31be.yoichi_yuasa@montavista.co.jp>
In-Reply-To: <20030205114045.281335ca.yoichi_yuasa@montavista.co.jp>
References: <20030204154025.340fdf40.yoichi_yuasa@montavista.co.jp>
	<20030204134406.A29585@linux-mips.org>
	<20030205114045.281335ca.yoichi_yuasa@montavista.co.jp>
Organization: MontaVista Software Japan, Inc.
X-Mailer: Sylpheed version 0.8.9 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="Multipart_Mon__10_Feb_2003_19:56:13_+0900_08239930"
Return-Path: <yoichi_yuasa@montavista.co.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 1374
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: yoichi_yuasa@montavista.co.jp
Precedence: bulk
X-list: linux-mips

This is a multi-part message in MIME format.

--Multipart_Mon__10_Feb_2003_19:56:13_+0900_08239930
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Hello again,

On Wed, 5 Feb 2003 11:40:45 +0900
Yoichi Yuasa <yoichi_yuasa@montavista.co.jp> wrote:

> On Tue, 4 Feb 2003 13:44:06 +0100
> Ralf Baechle <ralf@linux-mips.org> wrote:
> 
> > On Tue, Feb 04, 2003 at 03:40:25PM +0900, Yoichi Yuasa wrote:
> > 
> > > This patch is based on linux_2_4 tag cvs tree on ftp.linux-mips.org
> > > Would you apply this patch to CVS on ftp.linux-mips.org?
> > 
> > Could you also make a patch against 2.5?  It's a huge PITA when 2.4 and
> > 2.5 trees are diverging so I'd really like to have a patch for 2.5 also.
> 
> OK, please wait for a moment.

I also made a patch for 2.5.
Would you apply this patch to CVS on ftp.linux-mips.org?

Best Regards,

Yoichi

--Multipart_Mon__10_Feb_2003_19:56:13_+0900_08239930
Content-Type: text/plain;
 name="tanbac-tb0226-v25.diff"
Content-Disposition: attachment;
 filename="tanbac-tb0226-v25.diff"
Content-Transfer-Encoding: 7bit

diff -aruN --exclude=CVS --exclude=.cvsignore linux.orig/arch/mips/Kconfig-shared linux/arch/mips/Kconfig-shared
--- linux.orig/arch/mips/Kconfig-shared	Mon Feb 10 12:29:06 2003
+++ linux/arch/mips/Kconfig-shared	Mon Feb 10 19:17:40 2003
@@ -26,7 +26,7 @@
 
 config PCI_AUTO
 	bool "Support for PCI AUTO Config" if MIPS_PB1000
-	default y if ZAO_CAPCELLA || VICTOR_MPC30X || TOSHIBA_JMR3927 || NEC_EAGLE || DDB5477 || DDB5476 || DDB5074 || MIPS_ITE8172 || MIPS_IVR || MIPS_EV96100 || MIPS_PB1500
+	default y if ZAO_CAPCELLA || VICTOR_MPC30X || TOSHIBA_JMR3927 || NEC_EAGLE || DDB5477 || DDB5476 || DDB5074 || MIPS_ITE8172 || MIPS_IVR || MIPS_EV96100 || MIPS_PB1500 || TANBAC_TB0226
 
 config MIPS_PB1100
 	bool "Support for Alchemy Semi PB1100 board"
@@ -413,7 +413,7 @@
 
 config PCI
 	bool "Support for PCI controller" if SIBYTE_SB1xxx_SOC && SIBYTE_SB1250
-	default y if ZAO_CAPCELLA || VICTOR_MPC30X || TOSHIBA_JMR3927 || SNI_RM200_PCI || SGI_IP32 || SGI_IP27 || NEC_EAGLE || DDB5477 || DDB5476 || DDB5074 || MOMENCO_OCELOT_G || MOMENCO_OCELOT || MIPS_MALTA || MIPS_ATLAS || LASAT || MIPS_ITE8172 || HP_LASERJET || MIPS_IVR || MIPS_EV96100 || MIPS_EV64120 || MIPS_COBALT || MIPS_PB1500 || MIPS_PB1100 || MIPS_PB1000
+	default y if ZAO_CAPCELLA || VICTOR_MPC30X || TOSHIBA_JMR3927 || SNI_RM200_PCI || SGI_IP32 || SGI_IP27 || NEC_EAGLE || DDB5477 || DDB5476 || DDB5074 || MOMENCO_OCELOT_G || MOMENCO_OCELOT || MIPS_MALTA || MIPS_ATLAS || LASAT || MIPS_ITE8172 || HP_LASERJET || MIPS_IVR || MIPS_EV96100 || MIPS_EV64120 || MIPS_COBALT || MIPS_PB1500 || MIPS_PB1100 || MIPS_PB1000 || TANBAC_TB0226
 	help
 	  Find out whether you have a PCI motherboard. PCI is the name of a
 	  bus system, i.e. the way the CPU talks to the other stuff inside
@@ -437,6 +437,12 @@
 	  Technology and now in turn merged with Fujitsu.  Say Y here to
 	  support this machine type.
 
+config TANBAC_TB0226
+	bool "Support for TANBAC TB0226 (Mbase)"
+	help
+	  The TANBAC TB0226 (Mbase) is a MIPS-based platform manufactured by TANBAC.
+	  Please refer to <http://www.tanbac.co.jp/> about Mbase.
+
 config TOSHIBA_JMR3927
 	bool "Support for Toshiba JMR-TX3927 board"
 	depends on MIPS32
@@ -490,8 +496,8 @@
 
 config NONCOHERENT_IO
 	bool
-	depends on ZAO_CAPCELLA || VICTOR_MPC30X || TOSHIBA_JMR3927 || SNI_RM200_PCI || SGI_IP32 || SGI_IP22 || NINO || NEC_EAGLE || NEC_OSPREY || DDB5477 || DDB5476 || DDB5074 || MOMENCO_OCELOT_G || MOMENCO_OCELOT || MIPS_SEAD || MIPS_MALTA || MIPS_MAGNUM_4000 || OLIVETTI_M700 || MIPS_ATLAS || LASAT || MIPS_ITE8172 || IBM_WORKPAD || HP_LASERJET || MIPS_IVR || MIPS_EV96100 || MIPS_EV64120 || DECSTATION || MIPS_COBALT || MIPS_PB1500 || MIPS_PB1100 || MIPS_PB1000 || CASIO_E55 || ACER_PICA_61
-	default y if ZAO_CAPCELLA || VICTOR_MPC30X || TOSHIBA_JMR3927 || SNI_RM200_PCI || SGI_IP32 || SGI_IP22 || NINO || NEC_EAGLE || NEC_OSPREY || DDB5477 || DDB5476 || DDB5074 || MOMENCO_OCELOT_G || MOMENCO_OCELOT || MIPS_SEAD || MIPS_MALTA || MIPS_MAGNUM_4000 || OLIVETTI_M700 || MIPS_ATLAS || LASAT || MIPS_ITE8172 || IBM_WORKPAD || HP_LASERJET || MIPS_IVR || MIPS_EV96100 || MIPS_EV64120 || DECSTATION || MIPS_COBALT || MIPS_PB1500 || MIPS_PB1100 || MIPS_PB1000 || CASIO_E55 || ACER_PICA_61
+	depends on ZAO_CAPCELLA || VICTOR_MPC30X || TOSHIBA_JMR3927 || SNI_RM200_PCI || SGI_IP32 || SGI_IP22 || NINO || NEC_EAGLE || NEC_OSPREY || DDB5477 || DDB5476 || DDB5074 || MOMENCO_OCELOT_G || MOMENCO_OCELOT || MIPS_SEAD || MIPS_MALTA || MIPS_MAGNUM_4000 || OLIVETTI_M700 || MIPS_ATLAS || LASAT || MIPS_ITE8172 || IBM_WORKPAD || HP_LASERJET || MIPS_IVR || MIPS_EV96100 || MIPS_EV64120 || DECSTATION || MIPS_COBALT || MIPS_PB1500 || MIPS_PB1100 || MIPS_PB1000 || CASIO_E55 || ACER_PICA_61 || TANBAC_TB0226
+	default y if ZAO_CAPCELLA || VICTOR_MPC30X || TOSHIBA_JMR3927 || SNI_RM200_PCI || SGI_IP32 || SGI_IP22 || NINO || NEC_EAGLE || NEC_OSPREY || DDB5477 || DDB5476 || DDB5074 || MOMENCO_OCELOT_G || MOMENCO_OCELOT || MIPS_SEAD || MIPS_MALTA || MIPS_MAGNUM_4000 || OLIVETTI_M700 || MIPS_ATLAS || LASAT || MIPS_ITE8172 || IBM_WORKPAD || HP_LASERJET || MIPS_IVR || MIPS_EV96100 || MIPS_EV64120 || DECSTATION || MIPS_COBALT || MIPS_PB1500 || MIPS_PB1100 || MIPS_PB1000 || CASIO_E55 || ACER_PICA_61 || TANBAC_TB0226
 	default n if (SIBYTE_SB1250 || SGI_IP27)
 
 config CPU_LITTLE_ENDIAN
@@ -505,17 +511,17 @@
 
 config IRQ_CPU
 	bool
-	depends on ZAO_CAPCELLA || VICTOR_MPC30X || SGI_IP22 || NEC_EAGLE || NEC_OSPREY || DDB5477 || DDB5476 || DDB5074 || IBM_WORKPAD || HP_LASERJET || DECSTATION || CASIO_E55
+	depends on ZAO_CAPCELLA || VICTOR_MPC30X || SGI_IP22 || NEC_EAGLE || NEC_OSPREY || DDB5477 || DDB5476 || DDB5074 || IBM_WORKPAD || HP_LASERJET || DECSTATION || CASIO_E55 || TANBAC_TB0226
 	default y
 
 config VR41XX_TIME_C
 	bool
-	depends on ZAO_CAPCELLA || VICTOR_MPC30X || NEC_EAGLE || IBM_WORKPAD || CASIO_E55
+	depends on ZAO_CAPCELLA || VICTOR_MPC30X || NEC_EAGLE || IBM_WORKPAD || CASIO_E55 || TANBAC_TB0226
 	default y
 
 config DUMMY_KEYB
 	bool
-	depends on ZAO_CAPCELLA || VICTOR_MPC30X || SIBYTE_SB1250 || NEC_EAGLE || NEC_OSPREY || DDB5477 || IBM_WORKPAD || CASIO_E55
+	depends on ZAO_CAPCELLA || VICTOR_MPC30X || SIBYTE_SB1250 || NEC_EAGLE || NEC_OSPREY || DDB5477 || IBM_WORKPAD || CASIO_E55 || TANBAC_TB0226
 	default y
 
 config ALCHEMY_COMMON
@@ -525,7 +531,7 @@
 
 config VR41XX_COMMON
 	bool
-	depends on NEC_EAGLE || ZAO_CAPCELLA || VICTOR_MPC30X || IBM_WORKPAD || CASIO_E55
+	depends on NEC_EAGLE || ZAO_CAPCELLA || VICTOR_MPC30X || IBM_WORKPAD || CASIO_E55 || TANBAC_TB0226
 	default y
 
 config VRC4173
@@ -554,7 +560,7 @@
 
 config NEW_PCI
 	bool
-	depends on ZAO_CAPCELLA || VICTOR_MPC30X || TOSHIBA_JMR3927 || NEC_EAGLE || DDB5477 || DDB5476 || DDB5074 || MIPS_ITE8172 || HP_LASERJET || MIPS_IVR || MIPS_EV96100 || MIPS_PB1500 || MIPS_PB1100 || MIPS_PB1000
+	depends on ZAO_CAPCELLA || VICTOR_MPC30X || TOSHIBA_JMR3927 || NEC_EAGLE || DDB5477 || DDB5476 || DDB5074 || MIPS_ITE8172 || HP_LASERJET || MIPS_IVR || MIPS_EV96100 || MIPS_PB1500 || MIPS_PB1100 || MIPS_PB1000 || TANBAC_TB0226
 	default y
 
 config SWAP_IO_SPACE
diff -aruN --exclude=CVS --exclude=.cvsignore linux.orig/arch/mips/Makefile linux/arch/mips/Makefile
--- linux.orig/arch/mips/Makefile	Fri Jan 24 10:26:58 2003
+++ linux/arch/mips/Makefile	Mon Feb 10 19:17:40 2003
@@ -277,6 +277,12 @@
 load-$(CONFIG_CASIO_E55)	+= 0x80004000
 
 #
+# TANBAC TB0226 Mbase (VR4131)
+#
+core-$(CONFIG_TANBAC_TB0226)	+= arch/mips/vr41xx/tanbac-tb0226/
+load-$(CONFIG_TANBAC_TB0226)	+= 0x80000000
+
+#
 # Philips Nino
 #
 core-$(CONFIG_NINO)		+= arch/mips/philips/nino/
diff -aruN --exclude=CVS --exclude=.cvsignore linux.orig/arch/mips/defconfig-tb0226 linux/arch/mips/defconfig-tb0226
--- linux.orig/arch/mips/defconfig-tb0226	Thu Jan  1 09:00:00 1970
+++ linux/arch/mips/defconfig-tb0226	Mon Feb 10 19:17:40 2003
@@ -0,0 +1,900 @@
+#
+# Automatically generated make config: don't edit
+#
+CONFIG_MIPS=y
+CONFIG_MIPS32=y
+# CONFIG_MIPS64 is not set
+
+#
+# Code maturity level options
+#
+CONFIG_EXPERIMENTAL=y
+
+#
+# General setup
+#
+CONFIG_NET=y
+CONFIG_SYSVIPC=y
+# CONFIG_BSD_PROCESS_ACCT is not set
+CONFIG_SYSCTL=y
+
+#
+# Loadable module support
+#
+CONFIG_MODULES=y
+# CONFIG_MODVERSIONS is not set
+CONFIG_KMOD=y
+
+#
+# Machine selection
+#
+# CONFIG_ACER_PICA_61 is not set
+# CONFIG_MIPS_PB1000 is not set
+CONFIG_PCI_AUTO=y
+# CONFIG_MIPS_PB1100 is not set
+# CONFIG_MIPS_PB1500 is not set
+# CONFIG_BAGET_MIPS is not set
+# CONFIG_CASIO_E55 is not set
+# CONFIG_MIPS_COBALT is not set
+# CONFIG_DECSTATION is not set
+# CONFIG_MIPS_EV64120 is not set
+# CONFIG_MIPS_EV96100 is not set
+# CONFIG_MIPS_IVR is not set
+# CONFIG_LASAT is not set
+# CONFIG_HP_LASERJET is not set
+# CONFIG_IBM_WORKPAD is not set
+# CONFIG_MIPS_ITE8172 is not set
+# CONFIG_MIPS_ATLAS is not set
+# CONFIG_MIPS_MAGNUM_4000 is not set
+# CONFIG_MIPS_MALTA is not set
+# CONFIG_MIPS_SEAD is not set
+# CONFIG_MOMENCO_OCELOT is not set
+# CONFIG_MOMENCO_OCELOT_G is not set
+# CONFIG_DDB5074 is not set
+# CONFIG_DDB5476 is not set
+# CONFIG_DDB5477 is not set
+# CONFIG_NEC_OSPREY is not set
+# CONFIG_NEC_EAGLE is not set
+# CONFIG_OLIVETTI_M700 is not set
+# CONFIG_NINO is not set
+# CONFIG_SGI_IP22 is not set
+# CONFIG_SGI_IP32 is not set
+# CONFIG_SIBYTE_SB1xxx_SOC is not set
+CONFIG_PCI=y
+# CONFIG_SNI_RM200_PCI is not set
+CONFIG_TANBAC_TB0226=y
+# CONFIG_TOSHIBA_JMR3927 is not set
+# CONFIG_VICTOR_MPC30X is not set
+# CONFIG_ZAO_CAPCELLA is not set
+CONFIG_RWSEM_GENERIC_SPINLOCK=y
+CONFIG_GENERIC_ISA_DMA=y
+CONFIG_NONCOHERENT_IO=y
+CONFIG_CPU_LITTLE_ENDIAN=y
+CONFIG_IRQ_CPU=y
+CONFIG_VR41XX_TIME_C=y
+CONFIG_DUMMY_KEYB=y
+CONFIG_VR41XX_COMMON=y
+CONFIG_NEW_PCI=y
+CONFIG_FB=y
+
+#
+# CPU selection
+#
+# CONFIG_CPU_MIPS32 is not set
+# CONFIG_CPU_MIPS64 is not set
+# CONFIG_CPU_R3000 is not set
+# CONFIG_CPU_TX39XX is not set
+CONFIG_CPU_VR41XX=y
+# CONFIG_CPU_R4300 is not set
+# CONFIG_CPU_R4X00 is not set
+# CONFIG_CPU_TX49XX is not set
+# CONFIG_CPU_R5000 is not set
+# CONFIG_CPU_R5432 is not set
+# CONFIG_CPU_R6000 is not set
+# CONFIG_CPU_NEVADA is not set
+# CONFIG_CPU_R8000 is not set
+# CONFIG_CPU_R10000 is not set
+# CONFIG_CPU_RM7000 is not set
+# CONFIG_CPU_SB1 is not set
+# CONFIG_CPU_ADVANCED is not set
+CONFIG_CPU_HAS_SYNC=y
+# CONFIG_PREEMPT is not set
+
+#
+# Bus options (PCI, PCMCIA, EISA, ISA, TC)
+#
+CONFIG_PCI_NAMES=y
+CONFIG_MMU=y
+CONFIG_SWAP=y
+# CONFIG_HOTPLUG is not set
+
+#
+# Executable file formats
+#
+CONFIG_KCORE_ELF=y
+CONFIG_BINFMT_ELF=y
+# CONFIG_BINFMT_MISC is not set
+
+#
+# Memory Technology Devices (MTD)
+#
+# CONFIG_MTD is not set
+
+#
+# Parallel port support
+#
+# CONFIG_PARPORT is not set
+
+#
+# Plug and Play configuration
+#
+# CONFIG_PNP is not set
+
+#
+# Block devices
+#
+CONFIG_BLK_DEV_FD=y
+# CONFIG_BLK_CPQ_DA is not set
+# CONFIG_BLK_CPQ_CISS_DA is not set
+# CONFIG_BLK_DEV_DAC960 is not set
+# CONFIG_BLK_DEV_UMEM is not set
+CONFIG_BLK_DEV_LOOP=m
+CONFIG_BLK_DEV_NBD=m
+CONFIG_BLK_DEV_RAM=m
+CONFIG_BLK_DEV_RAM_SIZE=4096
+
+#
+# ATA/ATAPI/MFM/RLL support
+#
+CONFIG_IDE=y
+
+#
+# IDE, ATA and ATAPI Block devices
+#
+CONFIG_BLK_DEV_IDE=y
+
+#
+# Please see Documentation/ide.txt for help/info on IDE drives
+#
+# CONFIG_BLK_DEV_HD is not set
+CONFIG_BLK_DEV_IDEDISK=y
+CONFIG_IDEDISK_MULTI_MODE=y
+# CONFIG_IDEDISK_STROKE is not set
+# CONFIG_BLK_DEV_IDECD is not set
+# CONFIG_BLK_DEV_IDEFLOPPY is not set
+CONFIG_BLK_DEV_IDESCSI=y
+# CONFIG_IDE_TASK_IOCTL is not set
+
+#
+# IDE chipset support/bugfixes
+#
+CONFIG_BLK_DEV_IDEPCI=y
+# CONFIG_BLK_DEV_GENERIC is not set
+CONFIG_IDEPCI_SHARE_IRQ=y
+CONFIG_BLK_DEV_IDEDMA_PCI=y
+# CONFIG_BLK_DEV_IDE_TCQ is not set
+# CONFIG_BLK_DEV_OFFBOARD is not set
+# CONFIG_BLK_DEV_IDEDMA_FORCED is not set
+CONFIG_IDEDMA_PCI_AUTO=y
+# CONFIG_IDEDMA_ONLYDISK is not set
+CONFIG_BLK_DEV_IDEDMA=y
+# CONFIG_IDEDMA_PCI_WIP is not set
+CONFIG_BLK_DEV_ADMA=y
+# CONFIG_BLK_DEV_AEC62XX is not set
+# CONFIG_BLK_DEV_ALI15X3 is not set
+# CONFIG_BLK_DEV_AMD74XX is not set
+# CONFIG_BLK_DEV_CMD64X is not set
+# CONFIG_BLK_DEV_CY82C693 is not set
+# CONFIG_BLK_DEV_CS5530 is not set
+# CONFIG_BLK_DEV_HPT34X is not set
+# CONFIG_BLK_DEV_HPT366 is not set
+CONFIG_BLK_DEV_PIIX=y
+# CONFIG_BLK_DEV_NFORCE is not set
+# CONFIG_BLK_DEV_NS87415 is not set
+# CONFIG_BLK_DEV_OPTI621 is not set
+# CONFIG_BLK_DEV_PDC202XX_OLD is not set
+# CONFIG_BLK_DEV_PDC202XX_NEW is not set
+# CONFIG_BLK_DEV_SVWKS is not set
+# CONFIG_BLK_DEV_SIIMAGE is not set
+# CONFIG_BLK_DEV_SLC90E66 is not set
+# CONFIG_BLK_DEV_TRM290 is not set
+# CONFIG_BLK_DEV_VIA82CXXX is not set
+CONFIG_IDEDMA_AUTO=y
+# CONFIG_IDEDMA_IVB is not set
+CONFIG_BLK_DEV_IDE_MODES=y
+
+#
+# SCSI device support
+#
+CONFIG_SCSI=y
+
+#
+# SCSI support type (disk, tape, CD-ROM)
+#
+CONFIG_BLK_DEV_SD=y
+# CONFIG_CHR_DEV_ST is not set
+# CONFIG_CHR_DEV_OSST is not set
+CONFIG_BLK_DEV_SR=y
+# CONFIG_BLK_DEV_SR_VENDOR is not set
+CONFIG_CHR_DEV_SG=y
+
+#
+# Some SCSI devices (e.g. CD jukebox) support multiple LUNs
+#
+CONFIG_SCSI_MULTI_LUN=y
+# CONFIG_SCSI_REPORT_LUNS is not set
+CONFIG_SCSI_CONSTANTS=y
+# CONFIG_SCSI_LOGGING is not set
+
+#
+# SCSI low-level drivers
+#
+# CONFIG_BLK_DEV_3W_XXXX_RAID is not set
+# CONFIG_SCSI_ACARD is not set
+# CONFIG_SCSI_AACRAID is not set
+# CONFIG_SCSI_AIC7XXX is not set
+# CONFIG_SCSI_AIC7XXX_OLD is not set
+# CONFIG_SCSI_DPT_I2O is not set
+# CONFIG_SCSI_ADVANSYS is not set
+# CONFIG_SCSI_IN2000 is not set
+# CONFIG_SCSI_AM53C974 is not set
+# CONFIG_SCSI_MEGARAID is not set
+# CONFIG_SCSI_BUSLOGIC is not set
+# CONFIG_SCSI_CPQFCTS is not set
+# CONFIG_SCSI_DMX3191D is not set
+# CONFIG_SCSI_EATA is not set
+# CONFIG_SCSI_EATA_DMA is not set
+# CONFIG_SCSI_EATA_PIO is not set
+# CONFIG_SCSI_FUTURE_DOMAIN is not set
+# CONFIG_SCSI_GDTH is not set
+# CONFIG_SCSI_GENERIC_NCR5380 is not set
+# CONFIG_SCSI_GENERIC_NCR5380_MMIO is not set
+# CONFIG_SCSI_INITIO is not set
+# CONFIG_SCSI_INIA100 is not set
+# CONFIG_SCSI_NCR53C7xx is not set
+# CONFIG_SCSI_SYM53C8XX_2 is not set
+# CONFIG_SCSI_NCR53C8XX is not set
+# CONFIG_SCSI_SYM53C8XX is not set
+# CONFIG_SCSI_PCI2000 is not set
+# CONFIG_SCSI_PCI2220I is not set
+# CONFIG_SCSI_QLOGIC_ISP is not set
+# CONFIG_SCSI_QLOGIC_FC is not set
+# CONFIG_SCSI_QLOGIC_1280 is not set
+# CONFIG_SCSI_DC390T is not set
+# CONFIG_SCSI_U14_34F is not set
+# CONFIG_SCSI_NSP32 is not set
+# CONFIG_SCSI_DEBUG is not set
+
+#
+# Multi-device support (RAID and LVM)
+#
+# CONFIG_MD is not set
+
+#
+# Fusion MPT device support
+#
+# CONFIG_FUSION is not set
+
+#
+# IEEE 1394 (FireWire) support (EXPERIMENTAL)
+#
+# CONFIG_IEEE1394 is not set
+
+#
+# I2O device support
+#
+# CONFIG_I2O is not set
+
+#
+# Networking options
+#
+CONFIG_PACKET=y
+# CONFIG_PACKET_MMAP is not set
+CONFIG_NETLINK_DEV=m
+# CONFIG_NETFILTER is not set
+# CONFIG_FILTER is not set
+CONFIG_UNIX=y
+# CONFIG_NET_KEY is not set
+CONFIG_INET=y
+CONFIG_IP_MULTICAST=y
+CONFIG_IP_ADVANCED_ROUTER=y
+CONFIG_IP_MULTIPLE_TABLES=y
+CONFIG_IP_ROUTE_NAT=y
+CONFIG_IP_ROUTE_MULTIPATH=y
+CONFIG_IP_ROUTE_TOS=y
+CONFIG_IP_ROUTE_VERBOSE=y
+CONFIG_IP_ROUTE_LARGE_TABLES=y
+CONFIG_IP_PNP=y
+# CONFIG_IP_PNP_DHCP is not set
+CONFIG_IP_PNP_BOOTP=y
+# CONFIG_IP_PNP_RARP is not set
+# CONFIG_NET_IPIP is not set
+# CONFIG_NET_IPGRE is not set
+# CONFIG_IP_MROUTE is not set
+# CONFIG_ARPD is not set
+# CONFIG_INET_ECN is not set
+CONFIG_SYN_COOKIES=y
+# CONFIG_INET_AH is not set
+# CONFIG_INET_ESP is not set
+# CONFIG_IPV6 is not set
+
+#
+# SCTP Configuration (EXPERIMENTAL)
+#
+CONFIG_IPV6_SCTP__=y
+# CONFIG_IP_SCTP is not set
+# CONFIG_ATM is not set
+# CONFIG_VLAN_8021Q is not set
+# CONFIG_LLC is not set
+# CONFIG_DECNET is not set
+# CONFIG_BRIDGE is not set
+# CONFIG_X25 is not set
+# CONFIG_LAPB is not set
+# CONFIG_NET_DIVERT is not set
+# CONFIG_ECONET is not set
+# CONFIG_WAN_ROUTER is not set
+# CONFIG_NET_FASTROUTE is not set
+# CONFIG_NET_HW_FLOWCONTROL is not set
+
+#
+# QoS and/or fair queueing
+#
+# CONFIG_NET_SCHED is not set
+
+#
+# Network testing
+#
+# CONFIG_NET_PKTGEN is not set
+
+#
+# Network device support
+#
+CONFIG_NETDEVICES=y
+
+#
+# ARCnet devices
+#
+# CONFIG_ARCNET is not set
+# CONFIG_DUMMY is not set
+# CONFIG_BONDING is not set
+# CONFIG_EQUALIZER is not set
+# CONFIG_TUN is not set
+# CONFIG_ETHERTAP is not set
+
+#
+# Ethernet (10 or 100Mbit)
+#
+CONFIG_NET_ETHERNET=y
+# CONFIG_HAPPYMEAL is not set
+# CONFIG_SUNGEM is not set
+# CONFIG_NET_VENDOR_3COM is not set
+# CONFIG_NET_VENDOR_SMC is not set
+# CONFIG_NET_VENDOR_RACAL is not set
+
+#
+# Tulip family network device support
+#
+# CONFIG_NET_TULIP is not set
+# CONFIG_HP100 is not set
+CONFIG_NET_PCI=y
+# CONFIG_PCNET32 is not set
+# CONFIG_ADAPTEC_STARFIRE is not set
+# CONFIG_B44 is not set
+# CONFIG_TC35815 is not set
+# CONFIG_DGRS is not set
+CONFIG_EEPRO100=y
+# CONFIG_E100 is not set
+# CONFIG_FEALNX is not set
+# CONFIG_NATSEMI is not set
+# CONFIG_NE2K_PCI is not set
+# CONFIG_8139CP is not set
+# CONFIG_8139TOO is not set
+# CONFIG_SIS900 is not set
+# CONFIG_EPIC100 is not set
+# CONFIG_SUNDANCE is not set
+# CONFIG_TLAN is not set
+# CONFIG_VIA_RHINE is not set
+# CONFIG_LAN_SAA9730 is not set
+# CONFIG_NET_POCKET is not set
+
+#
+# Ethernet (1000 Mbit)
+#
+# CONFIG_ACENIC is not set
+# CONFIG_DL2K is not set
+# CONFIG_E1000 is not set
+# CONFIG_NS83820 is not set
+# CONFIG_HAMACHI is not set
+# CONFIG_YELLOWFIN is not set
+# CONFIG_SK98LIN is not set
+# CONFIG_TIGON3 is not set
+# CONFIG_FDDI is not set
+# CONFIG_HIPPI is not set
+CONFIG_PPP=m
+CONFIG_PPP_MULTILINK=y
+CONFIG_PPP_ASYNC=m
+CONFIG_PPP_SYNC_TTY=m
+CONFIG_PPP_DEFLATE=m
+CONFIG_PPP_BSDCOMP=m
+CONFIG_PPPOE=m
+# CONFIG_SLIP is not set
+
+#
+# Wireless LAN (non-hamradio)
+#
+# CONFIG_NET_RADIO is not set
+
+#
+# Token Ring devices
+#
+# CONFIG_TR is not set
+# CONFIG_NET_FC is not set
+# CONFIG_RCPCI is not set
+# CONFIG_SHAPER is not set
+
+#
+# Wan interfaces
+#
+# CONFIG_WAN is not set
+
+#
+# Amateur Radio support
+#
+# CONFIG_HAMRADIO is not set
+
+#
+# IrDA (infrared) support
+#
+# CONFIG_IRDA is not set
+
+#
+# ISDN subsystem
+#
+# CONFIG_ISDN_BOOL is not set
+
+#
+# Telephony Support
+#
+# CONFIG_PHONE is not set
+
+#
+# Input device support
+#
+CONFIG_INPUT=y
+
+#
+# Userland interfaces
+#
+CONFIG_INPUT_MOUSEDEV=m
+# CONFIG_INPUT_MOUSEDEV_PSAUX is not set
+CONFIG_INPUT_MOUSEDEV_SCREEN_X=1280
+CONFIG_INPUT_MOUSEDEV_SCREEN_Y=1024
+# CONFIG_INPUT_JOYDEV is not set
+# CONFIG_INPUT_TSDEV is not set
+# CONFIG_INPUT_EVDEV is not set
+# CONFIG_INPUT_EVBUG is not set
+
+#
+# Input I/O drivers
+#
+# CONFIG_GAMEPORT is not set
+CONFIG_SOUND_GAMEPORT=y
+# CONFIG_SERIO is not set
+
+#
+# Input Device Drivers
+#
+# CONFIG_INPUT_KEYBOARD is not set
+# CONFIG_INPUT_MOUSE is not set
+# CONFIG_INPUT_JOYSTICK is not set
+# CONFIG_INPUT_TOUCHSCREEN is not set
+# CONFIG_INPUT_MISC is not set
+
+#
+# Character devices
+#
+CONFIG_VT=y
+# CONFIG_VT_CONSOLE is not set
+CONFIG_HW_CONSOLE=y
+# CONFIG_SERIAL_NONSTANDARD is not set
+
+#
+# Serial drivers
+#
+CONFIG_SERIAL_8250=y
+CONFIG_SERIAL_8250_CONSOLE=y
+# CONFIG_SERIAL_8250_EXTENDED is not set
+
+#
+# Non-8250 serial port support
+#
+CONFIG_SERIAL_CORE=y
+CONFIG_SERIAL_CORE_CONSOLE=y
+CONFIG_UNIX98_PTYS=y
+CONFIG_UNIX98_PTY_COUNT=256
+
+#
+# I2C support
+#
+# CONFIG_I2C is not set
+
+#
+# Mice
+#
+# CONFIG_BUSMOUSE is not set
+# CONFIG_QIC02_TAPE is not set
+
+#
+# Watchdog Cards
+#
+# CONFIG_WATCHDOG is not set
+# CONFIG_NVRAM is not set
+# CONFIG_RTC is not set
+# CONFIG_GEN_RTC is not set
+# CONFIG_DTLK is not set
+# CONFIG_R3964 is not set
+# CONFIG_APPLICOM is not set
+
+#
+# Ftape, the floppy tape device driver
+#
+# CONFIG_FTAPE is not set
+# CONFIG_AGP is not set
+# CONFIG_DRM is not set
+# CONFIG_RAW_DRIVER is not set
+CONFIG_FONT_8x16=y
+CONFIG_DUMMY_CONSOLE=y
+
+#
+# Multimedia devices
+#
+# CONFIG_VIDEO_DEV is not set
+
+#
+# File systems
+#
+# CONFIG_QUOTA is not set
+# CONFIG_AUTOFS_FS is not set
+CONFIG_AUTOFS4_FS=y
+# CONFIG_REISERFS_FS is not set
+# CONFIG_ADFS_FS is not set
+# CONFIG_AFFS_FS is not set
+# CONFIG_HFS_FS is not set
+# CONFIG_BEFS_FS is not set
+# CONFIG_BFS_FS is not set
+# CONFIG_EXT3_FS is not set
+# CONFIG_JBD is not set
+CONFIG_FAT_FS=m
+CONFIG_MSDOS_FS=m
+CONFIG_VFAT_FS=m
+# CONFIG_EFS_FS is not set
+CONFIG_CRAMFS=m
+CONFIG_TMPFS=y
+CONFIG_RAMFS=y
+CONFIG_ISO9660_FS=y
+CONFIG_JOLIET=y
+CONFIG_ZISOFS=y
+# CONFIG_JFS_FS is not set
+# CONFIG_MINIX_FS is not set
+# CONFIG_VXFS_FS is not set
+# CONFIG_NTFS_FS is not set
+# CONFIG_HPFS_FS is not set
+CONFIG_PROC_FS=y
+# CONFIG_DEVFS_FS is not set
+CONFIG_DEVPTS_FS=y
+# CONFIG_QNX4FS_FS is not set
+CONFIG_ROMFS_FS=m
+CONFIG_EXT2_FS=y
+# CONFIG_EXT2_FS_XATTR is not set
+# CONFIG_SYSV_FS is not set
+# CONFIG_UDF_FS is not set
+# CONFIG_UFS_FS is not set
+# CONFIG_XFS_FS is not set
+
+#
+# Network File Systems
+#
+# CONFIG_CODA_FS is not set
+# CONFIG_INTERMEZZO_FS is not set
+CONFIG_NFS_FS=y
+CONFIG_NFS_V3=y
+# CONFIG_NFS_V4 is not set
+CONFIG_ROOT_NFS=y
+CONFIG_NFSD=m
+CONFIG_NFSD_V3=y
+# CONFIG_NFSD_V4 is not set
+# CONFIG_NFSD_TCP is not set
+CONFIG_SUNRPC=y
+CONFIG_LOCKD=y
+CONFIG_LOCKD_V4=y
+CONFIG_EXPORTFS=m
+# CONFIG_CIFS is not set
+CONFIG_SMB_FS=m
+CONFIG_SMB_NLS_DEFAULT=y
+CONFIG_SMB_NLS_REMOTE="cp932"
+# CONFIG_NCP_FS is not set
+# CONFIG_AFS_FS is not set
+CONFIG_ZISOFS_FS=y
+
+#
+# Partition Types
+#
+# CONFIG_PARTITION_ADVANCED is not set
+CONFIG_MSDOS_PARTITION=y
+CONFIG_SMB_NLS=y
+CONFIG_NLS=y
+
+#
+# Native Language Support
+#
+CONFIG_NLS_DEFAULT="iso8859-1"
+CONFIG_NLS_CODEPAGE_437=m
+# CONFIG_NLS_CODEPAGE_737 is not set
+# CONFIG_NLS_CODEPAGE_775 is not set
+# CONFIG_NLS_CODEPAGE_850 is not set
+# CONFIG_NLS_CODEPAGE_852 is not set
+# CONFIG_NLS_CODEPAGE_855 is not set
+# CONFIG_NLS_CODEPAGE_857 is not set
+# CONFIG_NLS_CODEPAGE_860 is not set
+# CONFIG_NLS_CODEPAGE_861 is not set
+# CONFIG_NLS_CODEPAGE_862 is not set
+# CONFIG_NLS_CODEPAGE_863 is not set
+# CONFIG_NLS_CODEPAGE_864 is not set
+# CONFIG_NLS_CODEPAGE_865 is not set
+# CONFIG_NLS_CODEPAGE_866 is not set
+# CONFIG_NLS_CODEPAGE_869 is not set
+# CONFIG_NLS_CODEPAGE_936 is not set
+# CONFIG_NLS_CODEPAGE_950 is not set
+CONFIG_NLS_CODEPAGE_932=m
+# CONFIG_NLS_CODEPAGE_949 is not set
+# CONFIG_NLS_CODEPAGE_874 is not set
+# CONFIG_NLS_ISO8859_8 is not set
+# CONFIG_NLS_CODEPAGE_1250 is not set
+# CONFIG_NLS_CODEPAGE_1251 is not set
+CONFIG_NLS_ISO8859_1=m
+# CONFIG_NLS_ISO8859_2 is not set
+# CONFIG_NLS_ISO8859_3 is not set
+# CONFIG_NLS_ISO8859_4 is not set
+# CONFIG_NLS_ISO8859_5 is not set
+# CONFIG_NLS_ISO8859_6 is not set
+# CONFIG_NLS_ISO8859_7 is not set
+# CONFIG_NLS_ISO8859_9 is not set
+# CONFIG_NLS_ISO8859_13 is not set
+# CONFIG_NLS_ISO8859_14 is not set
+# CONFIG_NLS_ISO8859_15 is not set
+# CONFIG_NLS_KOI8_R is not set
+# CONFIG_NLS_KOI8_U is not set
+# CONFIG_NLS_UTF8 is not set
+
+#
+# Console drivers
+#
+# CONFIG_VGA_CONSOLE is not set
+# CONFIG_MDA_CONSOLE is not set
+
+#
+# Frame-buffer support
+#
+# CONFIG_FB_CLGEN is not set
+# CONFIG_FB_PM2 is not set
+# CONFIG_FB_CYBER2000 is not set
+# CONFIG_FB_ATY is not set
+# CONFIG_FB_RIVA is not set
+CONFIG_FB_MATROX=y
+# CONFIG_FB_MATROX_MILLENIUM is not set
+# CONFIG_FB_MATROX_MYSTIQUE is not set
+# CONFIG_FB_MATROX_G450 is not set
+# CONFIG_FB_MATROX_G100A is not set
+# CONFIG_FB_MATROX_MULTIHEAD is not set
+# CONFIG_FB_RADEON is not set
+# CONFIG_FB_ATY128 is not set
+# CONFIG_FB_SIS is not set
+# CONFIG_FB_NEOMAGIC is not set
+# CONFIG_FB_3DFX is not set
+# CONFIG_FB_VOODOO1 is not set
+# CONFIG_FB_TRIDENT is not set
+# CONFIG_FB_PM3 is not set
+# CONFIG_FB_E1356 is not set
+# CONFIG_FB_VIRTUAL is not set
+CONFIG_FBCON_ADVANCED=y
+# CONFIG_FBCON_MFB is not set
+# CONFIG_FBCON_CFB2 is not set
+# CONFIG_FBCON_CFB4 is not set
+CONFIG_FBCON_CFB8=y
+CONFIG_FBCON_CFB16=y
+CONFIG_FBCON_CFB24=y
+CONFIG_FBCON_CFB32=y
+# CONFIG_FBCON_ACCEL is not set
+# CONFIG_FBCON_AFB is not set
+# CONFIG_FBCON_ILBM is not set
+# CONFIG_FBCON_IPLAN2P2 is not set
+# CONFIG_FBCON_IPLAN2P4 is not set
+# CONFIG_FBCON_IPLAN2P8 is not set
+# CONFIG_FBCON_VGA_PLANES is not set
+# CONFIG_FBCON_HGA is not set
+# CONFIG_FBCON_FONTWIDTH8_ONLY is not set
+# CONFIG_FONT_SUN8x16 is not set
+# CONFIG_FONT_SUN12x22 is not set
+CONFIG_FBCON_FONTS=y
+CONFIG_FONT_8x8=y
+# CONFIG_FONT_6x11 is not set
+# CONFIG_FONT_PEARL_8x8 is not set
+# CONFIG_FONT_ACORN_8x8 is not set
+# CONFIG_FONT_MINI_4x6 is not set
+
+#
+# Sound
+#
+CONFIG_SOUND=y
+
+#
+# Open Sound System
+#
+# CONFIG_SOUND_PRIME is not set
+
+#
+# Advanced Linux Sound Architecture
+#
+# CONFIG_SND is not set
+
+#
+# USB support
+#
+CONFIG_USB=y
+# CONFIG_USB_DEBUG is not set
+
+#
+# Miscellaneous USB options
+#
+CONFIG_USB_DEVICEFS=y
+CONFIG_USB_LONG_TIMEOUT=y
+CONFIG_USB_BANDWIDTH=y
+# CONFIG_USB_DYNAMIC_MINORS is not set
+
+#
+# USB Host Controller Drivers
+#
+CONFIG_USB_EHCI_HCD=y
+CONFIG_USB_OHCI_HCD=y
+# CONFIG_USB_UHCI_HCD_ALT is not set
+
+#
+# USB Device Class drivers
+#
+CONFIG_USB_AUDIO=m
+# CONFIG_USB_BLUETOOTH_TTY is not set
+# CONFIG_USB_MIDI is not set
+CONFIG_USB_ACM=m
+CONFIG_USB_PRINTER=m
+CONFIG_USB_STORAGE=m
+# CONFIG_USB_STORAGE_DEBUG is not set
+CONFIG_USB_STORAGE_DATAFAB=y
+CONFIG_USB_STORAGE_FREECOM=y
+CONFIG_USB_STORAGE_ISD200=y
+CONFIG_USB_STORAGE_DPCM=y
+CONFIG_USB_STORAGE_HP8200e=y
+CONFIG_USB_STORAGE_SDDR09=y
+# CONFIG_USB_STORAGE_SDDR55 is not set
+CONFIG_USB_STORAGE_JUMPSHOT=y
+
+#
+# USB Human Interface Devices (HID)
+#
+CONFIG_USB_HID=m
+# CONFIG_USB_HIDINPUT is not set
+CONFIG_USB_HIDDEV=y
+
+#
+# USB HID Boot Protocol drivers
+#
+# CONFIG_USB_KBD is not set
+# CONFIG_USB_MOUSE is not set
+# CONFIG_USB_AIPTEK is not set
+# CONFIG_USB_WACOM is not set
+# CONFIG_USB_POWERMATE is not set
+# CONFIG_USB_XPAD is not set
+
+#
+# USB Imaging devices
+#
+CONFIG_USB_MDC800=m
+CONFIG_USB_SCANNER=m
+CONFIG_USB_MICROTEK=m
+CONFIG_USB_HPUSBSCSI=m
+
+#
+# USB Multimedia devices
+#
+# CONFIG_USB_DABUSB is not set
+
+#
+# Video4Linux support is needed for USB Multimedia device support
+#
+
+#
+# USB Network adaptors
+#
+CONFIG_USB_CATC=m
+CONFIG_USB_CDCETHER=m
+CONFIG_USB_KAWETH=m
+CONFIG_USB_PEGASUS=m
+# CONFIG_USB_RTL8150 is not set
+CONFIG_USB_USBNET=m
+
+#
+# USB port drivers
+#
+
+#
+# USB Serial Converter support
+#
+CONFIG_USB_SERIAL=m
+CONFIG_USB_SERIAL_GENERIC=y
+CONFIG_USB_SERIAL_BELKIN=m
+CONFIG_USB_SERIAL_WHITEHEAT=m
+CONFIG_USB_SERIAL_DIGI_ACCELEPORT=m
+CONFIG_USB_SERIAL_EMPEG=m
+CONFIG_USB_SERIAL_FTDI_SIO=m
+CONFIG_USB_SERIAL_VISOR=m
+CONFIG_USB_SERIAL_IPAQ=m
+CONFIG_USB_SERIAL_IR=m
+CONFIG_USB_SERIAL_EDGEPORT=m
+# CONFIG_USB_SERIAL_EDGEPORT_TI is not set
+CONFIG_USB_SERIAL_KEYSPAN_PDA=m
+CONFIG_USB_SERIAL_KEYSPAN=m
+# CONFIG_USB_SERIAL_KEYSPAN_USA28 is not set
+# CONFIG_USB_SERIAL_KEYSPAN_USA28X is not set
+# CONFIG_USB_SERIAL_KEYSPAN_USA28XA is not set
+# CONFIG_USB_SERIAL_KEYSPAN_USA28XB is not set
+# CONFIG_USB_SERIAL_KEYSPAN_USA19 is not set
+# CONFIG_USB_SERIAL_KEYSPAN_USA18X is not set
+# CONFIG_USB_SERIAL_KEYSPAN_USA19W is not set
+# CONFIG_USB_SERIAL_KEYSPAN_USA19QW is not set
+# CONFIG_USB_SERIAL_KEYSPAN_USA19QI is not set
+# CONFIG_USB_SERIAL_KEYSPAN_USA49W is not set
+CONFIG_USB_SERIAL_KLSI=m
+CONFIG_USB_SERIAL_MCT_U232=m
+CONFIG_USB_SERIAL_PL2303=m
+# CONFIG_USB_SERIAL_SAFE is not set
+CONFIG_USB_SERIAL_CYBERJACK=m
+CONFIG_USB_SERIAL_XIRCOM=m
+CONFIG_USB_SERIAL_OMNINET=m
+
+#
+# USB Miscellaneous drivers
+#
+# CONFIG_USB_EMI26 is not set
+# CONFIG_USB_TIGL is not set
+# CONFIG_USB_AUERSWALD is not set
+CONFIG_USB_RIO500=m
+# CONFIG_USB_BRLVGER is not set
+# CONFIG_USB_LCD is not set
+# CONFIG_USB_TEST is not set
+
+#
+# Bluetooth support
+#
+# CONFIG_BT is not set
+
+#
+# Kernel hacking
+#
+CONFIG_CROSSCOMPILE=y
+# CONFIG_DEBUG_KERNEL is not set
+
+#
+# Security options
+#
+CONFIG_SECURITY_CAPABILITIES=y
+
+#
+# Cryptographic options
+#
+# CONFIG_CRYPTO is not set
+
+#
+# Library routines
+#
+# CONFIG_CRC32 is not set
+CONFIG_ZLIB_INFLATE=y
+CONFIG_ZLIB_DEFLATE=m
diff -aruN --exclude=CVS --exclude=.cvsignore linux.orig/arch/mips/vr41xx/tanbac-tb0226/Makefile linux/arch/mips/vr41xx/tanbac-tb0226/Makefile
--- linux.orig/arch/mips/vr41xx/tanbac-tb0226/Makefile	Thu Jan  1 09:00:00 1970
+++ linux/arch/mips/vr41xx/tanbac-tb0226/Makefile	Mon Feb 10 19:17:41 2003
@@ -0,0 +1,7 @@
+#
+# Makefile for the TANBAC TB0226 specific parts of the kernel
+#
+
+obj-y	:= init.o setup.o
+
+obj-$(CONFIG_PCI)	+= pci_fixup.o
diff -aruN --exclude=CVS --exclude=.cvsignore linux.orig/arch/mips/vr41xx/tanbac-tb0226/init.c linux/arch/mips/vr41xx/tanbac-tb0226/init.c
--- linux.orig/arch/mips/vr41xx/tanbac-tb0226/init.c	Thu Jan  1 09:00:00 1970
+++ linux/arch/mips/vr41xx/tanbac-tb0226/init.c	Mon Feb 10 19:17:41 2003
@@ -0,0 +1,68 @@
+/*
+ * FILE NAME
+ *	arch/mips/vr41xx/tanbac-tb0226/init.c
+ *
+ * BRIEF MODULE DESCRIPTION
+ *	Initialisation code for the TANBAC TB0226.
+ *
+ * Copyright 2002,2003 Yoichi Yuasa
+ *                yuasa@hh.iij4u.or.jp
+ *
+ *  This program is free software; you can redistribute it and/or modify it
+ *  under the terms of the GNU General Public License as published by the
+ *  Free Software Foundation; either version 2 of the License, or (at your
+ *  option) any later version.
+ */
+#include <linux/config.h>
+#include <linux/init.h>
+#include <linux/kernel.h>
+#include <linux/string.h>
+
+#include <asm/bootinfo.h>
+#include <asm/cpu.h>
+#include <asm/mipsregs.h>
+#include <asm/vr41xx/vr41xx.h>
+
+char arcs_cmdline[CL_SIZE];
+
+const char *get_system_type(void)
+{
+	return "TANBAC TB0226";
+}
+
+void __init bus_error_init(void)
+{
+}
+
+void __init prom_init(int argc, char **argv, unsigned long magic, int *prom_vec)
+{
+	u32 config;
+	int i;
+
+	/*
+	 * collect args and prepare cmd_line
+	 */
+	for (i = 1; i < argc; i++) {
+		strcat(arcs_cmdline, argv[i]);
+		if (i < (argc - 1))
+			strcat(arcs_cmdline, " ");
+	}
+
+	mips_machgroup = MACH_GROUP_NEC_VR41XX;
+	mips_machtype = MACH_TANBAC_TB0226;
+
+	switch (mips_cpu.processor_id) {
+	case PRID_VR4131_REV1_2:
+		config = read_c0_config();
+		config &= ~0x00000030UL;
+		config |= 0x00410000UL;
+		write_c0_config(config);
+		break;
+	default:
+		break;
+	}
+}
+
+void __init prom_free_prom_memory (void)
+{
+}
diff -aruN --exclude=CVS --exclude=.cvsignore linux.orig/arch/mips/vr41xx/tanbac-tb0226/pci_fixup.c linux/arch/mips/vr41xx/tanbac-tb0226/pci_fixup.c
--- linux.orig/arch/mips/vr41xx/tanbac-tb0226/pci_fixup.c	Thu Jan  1 09:00:00 1970
+++ linux/arch/mips/vr41xx/tanbac-tb0226/pci_fixup.c	Mon Feb 10 19:17:41 2003
@@ -0,0 +1,87 @@
+/*
+ * FILE NAME
+ *	arch/mips/vr41xx/tanbac-tb0226/pci_fixup.c
+ *
+ * BRIEF MODULE DESCRIPTION
+ *	The TANBAC TB0226 specific PCI fixups.
+ *
+ * Copyright 2002,2003 Yoichi Yuasa
+ *                yuasa@hh.iij4u.or.jp
+ *
+ *  This program is free software; you can redistribute it and/or modify it
+ *  under the terms of the GNU General Public License as published by the
+ *  Free Software Foundation; either version 2 of the License, or (at your
+ *  option) any later version.
+ */
+#include <linux/config.h>
+#include <linux/init.h>
+#include <linux/pci.h>
+
+#include <asm/vr41xx/tb0226.h>
+
+void __init pcibios_fixup_resources(struct pci_dev *dev)
+{
+}
+
+void __init pcibios_fixup(void)
+{
+}
+
+void __init pcibios_fixup_irqs(void)
+{
+	struct pci_dev *dev;
+	u8 slot, pin;
+
+	pci_for_each_dev(dev) {
+		slot = PCI_SLOT(dev->devfn);
+		dev->irq = 0;
+
+		switch (slot) {
+		case 12:
+			vr41xx_set_irq_trigger(GD82559_1_PIN, TRIGGER_LEVEL,
+			                       SIGNAL_THROUGH);
+			vr41xx_set_irq_level(GD82559_1_PIN, LEVEL_LOW);
+			dev->irq = GD82559_1_IRQ;
+			break;
+		case 13:
+			vr41xx_set_irq_trigger(GD82559_2_PIN, TRIGGER_LEVEL,
+			                       SIGNAL_THROUGH);
+			vr41xx_set_irq_level(GD82559_2_PIN, LEVEL_LOW);
+			dev->irq = GD82559_2_IRQ;
+			break;
+		case 14:
+			pci_read_config_byte(dev, PCI_INTERRUPT_PIN, &pin);
+			switch (pin) {
+			case 1:
+				vr41xx_set_irq_trigger(UPD720100_INTA_PIN,
+				                       TRIGGER_LEVEL,
+				                       SIGNAL_THROUGH);
+				vr41xx_set_irq_level(UPD720100_INTA_PIN, LEVEL_LOW);
+				dev->irq = UPD720100_INTA_IRQ;
+				break;
+			case 2:
+				vr41xx_set_irq_trigger(UPD720100_INTB_PIN,
+				                       TRIGGER_LEVEL,
+				                       SIGNAL_THROUGH);
+				vr41xx_set_irq_level(UPD720100_INTB_PIN, LEVEL_LOW);
+				dev->irq = UPD720100_INTB_IRQ;
+				break;
+			case 3:
+				vr41xx_set_irq_trigger(UPD720100_INTC_PIN,
+				                       TRIGGER_LEVEL,
+				                       SIGNAL_THROUGH);
+				vr41xx_set_irq_level(UPD720100_INTC_PIN, LEVEL_LOW);
+				dev->irq = UPD720100_INTC_IRQ;
+				break;
+			}
+			break;
+		}
+
+		pci_write_config_byte(dev, PCI_INTERRUPT_LINE, dev->irq);
+	}
+}
+
+unsigned int pcibios_assign_all_busses(void)
+{
+	return 0;
+}
diff -aruN --exclude=CVS --exclude=.cvsignore linux.orig/arch/mips/vr41xx/tanbac-tb0226/setup.c linux/arch/mips/vr41xx/tanbac-tb0226/setup.c
--- linux.orig/arch/mips/vr41xx/tanbac-tb0226/setup.c	Thu Jan  1 09:00:00 1970
+++ linux/arch/mips/vr41xx/tanbac-tb0226/setup.c	Mon Feb 10 19:17:41 2003
@@ -0,0 +1,113 @@
+/*
+ * FILE NAME
+ *	arch/mips/vr41xx/tanbac-tb0226/setup.c
+ *
+ * BRIEF MODULE DESCRIPTION
+ *	Setup for the TANBAC TB0226.
+ *
+ * Copyright 2002,2003 Yoichi Yuasa
+ *                yuasa@hh.iij4u.or.jp
+ *
+ *  This program is free software; you can redistribute it and/or modify it
+ *  under the terms of the GNU General Public License as published by the
+ *  Free Software Foundation; either version 2 of the License, or (at your
+ *  option) any later version.
+ */
+#include <linux/config.h>
+#include <linux/init.h>
+#include <linux/console.h>
+#include <linux/ide.h>
+#include <linux/ioport.h>
+
+#include <asm/pci_channel.h>
+#include <asm/reboot.h>
+#include <asm/time.h>
+#include <asm/vr41xx/tb0226.h>
+
+#ifdef CONFIG_BLK_DEV_INITRD
+extern unsigned long initrd_start, initrd_end;
+extern void * __rd_start, * __rd_end;
+#endif
+
+#ifdef CONFIG_PCI
+static struct resource vr41xx_pci_io_resource = {
+	"PCI I/O space",
+	VR41XX_PCI_IO_START,
+	VR41XX_PCI_IO_END,
+	IORESOURCE_IO
+};
+
+static struct resource vr41xx_pci_mem_resource = {
+	"PCI memory space",
+	VR41XX_PCI_MEM_START,
+	VR41XX_PCI_MEM_END,
+	IORESOURCE_MEM
+};
+
+extern struct pci_ops vr41xx_pci_ops;
+
+struct pci_channel mips_pci_channels[] = {
+	{&vr41xx_pci_ops, &vr41xx_pci_io_resource, &vr41xx_pci_mem_resource, 0, 256},
+	{NULL, NULL, NULL, 0, 0}
+};
+
+struct vr41xx_pci_address_space vr41xx_pci_mem1 = {
+	VR41XX_PCI_MEM1_BASE,
+	VR41XX_PCI_MEM1_MASK,
+	IO_MEM1_RESOURCE_START
+};
+
+struct vr41xx_pci_address_space vr41xx_pci_mem2 = {
+	VR41XX_PCI_MEM2_BASE,
+	VR41XX_PCI_MEM2_MASK,
+	IO_MEM2_RESOURCE_START
+};
+
+struct vr41xx_pci_address_space vr41xx_pci_io = {
+	VR41XX_PCI_IO_BASE,
+	VR41XX_PCI_IO_MASK,
+	IO_PORT_RESOURCE_START
+};
+
+static struct vr41xx_pci_address_map pci_address_map = {
+	&vr41xx_pci_mem1,
+	&vr41xx_pci_mem2,
+	&vr41xx_pci_io
+};
+#endif
+
+void __init tanbac_tb0226_setup(void)
+{
+	set_io_port_base(IO_PORT_BASE);
+	ioport_resource.start = IO_PORT_RESOURCE_START;
+	ioport_resource.end = IO_PORT_RESOURCE_END;
+	iomem_resource.start = IO_MEM1_RESOURCE_START;
+	iomem_resource.end = IO_MEM2_RESOURCE_END;
+
+#ifdef CONFIG_BLK_DEV_INITRD
+	ROOT_DEV = MKDEV(RAMDISK_MAJOR, 0);
+	initrd_start = (unsigned long)&__rd_start;
+	initrd_end = (unsigned long)&__rd_end;
+#endif
+
+	_machine_restart = vr41xx_restart;
+	_machine_halt = vr41xx_halt;
+	_machine_power_off = vr41xx_power_off;
+
+	board_time_init = vr41xx_time_init;
+	board_timer_setup = vr41xx_timer_setup;
+
+#ifdef CONFIG_FB
+	conswitchp = &dummy_con;
+#endif
+
+	vr41xx_bcu_init();
+
+	vr41xx_cmu_init(0);
+
+	vr41xx_siu_init(SIU_RS232C, 0);
+
+#ifdef CONFIG_PCI
+	vr41xx_pciu_init(&pci_address_map);
+#endif
+}
diff -aruN --exclude=CVS --exclude=.cvsignore linux.orig/include/asm-mips/bootinfo.h linux/include/asm-mips/bootinfo.h
--- linux.orig/include/asm-mips/bootinfo.h	Wed Jan 29 10:30:13 2003
+++ linux/include/asm-mips/bootinfo.h	Mon Feb 10 19:17:41 2003
@@ -176,6 +176,7 @@
 #define MACH_VICTOR_MPC30X	3	/* Victor MP-C303/304 */
 #define MACH_IBM_WORKPAD	4	/* IBM WorkPad z50 */
 #define MACH_CASIO_E55		5	/* CASIO CASSIOPEIA E-10/15/55/65 */
+#define MACH_TANBAC_TB0226	6	/* TANBAC TB0226 (Mbase) */
 
 #define CL_SIZE			(256)
 
diff -aruN --exclude=CVS --exclude=.cvsignore linux.orig/include/asm-mips/vr41xx/tb0226.h linux/include/asm-mips/vr41xx/tb0226.h
--- linux.orig/include/asm-mips/vr41xx/tb0226.h	Thu Jan  1 09:00:00 1970
+++ linux/include/asm-mips/vr41xx/tb0226.h	Mon Feb 10 19:17:41 2003
@@ -0,0 +1,69 @@
+/*
+ * FILE NAME
+ *	include/asm-mips/vr41xx/tb0226.h
+ *
+ * BRIEF MODULE DESCRIPTION
+ *	Include file for TANBAC TB0226.
+ *
+ * Copyright 2002,2003 Yoichi Yuasa
+ *                yuasa@hh.iij4u.or.jp
+ *
+ *  This program is free software; you can redistribute it and/or modify it
+ *  under the terms of the GNU General Public License as published by the
+ *  Free Software Foundation; either version 2 of the License, or (at your
+ *  option) any later version.
+ */
+#ifndef __TANBAC_TB0226_H
+#define __TANBAC_TB0226_H
+
+#include <asm/addrspace.h>
+#include <asm/vr41xx/vr41xx.h>
+
+/*
+ * Board specific address mapping
+ */
+#define VR41XX_PCI_MEM1_BASE		0x10000000
+#define VR41XX_PCI_MEM1_SIZE		0x04000000
+#define VR41XX_PCI_MEM1_MASK		0x7c000000
+
+#define VR41XX_PCI_MEM2_BASE		0x14000000
+#define VR41XX_PCI_MEM2_SIZE		0x02000000
+#define VR41XX_PCI_MEM2_MASK		0x7e000000
+
+#define VR41XX_PCI_IO_BASE		0x16000000
+#define VR41XX_PCI_IO_SIZE		0x02000000
+#define VR41XX_PCI_IO_MASK		0x7e000000
+
+#define VR41XX_PCI_IO_START		0x01000000
+#define VR41XX_PCI_IO_END		0x01ffffff
+
+#define VR41XX_PCI_MEM_START		0x12000000
+#define VR41XX_PCI_MEM_END		0x15ffffff
+
+#define IO_PORT_BASE			KSEG1ADDR(VR41XX_PCI_IO_BASE)
+#define IO_PORT_RESOURCE_START		0
+#define IO_PORT_RESOURCE_END		VR41XX_PCI_IO_SIZE
+#define IO_MEM1_RESOURCE_START		VR41XX_PCI_MEM1_BASE
+#define IO_MEM1_RESOURCE_END		(VR41XX_PCI_MEM1_BASE + VR41XX_PCI_MEM1_SIZE)
+#define IO_MEM2_RESOURCE_START		VR41XX_PCI_MEM2_BASE
+#define IO_MEM2_RESOURCE_END		(VR41XX_PCI_MEM2_BASE + VR41XX_PCI_MEM2_SIZE)
+
+/*
+ * General-Purpose I/O Pin Number
+ */
+#define GD82559_1_PIN			2
+#define GD82559_2_PIN			3
+#define UPD720100_INTA_PIN		4
+#define UPD720100_INTB_PIN		8
+#define UPD720100_INTC_PIN		13
+
+/*
+ * Interrupt Number
+ */
+#define GD82559_1_IRQ			GIU_IRQ(GD82559_1_PIN)
+#define GD82559_2_IRQ			GIU_IRQ(GD82559_2_PIN)
+#define UPD720100_INTA_IRQ		GIU_IRQ(UPD720100_INTA_PIN)
+#define UPD720100_INTB_IRQ		GIU_IRQ(UPD720100_INTB_PIN)
+#define UPD720100_INTC_IRQ		GIU_IRQ(UPD720100_INTC_PIN)
+
+#endif /* __TANBAC_TB0226_H */

--Multipart_Mon__10_Feb_2003_19:56:13_+0900_08239930--
