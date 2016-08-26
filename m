Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 26 Aug 2016 17:47:50 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:57976 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23992682AbcHZPoC5ChlI (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 26 Aug 2016 17:44:02 +0200
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Forcepoint Email with ESMTPS id AA7E911DC0EA1;
        Fri, 26 Aug 2016 16:43:40 +0100 (IST)
Received: from localhost (10.100.200.141) by HHMAIL01.hh.imgtec.org
 (10.100.10.21) with Microsoft SMTP Server (TLS) id 14.3.294.0; Fri, 26 Aug
 2016 16:43:42 +0100
From:   Paul Burton <paul.burton@imgtec.com>
To:     <linux-mips@linux-mips.org>, Ralf Baechle <ralf@linux-mips.org>
CC:     Paul Burton <paul.burton@imgtec.com>,
        Matt Redfearn <matt.redfearn@imgtec.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        Jacek Anaszewski <j.anaszewski@samsung.com>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Subject: [PATCH 23/26] MIPS: generic: Convert SEAD-3 to a generic board
Date:   Fri, 26 Aug 2016 16:37:22 +0100
Message-ID: <20160826153725.11629-24-paul.burton@imgtec.com>
X-Mailer: git-send-email 2.9.3
In-Reply-To: <20160826153725.11629-1-paul.burton@imgtec.com>
References: <20160826153725.11629-1-paul.burton@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.100.200.141]
Return-Path: <Paul.Burton@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 54807
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: paul.burton@imgtec.com
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

Convert the MIPS SEAD-3 board support to be a generic board, supported
by generic kernels.

Because the SEAD-3 boot protocol was defined long ago and we don't want
to force a switch to the UHI protocol, SEAD-3 is added as a legacy board
which is detected by reading the REVISION register. This may technically
not be a valid memory read & future work will include attempting to
handle that gracefully. In practice since SEAD-3 is the only legacy
board supported by the generic kernel so far the read will only happen
on SEAD-3 boards, and even once Malta is converted the same REVISION
register exists there too. Other boards such as Boston, Ci20 & Ci40 will
use the UHI boot protocol & thus not run any of the legacy board detect
functions.

Signed-off-by: Paul Burton <paul.burton@imgtec.com>
---

 arch/mips/Kbuild.platforms                         |   1 -
 arch/mips/Kconfig                                  |  37 +-----
 arch/mips/Makefile                                 |  13 +++
 arch/mips/boot/dts/mti/Makefile                    |   2 +-
 arch/mips/boot/dts/mti/sead3.dts                   |   1 +
 arch/mips/configs/generic/board-sead-3.config      |  32 +++++
 arch/mips/configs/sead3_defconfig                  | 129 ---------------------
 arch/mips/configs/sead3micro_defconfig             | 122 -------------------
 arch/mips/generic/Kconfig                          |   7 ++
 arch/mips/generic/Makefile                         |   2 +
 .../sead3-dtshim.c => generic/board-sead3.c}       | 106 +++++++++++++++--
 .../include/asm/mach-sead3/cpu-feature-overrides.h |  72 ------------
 arch/mips/include/asm/mach-sead3/irq.h             |   9 --
 .../include/asm/mach-sead3/kernel-entry-init.h     |  21 ----
 arch/mips/include/asm/mach-sead3/sead3-dtshim.h    |  29 -----
 arch/mips/include/asm/mach-sead3/war.h             |  24 ----
 arch/mips/mti-sead3/Makefile                       |  15 ---
 arch/mips/mti-sead3/Platform                       |   7 --
 arch/mips/mti-sead3/sead3-init.c                   | 100 ----------------
 arch/mips/mti-sead3/sead3-int.c                    |  23 ----
 arch/mips/mti-sead3/sead3-setup.c                  |  39 -------
 arch/mips/mti-sead3/sead3-time.c                   |  91 ---------------
 22 files changed, 152 insertions(+), 730 deletions(-)
 create mode 100644 arch/mips/configs/generic/board-sead-3.config
 delete mode 100644 arch/mips/configs/sead3_defconfig
 delete mode 100644 arch/mips/configs/sead3micro_defconfig
 rename arch/mips/{mti-sead3/sead3-dtshim.c => generic/board-sead3.c} (72%)
 delete mode 100644 arch/mips/include/asm/mach-sead3/cpu-feature-overrides.h
 delete mode 100644 arch/mips/include/asm/mach-sead3/irq.h
 delete mode 100644 arch/mips/include/asm/mach-sead3/kernel-entry-init.h
 delete mode 100644 arch/mips/include/asm/mach-sead3/sead3-dtshim.h
 delete mode 100644 arch/mips/include/asm/mach-sead3/war.h
 delete mode 100644 arch/mips/mti-sead3/Makefile
 delete mode 100644 arch/mips/mti-sead3/Platform
 delete mode 100644 arch/mips/mti-sead3/sead3-init.c
 delete mode 100644 arch/mips/mti-sead3/sead3-int.c
 delete mode 100644 arch/mips/mti-sead3/sead3-setup.c
 delete mode 100644 arch/mips/mti-sead3/sead3-time.c

diff --git a/arch/mips/Kbuild.platforms b/arch/mips/Kbuild.platforms
index 9c1e8f9..f5f1bdb 100644
--- a/arch/mips/Kbuild.platforms
+++ b/arch/mips/Kbuild.platforms
@@ -19,7 +19,6 @@ platforms += lasat
 platforms += loongson32
 platforms += loongson64
 platforms += mti-malta
-platforms += mti-sead3
 platforms += netlogic
 platforms += paravirt
 platforms += pic32
diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index 2884d80..a2b6dd1 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -543,41 +543,6 @@ config MACH_PIC32
 	  Microchip PIC32 is a family of general-purpose 32 bit MIPS core
 	  microcontrollers.
 
-config MIPS_SEAD3
-	bool "MIPS SEAD3 board"
-	select BOOT_ELF32
-	select BOOT_RAW
-	select BUILTIN_DTB
-	select CEVT_R4K
-	select CSRC_R4K
-	select CLKSRC_MIPS_GIC
-	select COMMON_CLK
-	select CPU_MIPSR2_IRQ_VI
-	select CPU_MIPSR2_IRQ_EI
-	select DMA_NONCOHERENT
-	select IRQ_MIPS_CPU
-	select MIPS_GIC
-	select LIBFDT
-	select MIPS_MSC
-	select SYS_HAS_CPU_MIPS32_R1
-	select SYS_HAS_CPU_MIPS32_R2
-	select SYS_HAS_CPU_MIPS32_R6
-	select SYS_HAS_CPU_MIPS64_R1
-	select SYS_SUPPORTS_32BIT_KERNEL
-	select SYS_SUPPORTS_64BIT_KERNEL
-	select SYS_SUPPORTS_BIG_ENDIAN
-	select SYS_SUPPORTS_LITTLE_ENDIAN
-	select SYS_SUPPORTS_SMARTMIPS
-	select SYS_SUPPORTS_MICROMIPS
-	select SYS_SUPPORTS_MIPS16
-	select SYS_SUPPORTS_RELOCATABLE
-	select USB_EHCI_BIG_ENDIAN_DESC
-	select USB_EHCI_BIG_ENDIAN_MMIO
-	select USE_OF
-	help
-	  This enables support for the MIPS Technologies SEAD3 evaluation
-	  board.
-
 config NEC_MARKEINS
 	bool "NEC EMMA2RH Mark-eins board"
 	select SOC_EMMA2RH
@@ -2960,7 +2925,7 @@ endchoice
 choice
 	prompt "Kernel command line type" if !CMDLINE_OVERRIDE
 	default MIPS_CMDLINE_FROM_DTB if USE_OF && !ATH79 && !MACH_INGENIC && \
-					 !MIPS_MALTA && !MIPS_SEAD3 && \
+					 !MIPS_MALTA && \
 					 !CAVIUM_OCTEON_SOC
 	default MIPS_CMDLINE_FROM_BOOTLOADER
 
diff --git a/arch/mips/Makefile b/arch/mips/Makefile
index 1add1e7..5e0eba3 100644
--- a/arch/mips/Makefile
+++ b/arch/mips/Makefile
@@ -487,3 +487,16 @@ $(generic_defconfigs):
 		-m -O $(objtree) $(srctree)/arch/$(ARCH)/configs/generic_defconfig $^ \
 		$(foreach board,$(BOARDS),$(generic_config_dir)/board-$(board).config)
 	$(Q)$(MAKE) olddefconfig
+
+#
+# Legacy defconfig compatibility - these targets used to be real defconfigs but
+# now that the boards have been converted to use the generic kernel they are
+# wrappers around the generic rules above.
+#
+.PHONY: sead3_defconfig
+sead3_defconfig:
+	$(Q)$(MAKE) 32r2el_defconfig BOARDS=sead-3
+
+.PHONY: sead3micro_defconfig
+sead3micro_defconfig:
+	$(Q)$(MAKE) micro32r2el_defconfig BOARDS=sead-3
diff --git a/arch/mips/boot/dts/mti/Makefile b/arch/mips/boot/dts/mti/Makefile
index 144d776..fcabd69 100644
--- a/arch/mips/boot/dts/mti/Makefile
+++ b/arch/mips/boot/dts/mti/Makefile
@@ -1,5 +1,5 @@
 dtb-$(CONFIG_MIPS_MALTA)	+= malta.dtb
-dtb-$(CONFIG_MIPS_SEAD3)	+= sead3.dtb
+dtb-$(CONFIG_LEGACY_BOARD_SEAD3)	+= sead3.dtb
 
 obj-y				+= $(patsubst %.dtb, %.dtb.o, $(dtb-y))
 
diff --git a/arch/mips/boot/dts/mti/sead3.dts b/arch/mips/boot/dts/mti/sead3.dts
index 2579ca5..b112879 100644
--- a/arch/mips/boot/dts/mti/sead3.dts
+++ b/arch/mips/boot/dts/mti/sead3.dts
@@ -10,6 +10,7 @@
 	#address-cells = <1>;
 	#size-cells = <1>;
 	compatible = "mti,sead-3";
+	model = "MIPS SEAD-3";
 	interrupt-parent = <&gic>;
 
 	chosen {
diff --git a/arch/mips/configs/generic/board-sead-3.config b/arch/mips/configs/generic/board-sead-3.config
new file mode 100644
index 0000000..3b5e1ac
--- /dev/null
+++ b/arch/mips/configs/generic/board-sead-3.config
@@ -0,0 +1,32 @@
+CONFIG_LEGACY_BOARD_SEAD3=y
+
+CONFIG_AUXDISPLAY=y
+CONFIG_IMG_ASCII_LCD=y
+
+CONFIG_NEW_LEDS=y
+CONFIG_LEDS_CLASS=y
+CONFIG_LEDS_SYSCON=y
+
+CONFIG_MMC=y
+CONFIG_MMC_SPI=y
+
+CONFIG_MTD=y
+CONFIG_MTD_BLOCK=y
+CONFIG_MTD_CFI=y
+CONFIG_MTD_CFI_INTELEXT=y
+CONFIG_MTD_OF_PARTS=y
+CONFIG_MTD_PHYSMAP=y
+CONFIG_MTD_PHYSMAP_OF=y
+CONFIG_MTD_UBI=y
+CONFIG_MTD_UBI_GLUEBI=y
+
+CONFIG_NETDEVICES=y
+CONFIG_SMSC911X=y
+CONFIG_SMSC_PHY=y
+
+CONFIG_SERIAL_8250=y
+CONFIG_SERIAL_8250_CONSOLE=y
+CONFIG_SERIAL_OF_PLATFORM=y
+
+CONFIG_USB=y
+CONFIG_USB_EHCI_HCD=y
diff --git a/arch/mips/configs/sead3_defconfig b/arch/mips/configs/sead3_defconfig
deleted file mode 100644
index ab4c465..0000000
--- a/arch/mips/configs/sead3_defconfig
+++ /dev/null
@@ -1,129 +0,0 @@
-CONFIG_MIPS_SEAD3=y
-CONFIG_CPU_LITTLE_ENDIAN=y
-CONFIG_CPU_MIPS32_R2=y
-CONFIG_HZ_100=y
-CONFIG_SYSVIPC=y
-CONFIG_POSIX_MQUEUE=y
-CONFIG_NO_HZ=y
-CONFIG_HIGH_RES_TIMERS=y
-CONFIG_IKCONFIG=y
-CONFIG_IKCONFIG_PROC=y
-CONFIG_LOG_BUF_SHIFT=15
-CONFIG_EMBEDDED=y
-CONFIG_SLAB=y
-CONFIG_PROFILING=y
-CONFIG_OPROFILE=y
-CONFIG_MODULES=y
-# CONFIG_BLK_DEV_BSG is not set
-CONFIG_CMDLINE_BOOL=y
-CONFIG_CMDLINE="earlycon"
-# CONFIG_CORE_DUMP_DEFAULT_ELF_HEADERS is not set
-CONFIG_NET=y
-CONFIG_PACKET=y
-CONFIG_UNIX=y
-CONFIG_INET=y
-CONFIG_IP_PNP=y
-CONFIG_IP_PNP_DHCP=y
-CONFIG_IP_PNP_BOOTP=y
-# CONFIG_INET_XFRM_MODE_TRANSPORT is not set
-# CONFIG_INET_XFRM_MODE_TUNNEL is not set
-# CONFIG_INET_XFRM_MODE_BEET is not set
-# CONFIG_INET_LRO is not set
-# CONFIG_INET_DIAG is not set
-# CONFIG_IPV6 is not set
-# CONFIG_WIRELESS is not set
-CONFIG_UEVENT_HELPER_PATH="/sbin/hotplug"
-CONFIG_DEVTMPFS=y
-CONFIG_MTD=y
-CONFIG_MTD_BLOCK=y
-CONFIG_MTD_CFI=y
-CONFIG_MTD_CFI_INTELEXT=y
-CONFIG_MTD_PHYSMAP=y
-CONFIG_MTD_UBI=y
-CONFIG_MTD_UBI_GLUEBI=y
-CONFIG_OF=y
-CONFIG_BLK_DEV_LOOP=y
-CONFIG_BLK_DEV_CRYPTOLOOP=m
-CONFIG_SCSI=y
-# CONFIG_SCSI_PROC_FS is not set
-CONFIG_BLK_DEV_SD=y
-CONFIG_CHR_DEV_SG=y
-# CONFIG_SCSI_LOWLEVEL is not set
-CONFIG_NETDEVICES=y
-CONFIG_SMSC911X=y
-# CONFIG_NET_VENDOR_WIZNET is not set
-CONFIG_MARVELL_PHY=y
-CONFIG_DAVICOM_PHY=y
-CONFIG_QSEMI_PHY=y
-CONFIG_LXT_PHY=y
-CONFIG_CICADA_PHY=y
-CONFIG_VITESSE_PHY=y
-CONFIG_SMSC_PHY=y
-CONFIG_BROADCOM_PHY=y
-CONFIG_ICPLUS_PHY=y
-# CONFIG_WLAN is not set
-# CONFIG_INPUT_MOUSEDEV is not set
-# CONFIG_INPUT_KEYBOARD is not set
-# CONFIG_INPUT_MOUSE is not set
-# CONFIG_SERIO is not set
-# CONFIG_CONSOLE_TRANSLATIONS is not set
-CONFIG_VT_HW_CONSOLE_BINDING=y
-CONFIG_LEGACY_PTY_COUNT=32
-CONFIG_SERIAL_8250=y
-CONFIG_SERIAL_8250_CONSOLE=y
-CONFIG_SERIAL_8250_NR_UARTS=2
-CONFIG_SERIAL_8250_RUNTIME_UARTS=2
-CONFIG_SERIAL_OF_PLATFORM=y
-# CONFIG_HW_RANDOM is not set
-CONFIG_I2C=y
-# CONFIG_I2C_COMPAT is not set
-CONFIG_I2C_CHARDEV=y
-# CONFIG_I2C_HELPER_AUTO is not set
-CONFIG_SPI=y
-CONFIG_POWER_RESET=y
-CONFIG_POWER_RESET_RESTART=y
-CONFIG_POWER_RESET_SYSCON=y
-CONFIG_SENSORS_ADT7475=y
-CONFIG_BACKLIGHT_LCD_SUPPORT=y
-CONFIG_LCD_CLASS_DEVICE=y
-CONFIG_BACKLIGHT_CLASS_DEVICE=y
-# CONFIG_VGA_CONSOLE is not set
-CONFIG_USB=y
-CONFIG_USB_ANNOUNCE_NEW_DEVICES=y
-CONFIG_USB_EHCI_HCD=y
-CONFIG_USB_EHCI_ROOT_HUB_TT=y
-CONFIG_USB_STORAGE=y
-CONFIG_MMC=y
-CONFIG_MMC_DEBUG=y
-CONFIG_MMC_SPI=y
-CONFIG_NEW_LEDS=y
-CONFIG_LEDS_CLASS=y
-CONFIG_LEDS_SYSCON=y
-CONFIG_LEDS_TRIGGERS=y
-CONFIG_LEDS_TRIGGER_HEARTBEAT=y
-CONFIG_RTC_CLASS=y
-CONFIG_RTC_DRV_M41T80=y
-CONFIG_EXT3_FS=y
-# CONFIG_EXT3_DEFAULTS_TO_ORDERED is not set
-CONFIG_XFS_FS=y
-CONFIG_XFS_QUOTA=y
-CONFIG_XFS_POSIX_ACL=y
-CONFIG_QUOTA=y
-# CONFIG_PRINT_QUOTA_WARNING is not set
-CONFIG_MSDOS_FS=m
-CONFIG_VFAT_FS=m
-CONFIG_TMPFS=y
-CONFIG_JFFS2_FS=y
-CONFIG_NFS_FS=y
-CONFIG_ROOT_NFS=y
-CONFIG_NLS_CODEPAGE_437=y
-CONFIG_NLS_ASCII=y
-CONFIG_NLS_ISO8859_1=y
-CONFIG_NLS_ISO8859_15=y
-CONFIG_NLS_UTF8=y
-# CONFIG_FTRACE is not set
-CONFIG_CRYPTO_CBC=y
-CONFIG_CRYPTO_ECB=y
-CONFIG_CRYPTO_ARC4=y
-# CONFIG_CRYPTO_ANSI_CPRNG is not set
-# CONFIG_CRYPTO_HW is not set
diff --git a/arch/mips/configs/sead3micro_defconfig b/arch/mips/configs/sead3micro_defconfig
deleted file mode 100644
index cd91a77..0000000
--- a/arch/mips/configs/sead3micro_defconfig
+++ /dev/null
@@ -1,122 +0,0 @@
-CONFIG_MIPS_SEAD3=y
-CONFIG_CPU_LITTLE_ENDIAN=y
-CONFIG_CPU_MIPS32_R2=y
-CONFIG_CPU_MICROMIPS=y
-CONFIG_HZ_100=y
-CONFIG_SYSVIPC=y
-CONFIG_POSIX_MQUEUE=y
-CONFIG_NO_HZ=y
-CONFIG_HIGH_RES_TIMERS=y
-CONFIG_IKCONFIG=y
-CONFIG_IKCONFIG_PROC=y
-CONFIG_LOG_BUF_SHIFT=15
-CONFIG_EMBEDDED=y
-CONFIG_SLAB=y
-CONFIG_PROFILING=y
-CONFIG_OPROFILE=y
-CONFIG_MODULES=y
-# CONFIG_BLK_DEV_BSG is not set
-# CONFIG_CORE_DUMP_DEFAULT_ELF_HEADERS is not set
-CONFIG_NET=y
-CONFIG_PACKET=y
-CONFIG_UNIX=y
-CONFIG_INET=y
-CONFIG_IP_PNP=y
-CONFIG_IP_PNP_DHCP=y
-CONFIG_IP_PNP_BOOTP=y
-# CONFIG_INET_XFRM_MODE_TRANSPORT is not set
-# CONFIG_INET_XFRM_MODE_TUNNEL is not set
-# CONFIG_INET_XFRM_MODE_BEET is not set
-# CONFIG_INET_LRO is not set
-# CONFIG_INET_DIAG is not set
-# CONFIG_IPV6 is not set
-# CONFIG_WIRELESS is not set
-CONFIG_UEVENT_HELPER_PATH="/sbin/hotplug"
-CONFIG_DEVTMPFS=y
-CONFIG_MTD=y
-CONFIG_MTD_BLOCK=y
-CONFIG_MTD_CFI=y
-CONFIG_MTD_CFI_INTELEXT=y
-CONFIG_MTD_PHYSMAP=y
-CONFIG_MTD_UBI=y
-CONFIG_MTD_UBI_GLUEBI=y
-CONFIG_BLK_DEV_LOOP=y
-CONFIG_BLK_DEV_CRYPTOLOOP=m
-CONFIG_SCSI=y
-# CONFIG_SCSI_PROC_FS is not set
-CONFIG_BLK_DEV_SD=y
-CONFIG_CHR_DEV_SG=y
-# CONFIG_SCSI_LOWLEVEL is not set
-CONFIG_NETDEVICES=y
-CONFIG_SMSC911X=y
-# CONFIG_NET_VENDOR_WIZNET is not set
-CONFIG_MARVELL_PHY=y
-CONFIG_DAVICOM_PHY=y
-CONFIG_QSEMI_PHY=y
-CONFIG_LXT_PHY=y
-CONFIG_CICADA_PHY=y
-CONFIG_VITESSE_PHY=y
-CONFIG_SMSC_PHY=y
-CONFIG_BROADCOM_PHY=y
-CONFIG_ICPLUS_PHY=y
-# CONFIG_WLAN is not set
-# CONFIG_INPUT_MOUSEDEV is not set
-# CONFIG_INPUT_KEYBOARD is not set
-# CONFIG_INPUT_MOUSE is not set
-# CONFIG_SERIO is not set
-# CONFIG_CONSOLE_TRANSLATIONS is not set
-CONFIG_VT_HW_CONSOLE_BINDING=y
-CONFIG_LEGACY_PTY_COUNT=32
-CONFIG_SERIAL_8250=y
-CONFIG_SERIAL_8250_CONSOLE=y
-CONFIG_SERIAL_8250_NR_UARTS=2
-CONFIG_SERIAL_8250_RUNTIME_UARTS=2
-# CONFIG_HW_RANDOM is not set
-CONFIG_I2C=y
-# CONFIG_I2C_COMPAT is not set
-CONFIG_I2C_CHARDEV=y
-# CONFIG_I2C_HELPER_AUTO is not set
-CONFIG_SPI=y
-CONFIG_SENSORS_ADT7475=y
-CONFIG_BACKLIGHT_LCD_SUPPORT=y
-CONFIG_LCD_CLASS_DEVICE=y
-CONFIG_BACKLIGHT_CLASS_DEVICE=y
-# CONFIG_VGA_CONSOLE is not set
-CONFIG_USB=y
-CONFIG_USB_ANNOUNCE_NEW_DEVICES=y
-CONFIG_USB_EHCI_HCD=y
-CONFIG_USB_EHCI_ROOT_HUB_TT=y
-CONFIG_USB_STORAGE=y
-CONFIG_MMC=y
-CONFIG_MMC_DEBUG=y
-CONFIG_MMC_SPI=y
-CONFIG_NEW_LEDS=y
-CONFIG_LEDS_CLASS=y
-CONFIG_LEDS_TRIGGERS=y
-CONFIG_LEDS_TRIGGER_HEARTBEAT=y
-CONFIG_RTC_CLASS=y
-CONFIG_RTC_DRV_M41T80=y
-CONFIG_EXT3_FS=y
-# CONFIG_EXT3_DEFAULTS_TO_ORDERED is not set
-CONFIG_XFS_FS=y
-CONFIG_XFS_QUOTA=y
-CONFIG_XFS_POSIX_ACL=y
-CONFIG_QUOTA=y
-# CONFIG_PRINT_QUOTA_WARNING is not set
-CONFIG_MSDOS_FS=m
-CONFIG_VFAT_FS=m
-CONFIG_TMPFS=y
-CONFIG_JFFS2_FS=y
-CONFIG_NFS_FS=y
-CONFIG_ROOT_NFS=y
-CONFIG_NLS_CODEPAGE_437=y
-CONFIG_NLS_ASCII=y
-CONFIG_NLS_ISO8859_1=y
-CONFIG_NLS_ISO8859_15=y
-CONFIG_NLS_UTF8=y
-# CONFIG_FTRACE is not set
-CONFIG_CRYPTO_CBC=y
-CONFIG_CRYPTO_ECB=y
-CONFIG_CRYPTO_ARC4=y
-# CONFIG_CRYPTO_ANSI_CPRNG is not set
-# CONFIG_CRYPTO_HW is not set
diff --git a/arch/mips/generic/Kconfig b/arch/mips/generic/Kconfig
index baddb06..a606b3f 100644
--- a/arch/mips/generic/Kconfig
+++ b/arch/mips/generic/Kconfig
@@ -9,4 +9,11 @@ config LEGACY_BOARDS
 	  kernel is booted without being provided with an FDT via the UHI
 	  boot protocol.
 
+config LEGACY_BOARD_SEAD3
+	bool "Support MIPS SEAD-3 boards"
+	select LEGACY_BOARDS
+	help
+	  Enable this to include support for booting on MIPS SEAD-3 FPGA-based
+	  development boards, which boot using a legacy boot protocol.
+
 endif
diff --git a/arch/mips/generic/Makefile b/arch/mips/generic/Makefile
index 26e6420..7c66494 100644
--- a/arch/mips/generic/Makefile
+++ b/arch/mips/generic/Makefile
@@ -11,3 +11,5 @@
 obj-y += init.o
 obj-y += irq.o
 obj-y += proc.o
+
+obj-$(CONFIG_LEGACY_BOARD_SEAD3)	+= board-sead3.o
diff --git a/arch/mips/mti-sead3/sead3-dtshim.c b/arch/mips/generic/board-sead3.c
similarity index 72%
rename from arch/mips/mti-sead3/sead3-dtshim.c
rename to arch/mips/generic/board-sead3.c
index d6b0708..f4ae058 100644
--- a/arch/mips/mti-sead3/sead3-dtshim.c
+++ b/arch/mips/generic/board-sead3.c
@@ -4,11 +4,11 @@
  *
  * This program is free software; you can redistribute it and/or modify it
  * under the terms of the GNU General Public License as published by the
- * Free Software Foundation; either version 2 of the License, or (at your
+ * Free Software Foundation;  either version 2 of the  License, or (at your
  * option) any later version.
  */
 
-#define pr_fmt(fmt) "sead3-dtshim: " fmt
+#define pr_fmt(fmt) "sead3: " fmt
 
 #include <linux/errno.h>
 #include <linux/libfdt.h>
@@ -16,13 +16,49 @@
 
 #include <asm/fw/fw.h>
 #include <asm/io.h>
+#include <asm/machine.h>
 
 #define SEAD_CONFIG			CKSEG1ADDR(0x1b100110)
 #define SEAD_CONFIG_GIC_PRESENT		BIT(1)
 
-static unsigned char fdt_buf[16 << 10] __initdata;
+#define MIPS_REVISION			CKSEG1ADDR(0x1fc00010)
+#define MIPS_REVISION_MACHINE		(0xf << 4)
+#define MIPS_REVISION_MACHINE_SEAD3	(0x4 << 4)
 
-static int append_memory(void *fdt)
+static __init bool sead3_detect(void)
+{
+	uint32_t rev;
+
+	rev = __raw_readl((void *)MIPS_REVISION);
+	return (rev & MIPS_REVISION_MACHINE) == MIPS_REVISION_MACHINE_SEAD3;
+}
+
+static __init int append_cmdline(void *fdt)
+{
+	int err, chosen_off;
+
+	/* find or add chosen node */
+	chosen_off = fdt_path_offset(fdt, "/chosen");
+	if (chosen_off == -FDT_ERR_NOTFOUND)
+		chosen_off = fdt_path_offset(fdt, "/chosen@0");
+	if (chosen_off == -FDT_ERR_NOTFOUND)
+		chosen_off = fdt_add_subnode(fdt, 0, "chosen");
+	if (chosen_off < 0) {
+		pr_err("Unable to find or add DT chosen node: %d\n",
+		       chosen_off);
+		return chosen_off;
+	}
+
+	err = fdt_setprop_string(fdt, chosen_off, "bootargs", fw_getcmdline());
+	if (err) {
+		pr_err("Unable to set bootargs property: %d\n", err);
+		return err;
+	}
+
+	return 0;
+}
+
+static __init int append_memory(void *fdt)
 {
 	unsigned long phys_memsize, memsize;
 	__be32 mem_array[2];
@@ -89,7 +125,7 @@ static int append_memory(void *fdt)
 	return 0;
 }
 
-static int remove_gic(void *fdt)
+static __init int remove_gic(void *fdt)
 {
 	const unsigned int cpu_ehci_int = 2;
 	const unsigned int cpu_uart_int = 4;
@@ -163,7 +199,7 @@ static int remove_gic(void *fdt)
 		return err;
 	}
 
-	ehci_off = fdt_node_offset_by_compatible(fdt, -1, "mti,sead3-ehci");
+	ehci_off = fdt_node_offset_by_compatible(fdt, -1, "generic-ehci");
 	if (ehci_off < 0) {
 		pr_err("unable to find EHCI DT node: %d\n", ehci_off);
 		return ehci_off;
@@ -178,7 +214,7 @@ static int remove_gic(void *fdt)
 	return 0;
 }
 
-static int serial_config(void *fdt)
+static __init int serial_config(void *fdt)
 {
 	const char *yamontty, *mode_var;
 	char mode_var_name[9], path[18], parity;
@@ -257,21 +293,28 @@ static int serial_config(void *fdt)
 	return 0;
 }
 
-void __init *sead3_dt_shim(void *fdt)
+static __init const void *sead3_fixup_fdt(const void *fdt,
+					  const void *match_data)
 {
+	static unsigned char fdt_buf[16 << 10] __initdata;
 	int err;
 
 	if (fdt_check_header(fdt))
 		panic("Corrupt DT");
 
-	/* if this isn't SEAD3, leave the DT alone */
-	if (fdt_node_check_compatible(fdt, 0, "mti,sead-3"))
-		return fdt;
+	/* if this isn't SEAD3, something went wrong */
+	BUG_ON(fdt_node_check_compatible(fdt, 0, "mti,sead-3"));
+
+	fw_init_cmdline();
 
 	err = fdt_open_into(fdt, fdt_buf, sizeof(fdt_buf));
 	if (err)
 		panic("Unable to open FDT: %d", err);
 
+	err = append_cmdline(fdt_buf);
+	if (err)
+		panic("Unable to patch FDT: %d", err);
+
 	err = append_memory(fdt_buf);
 	if (err)
 		panic("Unable to patch FDT: %d", err);
@@ -290,3 +333,44 @@ void __init *sead3_dt_shim(void *fdt)
 
 	return fdt_buf;
 }
+
+static __init unsigned int sead3_measure_hpt_freq(void)
+{
+	void __iomem *status_reg = (void __iomem *)0xbf000410;
+	unsigned int freq, orig, tick = 0;
+	unsigned long flags;
+
+	local_irq_save(flags);
+
+	orig = readl(status_reg) & 0x2;		      /* get original sample */
+	/* wait for transition */
+	while ((readl(status_reg) & 0x2) == orig)
+		;
+	orig = orig ^ 0x2;			      /* flip the bit */
+
+	write_c0_count(0);
+
+	/* wait 1 second (the sampling clock transitions every 10ms) */
+	while (tick < 100) {
+		/* wait for transition */
+		while ((readl(status_reg) & 0x2) == orig)
+			;
+		orig = orig ^ 0x2;			      /* flip the bit */
+		tick++;
+	}
+
+	freq = read_c0_count();
+
+	local_irq_restore(flags);
+
+	return freq;
+}
+
+extern char __dtb_sead3_begin[];
+
+MIPS_MACHINE(sead3) = {
+	.fdt = __dtb_sead3_begin,
+	.detect = sead3_detect,
+	.fixup_fdt = sead3_fixup_fdt,
+	.measure_hpt_freq = sead3_measure_hpt_freq,
+};
diff --git a/arch/mips/include/asm/mach-sead3/cpu-feature-overrides.h b/arch/mips/include/asm/mach-sead3/cpu-feature-overrides.h
deleted file mode 100644
index bfbd703..0000000
--- a/arch/mips/include/asm/mach-sead3/cpu-feature-overrides.h
+++ /dev/null
@@ -1,72 +0,0 @@
-/*
- * This file is subject to the terms and conditions of the GNU General Public
- * License.  See the file "COPYING" in the main directory of this archive
- * for more details.
- *
- * Copyright (C) 2003, 2004 Chris Dearman
- * Copyright (C) 2005 Ralf Baechle (ralf@linux-mips.org)
- */
-#ifndef __ASM_MACH_MIPS_CPU_FEATURE_OVERRIDES_H
-#define __ASM_MACH_MIPS_CPU_FEATURE_OVERRIDES_H
-
-
-/*
- * CPU feature overrides for MIPS boards
- */
-#ifdef CONFIG_CPU_MIPS32
-#define cpu_has_tlb		1
-#define cpu_has_4kex		1
-#define cpu_has_4k_cache	1
-/* #define cpu_has_fpu		? */
-/* #define cpu_has_32fpr	? */
-#define cpu_has_counter		1
-/* #define cpu_has_watch	? */
-#define cpu_has_divec		1
-#define cpu_has_vce		0
-/* #define cpu_has_cache_cdex_p ? */
-/* #define cpu_has_cache_cdex_s ? */
-/* #define cpu_has_prefetch	? */
-#define cpu_has_mcheck		1
-/* #define cpu_has_ejtag	? */
-#ifdef CONFIG_CPU_MICROMIPS
-#define cpu_has_llsc		0
-#else
-#define cpu_has_llsc		1
-#endif
-/* #define cpu_has_vtag_icache	? */
-/* #define cpu_has_dc_aliases	? */
-/* #define cpu_has_ic_fills_f_dc ? */
-#define cpu_has_nofpuex		0
-/* #define cpu_has_64bits	? */
-/* #define cpu_has_64bit_zero_reg ? */
-/* #define cpu_has_inclusive_pcaches ? */
-#define cpu_icache_snoops_remote_store 1
-#endif
-
-#ifdef CONFIG_CPU_MIPS64
-#define cpu_has_tlb		1
-#define cpu_has_4kex		1
-#define cpu_has_4k_cache	1
-/* #define cpu_has_fpu		? */
-/* #define cpu_has_32fpr	? */
-#define cpu_has_counter		1
-/* #define cpu_has_watch	? */
-#define cpu_has_divec		1
-#define cpu_has_vce		0
-/* #define cpu_has_cache_cdex_p ? */
-/* #define cpu_has_cache_cdex_s ? */
-/* #define cpu_has_prefetch	? */
-#define cpu_has_mcheck		1
-/* #define cpu_has_ejtag	? */
-#define cpu_has_llsc		1
-/* #define cpu_has_vtag_icache	? */
-/* #define cpu_has_dc_aliases	? */
-/* #define cpu_has_ic_fills_f_dc ? */
-#define cpu_has_nofpuex		0
-/* #define cpu_has_64bits	? */
-/* #define cpu_has_64bit_zero_reg ? */
-/* #define cpu_has_inclusive_pcaches ? */
-#define cpu_icache_snoops_remote_store 1
-#endif
-
-#endif /* __ASM_MACH_MIPS_CPU_FEATURE_OVERRIDES_H */
diff --git a/arch/mips/include/asm/mach-sead3/irq.h b/arch/mips/include/asm/mach-sead3/irq.h
deleted file mode 100644
index 5d154cf..0000000
--- a/arch/mips/include/asm/mach-sead3/irq.h
+++ /dev/null
@@ -1,9 +0,0 @@
-#ifndef __ASM_MACH_MIPS_IRQ_H
-#define __ASM_MACH_MIPS_IRQ_H
-
-#define NR_IRQS 256
-
-
-#include_next <irq.h>
-
-#endif /* __ASM_MACH_MIPS_IRQ_H */
diff --git a/arch/mips/include/asm/mach-sead3/kernel-entry-init.h b/arch/mips/include/asm/mach-sead3/kernel-entry-init.h
deleted file mode 100644
index 6cccd4d..0000000
--- a/arch/mips/include/asm/mach-sead3/kernel-entry-init.h
+++ /dev/null
@@ -1,21 +0,0 @@
-/*
- * This file is subject to the terms and conditions of the GNU General Public
- * License.  See the file "COPYING" in the main directory of this archive
- * for more details.
- *
- * Chris Dearman (chris@mips.com)
- * Copyright (C) 2007 Mips Technologies, Inc.
- */
-#ifndef __ASM_MACH_MIPS_KERNEL_ENTRY_INIT_H
-#define __ASM_MACH_MIPS_KERNEL_ENTRY_INIT_H
-
-	.macro	kernel_entry_setup
-	.endm
-
-/*
- * Do SMP slave processor setup necessary before we can safely execute C code.
- */
-	.macro	smp_slave_setup
-	.endm
-
-#endif /* __ASM_MACH_MIPS_KERNEL_ENTRY_INIT_H */
diff --git a/arch/mips/include/asm/mach-sead3/sead3-dtshim.h b/arch/mips/include/asm/mach-sead3/sead3-dtshim.h
deleted file mode 100644
index f5d7d9c..0000000
--- a/arch/mips/include/asm/mach-sead3/sead3-dtshim.h
+++ /dev/null
@@ -1,29 +0,0 @@
-/*
- * Copyright (C) 2016 Imagination Technologies
- * Author: Paul Burton <paul.burton@imgtec.com>
- *
- * This program is free software; you can redistribute it and/or modify it
- * under the terms of the GNU General Public License as published by the
- * Free Software Foundation; either version 2 of the License, or (at your
- * option) any later version.
- */
-
-#ifndef __MIPS_SEAD3_DTSHIM_H__
-#define __MIPS_SEAD3_DTSHIM_H__
-
-#include <linux/init.h>
-
-#ifdef CONFIG_MIPS_SEAD3
-
-extern void __init *sead3_dt_shim(void *fdt);
-
-#else /* !CONFIG_MIPS_SEAD3 */
-
-static inline void *sead3_dt_shim(void *fdt)
-{
-	return fdt;
-}
-
-#endif /* !CONFIG_MIPS_SEAD3 */
-
-#endif /* __MIPS_SEAD3_DTSHIM_H__ */
diff --git a/arch/mips/include/asm/mach-sead3/war.h b/arch/mips/include/asm/mach-sead3/war.h
deleted file mode 100644
index d068fc4..0000000
--- a/arch/mips/include/asm/mach-sead3/war.h
+++ /dev/null
@@ -1,24 +0,0 @@
-/*
- * This file is subject to the terms and conditions of the GNU General Public
- * License.  See the file "COPYING" in the main directory of this archive
- * for more details.
- *
- * Copyright (C) 2002, 2004, 2007 by Ralf Baechle <ralf@linux-mips.org>
- */
-#ifndef __ASM_MIPS_MACH_MIPS_WAR_H
-#define __ASM_MIPS_MACH_MIPS_WAR_H
-
-#define R4600_V1_INDEX_ICACHEOP_WAR	0
-#define R4600_V1_HIT_CACHEOP_WAR	0
-#define R4600_V2_HIT_CACHEOP_WAR	0
-#define R5432_CP0_INTERRUPT_WAR		0
-#define BCM1250_M3_WAR			0
-#define SIBYTE_1956_WAR			0
-#define MIPS4K_ICACHE_REFILL_WAR	1
-#define MIPS_CACHE_SYNC_WAR		1
-#define TX49XX_ICACHE_INDEX_INV_WAR	0
-#define ICACHE_REFILLS_WORKAROUND_WAR	1
-#define R10000_LLSC_WAR			0
-#define MIPS34K_MISSED_ITLB_WAR		0
-
-#endif /* __ASM_MIPS_MACH_MIPS_WAR_H */
diff --git a/arch/mips/mti-sead3/Makefile b/arch/mips/mti-sead3/Makefile
deleted file mode 100644
index 1674b9c..0000000
--- a/arch/mips/mti-sead3/Makefile
+++ /dev/null
@@ -1,15 +0,0 @@
-#
-# Carsten Langgaard, carstenl@mips.com
-# Copyright (C) 1999,2000 MIPS Technologies, Inc.  All rights reserved.
-#
-# Copyright (C) 2008 Wind River Systems, Inc.
-#   written by Ralf Baechle <ralf@linux-mips.org>
-#
-# Copyright (C) 2012 MIPS Technoligies, Inc.  All rights reserved.
-# Steven J. Hill <sjhill@mips.com>
-#
-obj-y := sead3-dtshim.o
-obj-y += sead3-init.o
-obj-y += sead3-int.o
-obj-y += sead3-setup.o
-obj-y += sead3-time.o
diff --git a/arch/mips/mti-sead3/Platform b/arch/mips/mti-sead3/Platform
deleted file mode 100644
index 3870924..0000000
--- a/arch/mips/mti-sead3/Platform
+++ /dev/null
@@ -1,7 +0,0 @@
-#
-# MIPS SEAD-3 board
-#
-platform-$(CONFIG_MIPS_SEAD3)	+= mti-sead3/
-cflags-$(CONFIG_MIPS_SEAD3)	+= -I$(srctree)/arch/mips/include/asm/mach-sead3
-load-$(CONFIG_MIPS_SEAD3)	+= 0xffffffff80100000
-all-$(CONFIG_MIPS_SEAD3)	:= $(COMPRESSION_FNAME).srec
diff --git a/arch/mips/mti-sead3/sead3-init.c b/arch/mips/mti-sead3/sead3-init.c
deleted file mode 100644
index 50f3fcb..0000000
--- a/arch/mips/mti-sead3/sead3-init.c
+++ /dev/null
@@ -1,100 +0,0 @@
-/*
- * This file is subject to the terms and conditions of the GNU General Public
- * License.  See the file "COPYING" in the main directory of this archive
- * for more details.
- *
- * Copyright (C) 2012 MIPS Technologies, Inc.  All rights reserved.
- */
-#include <linux/init.h>
-#include <linux/io.h>
-
-#include <asm/bootinfo.h>
-#include <asm/cacheflush.h>
-#include <asm/traps.h>
-#include <asm/mips-boards/generic.h>
-#include <asm/fw/fw.h>
-
-extern char except_vec_nmi;
-extern char except_vec_ejtag_debug;
-
-static void __init mips_nmi_setup(void)
-{
-	void *base;
-
-	base = cpu_has_veic ?
-		(void *)(CAC_BASE + 0xa80) :
-		(void *)(CAC_BASE + 0x380);
-#ifdef CONFIG_CPU_MICROMIPS
-	/*
-	 * Decrement the exception vector address by one for microMIPS.
-	 */
-	memcpy(base, (&except_vec_nmi - 1), 0x80);
-
-	/*
-	 * This is a hack. We do not know if the boot loader was built with
-	 * microMIPS instructions or not. If it was not, the NMI exception
-	 * code at 0x80000a80 will be taken in MIPS32 mode. The hand coded
-	 * assembly below forces us into microMIPS mode if we are a pure
-	 * microMIPS kernel. The assembly instructions are:
-	 *
-	 *  3C1A8000   lui       k0,0x8000
-	 *  375A0381   ori       k0,k0,0x381
-	 *  03400008   jr        k0
-	 *  00000000   nop
-	 *
-	 * The mode switch occurs by jumping to the unaligned exception
-	 * vector address at 0x80000381 which would have been 0x80000380
-	 * in MIPS32 mode. The jump to the unaligned address transitions
-	 * us into microMIPS mode.
-	 */
-	if (!cpu_has_veic) {
-		void *base2 = (void *)(CAC_BASE + 0xa80);
-		*((unsigned int *)base2) = 0x3c1a8000;
-		*((unsigned int *)base2 + 1) = 0x375a0381;
-		*((unsigned int *)base2 + 2) = 0x03400008;
-		*((unsigned int *)base2 + 3) = 0x00000000;
-		flush_icache_range((unsigned long)base2,
-			(unsigned long)base2 + 0x10);
-	}
-#else
-	memcpy(base, &except_vec_nmi, 0x80);
-#endif
-	flush_icache_range((unsigned long)base, (unsigned long)base + 0x80);
-}
-
-static void __init mips_ejtag_setup(void)
-{
-	void *base;
-
-	base = cpu_has_veic ?
-		(void *)(CAC_BASE + 0xa00) :
-		(void *)(CAC_BASE + 0x300);
-#ifdef CONFIG_CPU_MICROMIPS
-	/* Deja vu... */
-	memcpy(base, (&except_vec_ejtag_debug - 1), 0x80);
-	if (!cpu_has_veic) {
-		void *base2 = (void *)(CAC_BASE + 0xa00);
-		*((unsigned int *)base2) = 0x3c1a8000;
-		*((unsigned int *)base2 + 1) = 0x375a0301;
-		*((unsigned int *)base2 + 2) = 0x03400008;
-		*((unsigned int *)base2 + 3) = 0x00000000;
-		flush_icache_range((unsigned long)base2,
-			(unsigned long)base2 + 0x10);
-	}
-#else
-	memcpy(base, &except_vec_ejtag_debug, 0x80);
-#endif
-	flush_icache_range((unsigned long)base, (unsigned long)base + 0x80);
-}
-
-void __init prom_init(void)
-{
-	board_nmi_handler_setup = mips_nmi_setup;
-	board_ejtag_handler_setup = mips_ejtag_setup;
-
-	fw_init_cmdline();
-}
-
-void __init prom_free_prom_memory(void)
-{
-}
diff --git a/arch/mips/mti-sead3/sead3-int.c b/arch/mips/mti-sead3/sead3-int.c
deleted file mode 100644
index 2e6b732..0000000
--- a/arch/mips/mti-sead3/sead3-int.c
+++ /dev/null
@@ -1,23 +0,0 @@
-/*
- * This file is subject to the terms and conditions of the GNU General Public
- * License.  See the file "COPYING" in the main directory of this archive
- * for more details.
- *
- * Copyright (C) 2012 MIPS Technologies, Inc.  All rights reserved.
- */
-#include <linux/init.h>
-#include <linux/irqchip.h>
-#include <linux/irqchip/mips-gic.h>
-
-#include <asm/cpu-info.h>
-#include <asm/irq.h>
-
-void __init arch_init_irq(void)
-{
-	irqchip_init();
-
-	pr_info("GIC: %spresent\n", (gic_present) ? "" : "not ");
-	pr_info("EIC: %s\n",
-		(current_cpu_data.options & MIPS_CPU_VEIC) ?  "on" : "off");
-}
-
diff --git a/arch/mips/mti-sead3/sead3-setup.c b/arch/mips/mti-sead3/sead3-setup.c
deleted file mode 100644
index c915e54..0000000
--- a/arch/mips/mti-sead3/sead3-setup.c
+++ /dev/null
@@ -1,39 +0,0 @@
-/*
- * This file is subject to the terms and conditions of the GNU General Public
- * License.  See the file "COPYING" in the main directory of this archive
- * for more details.
- *
- * Copyright (C) 2012 MIPS Technologies, Inc.  All rights reserved.
- * Copyright (C) 2013 Imagination Technologies Ltd.
- */
-#include <linux/init.h>
-#include <linux/libfdt.h>
-#include <linux/of_fdt.h>
-
-#include <asm/prom.h>
-
-#include <asm/mach-sead3/sead3-dtshim.h>
-#include <asm/mips-boards/generic.h>
-
-const char *get_system_type(void)
-{
-	return "MIPS SEAD3";
-}
-
-void __init *plat_get_fdt(void)
-{
-	return (void *)__dtb_start;
-}
-
-void __init plat_mem_setup(void)
-{
-	void *fdt = plat_get_fdt();
-
-	fdt = sead3_dt_shim(fdt);
-	__dt_setup_arch(fdt);
-}
-
-void __init device_tree_init(void)
-{
-	unflatten_and_copy_device_tree();
-}
diff --git a/arch/mips/mti-sead3/sead3-time.c b/arch/mips/mti-sead3/sead3-time.c
deleted file mode 100644
index 71feb51..0000000
--- a/arch/mips/mti-sead3/sead3-time.c
+++ /dev/null
@@ -1,91 +0,0 @@
-/*
- * This file is subject to the terms and conditions of the GNU General Public
- * License.  See the file "COPYING" in the main directory of this archive
- * for more details.
- *
- * Copyright (C) 2012 MIPS Technologies, Inc.  All rights reserved.
- */
-#include <linux/init.h>
-#include <linux/irqchip/mips-gic.h>
-
-#include <asm/cpu.h>
-#include <asm/setup.h>
-#include <asm/time.h>
-#include <asm/irq.h>
-#include <asm/mips-boards/generic.h>
-
-static void __iomem *status_reg = (void __iomem *)0xbf000410;
-
-/*
- * Estimate CPU frequency.  Sets mips_hpt_frequency as a side-effect.
- */
-static unsigned int __init estimate_cpu_frequency(void)
-{
-	unsigned int prid = read_c0_prid() & (PRID_COMP_MASK | PRID_IMP_MASK);
-	unsigned int tick = 0;
-	unsigned int freq;
-	unsigned int orig;
-	unsigned long flags;
-
-	local_irq_save(flags);
-
-	orig = readl(status_reg) & 0x2;		      /* get original sample */
-	/* wait for transition */
-	while ((readl(status_reg) & 0x2) == orig)
-		;
-	orig = orig ^ 0x2;			      /* flip the bit */
-
-	write_c0_count(0);
-
-	/* wait 1 second (the sampling clock transitions every 10ms) */
-	while (tick < 100) {
-		/* wait for transition */
-		while ((readl(status_reg) & 0x2) == orig)
-			;
-		orig = orig ^ 0x2;			      /* flip the bit */
-		tick++;
-	}
-
-	freq = read_c0_count();
-
-	local_irq_restore(flags);
-
-	mips_hpt_frequency = freq;
-
-	/* Adjust for processor */
-	if ((prid != (PRID_COMP_MIPS | PRID_IMP_20KC)) &&
-		(prid != (PRID_COMP_MIPS | PRID_IMP_25KF)))
-		freq *= 2;
-
-	freq += 5000;	     /* rounding */
-	freq -= freq%10000;
-
-	return freq ;
-}
-
-int get_c0_perfcount_int(void)
-{
-	if (gic_present)
-		return gic_get_c0_perfcount_int();
-	if (cp0_perfcount_irq >= 0)
-		return MIPS_CPU_IRQ_BASE + cp0_perfcount_irq;
-	return -1;
-}
-EXPORT_SYMBOL_GPL(get_c0_perfcount_int);
-
-unsigned int get_c0_compare_int(void)
-{
-	if (gic_present)
-		return gic_get_c0_compare_int();
-	return MIPS_CPU_IRQ_BASE + cp0_compare_irq;
-}
-
-void __init plat_time_init(void)
-{
-	unsigned int est_freq;
-
-	est_freq = estimate_cpu_frequency();
-
-	pr_debug("CPU frequency %d.%02d MHz\n", (est_freq / 1000000),
-		(est_freq % 1000000) * 100 / 1000000);
-}
-- 
2.9.3
