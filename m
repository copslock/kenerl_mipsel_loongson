Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 28 Oct 2008 00:12:33 +0000 (GMT)
Received: from mail3.caviumnetworks.com ([12.108.191.235]:44821 "EHLO
	mail3.caviumnetworks.com") by ftp.linux-mips.org with ESMTP
	id S22533342AbYJ1AFS (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 28 Oct 2008 00:05:18 +0000
Received: from exch4.caveonetworks.com (Not Verified[192.168.16.23]) by mail3.caviumnetworks.com with MailMarshal (v6,2,2,3503)
	id <B490656f70006>; Mon, 27 Oct 2008 20:04:07 -0400
Received: from exch4.caveonetworks.com ([192.168.16.23]) by exch4.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Mon, 27 Oct 2008 17:03:11 -0700
Received: from dd1.caveonetworks.com ([64.169.86.201]) by exch4.caveonetworks.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
	 Mon, 27 Oct 2008 17:03:11 -0700
Received: from dd1.caveonetworks.com (localhost.localdomain [127.0.0.1])
	by dd1.caveonetworks.com (8.14.2/8.14.2) with ESMTP id m9S036ht003312;
	Mon, 27 Oct 2008 17:03:06 -0700
Received: (from ddaney@localhost)
	by dd1.caveonetworks.com (8.14.2/8.14.2/Submit) id m9S036Li003311;
	Mon, 27 Oct 2008 17:03:06 -0700
From:	David Daney <ddaney@caviumnetworks.com>
To:	linux-mips@linux-mips.org
Cc:	David Daney <ddaney@caviumnetworks.com>,
	Tomaso Paoletti <tpaoletti@caviumnetworks.com>
Subject: [PATCH 17/36] cavium: Hook Cavium specifics into main arch/mips dir
Date:	Mon, 27 Oct 2008 17:02:49 -0700
Message-Id: <1225152181-3221-17-git-send-email-ddaney@caviumnetworks.com>
X-Mailer: git-send-email 1.5.6.5
In-Reply-To: <1225152181-3221-16-git-send-email-ddaney@caviumnetworks.com>
References: <490655B6.4030406@caviumnetworks.com>
 <1225152181-3221-1-git-send-email-ddaney@caviumnetworks.com>
 <1225152181-3221-2-git-send-email-ddaney@caviumnetworks.com>
 <1225152181-3221-3-git-send-email-ddaney@caviumnetworks.com>
 <1225152181-3221-4-git-send-email-ddaney@caviumnetworks.com>
 <1225152181-3221-5-git-send-email-ddaney@caviumnetworks.com>
 <1225152181-3221-6-git-send-email-ddaney@caviumnetworks.com>
 <1225152181-3221-7-git-send-email-ddaney@caviumnetworks.com>
 <1225152181-3221-8-git-send-email-ddaney@caviumnetworks.com>
 <1225152181-3221-9-git-send-email-ddaney@caviumnetworks.com>
 <1225152181-3221-10-git-send-email-ddaney@caviumnetworks.com>
 <1225152181-3221-11-git-send-email-ddaney@caviumnetworks.com>
 <1225152181-3221-12-git-send-email-ddaney@caviumnetworks.com>
 <1225152181-3221-13-git-send-email-ddaney@caviumnetworks.com>
 <1225152181-3221-14-git-send-email-ddaney@caviumnetworks.com>
 <1225152181-3221-15-git-send-email-ddaney@caviumnetworks.com>
 <1225152181-3221-16-git-send-email-ddaney@caviumnetworks.com>
X-OriginalArrivalTime: 28 Oct 2008 00:03:11.0413 (UTC) FILETIME=[90E4CE50:01C93890]
Return-Path: <David.Daney@caviumnetworks.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 21028
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@caviumnetworks.com
Precedence: bulk
X-list: linux-mips

Take all the cavium specific files that were added and hook
them into the build system for the arch/mips.

Signed-off-by: Tomaso Paoletti <tpaoletti@caviumnetworks.com>
Signed-off-by: David Daney <ddaney@caviumnetworks.com>
---
 arch/mips/Makefile        |   13 +++++++++++++
 arch/mips/kernel/Makefile |    9 +++++++++
 arch/mips/lib/Makefile    |    1 +
 arch/mips/mm/Makefile     |    5 +++++
 4 files changed, 28 insertions(+), 0 deletions(-)

diff --git a/arch/mips/Makefile b/arch/mips/Makefile
index 28c55f6..0addc84 100644
--- a/arch/mips/Makefile
+++ b/arch/mips/Makefile
@@ -144,6 +144,7 @@ cflags-$(CONFIG_CPU_SB1)	+= $(call cc-option,-march=sb1,-march=r5000) \
 cflags-$(CONFIG_CPU_R8000)	+= -march=r8000 -Wa,--trap
 cflags-$(CONFIG_CPU_R10000)	+= $(call cc-option,-march=r10000,-march=r8000) \
 			-Wa,--trap
+cflags-$(CONFIG_CPU_CAVIUM_OCTEON) += -march=octeon -Wa,--trap
 
 cflags-$(CONFIG_CPU_R4000_WORKAROUNDS)	+= $(call cc-option,-mfix-r4000,)
 cflags-$(CONFIG_CPU_R4400_WORKAROUNDS)	+= $(call cc-option,-mfix-r4400,)
@@ -586,6 +587,18 @@ core-$(CONFIG_TOSHIBA_RBTX4927)	+= arch/mips/txx9/rbtx4927/
 core-$(CONFIG_TOSHIBA_RBTX4938) += arch/mips/txx9/rbtx4938/
 core-$(CONFIG_TOSHIBA_RBTX4939) += arch/mips/txx9/rbtx4939/
 
+#
+# Cavium Octeon
+#
+core-$(CONFIG_CPU_CAVIUM_OCTEON)	+= arch/mips/cavium-octeon/
+cflags-$(CONFIG_CPU_CAVIUM_OCTEON)	+= -I$(srctree)/arch/mips/include/asm/mach-cavium-octeon
+core-$(CONFIG_CPU_CAVIUM_OCTEON)	+= arch/mips/cavium-octeon/executive/
+ifdef CONFIG_CAVIUM_OCTEON_2ND_KERNEL
+load-$(CONFIG_CPU_CAVIUM_OCTEON)	+= 0xffffffff84100000
+else
+load-$(CONFIG_CPU_CAVIUM_OCTEON) 	+= 0xffffffff81100000
+endif
+
 cflags-y			+= -I$(srctree)/arch/mips/include/asm/mach-generic
 drivers-$(CONFIG_PCI)		+= arch/mips/pci/
 
diff --git a/arch/mips/kernel/Makefile b/arch/mips/kernel/Makefile
index b1372c2..93ff9c4 100644
--- a/arch/mips/kernel/Makefile
+++ b/arch/mips/kernel/Makefile
@@ -43,6 +43,7 @@ obj-$(CONFIG_CPU_SB1)		+= r4k_fpu.o r4k_switch.o
 obj-$(CONFIG_CPU_TX39XX)	+= r2300_fpu.o r2300_switch.o
 obj-$(CONFIG_CPU_TX49XX)	+= r4k_fpu.o r4k_switch.o
 obj-$(CONFIG_CPU_VR41XX)	+= r4k_fpu.o r4k_switch.o
+obj-$(CONFIG_CPU_CAVIUM_OCTEON)	+= octeon_switch.o
 
 obj-$(CONFIG_SMP)		+= smp.o
 obj-$(CONFIG_SMP_UP)		+= smp-up.o
@@ -66,6 +67,7 @@ obj-$(CONFIG_MIPS_MSC)		+= irq-msc01.o
 obj-$(CONFIG_IRQ_TXX9)		+= irq_txx9.o
 obj-$(CONFIG_IRQ_GT641XX)	+= irq-gt641xx.o
 obj-$(CONFIG_IRQ_GIC)		+= irq-gic.o
+obj-$(CONFIG_IRQ_CPU_OCTEON)	+= irq-octeon.o
 
 obj-$(CONFIG_32BIT)		+= scall32-o32.o
 obj-$(CONFIG_64BIT)		+= scall64-64.o
@@ -90,3 +92,10 @@ CFLAGS_cpu-bugs64.o	= $(shell if $(CC) $(KBUILD_CFLAGS) -Wa,-mdaddi -c -o /dev/n
 obj-$(CONFIG_HAVE_STD_PC_SERIAL_PORT)	+= 8250-platform.o
 
 EXTRA_CFLAGS += -Werror
+
+ifdef CONFIG_CPU_CAVIUM_OCTEON
+OCTEON_ROOT = $(srctree)/arch/mips/cavium-octeon
+
+CFLAGS_irq-octeon.o	= -I$(OCTEON_ROOT)/executive
+CFLAGS_ptrace.o	= -I$(OCTEON_ROOT)/executive
+endif
diff --git a/arch/mips/lib/Makefile b/arch/mips/lib/Makefile
index dbcf651..c13c7ad 100644
--- a/arch/mips/lib/Makefile
+++ b/arch/mips/lib/Makefile
@@ -27,6 +27,7 @@ obj-$(CONFIG_CPU_SB1)		+= dump_tlb.o
 obj-$(CONFIG_CPU_TX39XX)	+= r3k_dump_tlb.o
 obj-$(CONFIG_CPU_TX49XX)	+= dump_tlb.o
 obj-$(CONFIG_CPU_VR41XX)	+= dump_tlb.o
+obj-$(CONFIG_CPU_CAVIUM_OCTEON)	+= dump_tlb.o
 
 # libgcc-style stuff needed in the kernel
 obj-y += ashldi3.o ashrdi3.o cmpdi2.o lshrdi3.o ucmpdi2.o
diff --git a/arch/mips/mm/Makefile b/arch/mips/mm/Makefile
index 95ba32b..3dad926 100644
--- a/arch/mips/mm/Makefile
+++ b/arch/mips/mm/Makefile
@@ -27,6 +27,7 @@ obj-$(CONFIG_CPU_SB1)		+= c-r4k.o cerr-sb1.o cex-sb1.o tlb-r4k.o
 obj-$(CONFIG_CPU_TX39XX)	+= c-tx39.o tlb-r3k.o
 obj-$(CONFIG_CPU_TX49XX)	+= c-r4k.o cex-gen.o tlb-r4k.o
 obj-$(CONFIG_CPU_VR41XX)	+= c-r4k.o cex-gen.o tlb-r4k.o
+obj-$(CONFIG_CPU_CAVIUM_OCTEON)	+= c-octeon.o cex-oct.o tlb-r4k.o
 
 obj-$(CONFIG_IP22_CPU_SCACHE)	+= sc-ip22.o
 obj-$(CONFIG_R5000_CPU_SCACHE)  += sc-r5k.o
@@ -34,3 +35,7 @@ obj-$(CONFIG_RM7000_CPU_SCACHE)	+= sc-rm7k.o
 obj-$(CONFIG_MIPS_CPU_SCACHE)	+= sc-mips.o
 
 EXTRA_CFLAGS += -Werror
+
+OCTEON_ROOT = $(srctree)/arch/mips/cavium-octeon
+CFLAGS_c-octeon.o	= -I$(OCTEON_ROOT)/executive
+
-- 
1.5.6.5
