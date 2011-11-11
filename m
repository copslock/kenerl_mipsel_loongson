Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 11 Nov 2011 12:39:10 +0100 (CET)
Received: from mx1.netlogicmicro.com ([12.203.210.36]:1978 "EHLO
        orion5.netlogicmicro.com" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S1903964Ab1KKLh5 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 11 Nov 2011 12:37:57 +0100
X-TM-IMSS-Message-ID: <1acd63230007c9dd@netlogicmicro.com>
Received: from hqcas01.netlogicmicro.com ([10.10.50.14]) by netlogicmicro.com ([10.10.16.19]) with ESMTP (TREND IMSS SMTP Service 7.0; TLS: TLSv1/SSLv3,128bits,AES128-SHA) id 1acd63230007c9dd ; Fri, 11 Nov 2011 03:37:50 -0800
Date:   Fri, 11 Nov 2011 17:09:53 +0530
From:   Jayachandran C <jayachandranc@netlogicmicro.com>
To:     <linux-mips@linux-mips.org>, <ralf@linux-mips.org>
Subject: [PATCH 08/12] MIPS: Netlogic: Add XLP makefiles and config
Message-ID: <14e8b3427527f4cf43939d9d07325748a941d67a.1321011002.git.jayachandranc@netlogicmicro.com>
References: <cover.1321010998.git.jayachandranc@netlogicmicro.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <cover.1321010998.git.jayachandranc@netlogicmicro.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-OriginalArrivalTime: 11 Nov 2011 11:37:49.0396 (UTC) FILETIME=[57051140:01CCA066]
X-archive-position: 31550
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jayachandranc@netlogicmicro.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 10228

- Add CPU_XLP and NLM_XLR_BOARD to arch/mips/Kconfig for Netlogic XLP boards
- Update mips Makefiles to add XLP

Signed-off-by: Jayachandran C <jayachandranc@netlogicmicro.com>
---
 arch/mips/Kconfig               |   43 +++++++++++++++++++++++++++++++++++++++
 arch/mips/kernel/Makefile       |    1 +
 arch/mips/lib/Makefile          |    1 +
 arch/mips/mm/Makefile           |    1 +
 arch/mips/netlogic/Makefile     |    1 +
 arch/mips/netlogic/Platform     |    1 +
 arch/mips/netlogic/xlp/Makefile |    2 +
 7 files changed, 50 insertions(+), 0 deletions(-)
 create mode 100644 arch/mips/netlogic/xlp/Makefile

diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index 58515fd..c3b1b35 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -783,6 +783,33 @@ config NLM_XLR_BOARD
 	  Support for systems based on Netlogic XLR and XLS processors.
 	  Say Y here if you have a XLR or XLS based board.
 
+config NLM_XLP_BOARD
+	bool "Netlogic XLP based systems"
+	depends on EXPERIMENTAL
+	select BOOT_ELF32
+	select NLM_COMMON
+	select SYS_HAS_CPU_XLP
+	select SYS_SUPPORTS_SMP
+	select HW_HAS_PCI
+	select SWAP_IO_SPACE
+	select SYS_SUPPORTS_32BIT_KERNEL
+	select SYS_SUPPORTS_64BIT_KERNEL
+	select 64BIT_PHYS_ADDR
+	select SYS_SUPPORTS_BIG_ENDIAN
+	select SYS_SUPPORTS_LITTLE_ENDIAN
+	select SYS_SUPPORTS_HIGHMEM
+	select DMA_COHERENT
+	select NR_CPUS_DEFAULT_32
+	select CEVT_R4K
+	select CSRC_R4K
+	select IRQ_CPU
+	select ZONE_DMA if 64BIT
+	select SYNC_R4K
+	select SYS_HAS_EARLY_PRINTK
+	help
+	  This board is based on Netlogic XLP Processor.
+	  Say Y here if you have a XLP based board.
+
 endchoice
 
 source "arch/mips/alchemy/Kconfig"
@@ -1472,6 +1499,19 @@ config CPU_XLR
 	select CPU_SUPPORTS_HUGEPAGES
 	help
 	  Netlogic Microsystems XLR/XLS processors.
+
+config CPU_XLP
+	bool "Netlogic XLP SoC"
+	depends on SYS_HAS_CPU_XLP
+	select CPU_SUPPORTS_32BIT_KERNEL
+	select CPU_SUPPORTS_64BIT_KERNEL
+	select CPU_SUPPORTS_HIGHMEM
+	select CPU_HAS_LLSC
+	select WEAK_ORDERING
+	select WEAK_REORDERING_BEYOND_LLSC
+	select CPU_HAS_PREFETCH
+	help
+	  Netlogic Microsystems XLP processors.
 endchoice
 
 if CPU_LOONGSON2F
@@ -1605,6 +1645,9 @@ config SYS_HAS_CPU_BMIPS5000
 config SYS_HAS_CPU_XLR
 	bool
 
+config SYS_HAS_CPU_XLP
+	bool
+
 #
 # CPU may reorder R->R, R->W, W->R, W->W
 # Reordering beyond LL and SC is handled in WEAK_REORDERING_BEYOND_LLSC
diff --git a/arch/mips/kernel/Makefile b/arch/mips/kernel/Makefile
index 1a96618..810ab50 100644
--- a/arch/mips/kernel/Makefile
+++ b/arch/mips/kernel/Makefile
@@ -55,6 +55,7 @@ obj-$(CONFIG_CPU_TX49XX)	+= r4k_fpu.o r4k_switch.o
 obj-$(CONFIG_CPU_VR41XX)	+= r4k_fpu.o r4k_switch.o
 obj-$(CONFIG_CPU_CAVIUM_OCTEON)	+= octeon_switch.o
 obj-$(CONFIG_CPU_XLR)		+= r4k_fpu.o r4k_switch.o
+obj-$(CONFIG_CPU_XLP)		+= r4k_fpu.o r4k_switch.o
 
 obj-$(CONFIG_SMP)		+= smp.o
 obj-$(CONFIG_SMP_UP)		+= smp-up.o
diff --git a/arch/mips/lib/Makefile b/arch/mips/lib/Makefile
index b2cad4f..2a7c74f 100644
--- a/arch/mips/lib/Makefile
+++ b/arch/mips/lib/Makefile
@@ -29,6 +29,7 @@ obj-$(CONFIG_CPU_TX49XX)	+= dump_tlb.o
 obj-$(CONFIG_CPU_VR41XX)	+= dump_tlb.o
 obj-$(CONFIG_CPU_CAVIUM_OCTEON)	+= dump_tlb.o
 obj-$(CONFIG_CPU_XLR)		+= dump_tlb.o
+obj-$(CONFIG_CPU_XLP)		+= dump_tlb.o
 
 # libgcc-style stuff needed in the kernel
 obj-y += ashldi3.o ashrdi3.o cmpdi2.o lshrdi3.o ucmpdi2.o
diff --git a/arch/mips/mm/Makefile b/arch/mips/mm/Makefile
index 3ca2a06..4aa2028 100644
--- a/arch/mips/mm/Makefile
+++ b/arch/mips/mm/Makefile
@@ -31,6 +31,7 @@ obj-$(CONFIG_CPU_TX49XX)	+= c-r4k.o cex-gen.o tlb-r4k.o
 obj-$(CONFIG_CPU_VR41XX)	+= c-r4k.o cex-gen.o tlb-r4k.o
 obj-$(CONFIG_CPU_CAVIUM_OCTEON)	+= c-octeon.o cex-oct.o tlb-r4k.o
 obj-$(CONFIG_CPU_XLR)		+= c-r4k.o tlb-r4k.o cex-gen.o
+obj-$(CONFIG_CPU_XLP)		+= c-r4k.o tlb-r4k.o cex-gen.o
 
 obj-$(CONFIG_IP22_CPU_SCACHE)	+= sc-ip22.o
 obj-$(CONFIG_R5000_CPU_SCACHE)  += sc-r5k.o
diff --git a/arch/mips/netlogic/Makefile b/arch/mips/netlogic/Makefile
index 797326d..36d169b 100644
--- a/arch/mips/netlogic/Makefile
+++ b/arch/mips/netlogic/Makefile
@@ -1,2 +1,3 @@
 obj-$(CONFIG_NLM_COMMON)	+=	common/
 obj-$(CONFIG_CPU_XLR)		+=	xlr/
+obj-$(CONFIG_CPU_XLP)		+=	xlp/
diff --git a/arch/mips/netlogic/Platform b/arch/mips/netlogic/Platform
index 7811b10..cdfc9ab 100644
--- a/arch/mips/netlogic/Platform
+++ b/arch/mips/netlogic/Platform
@@ -8,6 +8,7 @@ cflags-$(CONFIG_NLM_COMMON)	+= -I$(srctree)/arch/mips/include/asm/netlogic
 # use mips64 if xlr is not available
 #
 cflags-$(CONFIG_CPU_XLR)	+= $(call cc-option,-march=xlr,-march=mips64)
+cflags-$(CONFIG_CPU_XLP)	+= $(call cc-option,-march=xlp,-march=mips64r2)
 
 #
 # NETLOGIC processor support
diff --git a/arch/mips/netlogic/xlp/Makefile b/arch/mips/netlogic/xlp/Makefile
new file mode 100644
index 0000000..1940d1c
--- /dev/null
+++ b/arch/mips/netlogic/xlp/Makefile
@@ -0,0 +1,2 @@
+obj-y				+= setup.o platform.o nlm_hal.o
+obj-$(CONFIG_SMP)		+= smpboot.o wakeup.o
-- 
1.7.5.4
