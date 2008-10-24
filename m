Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 24 Oct 2008 02:03:46 +0100 (BST)
Received: from mail3.caviumnetworks.com ([12.108.191.235]:52070 "EHLO
	mail3.caviumnetworks.com") by ftp.linux-mips.org with ESMTP
	id S22251751AbYJXA6U (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 24 Oct 2008 01:58:20 +0100
Received: from exch4.caveonetworks.com (Not Verified[192.168.16.23]) by mail3.caviumnetworks.com with MailMarshal (v6,2,2,3503)
	id <B49011d670002>; Thu, 23 Oct 2008 20:57:11 -0400
Received: from exch4.caveonetworks.com ([192.168.16.23]) by exch4.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Thu, 23 Oct 2008 17:57:10 -0700
Received: from dd1.caveonetworks.com ([64.169.86.201]) by exch4.caveonetworks.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
	 Thu, 23 Oct 2008 17:57:09 -0700
Received: from dd1.caveonetworks.com (localhost.localdomain [127.0.0.1])
	by dd1.caveonetworks.com (8.14.2/8.14.2) with ESMTP id m9O0v4ai005629;
	Thu, 23 Oct 2008 17:57:04 -0700
Received: (from ddaney@localhost)
	by dd1.caveonetworks.com (8.14.2/8.14.2/Submit) id m9O0v4SR005628;
	Thu, 23 Oct 2008 17:57:04 -0700
From:	ddaney@caviumnetworks.com
To:	linux-mips@linux-mips.org
Cc:	David Daney <ddaney@caviumnetworks.com>,
	Tomaso Paoletti <tpaoletti@caviumnetworks.com>
Subject: [PATCH 17/37] cavium: Hook Cavium specifics into main arch/mips dir
Date:	Thu, 23 Oct 2008 17:56:41 -0700
Message-Id: <1224809821-5532-18-git-send-email-ddaney@caviumnetworks.com>
X-Mailer: git-send-email 1.5.5.1
In-Reply-To: <1224809821-5532-1-git-send-email-ddaney@caviumnetworks.com>
References: <1224809821-5532-1-git-send-email-ddaney@caviumnetworks.com>
X-OriginalArrivalTime: 24 Oct 2008 00:57:09.0454 (UTC) FILETIME=[7143A6E0:01C93573]
Return-Path: <David.Daney@caviumnetworks.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 20898
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@caviumnetworks.com
Precedence: bulk
X-list: linux-mips

From: David Daney <ddaney@caviumnetworks.com>

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
index 7f39fd8..9d487ea 100644
--- a/arch/mips/Makefile
+++ b/arch/mips/Makefile
@@ -142,6 +142,7 @@ cflags-$(CONFIG_CPU_SB1)	+= $(call cc-option,-march=sb1,-march=r5000) \
 cflags-$(CONFIG_CPU_R8000)	+= -march=r8000 -Wa,--trap
 cflags-$(CONFIG_CPU_R10000)	+= $(call cc-option,-march=r10000,-march=r8000) \
 			-Wa,--trap
+cflags-$(CONFIG_CPU_CAVIUM_OCTEON) += -march=octeon -Wa,--trap
 
 cflags-$(CONFIG_CPU_R4000_WORKAROUNDS)	+= $(call cc-option,-mfix-r4000,)
 cflags-$(CONFIG_CPU_R4400_WORKAROUNDS)	+= $(call cc-option,-mfix-r4400,)
@@ -573,6 +574,18 @@ core-$(CONFIG_TOSHIBA_RBTX4927)	+= arch/mips/txx9/rbtx4927/
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
index d9da711..3174b56 100644
--- a/arch/mips/kernel/Makefile
+++ b/arch/mips/kernel/Makefile
@@ -42,6 +42,7 @@ obj-$(CONFIG_CPU_SB1)		+= r4k_fpu.o r4k_switch.o
 obj-$(CONFIG_CPU_TX39XX)	+= r2300_fpu.o r2300_switch.o
 obj-$(CONFIG_CPU_TX49XX)	+= r4k_fpu.o r4k_switch.o
 obj-$(CONFIG_CPU_VR41XX)	+= r4k_fpu.o r4k_switch.o
+obj-$(CONFIG_CPU_CAVIUM_OCTEON)	+= octeon_switch.o
 
 obj-$(CONFIG_SMP)		+= smp.o
 obj-$(CONFIG_SMP_UP)		+= smp-up.o
@@ -65,6 +66,7 @@ obj-$(CONFIG_MIPS_MSC)		+= irq-msc01.o
 obj-$(CONFIG_IRQ_TXX9)		+= irq_txx9.o
 obj-$(CONFIG_IRQ_GT641XX)	+= irq-gt641xx.o
 obj-$(CONFIG_IRQ_GIC)		+= irq-gic.o
+obj-$(CONFIG_IRQ_CPU_OCTEON)	+= irq-octeon.o
 
 obj-$(CONFIG_32BIT)		+= scall32-o32.o
 obj-$(CONFIG_64BIT)		+= scall64-64.o
@@ -89,3 +91,10 @@ CFLAGS_cpu-bugs64.o	= $(shell if $(CC) $(KBUILD_CFLAGS) -Wa,-mdaddi -c -o /dev/n
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
index 8810dfb..872aae3 100644
--- a/arch/mips/lib/Makefile
+++ b/arch/mips/lib/Makefile
@@ -26,6 +26,7 @@ obj-$(CONFIG_CPU_SB1)		+= dump_tlb.o
 obj-$(CONFIG_CPU_TX39XX)	+= r3k_dump_tlb.o
 obj-$(CONFIG_CPU_TX49XX)	+= dump_tlb.o
 obj-$(CONFIG_CPU_VR41XX)	+= dump_tlb.o
+obj-$(CONFIG_CPU_CAVIUM_OCTEON)	+= dump_tlb.o
 
 # libgcc-style stuff needed in the kernel
 obj-y += ashldi3.o ashrdi3.o cmpdi2.o lshrdi3.o ucmpdi2.o
diff --git a/arch/mips/mm/Makefile b/arch/mips/mm/Makefile
index 44e8dd8..6032f5c 100644
--- a/arch/mips/mm/Makefile
+++ b/arch/mips/mm/Makefile
@@ -26,6 +26,7 @@ obj-$(CONFIG_CPU_SB1)		+= c-r4k.o cerr-sb1.o cex-sb1.o tlb-r4k.o
 obj-$(CONFIG_CPU_TX39XX)	+= c-tx39.o tlb-r3k.o
 obj-$(CONFIG_CPU_TX49XX)	+= c-r4k.o cex-gen.o tlb-r4k.o
 obj-$(CONFIG_CPU_VR41XX)	+= c-r4k.o cex-gen.o tlb-r4k.o
+obj-$(CONFIG_CPU_CAVIUM_OCTEON)	+= c-octeon.o cex-oct.o tlb-r4k.o
 
 obj-$(CONFIG_IP22_CPU_SCACHE)	+= sc-ip22.o
 obj-$(CONFIG_R5000_CPU_SCACHE)  += sc-r5k.o
@@ -33,3 +34,7 @@ obj-$(CONFIG_RM7000_CPU_SCACHE)	+= sc-rm7k.o
 obj-$(CONFIG_MIPS_CPU_SCACHE)	+= sc-mips.o
 
 EXTRA_CFLAGS += -Werror
+
+OCTEON_ROOT = $(srctree)/arch/mips/cavium-octeon
+CFLAGS_c-octeon.o	= -I$(OCTEON_ROOT)/executive
+
-- 
1.5.5.1
