Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 26 Jul 2008 09:21:19 +0100 (BST)
Received: from wf-out-1314.google.com ([209.85.200.175]:46904 "EHLO
	wf-out-1314.google.com") by ftp.linux-mips.org with ESMTP
	id S28583539AbYGZIVK (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Sat, 26 Jul 2008 09:21:10 +0100
Received: by wf-out-1314.google.com with SMTP id 27so3566120wfd.21
        for <linux-mips@linux-mips.org>; Sat, 26 Jul 2008 01:21:07 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:sender
         :to:subject:cc:mime-version:content-type:content-transfer-encoding
         :content-disposition:x-google-sender-auth;
        bh=WPe5i9yXHBgqRNMiBflrYVruSm6gpQa9viBbjlwR0RY=;
        b=aNySmUvbzEUKphjTZ2xn0GaYSnGuxPMo1+pvodOgURmh2R8g0aYbMH7CbT6yIxdbYq
         rTcZ8Zi7pLIqh0hyBjeHTvAem2dphu8aQZAbY+VCsuKf2zz3zwTIoy2FDoZ+DzF75AAL
         C9O1/8nnFpWOBwcXHqAxiW6Jtl/jDRIP4/T/I=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=message-id:date:from:sender:to:subject:cc:mime-version:content-type
         :content-transfer-encoding:content-disposition:x-google-sender-auth;
        b=bReiZgrlf7yNC4dwc+IWI+lR59DnOX7AQgaO+U5DsOHfocuhM0PmIZgmEfWdpav6MI
         sIYzV3ZvcTUSker2yQ7ZvKBjSBGwRD0Mrv9OAVxmNUjdQSWAhXwnIeosJeNB0Sltyiub
         aGcsulRyBmtA1AJy+uT8X1CJDietdujT6JzwU=
Received: by 10.142.226.2 with SMTP id y2mr849953wfg.80.1217060467507;
        Sat, 26 Jul 2008 01:21:07 -0700 (PDT)
Received: by 10.142.49.17 with HTTP; Sat, 26 Jul 2008 01:21:07 -0700 (PDT)
Message-ID: <64660ef00807260121g65517381m5e3af76fe2b58642@mail.gmail.com>
Date:	Sat, 26 Jul 2008 09:21:07 +0100
From:	"Daniel Laird" <daniel.j.laird@nxp.com>
To:	"Ralf Baechle" <ralf@linux-mips.org>
Subject: [PATCH] minor update to the upstream-apkm tree to get pnx833x booting
Cc:	linux-mips@linux-mips.org
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
X-Google-Sender-Auth: de4d5fa208d70f89
Return-Path: <daniel.j.laird@googlemail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 19976
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: daniel.j.laird@nxp.com
Precedence: bulk
X-list: linux-mips

Life at last.... This patch updates the upstream-akpm stream to get
the pnx833x actually building / booting.
All runs well now.  Default Config file has been updated as well.

 Kconfig                          |    1
 configs/pnx8335-stb225_defconfig |   96 ++++++++++++++++++---------------------
 nxp/pnx833x/common/platform.c    |   11 ++++
 3 files changed, 56 insertions(+), 52 deletions(-)

Signed-off-by: Daniel Laird <daniel.j.laird@nxp.com>

diff -urN upstream-akpm.orig/arch/mips/configs/pnx8335-stb225_defconfig
upstream-akpm.updated/arch/mips/configs/pnx8335-stb225_defconfig
--- upstream-akpm.orig/arch/mips/configs/pnx8335-stb225_defconfig	2008-07-23
16:14:02.000000000 +0100
+++ upstream-akpm.updated/arch/mips/configs/pnx8335-stb225_defconfig	2008-07-26
09:17:08.000000000 +0100
@@ -1,7 +1,7 @@
 #
 # Automatically generated make config: don't edit
-# Linux kernel version: 2.6.26-rc4
-# Mon Jun 16 13:21:29 2008
+# Linux kernel version: 2.6.26
+# Sat Jul 26 09:02:59 2008
 #
 CONFIG_MIPS=y

@@ -16,9 +16,7 @@
 # CONFIG_MACH_JAZZ is not set
 # CONFIG_LASAT is not set
 # CONFIG_LEMOTE_FULONG is not set
-# CONFIG_MIPS_ATLAS is not set
 # CONFIG_MIPS_MALTA is not set
-# CONFIG_MIPS_SEAD is not set
 # CONFIG_MIPS_SIM is not set
 # CONFIG_MARKEINS is not set
 # CONFIG_MACH_VR41XX is not set
@@ -41,9 +39,8 @@
 # CONFIG_SIBYTE_SENTOSA is not set
 # CONFIG_SIBYTE_BIGSUR is not set
 # CONFIG_SNI_RM is not set
-# CONFIG_TOSHIBA_JMR3927 is not set
-# CONFIG_TOSHIBA_RBTX4927 is not set
-# CONFIG_TOSHIBA_RBTX4938 is not set
+# CONFIG_MACH_TX39XX is not set
+# CONFIG_MACH_TX49XX is not set
 # CONFIG_WR_PPMC is not set
 CONFIG_RWSEM_GENERIC_SPINLOCK=y
 # CONFIG_ARCH_HAS_ILOG2_U32 is not set
@@ -61,8 +58,6 @@
 CONFIG_CSRC_R4K=y
 CONFIG_DMA_NONCOHERENT=y
 CONFIG_DMA_NEED_PCI_MAP_STATE=y
-CONFIG_EARLY_PRINTK=y
-CONFIG_SYS_HAS_EARLY_PRINTK=y
 # CONFIG_HOTPLUG_CPU is not set
 # CONFIG_NO_IOPORT is not set
 CONFIG_GENERIC_GPIO=y
@@ -215,6 +210,7 @@
 # CONFIG_HAVE_KPROBES is not set
 # CONFIG_HAVE_KRETPROBES is not set
 # CONFIG_HAVE_DMA_ATTRS is not set
+# CONFIG_USE_GENERIC_SMP_HELPERS is not set
 CONFIG_PROC_PAGE_MONITOR=y
 CONFIG_SLABINFO=y
 CONFIG_RT_MUTEXES=y
@@ -232,6 +228,7 @@
 # CONFIG_BLK_DEV_IO_TRACE is not set
 # CONFIG_LSF is not set
 # CONFIG_BLK_DEV_BSG is not set
+# CONFIG_BLK_DEV_INTEGRITY is not set

 #
 # IO Schedulers
@@ -366,6 +363,8 @@
 CONFIG_STANDALONE=y
 CONFIG_PREVENT_FIRMWARE_BUILD=y
 CONFIG_FW_LOADER=y
+CONFIG_FIRMWARE_IN_KERNEL=y
+CONFIG_EXTRA_FIRMWARE=""
 # CONFIG_SYS_HYPERVISOR is not set
 # CONFIG_CONNECTOR is not set
 CONFIG_MTD=y
@@ -459,6 +458,7 @@
 # CONFIG_BLK_DEV_RAM is not set
 # CONFIG_CDROM_PKTCDVD is not set
 # CONFIG_ATA_OVER_ETH is not set
+# CONFIG_BLK_DEV_HD is not set
 # CONFIG_MISC_DEVICES is not set
 CONFIG_HAVE_IDE=y
 # CONFIG_IDE is not set
@@ -501,6 +501,7 @@
 # CONFIG_SCSI_SAS_LIBSAS is not set
 # CONFIG_SCSI_SRP_ATTRS is not set
 # CONFIG_SCSI_LOWLEVEL is not set
+# CONFIG_SCSI_DH is not set
 CONFIG_ATA=y
 # CONFIG_ATA_NONSTANDARD is not set
 CONFIG_SATA_PMP=y
@@ -509,7 +510,6 @@
 # CONFIG_PATA_PLATFORM is not set
 # CONFIG_MD is not set
 CONFIG_NETDEVICES=y
-# CONFIG_NETDEVICES_MULTIQUEUE is not set
 # CONFIG_DUMMY is not set
 # CONFIG_BONDING is not set
 # CONFIG_MACVLAN is not set
@@ -526,7 +526,6 @@
 # CONFIG_IBM_NEW_EMAC_TAH is not set
 # CONFIG_IBM_NEW_EMAC_EMAC4 is not set
 # CONFIG_B44 is not set
-# CONFIG_IP3902 is not set
 # CONFIG_NETDEV_1000 is not set
 # CONFIG_NETDEV_10000 is not set

@@ -584,6 +583,7 @@
 # Character devices
 #
 CONFIG_VT=y
+CONFIG_CONSOLE_TRANSLATIONS=y
 # CONFIG_VT_CONSOLE is not set
 CONFIG_HW_CONSOLE=y
 # CONFIG_VT_HW_CONSOLE_BINDING is not set
@@ -612,27 +612,39 @@
 CONFIG_I2C=y
 CONFIG_I2C_BOARDINFO=y
 CONFIG_I2C_CHARDEV=y
-CONFIG_I2C_ALGOPCA=y

 #
 # I2C Hardware Bus support
 #
+
+#
+# I2C system bus drivers (mostly embedded / system-on-chip)
+#
 # CONFIG_I2C_GPIO is not set
 # CONFIG_I2C_OCORES is not set
-# CONFIG_I2C_PARPORT_LIGHT is not set
 # CONFIG_I2C_SIMTEC is not set
+
+#
+# External I2C/SMBus adapter drivers
+#
+# CONFIG_I2C_PARPORT_LIGHT is not set
 # CONFIG_I2C_TAOS_EVM is not set
-# CONFIG_I2C_STUB is not set
+
+#
+# Other I2C/SMBus bus drivers
+#
 # CONFIG_I2C_PCA_PLATFORM is not set
-CONFIG_I2C_PNX0105=y
+# CONFIG_I2C_STUB is not set

 #
 # Miscellaneous I2C Chip support
 #
 # CONFIG_DS1682 is not set
+# CONFIG_AT24 is not set
 # CONFIG_SENSORS_EEPROM is not set
 # CONFIG_SENSORS_PCF8574 is not set
 # CONFIG_PCF8575 is not set
+# CONFIG_SENSORS_PCA9539 is not set
 # CONFIG_SENSORS_PCF8591 is not set
 # CONFIG_SENSORS_MAX6875 is not set
 # CONFIG_SENSORS_TSL2550 is not set
@@ -645,6 +657,7 @@
 # CONFIG_POWER_SUPPLY is not set
 # CONFIG_HWMON is not set
 # CONFIG_THERMAL is not set
+# CONFIG_THERMAL_HWMON is not set
 # CONFIG_WATCHDOG is not set

 #
@@ -656,6 +669,7 @@
 #
 # Multifunction device drivers
 #
+# CONFIG_MFD_CORE is not set
 # CONFIG_MFD_SM501 is not set
 # CONFIG_HTC_PASIC3 is not set

@@ -719,6 +733,7 @@
 # CONFIG_DVB_SP887X is not set
 # CONFIG_DVB_CX22700 is not set
 # CONFIG_DVB_CX22702 is not set
+# CONFIG_DVB_DRX397XD is not set
 # CONFIG_DVB_L64781 is not set
 CONFIG_DVB_TDA1004X=y
 # CONFIG_DVB_NXT6000 is not set
@@ -806,15 +821,7 @@
 CONFIG_DUMMY_CONSOLE=y
 # CONFIG_FRAMEBUFFER_CONSOLE is not set
 # CONFIG_LOGO is not set
-
-#
-# Sound
-#
 CONFIG_SOUND=m
-
-#
-# Advanced Linux Sound Architecture
-#
 CONFIG_SND=m
 CONFIG_SND_TIMER=m
 CONFIG_SND_PCM=m
@@ -830,38 +837,16 @@
 CONFIG_SND_VERBOSE_PROCFS=y
 CONFIG_SND_VERBOSE_PRINTK=y
 CONFIG_SND_DEBUG=y
-CONFIG_SND_DEBUG_DETECT=y
+# CONFIG_SND_DEBUG_VERBOSE is not set
 # CONFIG_SND_PCM_XRUN_DEBUG is not set
-
-#
-# Generic devices
-#
+CONFIG_SND_DRIVERS=y
 # CONFIG_SND_DUMMY is not set
 # CONFIG_SND_VIRMIDI is not set
 # CONFIG_SND_MTPAV is not set
 # CONFIG_SND_SERIAL_U16550 is not set
 # CONFIG_SND_MPU401 is not set
-
-#
-# ALSA MIPS devices
-#
-
-#
-# System on Chip audio support
-#
+CONFIG_SND_MIPS=y
 # CONFIG_SND_SOC is not set
-
-#
-# ALSA SoC audio for Freescale SOCs
-#
-
-#
-# SoC Audio for the Texas Instruments OMAP
-#
-
-#
-# Open Sound System
-#
 # CONFIG_SOUND_PRIME is not set
 CONFIG_HID_SUPPORT=y
 CONFIG_HID=y
@@ -884,6 +869,7 @@
 # CONFIG_ACCESSIBILITY is not set
 CONFIG_RTC_LIB=y
 # CONFIG_RTC_CLASS is not set
+# CONFIG_DMADEVICES is not set
 # CONFIG_UIO is not set

 #
@@ -969,17 +955,16 @@
 CONFIG_NFS_V3=y
 # CONFIG_NFS_V3_ACL is not set
 # CONFIG_NFS_V4 is not set
+CONFIG_ROOT_NFS=y
 CONFIG_NFSD=m
 CONFIG_NFSD_V3=y
 # CONFIG_NFSD_V3_ACL is not set
 # CONFIG_NFSD_V4 is not set
-CONFIG_ROOT_NFS=y
 CONFIG_LOCKD=y
 CONFIG_LOCKD_V4=y
 CONFIG_EXPORTFS=m
 CONFIG_NFS_COMMON=y
 CONFIG_SUNRPC=y
-# CONFIG_SUNRPC_BIND34 is not set
 # CONFIG_RPCSEC_GSS_KRB5 is not set
 # CONFIG_RPCSEC_GSS_SPKM3 is not set
 # CONFIG_SMB_FS is not set
@@ -1049,6 +1034,7 @@
 # CONFIG_HEADERS_CHECK is not set
 # CONFIG_DEBUG_KERNEL is not set
 # CONFIG_SAMPLES is not set
+# CONFIG_KERNEL_TESTS is not set
 CONFIG_CMDLINE=""

 #
@@ -1102,6 +1088,10 @@
 # CONFIG_CRYPTO_MD4 is not set
 CONFIG_CRYPTO_MD5=y
 # CONFIG_CRYPTO_MICHAEL_MIC is not set
+# CONFIG_CRYPTO_RMD128 is not set
+# CONFIG_CRYPTO_RMD160 is not set
+# CONFIG_CRYPTO_RMD256 is not set
+# CONFIG_CRYPTO_RMD320 is not set
 CONFIG_CRYPTO_SHA1=y
 # CONFIG_CRYPTO_SHA256 is not set
 # CONFIG_CRYPTO_SHA512 is not set
@@ -1132,6 +1122,11 @@
 #
 # CONFIG_CRYPTO_DEFLATE is not set
 # CONFIG_CRYPTO_LZO is not set
+
+#
+# Random Number Generation
+#
+# CONFIG_CRYPTO_PRNG is not set
 CONFIG_CRYPTO_HW=y

 #
@@ -1141,6 +1136,7 @@
 # CONFIG_GENERIC_FIND_FIRST_BIT is not set
 # CONFIG_CRC_CCITT is not set
 # CONFIG_CRC16 is not set
+# CONFIG_CRC_T10DIF is not set
 # CONFIG_CRC_ITU_T is not set
 CONFIG_CRC32=y
 # CONFIG_CRC7 is not set
diff -urN upstream-akpm.orig/arch/mips/Kconfig
upstream-akpm.updated/arch/mips/Kconfig
--- upstream-akpm.orig/arch/mips/Kconfig	2008-07-23 16:14:02.000000000 +0100
+++ upstream-akpm.updated/arch/mips/Kconfig	2008-07-26 09:02:52.000000000 +0100
@@ -857,7 +857,6 @@
 	select CSRC_R4K
 	select IRQ_CPU
 	select DMA_NONCOHERENT
-	select SYS_HAS_EARLY_PRINTK
 	select SYS_HAS_CPU_MIPS32_R2
 	select SYS_SUPPORTS_32BIT_KERNEL
 	select SYS_SUPPORTS_LITTLE_ENDIAN
diff -urN upstream-akpm.orig/arch/mips/nxp/pnx833x/common/platform.c
upstream-akpm.updated/arch/mips/nxp/pnx833x/common/platform.c
--- upstream-akpm.orig/arch/mips/nxp/pnx833x/common/platform.c	2008-07-23
16:14:02.000000000 +0100
+++ upstream-akpm.updated/arch/mips/nxp/pnx833x/common/platform.c	2008-07-25
15:20:03.000000000 +0100
@@ -29,9 +29,14 @@
 #include <linux/resource.h>
 #include <linux/serial.h>
 #include <linux/serial_pnx8xxx.h>
-#include <linux/i2c-pnx0105.h>
 #include <linux/mtd/nand.h>
 #include <linux/mtd/partitions.h>
+#include <linux/dma-mapping.h>
+
+#ifdef CONFIG_I2C_PNX0105
+/* Until i2c driver available in kernel.*/
+#include <linux/i2c-pnx0105.h>
+#endif

 #include <irq.h>
 #include <irq-mapping.h>
@@ -129,6 +134,7 @@
 	.resource	= pnx833x_usb_ehci_resources,
 };

+#ifdef CONFIG_I2C_PNX0105
 static struct resource pnx833x_i2c0_resources[] = {
 	{
 		.start		= PNX833X_I2C0_PORTS_START,
@@ -190,6 +196,7 @@
 	.num_resources  = ARRAY_SIZE(pnx833x_i2c1_resources),
 	.resource	= pnx833x_i2c1_resources,
 };
+#endif

 static u64 ethernet_dmamask = DMA_32BIT_MASK;

@@ -290,8 +297,10 @@
 static struct platform_device *pnx833x_platform_devices[] __initdata = {
 	&pnx833x_uart_device,
 	&pnx833x_usb_ehci_device,
+#ifdef CONFIG_I2C_PNX0105
 	&pnx833x_i2c0_device,
 	&pnx833x_i2c1_device,
+#endif
 	&pnx833x_ethernet_device,
 	&pnx833x_sata_device,
 	&pnx833x_flash_nand,
