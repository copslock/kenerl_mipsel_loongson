Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 03 Dec 2008 23:49:36 +0000 (GMT)
Received: from mail3.caviumnetworks.com ([12.108.191.235]:23191 "EHLO
	mail3.caviumnetworks.com") by ftp.linux-mips.org with ESMTP
	id S24087254AbYLCXpU (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 3 Dec 2008 23:45:20 +0000
Received: from exch4.caveonetworks.com (Not Verified[192.168.16.23]) by mail3.caviumnetworks.com with MailMarshal (v6,2,2,3503)
	id <B493719e80000>; Wed, 03 Dec 2008 18:44:40 -0500
Received: from exch4.caveonetworks.com ([192.168.16.23]) by exch4.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Wed, 3 Dec 2008 15:44:38 -0800
Received: from dd1.caveonetworks.com ([64.169.86.201]) by exch4.caveonetworks.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
	 Wed, 3 Dec 2008 15:44:38 -0800
Received: from dd1.caveonetworks.com (localhost.localdomain [127.0.0.1])
	by dd1.caveonetworks.com (8.14.2/8.14.2) with ESMTP id mB3NiXdH015626;
	Wed, 3 Dec 2008 15:44:33 -0800
Received: (from ddaney@localhost)
	by dd1.caveonetworks.com (8.14.2/8.14.2/Submit) id mB3NiXjb015625;
	Wed, 3 Dec 2008 15:44:33 -0800
From:	David Daney <ddaney@caviumnetworks.com>
To:	linux-mips@linux-mips.org
Cc:	David Daney <ddaney@caviumnetworks.com>,
	Tomaso Paoletti <tpaoletti@caviumnetworks.com>
Subject: [PATCH 10/21] MIPS: Hook up Cavium OCTEON in arch/mips.
Date:	Wed,  3 Dec 2008 15:44:20 -0800
Message-Id: <1228347871-15563-10-git-send-email-ddaney@caviumnetworks.com>
X-Mailer: git-send-email 1.5.6.5
In-Reply-To: <493718EA.40703@caviumnetworks.com>
References: <493718EA.40703@caviumnetworks.com>
X-OriginalArrivalTime: 03 Dec 2008 23:44:38.0617 (UTC) FILETIME=[1AE65C90:01C955A1]
Return-Path: <David.Daney@caviumnetworks.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 21517
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@caviumnetworks.com
Precedence: bulk
X-list: linux-mips

Take all the OCTEON specific files that were added, and hook them into
the build system for the arch/mips.  For versions of GCC that lack
OCTEON support, override gas target architecture.

Signed-off-by: Tomaso Paoletti <tpaoletti@caviumnetworks.com>
Signed-off-by: David Daney <ddaney@caviumnetworks.com>
---
 arch/mips/Makefile        |   16 ++++++++++++++++
 arch/mips/kernel/Makefile |    1 +
 arch/mips/lib/Makefile    |    1 +
 arch/mips/mm/Makefile     |    1 +
 4 files changed, 19 insertions(+), 0 deletions(-)

diff --git a/arch/mips/Makefile b/arch/mips/Makefile
index 28c55f6..0bc2120 100644
--- a/arch/mips/Makefile
+++ b/arch/mips/Makefile
@@ -144,6 +144,10 @@ cflags-$(CONFIG_CPU_SB1)	+= $(call cc-option,-march=sb1,-march=r5000) \
 cflags-$(CONFIG_CPU_R8000)	+= -march=r8000 -Wa,--trap
 cflags-$(CONFIG_CPU_R10000)	+= $(call cc-option,-march=r10000,-march=r8000) \
 			-Wa,--trap
+cflags-$(CONFIG_CPU_CAVIUM_OCTEON) += $(call cc-option,-march=octeon) -Wa,--trap
+ifeq (,$(findstring march=octeon, $(cflags-$(CONFIG_CPU_CAVIUM_OCTEON))))
+cflags-$(CONFIG_CPU_CAVIUM_OCTEON) += -Wa,-march=octeon
+endif
 
 cflags-$(CONFIG_CPU_R4000_WORKAROUNDS)	+= $(call cc-option,-mfix-r4000,)
 cflags-$(CONFIG_CPU_R4400_WORKAROUNDS)	+= $(call cc-option,-mfix-r4400,)
@@ -586,6 +590,18 @@ core-$(CONFIG_TOSHIBA_RBTX4927)	+= arch/mips/txx9/rbtx4927/
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
index b1372c2..3ab4ac9 100644
--- a/arch/mips/kernel/Makefile
+++ b/arch/mips/kernel/Makefile
@@ -43,6 +43,7 @@ obj-$(CONFIG_CPU_SB1)		+= r4k_fpu.o r4k_switch.o
 obj-$(CONFIG_CPU_TX39XX)	+= r2300_fpu.o r2300_switch.o
 obj-$(CONFIG_CPU_TX49XX)	+= r4k_fpu.o r4k_switch.o
 obj-$(CONFIG_CPU_VR41XX)	+= r4k_fpu.o r4k_switch.o
+obj-$(CONFIG_CPU_CAVIUM_OCTEON)	+= octeon_switch.o
 
 obj-$(CONFIG_SMP)		+= smp.o
 obj-$(CONFIG_SMP_UP)		+= smp-up.o
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
index 95ba32b..d7ec955 100644
--- a/arch/mips/mm/Makefile
+++ b/arch/mips/mm/Makefile
@@ -27,6 +27,7 @@ obj-$(CONFIG_CPU_SB1)		+= c-r4k.o cerr-sb1.o cex-sb1.o tlb-r4k.o
 obj-$(CONFIG_CPU_TX39XX)	+= c-tx39.o tlb-r3k.o
 obj-$(CONFIG_CPU_TX49XX)	+= c-r4k.o cex-gen.o tlb-r4k.o
 obj-$(CONFIG_CPU_VR41XX)	+= c-r4k.o cex-gen.o tlb-r4k.o
+obj-$(CONFIG_CPU_CAVIUM_OCTEON)	+= c-octeon.o cex-oct.o tlb-r4k.o
 
 obj-$(CONFIG_IP22_CPU_SCACHE)	+= sc-ip22.o
 obj-$(CONFIG_R5000_CPU_SCACHE)  += sc-r5k.o
-- 
1.5.6.5
