Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 22 Apr 2011 18:55:35 +0200 (CEST)
Received: from mx1.netlogicmicro.com ([12.49.93.86]:4716 "EHLO
        orion5.netlogicmicro.com" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S1491114Ab1DVQyw (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 22 Apr 2011 18:54:52 +0200
X-TM-IMSS-Message-ID: <e42d33ea00016b70@netlogicmicro.com>
Received: from orion8.netlogicmicro.com ([10.10.16.60]) by netlogicmicro.com ([10.10.16.19]) with ESMTP (TREND IMSS SMTP Service 7.0) id e42d33ea00016b70 ; Fri, 22 Apr 2011 09:54:35 -0700
Received: from jayachandranc.netlogicmicro.com ([10.7.0.77]) by orion8.netlogicmicro.com with Microsoft SMTPSVC(6.0.3790.3959);
         Fri, 22 Apr 2011 09:55:36 -0700
Date:   Fri, 22 Apr 2011 22:32:16 +0530
From:   Jayachandran C <jayachandranc@netlogicmicro.com>
To:     linux-mips@linux-mips.org, ralf@linux-mips.org
Subject: [PATCH 5/8] Kconfig and Makefile update for Netlogic XLR/XLS
Message-ID: <d22bfa5e52c6548397f6f73462d3b44530eaa408.1303487516.git.jayachandranc@netlogicmicro.com>
References: <cover.1303487516.git.jayachandranc@netlogicmicro.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1303487516.git.jayachandranc@netlogicmicro.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
X-OriginalArrivalTime: 22 Apr 2011 16:55:37.0024 (UTC) FILETIME=[1A5AF400:01CC010E]
Return-Path: <jayachandranc@netlogicmicro.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 29789
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jayachandranc@netlogicmicro.com
Precedence: bulk
X-list: linux-mips

Add NLM_XLR_BOARD, CPU_XLR and other config options
Makefile updates, mostly based on r4k

Signed-off-by: Jayachandran C <jayachandranc@netlogicmicro.com>
---
 arch/mips/Kconfig               |   42 +++++++++++++++++++++++++++++++++++++++
 arch/mips/Makefile              |   12 +++++++++++
 arch/mips/kernel/Makefile       |    1 +
 arch/mips/lib/Makefile          |    1 +
 arch/mips/mm/Makefile           |    1 +
 arch/mips/netlogic/Kconfig      |    5 ++++
 arch/mips/netlogic/xlr/Makefile |    5 ++++
 7 files changed, 67 insertions(+), 0 deletions(-)
 create mode 100644 arch/mips/netlogic/Kconfig
 create mode 100644 arch/mips/netlogic/xlr/Makefile

diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index 351c80f..5016caa 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -736,6 +736,33 @@ config CAVIUM_OCTEON_REFERENCE_BOARD
 		Hikari
 	  Say Y here for most Octeon reference boards.
 
+config NLM_XLR_BOARD
+	bool "Netlogic XLR/XLS based systems"
+	depends on EXPERIMENTAL
+	select BOOT_ELF32
+	select NLM_COMMON
+	select NLM_XLR
+	select SYS_HAS_CPU_XLR
+	select SYS_SUPPORTS_SMP
+	select HW_HAS_PCI
+	select SWAP_IO_SPACE
+	select SYS_SUPPORTS_32BIT_KERNEL
+	select SYS_SUPPORTS_64BIT_KERNEL
+	select 64BIT_PHYS_ADDR
+	select SYS_SUPPORTS_BIG_ENDIAN
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
+	  Support for systems based on Netlogic XLR and XLS processors.
+	  Say Y here if you have a XLR or XLS based board.
+
 endchoice
 
 source "arch/mips/alchemy/Kconfig"
@@ -752,6 +779,7 @@ source "arch/mips/txx9/Kconfig"
 source "arch/mips/vr41xx/Kconfig"
 source "arch/mips/cavium-octeon/Kconfig"
 source "arch/mips/loongson/Kconfig"
+source "arch/mips/netlogic/Kconfig"
 
 endmenu
 
@@ -1420,6 +1448,17 @@ config CPU_BMIPS5000
 	help
 	  Broadcom BMIPS5000 processors.
 
+config CPU_XLR
+	bool "Netlogic XLR SoC"
+	depends on SYS_HAS_CPU_XLR
+	select CPU_SUPPORTS_32BIT_KERNEL
+	select CPU_SUPPORTS_64BIT_KERNEL
+	select CPU_SUPPORTS_HIGHMEM
+	select WEAK_ORDERING
+	select WEAK_REORDERING_BEYOND_LLSC
+	select CPU_SUPPORTS_HUGEPAGES
+	help
+	  Netlogic Microsystems XLR/XLS processors.
 endchoice
 
 if CPU_LOONGSON2F
@@ -1550,6 +1589,9 @@ config SYS_HAS_CPU_BMIPS4380
 config SYS_HAS_CPU_BMIPS5000
 	bool
 
+config SYS_HAS_CPU_XLR
+	bool
+
 #
 # CPU may reorder R->R, R->W, W->R, W->W
 # Reordering beyond LL and SC is handled in WEAK_REORDERING_BEYOND_LLSC
diff --git a/arch/mips/Makefile b/arch/mips/Makefile
index 53e3514..884819c 100644
--- a/arch/mips/Makefile
+++ b/arch/mips/Makefile
@@ -191,6 +191,18 @@ endif
 #
 include $(srctree)/arch/mips/Kbuild.platforms
 
+#
+# NETLOGIC SOC Common (common)
+#
+cflags-$(CONFIG_NLM_COMMON)		+= -I$(srctree)/arch/mips/include/asm/mach-netlogic
+cflags-$(CONFIG_NLM_COMMON)		+= -I$(srctree)/arch/mips/include/asm/netlogic
+
+#
+# NETLOGIC XLR/XLS SoC, Simulator and boards
+#
+core-$(CONFIG_NLM_XLR)      		+= arch/mips/netlogic/xlr/
+load-$(CONFIG_NLM_XLR_BOARD)		+= 0xffffffff84000000
+
 cflags-y			+= -I$(srctree)/arch/mips/include/asm/mach-generic
 drivers-$(CONFIG_PCI)		+= arch/mips/pci/
 
diff --git a/arch/mips/kernel/Makefile b/arch/mips/kernel/Makefile
index cedee2b..83bba33 100644
--- a/arch/mips/kernel/Makefile
+++ b/arch/mips/kernel/Makefile
@@ -52,6 +52,7 @@ obj-$(CONFIG_CPU_TX39XX)	+= r2300_fpu.o r2300_switch.o
 obj-$(CONFIG_CPU_TX49XX)	+= r4k_fpu.o r4k_switch.o
 obj-$(CONFIG_CPU_VR41XX)	+= r4k_fpu.o r4k_switch.o
 obj-$(CONFIG_CPU_CAVIUM_OCTEON)	+= octeon_switch.o
+obj-$(CONFIG_CPU_XLR)		+= r4k_fpu.o r4k_switch.o
 
 obj-$(CONFIG_SMP)		+= smp.o
 obj-$(CONFIG_SMP_UP)		+= smp-up.o
diff --git a/arch/mips/lib/Makefile b/arch/mips/lib/Makefile
index 2adead5..b2cad4f 100644
--- a/arch/mips/lib/Makefile
+++ b/arch/mips/lib/Makefile
@@ -28,6 +28,7 @@ obj-$(CONFIG_CPU_TX39XX)	+= r3k_dump_tlb.o
 obj-$(CONFIG_CPU_TX49XX)	+= dump_tlb.o
 obj-$(CONFIG_CPU_VR41XX)	+= dump_tlb.o
 obj-$(CONFIG_CPU_CAVIUM_OCTEON)	+= dump_tlb.o
+obj-$(CONFIG_CPU_XLR)		+= dump_tlb.o
 
 # libgcc-style stuff needed in the kernel
 obj-y += ashldi3.o ashrdi3.o cmpdi2.o lshrdi3.o ucmpdi2.o
diff --git a/arch/mips/mm/Makefile b/arch/mips/mm/Makefile
index d679c77..eb44636 100644
--- a/arch/mips/mm/Makefile
+++ b/arch/mips/mm/Makefile
@@ -29,6 +29,7 @@ obj-$(CONFIG_CPU_TX39XX)	+= c-tx39.o tlb-r3k.o
 obj-$(CONFIG_CPU_TX49XX)	+= c-r4k.o cex-gen.o tlb-r4k.o
 obj-$(CONFIG_CPU_VR41XX)	+= c-r4k.o cex-gen.o tlb-r4k.o
 obj-$(CONFIG_CPU_CAVIUM_OCTEON)	+= c-octeon.o cex-oct.o tlb-r4k.o
+obj-$(CONFIG_CPU_XLR)		+= c-r4k.o tlb-r4k.o cex-gen.o
 
 obj-$(CONFIG_IP22_CPU_SCACHE)	+= sc-ip22.o
 obj-$(CONFIG_R5000_CPU_SCACHE)  += sc-r5k.o
diff --git a/arch/mips/netlogic/Kconfig b/arch/mips/netlogic/Kconfig
new file mode 100644
index 0000000..a5ca743
--- /dev/null
+++ b/arch/mips/netlogic/Kconfig
@@ -0,0 +1,5 @@
+config NLM_COMMON
+	bool
+
+config NLM_XLR
+	bool
diff --git a/arch/mips/netlogic/xlr/Makefile b/arch/mips/netlogic/xlr/Makefile
new file mode 100644
index 0000000..9bd3f73
--- /dev/null
+++ b/arch/mips/netlogic/xlr/Makefile
@@ -0,0 +1,5 @@
+obj-y				+= setup.o platform.o irq.o setup.o time.o
+obj-$(CONFIG_SMP)		+= smp.o smpboot.o
+obj-$(CONFIG_EARLY_PRINTK)	+= xlr_console.o
+
+EXTRA_CFLAGS			+= -Werror
-- 
1.7.1


-- 
Jayachandran C.
jayachandranc@netlogicmicro.com                  (Netlogic Microsystems)
