Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 23 Oct 2008 22:00:11 +0100 (BST)
Received: from smtp16.dti.ne.jp ([202.216.231.191]:52621 "EHLO
	smtp16.dti.ne.jp") by ftp.linux-mips.org with ESMTP
	id S22247615AbYJWVAI (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 23 Oct 2008 22:00:08 +0100
Received: from [192.168.1.3] (PPPax526.tokyo-ip.dti.ne.jp [210.170.129.26]) by smtp16.dti.ne.jp (3.11s) with ESMTP AUTH id m9NL01R2009038;Fri, 24 Oct 2008 06:00:04 +0900 (JST)
Message-ID: <4900E5D1.9080400@ruby.dti.ne.jp>
Date:	Fri, 24 Oct 2008 06:00:01 +0900
From:	Shinya Kuribayashi <skuribay@ruby.dti.ne.jp>
User-Agent: Thunderbird 2.0.0.17 (X11/20080925)
MIME-Version: 1.0
To:	linux-mips@linux-mips.org
CC:	shinya.kuribayashi@necel.com
Subject: [PATCH 02/12] MIPS: EMMA Kconfig reorganization
References: <4900A510.3000101@ruby.dti.ne.jp>
In-Reply-To: <4900A510.3000101@ruby.dti.ne.jp>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <skuribay@ruby.dti.ne.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 20874
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: skuribay@ruby.dti.ne.jp
Precedence: bulk
X-list: linux-mips

- Move EMMA related stuff into arch/mips/emma/Kconfig
- Create CONFIG_SOC_EMMA* to handle more EMMA SoCs effectively
- Rename CONFIG_MARKEINS into CONFIG_NEC_MARKEINS

Signed-off-by: Shinya Kuribayashi <shinya.kuribayashi@necel.com>
---

[02/12] does not seem to be properly transfered.  Here it is.


 arch/mips/Kconfig                       |   17 +++--------------
 arch/mips/Makefile                      |   11 +++++++----
 arch/mips/emma/Kconfig                  |   29 +++++++++++++++++++++++++++++
 arch/mips/emma2rh/common/Makefile       |    2 +-
 arch/mips/emma2rh/common/prom.c         |    4 ++--
 arch/mips/emma2rh/markeins/Makefile     |    2 +-
 arch/mips/include/asm/emma2rh/emma2rh.h |    2 +-
 arch/mips/pci/Makefile                  |    2 +-
 8 files changed, 45 insertions(+), 24 deletions(-)
 create mode 100644 arch/mips/emma/Kconfig

diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index e6ad125..7c638a7 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -238,20 +238,8 @@ config MIPS_SIM
 	  This option enables support for MIPS Technologies MIPSsim software
 	  emulator.
 
-config MARKEINS
-	bool "NEC EMMA2RH Mark-eins"
-	select CEVT_R4K
-	select CSRC_R4K
-	select DMA_NONCOHERENT
-	select HW_HAS_PCI
-	select IRQ_CPU
-	select SWAP_IO_SPACE
-	select SYS_SUPPORTS_32BIT_KERNEL
-	select SYS_SUPPORTS_BIG_ENDIAN
-	select SYS_SUPPORTS_LITTLE_ENDIAN
-	select SYS_HAS_CPU_R5500
-	help
-	  This enables support for the NEC Mark-eins board with VR5500 CPU.
+config MACH_EMMA
+	bool "NEC EMMA series based machines"
 
 config MACH_VR41XX
 	bool "NEC VR4100 series based machines"
@@ -600,6 +588,7 @@ endchoice
 
 source "arch/mips/alchemy/Kconfig"
 source "arch/mips/basler/excite/Kconfig"
+source "arch/mips/emma/Kconfig"
 source "arch/mips/jazz/Kconfig"
 source "arch/mips/lasat/Kconfig"
 source "arch/mips/pmc-sierra/Kconfig"
diff --git a/arch/mips/Makefile b/arch/mips/Makefile
index c2197c3..a1d1f77 100644
--- a/arch/mips/Makefile
+++ b/arch/mips/Makefile
@@ -401,14 +401,17 @@ load-$(CONFIG_PNX8550_JBS)	+= 0xffffffff80060000
 libs-$(CONFIG_PNX8550_STB810)	+= arch/mips/nxp/pnx8550/stb810/
 load-$(CONFIG_PNX8550_STB810)	+= 0xffffffff80060000
 
+#
 # NEC EMMA2RH boards
 #
-core-$(CONFIG_EMMA2RH)          += arch/mips/emma2rh/common/
-cflags-$(CONFIG_EMMA2RH)        += -I$(srctree)/arch/mips/include/asm/mach-emma2rh
+core-$(CONFIG_SOC_EMMA2RH)	+= arch/mips/emma2rh/common/
+cflags-$(CONFIG_SOC_EMMA2RH)	+= -I$(srctree)/arch/mips/include/asm/mach-emma2rh
 
+#
 # NEC EMMA2RH Mark-eins
-core-$(CONFIG_MARKEINS)         += arch/mips/emma2rh/markeins/
-load-$(CONFIG_MARKEINS)         += 0xffffffff88100000
+#
+core-$(CONFIG_NEC_MARKEINS)	+= arch/mips/emma2rh/markeins/
+load-$(CONFIG_NEC_MARKEINS)	+= 0xffffffff88100000
 
 #
 # SGI IP22 (Indy/Indigo2)
diff --git a/arch/mips/emma/Kconfig b/arch/mips/emma/Kconfig
new file mode 100644
index 0000000..9669c72
--- /dev/null
+++ b/arch/mips/emma/Kconfig
@@ -0,0 +1,29 @@
+choice
+	prompt "Machine type"
+	depends on MACH_EMMA
+	default NEC_MARKEINS
+
+config NEC_MARKEINS
+	bool "NEC EMMA2RH Mark-eins board"
+	select SOC_EMMA2RH
+	select HW_HAS_PCI
+	help
+	  This enables support for the NEC Electronics Mark-eins boards.
+
+endchoice
+
+config SOC_EMMA2RH
+	bool
+	select SOC_EMMA
+	select SYS_HAS_CPU_R5500
+	select SYS_SUPPORTS_32BIT_KERNEL
+	select SYS_SUPPORTS_64BIT_KERNEL
+
+config SOC_EMMA
+	bool
+	select CEVT_R4K
+	select CSRC_R4K
+	select DMA_NONCOHERENT
+	select IRQ_CPU
+	select SWAP_IO_SPACE
+	select SYS_SUPPORTS_BIG_ENDIAN
diff --git a/arch/mips/emma2rh/common/Makefile b/arch/mips/emma2rh/common/Makefile
index 859121b..cb0fd32 100644
--- a/arch/mips/emma2rh/common/Makefile
+++ b/arch/mips/emma2rh/common/Makefile
@@ -10,4 +10,4 @@
 #  (at your option) any later version.
 #
 
-obj-$(CONFIG_MARKEINS)	+= irq.o irq_emma2rh.o prom.o
+obj-$(CONFIG_NEC_MARKEINS)	+= irq.o irq_emma2rh.o prom.o
diff --git a/arch/mips/emma2rh/common/prom.c b/arch/mips/emma2rh/common/prom.c
index e14a2e3..97bf29e 100644
--- a/arch/mips/emma2rh/common/prom.c
+++ b/arch/mips/emma2rh/common/prom.c
@@ -33,7 +33,7 @@
 
 const char *get_system_type(void)
 {
-#if defined(CONFIG_MARKEINS)
+#ifdef CONFIG_NEC_MARKEINS
 	return "NEC EMMA2RH Mark-eins";
 #else
 #error  Unknown NEC board
@@ -60,7 +60,7 @@ void __init prom_init(void)
 		strcat(arcs_cmdline, " ");
 	}
 
-#if defined(CONFIG_MARKEINS)
+#ifdef CONFIG_NEC_MARKEINS
 	add_memory_region(0, EMMA2RH_RAM_SIZE, BOOT_MEM_RAM);
 #else
 #error  Unknown NEC board
diff --git a/arch/mips/emma2rh/markeins/Makefile b/arch/mips/emma2rh/markeins/Makefile
index 14fc268..3c8b864 100644
--- a/arch/mips/emma2rh/markeins/Makefile
+++ b/arch/mips/emma2rh/markeins/Makefile
@@ -10,4 +10,4 @@
 #  (at your option) any later version.
 #
 
-obj-$(CONFIG_MARKEINS) += irq.o irq_markeins.o setup.o led.o platform.o
+obj-$(CONFIG_NEC_MARKEINS) += irq.o irq_markeins.o setup.o led.o platform.o
diff --git a/arch/mips/include/asm/emma2rh/emma2rh.h b/arch/mips/include/asm/emma2rh/emma2rh.h
index 6a1af0a..5d79669 100644
--- a/arch/mips/include/asm/emma2rh/emma2rh.h
+++ b/arch/mips/include/asm/emma2rh/emma2rh.h
@@ -324,7 +324,7 @@ static inline u8 emma2rh_in8(u32 offset)
 /*
  * include the board dependent part
  */
-#if defined(CONFIG_MARKEINS)
+#ifdef CONFIG_NEC_MARKEINS
 #include <asm/emma2rh/markeins.h>
 #else
 #error "Unknown EMMA2RH board!"
diff --git a/arch/mips/pci/Makefile b/arch/mips/pci/Makefile
index b188624..e8a97f5 100644
--- a/arch/mips/pci/Makefile
+++ b/arch/mips/pci/Makefile
@@ -13,7 +13,7 @@ obj-$(CONFIG_MIPS_MSC)		+= ops-msc.o
 obj-$(CONFIG_MIPS_NILE4)	+= ops-nile4.o
 obj-$(CONFIG_SOC_TX3927)	+= ops-tx3927.o
 obj-$(CONFIG_PCI_VR41XX)	+= ops-vr41xx.o pci-vr41xx.o
-obj-$(CONFIG_MARKEINS)		+= ops-emma2rh.o pci-emma2rh.o fixup-emma2rh.o
+obj-$(CONFIG_NEC_MARKEINS)	+= ops-emma2rh.o pci-emma2rh.o fixup-emma2rh.o
 obj-$(CONFIG_PCI_TX4927)	+= ops-tx4927.o
 obj-$(CONFIG_BCM47XX)		+= pci-bcm47xx.o
 
