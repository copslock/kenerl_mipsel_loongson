Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 24 Jul 2012 23:43:52 +0200 (CEST)
Received: from home.bethel-hill.org ([63.228.164.32]:49883 "EHLO
        home.bethel-hill.org" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S1903782Ab2GXVkp (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 24 Jul 2012 23:40:45 +0200
Received: by home.bethel-hill.org with esmtpsa (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
        (Exim 4.72)
        (envelope-from <sjhill@mips.com>)
        id 1StmqN-0003yX-7v; Tue, 24 Jul 2012 16:40:39 -0500
From:   "Steven J. Hill" <sjhill@mips.com>
To:     linux-mips@linux-mips.org
Cc:     "Steven J. Hill" <sjhill@mips.com>, ralf@linux-mips.org
Subject: [PATCH v3,02/10] MIPS: Changes to configuration files for SEAD-3 platform.
Date:   Tue, 24 Jul 2012 16:40:34 -0500
Message-Id: <1343166034-1895-1-git-send-email-sjhill@mips.com>
X-Mailer: git-send-email 1.7.11.1
X-archive-position: 33980
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sjhill@mips.com
Precedence: bulk
List-help: <mailto:ecartis@linux-mips.org?Subject=help>
List-unsubscribe: <mailto:ecartis@linux-mips.org?subject=unsubscribe%20linux-mips>
List-software: Ecartis version 1.0.0
List-Id: linux-mips <linux-mips.eddie.linux-mips.org>
X-List-ID: linux-mips <linux-mips.eddie.linux-mips.org>
List-subscribe: <mailto:ecartis@linux-mips.org?subject=subscribe%20linux-mips>
List-owner: <mailto:ralf@linux-mips.org>
List-post: <mailto:linux-mips@linux-mips.org>
List-archive: <http://www.linux-mips.org/archives/linux-mips/>
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>

From: "Steven J. Hill" <sjhill@mips.com>

Change MIPS configuration files to add the SEAD-3. Also add
new default configuration file for a SEAD-3 kernel.

Signed-off-by: Steven J. Hill <sjhill@mips.com>
---
 arch/mips/Kbuild.platforms        |   1 +
 arch/mips/Kconfig                 |  33 +++++++++-
 arch/mips/configs/sead3_defconfig | 124 ++++++++++++++++++++++++++++++++++++++
 3 files changed, 155 insertions(+), 3 deletions(-)
 create mode 100644 arch/mips/configs/sead3_defconfig

diff --git a/arch/mips/Kbuild.platforms b/arch/mips/Kbuild.platforms
index 5ce8029..84a3a81 100644
--- a/arch/mips/Kbuild.platforms
+++ b/arch/mips/Kbuild.platforms
@@ -16,6 +16,7 @@ platforms += lasat
 platforms += loongson
 platforms += mipssim
 platforms += mti-malta
+platforms += mti-sead3
 platforms += netlogic
 platforms += pmc-sierra
 platforms += pnx833x
diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index 437b2cb..78fdba4 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -304,6 +304,35 @@ config MIPS_MALTA
 	  This enables support for the MIPS Technologies Malta evaluation
 	  board.
 
+config MIPS_SEAD3
+	bool "MIPS SEAD3 board"
+	select BOOT_ELF32
+	select BOOT_RAW
+	select CEVT_R4K
+	select DMA_NONCOHERENT
+	select IRQ_CPU
+	select IRQ_GIC
+	select MIPS_BOARDS_GEN
+	select MIPS_CPU_SCACHE
+	select MIPS_MSC
+	select SYS_HAS_CPU_MIPS32_R1
+	select SYS_HAS_CPU_MIPS32_R2
+	select SYS_HAS_CPU_MIPS64_R1
+	select SYS_HAS_EARLY_PRINTK
+	select SYS_SUPPORTS_32BIT_KERNEL
+	select SYS_SUPPORTS_64BIT_KERNEL
+	select SYS_SUPPORTS_BIG_ENDIAN
+	select SYS_SUPPORTS_LITTLE_ENDIAN
+	select SYS_SUPPORTS_MULTITHREADING
+	select SYS_SUPPORTS_SMARTMIPS
+	select SYS_SUPPORTS_MICROMIPS
+	select USB_ARCH_HAS_EHCI
+	select USB_EHCI_BIG_ENDIAN_DESC
+	select USB_EHCI_BIG_ENDIAN_MMIO
+	help
+	  This enables support for the MIPS Technologies SEAD3 evaluation
+	  board.
+
 config MIPS_SIM
 	bool 'MIPS simulator (MIPSsim)'
 	select CEVT_R4K
@@ -1711,7 +1740,6 @@ config HARDWARE_WATCHPOINTS
 menu "Kernel type"
 
 choice
-
 	prompt "Kernel code model"
 	help
 	  You should only select this option if you have a workload that
@@ -1855,7 +1883,7 @@ config MIPS_MT_DISABLED
 
 config MIPS_MT_SMP
 	bool "Use 1 TC on each available VPE for SMP"
-	depends on SYS_SUPPORTS_MULTITHREADING
+	depends on SYS_SUPPORTS_MULTITHREADING && !MIPS_SEAD3
 	select CPU_MIPSR2_IRQ_VI
 	select CPU_MIPSR2_IRQ_EI
 	select MIPS_MT
@@ -1919,7 +1947,6 @@ config SCHED_SMT
 config SYS_SUPPORTS_SCHED_SMT
 	bool
 
-
 config SYS_SUPPORTS_MULTITHREADING
 	bool
 
diff --git a/arch/mips/configs/sead3_defconfig b/arch/mips/configs/sead3_defconfig
new file mode 100644
index 0000000..e3eec68
--- /dev/null
+++ b/arch/mips/configs/sead3_defconfig
@@ -0,0 +1,124 @@
+CONFIG_MIPS_SEAD3=y
+CONFIG_CPU_LITTLE_ENDIAN=y
+CONFIG_CPU_MIPS32_R2=y
+CONFIG_HZ_100=y
+CONFIG_EXPERIMENTAL=y
+CONFIG_SYSVIPC=y
+CONFIG_POSIX_MQUEUE=y
+CONFIG_NO_HZ=y
+CONFIG_HIGH_RES_TIMERS=y
+CONFIG_IKCONFIG=y
+CONFIG_IKCONFIG_PROC=y
+CONFIG_LOG_BUF_SHIFT=15
+CONFIG_EMBEDDED=y
+CONFIG_SLAB=y
+CONFIG_PROFILING=y
+CONFIG_OPROFILE=y
+CONFIG_MODULES=y
+# CONFIG_BLK_DEV_BSG is not set
+# CONFIG_CORE_DUMP_DEFAULT_ELF_HEADERS is not set
+CONFIG_NET=y
+CONFIG_PACKET=y
+CONFIG_UNIX=y
+CONFIG_INET=y
+CONFIG_IP_PNP=y
+CONFIG_IP_PNP_DHCP=y
+CONFIG_IP_PNP_BOOTP=y
+# CONFIG_INET_XFRM_MODE_TRANSPORT is not set
+# CONFIG_INET_XFRM_MODE_TUNNEL is not set
+# CONFIG_INET_XFRM_MODE_BEET is not set
+# CONFIG_INET_LRO is not set
+# CONFIG_INET_DIAG is not set
+# CONFIG_IPV6 is not set
+# CONFIG_WIRELESS is not set
+CONFIG_UEVENT_HELPER_PATH="/sbin/hotplug"
+CONFIG_MTD=y
+CONFIG_MTD_CHAR=y
+CONFIG_MTD_BLOCK=y
+CONFIG_MTD_CFI=y
+CONFIG_MTD_CFI_INTELEXT=y
+CONFIG_MTD_PHYSMAP=y
+CONFIG_MTD_UBI=y
+CONFIG_MTD_UBI_GLUEBI=y
+CONFIG_BLK_DEV_LOOP=y
+CONFIG_BLK_DEV_CRYPTOLOOP=m
+CONFIG_SCSI=y
+# CONFIG_SCSI_PROC_FS is not set
+CONFIG_BLK_DEV_SD=y
+CONFIG_CHR_DEV_SG=y
+# CONFIG_SCSI_LOWLEVEL is not set
+CONFIG_NETDEVICES=y
+CONFIG_SMSC911X=y
+# CONFIG_NET_VENDOR_WIZNET is not set
+CONFIG_MARVELL_PHY=y
+CONFIG_DAVICOM_PHY=y
+CONFIG_QSEMI_PHY=y
+CONFIG_LXT_PHY=y
+CONFIG_CICADA_PHY=y
+CONFIG_VITESSE_PHY=y
+CONFIG_SMSC_PHY=y
+CONFIG_BROADCOM_PHY=y
+CONFIG_ICPLUS_PHY=y
+# CONFIG_WLAN is not set
+# CONFIG_INPUT_MOUSEDEV is not set
+# CONFIG_INPUT_KEYBOARD is not set
+# CONFIG_INPUT_MOUSE is not set
+# CONFIG_SERIO is not set
+# CONFIG_CONSOLE_TRANSLATIONS is not set
+CONFIG_VT_HW_CONSOLE_BINDING=y
+CONFIG_LEGACY_PTY_COUNT=32
+CONFIG_SERIAL_8250=y
+CONFIG_SERIAL_8250_CONSOLE=y
+CONFIG_SERIAL_8250_NR_UARTS=2
+CONFIG_SERIAL_8250_RUNTIME_UARTS=2
+# CONFIG_HW_RANDOM is not set
+CONFIG_I2C=y
+# CONFIG_I2C_COMPAT is not set
+CONFIG_I2C_CHARDEV=y
+# CONFIG_I2C_HELPER_AUTO is not set
+CONFIG_SPI=y
+CONFIG_SENSORS_ADT7475=y
+CONFIG_BACKLIGHT_LCD_SUPPORT=y
+CONFIG_LCD_CLASS_DEVICE=y
+CONFIG_BACKLIGHT_CLASS_DEVICE=y
+# CONFIG_VGA_CONSOLE is not set
+CONFIG_USB=y
+CONFIG_USB_ANNOUNCE_NEW_DEVICES=y
+CONFIG_USB_EHCI_HCD=y
+CONFIG_USB_EHCI_ROOT_HUB_TT=y
+CONFIG_USB_STORAGE=y
+CONFIG_MMC=y
+CONFIG_MMC_DEBUG=y
+CONFIG_MMC_SPI=y
+CONFIG_NEW_LEDS=y
+CONFIG_LEDS_CLASS=y
+CONFIG_LEDS_TRIGGERS=y
+CONFIG_LEDS_TRIGGER_HEARTBEAT=y
+CONFIG_RTC_CLASS=y
+CONFIG_RTC_DRV_M41T80=y
+CONFIG_EXT3_FS=y
+# CONFIG_EXT3_DEFAULTS_TO_ORDERED is not set
+CONFIG_XFS_FS=y
+CONFIG_XFS_QUOTA=y
+CONFIG_XFS_POSIX_ACL=y
+CONFIG_QUOTA=y
+# CONFIG_PRINT_QUOTA_WARNING is not set
+CONFIG_MSDOS_FS=m
+CONFIG_VFAT_FS=m
+CONFIG_TMPFS=y
+CONFIG_JFFS2_FS=y
+CONFIG_NFS_FS=y
+CONFIG_ROOT_NFS=y
+CONFIG_NLS_CODEPAGE_437=y
+CONFIG_NLS_ASCII=y
+CONFIG_NLS_ISO8859_1=y
+CONFIG_NLS_ISO8859_15=y
+CONFIG_NLS_UTF8=y
+# CONFIG_FTRACE is not set
+CONFIG_CRYPTO=y
+CONFIG_CRYPTO_CBC=y
+CONFIG_CRYPTO_ECB=y
+CONFIG_CRYPTO_AES=y
+CONFIG_CRYPTO_ARC4=y
+# CONFIG_CRYPTO_ANSI_CPRNG is not set
+# CONFIG_CRYPTO_HW is not set
-- 
1.7.11.1
