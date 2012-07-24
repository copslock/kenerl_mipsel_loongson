Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 24 Jul 2012 23:41:44 +0200 (CEST)
Received: from home.bethel-hill.org ([63.228.164.32]:49873 "EHLO
        home.bethel-hill.org" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S1903755Ab2GXVkR (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 24 Jul 2012 23:40:17 +0200
Received: by home.bethel-hill.org with esmtpsa (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
        (Exim 4.72)
        (envelope-from <sjhill@mips.com>)
        id 1Stmpv-0003y5-3x; Tue, 24 Jul 2012 16:40:11 -0500
From:   "Steven J. Hill" <sjhill@mips.com>
To:     linux-mips@linux-mips.org
Cc:     "Steven J. Hill" <sjhill@mips.com>, ralf@linux-mips.org
Subject: [PATCH v2,9/9] MIPS: Add microMIPS configuration option.
Date:   Tue, 24 Jul 2012 16:40:06 -0500
Message-Id: <1343166006-1723-1-git-send-email-sjhill@mips.com>
X-Mailer: git-send-email 1.7.11.1
X-archive-position: 33975
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

This adds the option to build the Linux kernel using only the
microMIPS ISA. The resulting kernel binary is, at a minimum,
20% smaller than using the MIPS32R2 ISA.

Signed-off-by: Steven J. Hill <sjhill@mips.com>
---
 arch/mips/Kconfig                      |  10 +++
 arch/mips/Makefile                     |   1 +
 arch/mips/configs/sead3micro_defconfig | 125 +++++++++++++++++++++++++++++++++
 arch/mips/kernel/proc.c                |   4 ++
 4 files changed, 140 insertions(+)
 create mode 100644 arch/mips/configs/sead3micro_defconfig

diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index eb34851..a38d016 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -2077,6 +2077,13 @@ config CPU_HAS_SMARTMIPS
 	  you don't know you probably don't have SmartMIPS and should say N
 	  here.
 
+config CPU_MICROMIPS
+	depends on SYS_SUPPORTS_MICROMIPS
+	bool "Build kernel using microMIPS ISA"
+	help
+	  When this option is enabled the kernel will be built using the
+	  microMIPS ISA
+
 config CPU_HAS_WB
 	bool
 
@@ -2140,6 +2147,9 @@ config SYS_SUPPORTS_HIGHMEM
 config SYS_SUPPORTS_SMARTMIPS
 	bool
 
+config SYS_SUPPORTS_MICROMIPS
+	bool
+
 config ARCH_FLATMEM_ENABLE
 	def_bool y
 	depends on !NUMA && !CPU_LOONGSON2
diff --git a/arch/mips/Makefile b/arch/mips/Makefile
index 764e37a..363d8c8 100644
--- a/arch/mips/Makefile
+++ b/arch/mips/Makefile
@@ -114,6 +114,7 @@ cflags-$(CONFIG_CPU_BIG_ENDIAN)		+= $(shell $(CC) -dumpmachine |grep -q 'mips.*e
 cflags-$(CONFIG_CPU_LITTLE_ENDIAN)	+= $(shell $(CC) -dumpmachine |grep -q 'mips.*el-.*' || echo -EL $(undef-all) $(predef-le))
 
 cflags-$(CONFIG_CPU_HAS_SMARTMIPS)	+= $(call cc-option,-msmartmips)
+cflags-$(CONFIG_CPU_MICROMIPS) += $(call cc-option,-mmicromips -mno-jals)
 
 cflags-$(CONFIG_SB1XXX_CORELIS)	+= $(call cc-option,-mno-sched-prolog) \
 				   -fno-omit-frame-pointer
diff --git a/arch/mips/configs/sead3micro_defconfig b/arch/mips/configs/sead3micro_defconfig
new file mode 100644
index 0000000..403332f
--- /dev/null
+++ b/arch/mips/configs/sead3micro_defconfig
@@ -0,0 +1,125 @@
+CONFIG_MIPS_SEAD3=y
+CONFIG_CPU_LITTLE_ENDIAN=y
+CONFIG_CPU_MIPS32_R2=y
+CONFIG_CPU_MICROMIPS=y
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
diff --git a/arch/mips/kernel/proc.c b/arch/mips/kernel/proc.c
index 5569d09..c5e97d4 100644
--- a/arch/mips/kernel/proc.c
+++ b/arch/mips/kernel/proc.c
@@ -73,6 +73,10 @@ static int show_cpuinfo(struct seq_file *m, void *v)
 		      cpu_has_mipsmt ? " mt" : "",
 		      cpu_has_mmips ? " micromips" : ""
 		);
+	if (cpu_has_mmips) {
+		seq_printf(m, "micromips kernel\t: %s\n",
+			(read_c0_config3() & MIPS_CONF3_ISA_OE) ? "yes" : "no");
+	}
 	seq_printf(m, "shadow register sets\t: %d\n",
 		      cpu_data[n].srsets);
 	seq_printf(m, "kscratch registers\t: %d\n",
-- 
1.7.11.1
