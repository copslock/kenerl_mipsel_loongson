Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 30 Jul 2011 15:33:56 +0200 (CEST)
Received: from mx1.netlogicmicro.com ([12.203.210.36]:2251 "EHLO
        orion5.netlogicmicro.com" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S1491104Ab1G3Ncz (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 30 Jul 2011 15:32:55 +0200
X-TM-IMSS-Message-ID: <e148a81700026d27@netlogicmicro.com>
Received: from orion8.netlogicmicro.com ([10.10.16.60]) by netlogicmicro.com ([10.10.16.19]) with ESMTP (TREND IMSS SMTP Service 7.0) id e148a81700026d27 ; Sat, 30 Jul 2011 06:31:17 -0700
Received: from jayachandranc.netlogicmicro.com ([10.7.0.77]) by orion8.netlogicmicro.com with Microsoft SMTPSVC(6.0.3790.3959);
         Sat, 30 Jul 2011 06:28:15 -0700
Date:   Sat, 30 Jul 2011 18:58:46 +0530
From:   Jayachandran C <jayachandranc@netlogicmicro.com>
To:     linux-mips@linux-mips.org, ralf@linux-mips.org
Subject: [PATCH 3/4] MIPS: Netlogic: Build support for netlogic XLP
Message-ID: <c6649ef54a1a2eefa18b1d95b8533060308818d2.1312024108.git.jayachandranc@netlogicmicro.com>
References: <cover.1312024106.git.jayachandranc@netlogicmicro.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1312024106.git.jayachandranc@netlogicmicro.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-OriginalArrivalTime: 30 Jul 2011 13:28:15.0357 (UTC) FILETIME=[89707AD0:01CC4EBC]
X-archive-position: 30772
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jayachandranc@netlogicmicro.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 22304

Kconfig and makefile updates
---
 arch/mips/Kconfig               |   44 +++++++++++++++++++++++++++++++++++++++
 arch/mips/kernel/Makefile       |    1 +
 arch/mips/lib/Makefile          |    1 +
 arch/mips/mm/Makefile           |    1 +
 arch/mips/netlogic/Kconfig      |    3 ++
 arch/mips/netlogic/Platform     |    7 ++++++
 arch/mips/netlogic/xlp/Makefile |    5 ++-
 7 files changed, 60 insertions(+), 2 deletions(-)

diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index d300c2b..d164b74 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -785,6 +785,34 @@ config NLM_XLR_BOARD
 	  Support for systems based on Netlogic XLR and XLS processors.
 	  Say Y here if you have a XLR or XLS based board.
 
+config NLM_XLP_BOARD
+	bool "Netlogic XLP based systems"
+	depends on EXPERIMENTAL
+	select BOOT_ELF32
+	select NLM_COMMON
+	select NLM_XLP
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
@@ -1474,6 +1502,19 @@ config CPU_XLR
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
@@ -1607,6 +1648,9 @@ config SYS_HAS_CPU_BMIPS5000
 config SYS_HAS_CPU_XLR
 	bool
 
+config SYS_HAS_CPU_XLP
+	bool
+
 #
 # CPU may reorder R->R, R->W, W->R, W->W
 # Reordering beyond LL and SC is handled in WEAK_REORDERING_BEYOND_LLSC
diff --git a/arch/mips/kernel/Makefile b/arch/mips/kernel/Makefile
index 83bba33..ab31b00 100644
--- a/arch/mips/kernel/Makefile
+++ b/arch/mips/kernel/Makefile
@@ -53,6 +53,7 @@ obj-$(CONFIG_CPU_TX49XX)	+= r4k_fpu.o r4k_switch.o
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
index 4d8c162..59b0905 100644
--- a/arch/mips/mm/Makefile
+++ b/arch/mips/mm/Makefile
@@ -31,6 +31,7 @@ obj-$(CONFIG_CPU_TX49XX)	+= c-r4k.o cex-gen.o tlb-r4k.o
 obj-$(CONFIG_CPU_VR41XX)	+= c-r4k.o cex-gen.o tlb-r4k.o
 obj-$(CONFIG_CPU_CAVIUM_OCTEON)	+= c-octeon.o cex-oct.o tlb-r4k.o
 obj-$(CONFIG_CPU_XLR)		+= c-r4k.o tlb-r4k.o cex-gen.o
+obj-$(CONFIG_CPU_XLP)		+= c-r4k.o tlb-r4k.o cex-gen.o
 
 obj-$(CONFIG_IP22_CPU_SCACHE)	+= sc-ip22.o
 obj-$(CONFIG_R5000_CPU_SCACHE)  += sc-r5k.o
diff --git a/arch/mips/netlogic/Kconfig b/arch/mips/netlogic/Kconfig
index a5ca743..464d4b2 100644
--- a/arch/mips/netlogic/Kconfig
+++ b/arch/mips/netlogic/Kconfig
@@ -3,3 +3,6 @@ config NLM_COMMON
 
 config NLM_XLR
 	bool
+
+config NLM_XLP
+	bool
diff --git a/arch/mips/netlogic/Platform b/arch/mips/netlogic/Platform
index 502d912..9853153 100644
--- a/arch/mips/netlogic/Platform
+++ b/arch/mips/netlogic/Platform
@@ -8,9 +8,16 @@ cflags-$(CONFIG_NLM_COMMON)  += -I$(srctree)/arch/mips/include/asm/netlogic
 # use mips64 if xlr is not available
 #
 cflags-$(CONFIG_NLM_XLR)	+= $(call cc-option,-march=xlr,-march=mips64)
+cflags-$(CONFIG_NLM_XLP)	+= $(call cc-option,-march=xlp,-march=mips64r2)
 
 #
 # NETLOGIC XLR/XLS SoC, Simulator and boards
 #
 core-$(CONFIG_NLM_XLR)	      += arch/mips/netlogic/xlr/
 load-$(CONFIG_NLM_XLR_BOARD)  += 0xffffffff80100000
+
+#
+# NETLOGIC XLP SoC, Simulator and boards
+#
+core-$(CONFIG_NLM_XLP)	      += arch/mips/netlogic/xlp/
+load-$(CONFIG_NLM_XLP_BOARD)  += 0xffffffff80100000
diff --git a/arch/mips/netlogic/xlp/Makefile b/arch/mips/netlogic/xlp/Makefile
index d1023e0..aea1918 100644
--- a/arch/mips/netlogic/xlp/Makefile
+++ b/arch/mips/netlogic/xlp/Makefile
@@ -1,4 +1,5 @@
-obj-y		= setup.o platform.o irq.o setup.o time.o nlm_hal.o
-obj-$(CONFIG_EARLY_PRINTK) += xlp_console.o
+obj-y			+= setup.o platform.o irq.o setup.o time.o nlm_hal.o
+obj-$(CONFIG_SMP)	+= smp.o smpboot.o
+obj-$(CONFIG_EARLY_PRINTK)	+= xlp_console.o
 
 EXTRA_CFLAGS	+= -Werror
-- 
1.7.4.1


-- 
Jayachandran C.
jayachandranc@netlogicmicro.com                  (Netlogic Microsystems)
jchandra@freebsd.org                               (The FreeBSD Project)
