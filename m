Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 15 Jul 2010 21:45:22 +0200 (CEST)
Received: from mail-bw0-f49.google.com ([209.85.214.49]:62513 "EHLO
        mail-bw0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491837Ab0GOTpS (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 15 Jul 2010 21:45:18 +0200
Received: by bwz15 with SMTP id 15so902171bwz.36
        for <linux-mips@linux-mips.org>; Thu, 15 Jul 2010 12:45:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=x6YUF3aeBHYAloSN/vEPVMm4qSMb0+FB7H3tXUU2ODk=;
        b=TeRErKrVCEZw+R4hq7UnC2IhiOMhkfX+qhvWuYhFp+tq5SfwkSsxzJYocODLA9tg8K
         UYQod0AX7VFEecBlKAm+867U2g8PAmMI7WdFFp85MlvE7iCkjSlRdNyunoEZWNyl13Xp
         8DE2A7IhikXZj+Q5k7/duapGASE3rE/GYyHkY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=eWuzJ5Hwdm9DZ5sEOHIS5zJXPxp7jEklZGpM9iSdjZkCurVE2UY38pVE0/Gl2bgzNf
         abaIZWu206jPcqudkp21UIEprMngwCp/lboJq3YUk4v+A9665t2nhRKlguviBhPDv5OV
         8g6cIcbPGKHqV/kxzfBB9Uw5HFZaKjevGm/P8=
Received: by 10.204.101.72 with SMTP id b8mr78477bko.192.1279223117459;
        Thu, 15 Jul 2010 12:45:17 -0700 (PDT)
Received: from localhost.localdomain (fnoeppeil48.netpark.at [217.175.205.176])
        by mx.google.com with ESMTPS id s17sm7274438bkx.18.2010.07.15.12.45.14
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 15 Jul 2010 12:45:15 -0700 (PDT)
From:   Manuel Lauss <manuel.lauss@googlemail.com>
To:     Linux-MIPS <linux-mips@linux-mips.org>
Cc:     Manuel Lauss <manuel.lauss@googlemail.com>
Subject: [PATCH 1/2] MIPS: Alchemy: remove SOC_AU1X00 in favor of MIPS_ALCHEMY
Date:   Thu, 15 Jul 2010 21:45:04 +0200
Message-Id: <1279223105-23816-1-git-send-email-manuel.lauss@googlemail.com>
X-Mailer: git-send-email 1.7.1.1
Return-Path: <manuel.lauss@googlemail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 27396
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: manuel.lauss@googlemail.com
Precedence: bulk
X-list: linux-mips

This patch removes the CONFIG_SOC_AU1X00 Kconfig symbol since its
job can also be done by MACH_ALCHEMY, now renamed to MIPS_ALCHEMY.

Signed-off-by: Manuel Lauss <manuel.lauss@googlemail.com>
---
 arch/mips/Kconfig                  |   11 ++++++++++-
 arch/mips/alchemy/Kconfig          |   19 +------------------
 arch/mips/alchemy/Platform         |    4 ++--
 arch/mips/boot/compressed/Makefile |    2 +-
 arch/mips/configs/db1000_defconfig |    3 +--
 arch/mips/configs/db1100_defconfig |    3 +--
 arch/mips/configs/db1200_defconfig |    3 +--
 arch/mips/configs/db1500_defconfig |    3 +--
 arch/mips/configs/db1550_defconfig |    3 +--
 arch/mips/configs/mtx1_defconfig   |    3 +--
 arch/mips/configs/pb1100_defconfig |    3 +--
 arch/mips/configs/pb1200_defconfig |    3 +--
 arch/mips/configs/pb1500_defconfig |    3 +--
 arch/mips/configs/pb1550_defconfig |    3 +--
 arch/mips/include/asm/hazards.h    |    4 ++--
 drivers/net/Kconfig                |    2 +-
 drivers/pcmcia/Kconfig             |    4 ++--
 drivers/rtc/Kconfig                |    2 +-
 drivers/serial/Kconfig             |    2 +-
 drivers/usb/Kconfig                |    2 +-
 drivers/usb/host/ohci-hcd.c        |    2 +-
 21 files changed, 33 insertions(+), 51 deletions(-)

diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index cdaae94..b189555 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -23,8 +23,17 @@ choice
 	prompt "System type"
 	default SGI_IP22
 
-config MACH_ALCHEMY
+config MIPS_ALCHEMY
 	bool "Alchemy processor based machines"
+	select 64BIT_PHYS_ADDR
+	select CEVT_R4K_LIB
+	select CSRC_R4K_LIB
+	select IRQ_CPU
+	select SYS_HAS_CPU_MIPS32_R1
+	select SYS_SUPPORTS_32BIT_KERNEL
+	select SYS_SUPPORTS_APM_EMULATION
+	select GENERIC_GPIO
+	select ARCH_WANT_OPTIONAL_GPIOLIB
 	select SYS_SUPPORTS_ZBOOT
 
 config AR7
diff --git a/arch/mips/alchemy/Kconfig b/arch/mips/alchemy/Kconfig
index df3b1a7..1179c4d 100644
--- a/arch/mips/alchemy/Kconfig
+++ b/arch/mips/alchemy/Kconfig
@@ -11,7 +11,7 @@ config ALCHEMY_GPIO_INDIRECT
 
 choice
 	prompt "Machine type"
-	depends on MACH_ALCHEMY
+	depends on MIPS_ALCHEMY
 	default MIPS_DB1000
 
 config MIPS_MTX1
@@ -132,37 +132,20 @@ endchoice
 
 config SOC_AU1000
 	bool
-	select SOC_AU1X00
 	select ALCHEMY_GPIOINT_AU1000
 
 config SOC_AU1100
 	bool
-	select SOC_AU1X00
 	select ALCHEMY_GPIOINT_AU1000
 
 config SOC_AU1500
 	bool
-	select SOC_AU1X00
 	select ALCHEMY_GPIOINT_AU1000
 
 config SOC_AU1550
 	bool
-	select SOC_AU1X00
 	select ALCHEMY_GPIOINT_AU1000
 
 config SOC_AU1200
 	bool
-	select SOC_AU1X00
 	select ALCHEMY_GPIOINT_AU1000
-
-config SOC_AU1X00
-	bool
-	select 64BIT_PHYS_ADDR
-	select CEVT_R4K_LIB
-	select CSRC_R4K_LIB
-	select IRQ_CPU
-	select SYS_HAS_CPU_MIPS32_R1
-	select SYS_SUPPORTS_32BIT_KERNEL
-	select SYS_SUPPORTS_APM_EMULATION
-	select GENERIC_GPIO
-	select ARCH_WANT_OPTIONAL_GPIOLIB
diff --git a/arch/mips/alchemy/Platform b/arch/mips/alchemy/Platform
index 495cc9a..0bf2b09 100644
--- a/arch/mips/alchemy/Platform
+++ b/arch/mips/alchemy/Platform
@@ -1,7 +1,7 @@
 #
 # Core Alchemy code
 #
-platform-$(CONFIG_MACH_ALCHEMY)	+= alchemy/common/
+platform-$(CONFIG_MIPS_ALCHEMY)	+= alchemy/common/
 
 
 #
@@ -106,4 +106,4 @@ load-$(CONFIG_MIPS_XXS1500)	+= 0xffffffff80100000
 # compiler picks the board one.  If they don't, it will make sure
 # the alchemy generic gpio header is picked up.
 
-cflags-$(CONFIG_MACH_ALCHEMY)	+= -I$(srctree)/arch/mips/include/asm/mach-au1x00
+cflags-$(CONFIG_MIPS_ALCHEMY)	+= -I$(srctree)/arch/mips/include/asm/mach-au1x00
diff --git a/arch/mips/boot/compressed/Makefile b/arch/mips/boot/compressed/Makefile
index 74a52d7..edc48ad 100644
--- a/arch/mips/boot/compressed/Makefile
+++ b/arch/mips/boot/compressed/Makefile
@@ -40,7 +40,7 @@ vmlinuzobjs-y := $(obj)/head.o $(obj)/decompress.o $(obj)/dbg.o
 
 ifdef CONFIG_DEBUG_ZBOOT
 vmlinuzobjs-$(CONFIG_SYS_SUPPORTS_ZBOOT_UART16550) += $(obj)/uart-16550.o
-vmlinuzobjs-$(CONFIG_MACH_ALCHEMY)		   += $(obj)/uart-alchemy.o
+vmlinuzobjs-$(CONFIG_MIPS_ALCHEMY)		   += $(obj)/uart-alchemy.o
 endif
 
 targets += vmlinux.bin
diff --git a/arch/mips/configs/db1000_defconfig b/arch/mips/configs/db1000_defconfig
index f66d406..3a9ec6c 100644
--- a/arch/mips/configs/db1000_defconfig
+++ b/arch/mips/configs/db1000_defconfig
@@ -8,7 +8,7 @@ CONFIG_MIPS=y
 #
 # Machine selection
 #
-CONFIG_MACH_ALCHEMY=y
+CONFIG_MIPS_ALCHEMY=y
 # CONFIG_AR7 is not set
 # CONFIG_BCM47XX is not set
 # CONFIG_BCM63XX is not set
@@ -64,7 +64,6 @@ CONFIG_MIPS_DB1000=y
 # CONFIG_MIPS_PB1550 is not set
 # CONFIG_MIPS_XXS1500 is not set
 CONFIG_SOC_AU1000=y
-CONFIG_SOC_AU1X00=y
 CONFIG_LOONGSON_UART_BASE=y
 CONFIG_RWSEM_GENERIC_SPINLOCK=y
 # CONFIG_ARCH_HAS_ILOG2_U32 is not set
diff --git a/arch/mips/configs/db1100_defconfig b/arch/mips/configs/db1100_defconfig
index abb9a58..4589b84 100644
--- a/arch/mips/configs/db1100_defconfig
+++ b/arch/mips/configs/db1100_defconfig
@@ -8,7 +8,7 @@ CONFIG_MIPS=y
 #
 # Machine selection
 #
-CONFIG_MACH_ALCHEMY=y
+CONFIG_MIPS_ALCHEMY=y
 # CONFIG_AR7 is not set
 # CONFIG_BCM47XX is not set
 # CONFIG_BCM63XX is not set
@@ -64,7 +64,6 @@ CONFIG_MIPS_DB1100=y
 # CONFIG_MIPS_PB1550 is not set
 # CONFIG_MIPS_XXS1500 is not set
 CONFIG_SOC_AU1100=y
-CONFIG_SOC_AU1X00=y
 CONFIG_LOONGSON_UART_BASE=y
 CONFIG_RWSEM_GENERIC_SPINLOCK=y
 # CONFIG_ARCH_HAS_ILOG2_U32 is not set
diff --git a/arch/mips/configs/db1200_defconfig b/arch/mips/configs/db1200_defconfig
index 991c20a..9950f2a 100644
--- a/arch/mips/configs/db1200_defconfig
+++ b/arch/mips/configs/db1200_defconfig
@@ -8,7 +8,7 @@ CONFIG_MIPS=y
 #
 # Machine selection
 #
-CONFIG_MACH_ALCHEMY=y
+CONFIG_MIPS_ALCHEMY=y
 # CONFIG_AR7 is not set
 # CONFIG_BCM47XX is not set
 # CONFIG_BCM63XX is not set
@@ -64,7 +64,6 @@ CONFIG_MIPS_DB1200=y
 # CONFIG_MIPS_PB1550 is not set
 # CONFIG_MIPS_XXS1500 is not set
 CONFIG_SOC_AU1200=y
-CONFIG_SOC_AU1X00=y
 CONFIG_LOONGSON_UART_BASE=y
 CONFIG_RWSEM_GENERIC_SPINLOCK=y
 # CONFIG_ARCH_HAS_ILOG2_U32 is not set
diff --git a/arch/mips/configs/db1500_defconfig b/arch/mips/configs/db1500_defconfig
index 5424c91..346ae63 100644
--- a/arch/mips/configs/db1500_defconfig
+++ b/arch/mips/configs/db1500_defconfig
@@ -8,7 +8,7 @@ CONFIG_MIPS=y
 #
 # Machine selection
 #
-CONFIG_MACH_ALCHEMY=y
+CONFIG_MIPS_ALCHEMY=y
 # CONFIG_AR7 is not set
 # CONFIG_BCM47XX is not set
 # CONFIG_BCM63XX is not set
@@ -64,7 +64,6 @@ CONFIG_MIPS_DB1500=y
 # CONFIG_MIPS_PB1550 is not set
 # CONFIG_MIPS_XXS1500 is not set
 CONFIG_SOC_AU1500=y
-CONFIG_SOC_AU1X00=y
 CONFIG_LOONGSON_UART_BASE=y
 CONFIG_RWSEM_GENERIC_SPINLOCK=y
 # CONFIG_ARCH_HAS_ILOG2_U32 is not set
diff --git a/arch/mips/configs/db1550_defconfig b/arch/mips/configs/db1550_defconfig
index 949b6dc..10eafb9 100644
--- a/arch/mips/configs/db1550_defconfig
+++ b/arch/mips/configs/db1550_defconfig
@@ -8,7 +8,7 @@ CONFIG_MIPS=y
 #
 # Machine selection
 #
-CONFIG_MACH_ALCHEMY=y
+CONFIG_MIPS_ALCHEMY=y
 # CONFIG_AR7 is not set
 # CONFIG_BCM47XX is not set
 # CONFIG_BCM63XX is not set
@@ -64,7 +64,6 @@ CONFIG_MIPS_DB1550=y
 # CONFIG_MIPS_PB1550 is not set
 # CONFIG_MIPS_XXS1500 is not set
 CONFIG_SOC_AU1550=y
-CONFIG_SOC_AU1X00=y
 CONFIG_LOONGSON_UART_BASE=y
 CONFIG_RWSEM_GENERIC_SPINLOCK=y
 # CONFIG_ARCH_HAS_ILOG2_U32 is not set
diff --git a/arch/mips/configs/mtx1_defconfig b/arch/mips/configs/mtx1_defconfig
index cff8f4c..10d20aa 100644
--- a/arch/mips/configs/mtx1_defconfig
+++ b/arch/mips/configs/mtx1_defconfig
@@ -8,7 +8,7 @@ CONFIG_MIPS=y
 #
 # Machine selection
 #
-CONFIG_MACH_ALCHEMY=y
+CONFIG_MIPS_ALCHEMY=y
 # CONFIG_AR7 is not set
 # CONFIG_BCM47XX is not set
 # CONFIG_BCM63XX is not set
@@ -64,7 +64,6 @@ CONFIG_MIPS_MTX1=y
 # CONFIG_MIPS_PB1550 is not set
 # CONFIG_MIPS_XXS1500 is not set
 CONFIG_SOC_AU1500=y
-CONFIG_SOC_AU1X00=y
 CONFIG_LOONGSON_UART_BASE=y
 CONFIG_RWSEM_GENERIC_SPINLOCK=y
 # CONFIG_ARCH_HAS_ILOG2_U32 is not set
diff --git a/arch/mips/configs/pb1100_defconfig b/arch/mips/configs/pb1100_defconfig
index 97382b6..778f726 100644
--- a/arch/mips/configs/pb1100_defconfig
+++ b/arch/mips/configs/pb1100_defconfig
@@ -8,7 +8,7 @@ CONFIG_MIPS=y
 #
 # Machine selection
 #
-CONFIG_MACH_ALCHEMY=y
+CONFIG_MIPS_ALCHEMY=y
 # CONFIG_AR7 is not set
 # CONFIG_BCM47XX is not set
 # CONFIG_BCM63XX is not set
@@ -64,7 +64,6 @@ CONFIG_MIPS_PB1100=y
 # CONFIG_MIPS_PB1550 is not set
 # CONFIG_MIPS_XXS1500 is not set
 CONFIG_SOC_AU1100=y
-CONFIG_SOC_AU1X00=y
 CONFIG_LOONGSON_UART_BASE=y
 CONFIG_RWSEM_GENERIC_SPINLOCK=y
 # CONFIG_ARCH_HAS_ILOG2_U32 is not set
diff --git a/arch/mips/configs/pb1200_defconfig b/arch/mips/configs/pb1200_defconfig
index e9ad773..0f908c6 100644
--- a/arch/mips/configs/pb1200_defconfig
+++ b/arch/mips/configs/pb1200_defconfig
@@ -8,7 +8,7 @@ CONFIG_MIPS=y
 #
 # Machine selection
 #
-CONFIG_MACH_ALCHEMY=y
+CONFIG_MIPS_ALCHEMY=y
 # CONFIG_AR7 is not set
 # CONFIG_BCM47XX is not set
 # CONFIG_BCM63XX is not set
@@ -64,7 +64,6 @@ CONFIG_MIPS_PB1200=y
 # CONFIG_MIPS_PB1550 is not set
 # CONFIG_MIPS_XXS1500 is not set
 CONFIG_SOC_AU1200=y
-CONFIG_SOC_AU1X00=y
 CONFIG_LOONGSON_UART_BASE=y
 CONFIG_RWSEM_GENERIC_SPINLOCK=y
 # CONFIG_ARCH_HAS_ILOG2_U32 is not set
diff --git a/arch/mips/configs/pb1500_defconfig b/arch/mips/configs/pb1500_defconfig
index 7497d33..1c5fe6f 100644
--- a/arch/mips/configs/pb1500_defconfig
+++ b/arch/mips/configs/pb1500_defconfig
@@ -8,7 +8,7 @@ CONFIG_MIPS=y
 #
 # Machine selection
 #
-CONFIG_MACH_ALCHEMY=y
+CONFIG_MIPS_ALCHEMY=y
 # CONFIG_AR7 is not set
 # CONFIG_BCM47XX is not set
 # CONFIG_BCM63XX is not set
@@ -64,7 +64,6 @@ CONFIG_MIPS_PB1500=y
 # CONFIG_MIPS_PB1550 is not set
 # CONFIG_MIPS_XXS1500 is not set
 CONFIG_SOC_AU1500=y
-CONFIG_SOC_AU1X00=y
 CONFIG_LOONGSON_UART_BASE=y
 CONFIG_RWSEM_GENERIC_SPINLOCK=y
 # CONFIG_ARCH_HAS_ILOG2_U32 is not set
diff --git a/arch/mips/configs/pb1550_defconfig b/arch/mips/configs/pb1550_defconfig
index aa526f5..49494b0 100644
--- a/arch/mips/configs/pb1550_defconfig
+++ b/arch/mips/configs/pb1550_defconfig
@@ -8,7 +8,7 @@ CONFIG_MIPS=y
 #
 # Machine selection
 #
-CONFIG_MACH_ALCHEMY=y
+CONFIG_MIPS_ALCHEMY=y
 # CONFIG_AR7 is not set
 # CONFIG_BCM47XX is not set
 # CONFIG_BCM63XX is not set
@@ -64,7 +64,6 @@ CONFIG_ALCHEMY_GPIOINT_AU1000=y
 CONFIG_MIPS_PB1550=y
 # CONFIG_MIPS_XXS1500 is not set
 CONFIG_SOC_AU1550=y
-CONFIG_SOC_AU1X00=y
 CONFIG_LOONGSON_UART_BASE=y
 CONFIG_RWSEM_GENERIC_SPINLOCK=y
 # CONFIG_ARCH_HAS_ILOG2_U32 is not set
diff --git a/arch/mips/include/asm/hazards.h b/arch/mips/include/asm/hazards.h
index 0eaf77f..4e33216 100644
--- a/arch/mips/include/asm/hazards.h
+++ b/arch/mips/include/asm/hazards.h
@@ -87,7 +87,7 @@ do {									\
 	: "=r" (tmp));							\
 } while (0)
 
-#elif defined(CONFIG_CPU_MIPSR1) && !defined(CONFIG_MACH_ALCHEMY)
+#elif defined(CONFIG_CPU_MIPSR1) && !defined(CONFIG_MIPS_ALCHEMY)
 
 /*
  * These are slightly complicated by the fact that we guarantee R1 kernels to
@@ -138,7 +138,7 @@ do {									\
 		__instruction_hazard();					\
 } while (0)
 
-#elif defined(CONFIG_MACH_ALCHEMY) || defined(CONFIG_CPU_CAVIUM_OCTEON) || \
+#elif defined(CONFIG_MIPS_ALCHEMY) || defined(CONFIG_CPU_CAVIUM_OCTEON) || \
       defined(CONFIG_CPU_LOONGSON2) || defined(CONFIG_CPU_R10000) || \
       defined(CONFIG_CPU_R5500)
 
diff --git a/drivers/net/Kconfig b/drivers/net/Kconfig
index ce2fcdd..adead30 100644
--- a/drivers/net/Kconfig
+++ b/drivers/net/Kconfig
@@ -484,7 +484,7 @@ config XTENSA_XT2000_SONIC
 
 config MIPS_AU1X00_ENET
 	tristate "MIPS AU1000 Ethernet support"
-	depends on SOC_AU1X00
+	depends on MIPS_ALCHEMY
 	select PHYLIB
 	select CRC32
 	help
diff --git a/drivers/pcmcia/Kconfig b/drivers/pcmcia/Kconfig
index d0f5ad3..c988514 100644
--- a/drivers/pcmcia/Kconfig
+++ b/drivers/pcmcia/Kconfig
@@ -157,11 +157,11 @@ config PCMCIA_M8XX
 
 config PCMCIA_AU1X00
 	tristate "Au1x00 pcmcia support"
-	depends on SOC_AU1X00 && PCMCIA
+	depends on MIPS_ALCHEMY && PCMCIA
 
 config PCMCIA_ALCHEMY_DEVBOARD
 	tristate "Alchemy Db/Pb1xxx PCMCIA socket services"
-	depends on SOC_AU1X00 && PCMCIA
+	depends on MIPS_ALCHEMY && PCMCIA
 	select 64BIT_PHYS_ADDR
 	help
 	  Enable this driver of you want PCMCIA support on your Alchemy
diff --git a/drivers/rtc/Kconfig b/drivers/rtc/Kconfig
index 10ba12c..9d6952e 100644
--- a/drivers/rtc/Kconfig
+++ b/drivers/rtc/Kconfig
@@ -774,7 +774,7 @@ config RTC_DRV_AT91SAM9_GPBR
 
 config RTC_DRV_AU1XXX
 	tristate "Au1xxx Counter0 RTC support"
-	depends on SOC_AU1X00
+	depends on MIPS_ALCHEMY
 	help
 	  This is a driver for the Au1xxx on-chip Counter0 (Time-Of-Year
 	  counter) to be used as a RTC.
diff --git a/drivers/serial/Kconfig b/drivers/serial/Kconfig
index 8b23165..1acc7b3 100644
--- a/drivers/serial/Kconfig
+++ b/drivers/serial/Kconfig
@@ -260,7 +260,7 @@ config SERIAL_8250_ACORN
 
 config SERIAL_8250_AU1X00
 	bool "Au1x00 serial port support"
-	depends on SERIAL_8250 != n && SOC_AU1X00
+	depends on SERIAL_8250 != n && MIPS_ALCHEMY
 	help
 	  If you have an Au1x00 SOC based board and want to use the serial port,
 	  say Y to this option. The driver can handle up to 4 serial ports,
diff --git a/drivers/usb/Kconfig b/drivers/usb/Kconfig
index 6a58cb1..c2ddab1 100644
--- a/drivers/usb/Kconfig
+++ b/drivers/usb/Kconfig
@@ -45,7 +45,7 @@ config USB_ARCH_HAS_OHCI
 	default y if STB03xxx
 	default y if PPC_MPC52xx
 	# MIPS:
-	default y if SOC_AU1X00
+	default y if MIPS_ALCHEMY
 	# SH:
 	default y if CPU_SUBTYPE_SH7720
 	default y if CPU_SUBTYPE_SH7721
diff --git a/drivers/usb/host/ohci-hcd.c b/drivers/usb/host/ohci-hcd.c
index fc57655..ba6b0a5 100644
--- a/drivers/usb/host/ohci-hcd.c
+++ b/drivers/usb/host/ohci-hcd.c
@@ -1031,7 +1031,7 @@ MODULE_LICENSE ("GPL");
 #define PLATFORM_DRIVER		ohci_hcd_ep93xx_driver
 #endif
 
-#ifdef CONFIG_SOC_AU1X00
+#ifdef CONFIG_MIPS_ALCHEMY
 #include "ohci-au1xxx.c"
 #define PLATFORM_DRIVER		ohci_hcd_au1xxx_driver
 #endif
-- 
1.7.1.1
