Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 23 Jan 2013 13:12:18 +0100 (CET)
Received: from nbd.name ([46.4.11.11]:52061 "EHLO nbd.name"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6833407Ab3AWMJGS6uYa (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 23 Jan 2013 13:09:06 +0100
From:   John Crispin <blogic@openwrt.org>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     linux-mips@linux-mips.org, John Crispin <blogic@openwrt.org>
Subject: [RFC 11/11] MIPS: ralink: adds Kbuild files
Date:   Wed, 23 Jan 2013 13:05:55 +0100
Message-Id: <1358942755-25371-12-git-send-email-blogic@openwrt.org>
X-Mailer: git-send-email 1.7.10.4
In-Reply-To: <1358942755-25371-1-git-send-email-blogic@openwrt.org>
References: <1358942755-25371-1-git-send-email-blogic@openwrt.org>
X-archive-position: 35517
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: blogic@openwrt.org
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

Add the Kbuild symbols and Makefiles needed to actually build the ralink code
from this series

Signed-off-by: John Crispin <blogic@openwrt.org>
---
 arch/mips/Kbuild.platforms    |    1 +
 arch/mips/Kconfig             |   19 ++++++++++++++++++-
 arch/mips/ralink/Kconfig      |   27 +++++++++++++++++++++++++++
 arch/mips/ralink/Makefile     |   15 +++++++++++++++
 arch/mips/ralink/Platform     |   11 +++++++++++
 arch/mips/ralink/dts/Makefile |    1 +
 6 files changed, 73 insertions(+), 1 deletion(-)
 create mode 100644 arch/mips/ralink/Kconfig
 create mode 100644 arch/mips/ralink/Makefile
 create mode 100644 arch/mips/ralink/Platform
 create mode 100644 arch/mips/ralink/dts/Makefile

diff --git a/arch/mips/Kbuild.platforms b/arch/mips/Kbuild.platforms
index 91b9d69..9a73ce6 100644
--- a/arch/mips/Kbuild.platforms
+++ b/arch/mips/Kbuild.platforms
@@ -22,6 +22,7 @@ platforms += pmc-sierra
 platforms += pnx833x
 platforms += pnx8550
 platforms += powertv
+platforms += ralink
 platforms += rb532
 platforms += sgi-ip22
 platforms += sgi-ip27
diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index 2ac626a..89c92d3 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -434,6 +434,22 @@ config POWERTV
 	help
 	  This enables support for the Cisco PowerTV Platform.
 
+config RALINK
+	bool "Ralink based machines"
+	select CEVT_R4K
+	select CSRC_R4K
+	select BOOT_RAW
+	select DMA_NONCOHERENT
+	select IRQ_CPU
+	select USE_OF
+	select SYS_HAS_CPU_MIPS32_R1
+	select SYS_HAS_CPU_MIPS32_R2
+	select SYS_SUPPORTS_32BIT_KERNEL
+	select SYS_SUPPORTS_LITTLE_ENDIAN
+	select SYS_HAS_EARLY_PRINTK
+	select HAVE_MACH_CLKDEV
+	select CLKDEV_LOOKUP
+
 config SGI_IP22
 	bool "SGI IP22 (Indy/Indigo2)"
 	select FW_ARC
@@ -846,6 +862,7 @@ source "arch/mips/lantiq/Kconfig"
 source "arch/mips/lasat/Kconfig"
 source "arch/mips/pmc-sierra/Kconfig"
 source "arch/mips/powertv/Kconfig"
+source "arch/mips/ralink/Kconfig"
 source "arch/mips/sgi-ip27/Kconfig"
 source "arch/mips/sibyte/Kconfig"
 source "arch/mips/txx9/Kconfig"
@@ -1160,7 +1177,7 @@ config BOOT_ELF32
 
 config MIPS_L1_CACHE_SHIFT
 	int
-	default "4" if MACH_DECSTATION || MIKROTIK_RB532 || PMC_MSP4200_EVAL
+	default "4" if MACH_DECSTATION || MIKROTIK_RB532 || PMC_MSP4200_EVAL || RALINK_RT288X
 	default "6" if MIPS_CPU_SCACHE
 	default "7" if SGI_IP22 || SGI_IP27 || SGI_IP28 || SNI_RM || CPU_CAVIUM_OCTEON
 	default "5"
diff --git a/arch/mips/ralink/Kconfig b/arch/mips/ralink/Kconfig
new file mode 100644
index 0000000..1be044c
--- /dev/null
+++ b/arch/mips/ralink/Kconfig
@@ -0,0 +1,27 @@
+if RALINK
+
+choice
+	prompt "Ralink SoC selection"
+	default SOC_RT305X
+	help
+	  Select Ralink MIPS SoC type.
+
+	config SOC_RT305X
+		bool "RT305x"
+		select USB_ARCH_HAS_OHCI
+		select USB_ARCH_HAS_EHCI
+
+endchoice
+
+choice
+	prompt "Devicetree selection"
+	default DTB_RT305X_EVAL
+	help
+	  Select the devicetree.
+
+	config DTB_RT305X_EVAL
+		bool "RT305x eval kit"
+
+endchoice
+
+endif
diff --git a/arch/mips/ralink/Makefile b/arch/mips/ralink/Makefile
new file mode 100644
index 0000000..939757f
--- /dev/null
+++ b/arch/mips/ralink/Makefile
@@ -0,0 +1,15 @@
+# This program is free software; you can redistribute it and/or modify it
+# under the terms of the GNU General Public License version 2 as published
+# by the Free Software Foundation.#
+# Makefile for the Ralink common stuff
+#
+# Copyright (C) 2009-2011 Gabor Juhos <juhosg@openwrt.org>
+# Copyright (C) 2013 John Crispin <blogic@openwrt.org>
+
+obj-y := prom.o of.o reset.o clk.o irq.o
+
+obj-$(CONFIG_SOC_RT305X) += rt305x.o
+
+obj-$(CONFIG_EARLY_PRINTK) += early_printk.o
+
+obj-y += dts/
diff --git a/arch/mips/ralink/Platform b/arch/mips/ralink/Platform
new file mode 100644
index 0000000..1d7e8fb
--- /dev/null
+++ b/arch/mips/ralink/Platform
@@ -0,0 +1,11 @@
+#
+# Ralink SoC common stuff
+#
+core-$(CONFIG_RALINK)     += arch/mips/ralink/
+cflags-$(CONFIG_RALINK)   += -I$(srctree)/arch/mips/include/asm/mach-ralink
+
+#
+# Ralink RT305x
+#
+cflags-$(CONFIG_SOC_RT305X) += -I$(srctree)/arch/mips/include/asm/mach-ralink/rt305x
+load-$(CONFIG_SOC_RT305X)   += 0xffffffff80000000
diff --git a/arch/mips/ralink/dts/Makefile b/arch/mips/ralink/dts/Makefile
new file mode 100644
index 0000000..e2ce7b4
--- /dev/null
+++ b/arch/mips/ralink/dts/Makefile
@@ -0,0 +1 @@
+obj-$(CONFIG_DTB_RT305X_EVAL) := rt305x.dtb.o
-- 
1.7.10.4
