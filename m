Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 23 Oct 2008 17:28:08 +0100 (BST)
Received: from smtp16.dti.ne.jp ([202.216.231.191]:14988 "EHLO
	smtp16.dti.ne.jp") by ftp.linux-mips.org with ESMTP
	id S22229948AbYJWQ2B (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 23 Oct 2008 17:28:01 +0100
Received: from [192.168.1.3] (PPPax526.tokyo-ip.dti.ne.jp [210.170.129.26]) by smtp16.dti.ne.jp (3.11s) with ESMTP AUTH id m9NGRvgI006631;Fri, 24 Oct 2008 01:27:58 +0900 (JST)
Message-ID: <4900A60D.5050101@ruby.dti.ne.jp>
Date:	Fri, 24 Oct 2008 01:27:57 +0900
From:	Shinya Kuribayashi <skuribay@ruby.dti.ne.jp>
User-Agent: Thunderbird 2.0.0.17 (X11/20080925)
MIME-Version: 1.0
To:	linux-mips@linux-mips.org
CC:	shinya.kuribayashi@necel.com
Subject: [PATCH 01/12] MIPS: Add CONFIG_CPU_R5500 for NEC VR5500 series processors
References: <4900A510.3000101@ruby.dti.ne.jp>
In-Reply-To: <4900A510.3000101@ruby.dti.ne.jp>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <skuribay@ruby.dti.ne.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 20860
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: skuribay@ruby.dti.ne.jp
Precedence: bulk
X-list: linux-mips

We already have sufficient infrastructure to support VR5500 and VR5500A
series processors.  Here's a Makefile support to make it selectable by
ports, and enable it for NEC EMMA2RH Markeins board.

This patch also fixes a confused target help, and adds 1Gb PageMask bits
supported by VR5500 and its variants.

Signed-off-by: Shinya Kuribayashi <shinya.kuribayashi@necel.com>
---
 arch/mips/Kconfig                |   18 +++++++++++++++---
 arch/mips/Makefile               |    2 ++
 arch/mips/include/asm/mipsregs.h |    1 +
 arch/mips/include/asm/module.h   |    2 ++
 arch/mips/kernel/Makefile        |    1 +
 arch/mips/lib/Makefile           |    1 +
 arch/mips/lib/dump_tlb.c         |    1 +
 arch/mips/mm/Makefile            |    1 +
 8 files changed, 24 insertions(+), 3 deletions(-)

diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index 5f149b0..e6ad125 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -249,10 +249,9 @@ config MARKEINS
 	select SYS_SUPPORTS_32BIT_KERNEL
 	select SYS_SUPPORTS_BIG_ENDIAN
 	select SYS_SUPPORTS_LITTLE_ENDIAN
-	select SYS_HAS_CPU_R5000
+	select SYS_HAS_CPU_R5500
 	help
-	  This enables support for the R5432-based NEC Mark-eins
-	  boards with R5500 CPU.
+	  This enables support for the NEC Mark-eins board with VR5500 CPU.
 
 config MACH_VR41XX
 	bool "NEC VR4100 series based machines"
@@ -1092,6 +1091,16 @@ config CPU_R5432
 	select CPU_SUPPORTS_32BIT_KERNEL
 	select CPU_SUPPORTS_64BIT_KERNEL
 
+config CPU_R5500
+	bool "R5500"
+	depends on SYS_HAS_CPU_R5500
+	select CPU_HAS_LLSC
+	select CPU_SUPPORTS_32BIT_KERNEL
+	select CPU_SUPPORTS_64BIT_KERNEL
+	help
+	  NEC VR5500 and VR5500A series processors implement 64-bit MIPS IV
+	  instruction set.
+
 config CPU_R6000
 	bool "R6000"
 	depends on EXPERIMENTAL
@@ -1202,6 +1211,9 @@ config SYS_HAS_CPU_R5000
 config SYS_HAS_CPU_R5432
 	bool
 
+config SYS_HAS_CPU_R5500
+	bool
+
 config SYS_HAS_CPU_R6000
 	bool
 
diff --git a/arch/mips/Makefile b/arch/mips/Makefile
index 7f39fd8..c2197c3 100644
--- a/arch/mips/Makefile
+++ b/arch/mips/Makefile
@@ -131,6 +131,8 @@ cflags-$(CONFIG_CPU_MIPS64_R2)	+= $(call cc-option,-march=mips64r2,-mips64r2 -U_
 cflags-$(CONFIG_CPU_R5000)	+= -march=r5000 -Wa,--trap
 cflags-$(CONFIG_CPU_R5432)	+= $(call cc-option,-march=r5400,-march=r5000) \
 			-Wa,--trap
+cflags-$(CONFIG_CPU_R5500)	+= $(call cc-option,-march=r5500,-march=r5000) \
+			-Wa,--trap
 cflags-$(CONFIG_CPU_NEVADA)	+= $(call cc-option,-march=rm5200,-march=r5000) \
 			-Wa,--trap
 cflags-$(CONFIG_CPU_RM7000)	+= $(call cc-option,-march=rm7000,-march=r5000) \
diff --git a/arch/mips/include/asm/mipsregs.h b/arch/mips/include/asm/mipsregs.h
index 9798660..9316324 100644
--- a/arch/mips/include/asm/mipsregs.h
+++ b/arch/mips/include/asm/mipsregs.h
@@ -192,6 +192,7 @@
 #define PM_16M		0x01ffe000
 #define PM_64M		0x07ffe000
 #define PM_256M		0x1fffe000
+#define PM_1G		0x7fffe000
 
 #endif
 
diff --git a/arch/mips/include/asm/module.h b/arch/mips/include/asm/module.h
index de6d09e..e2e09b2 100644
--- a/arch/mips/include/asm/module.h
+++ b/arch/mips/include/asm/module.h
@@ -98,6 +98,8 @@ search_module_dbetables(unsigned long addr)
 #define MODULE_PROC_FAMILY "R5000 "
 #elif defined CONFIG_CPU_R5432
 #define MODULE_PROC_FAMILY "R5432 "
+#elif defined CONFIG_CPU_R5500
+#define MODULE_PROC_FAMILY "R5500 "
 #elif defined CONFIG_CPU_R6000
 #define MODULE_PROC_FAMILY "R6000 "
 #elif defined CONFIG_CPU_NEVADA
diff --git a/arch/mips/kernel/Makefile b/arch/mips/kernel/Makefile
index d9da711..b1372c2 100644
--- a/arch/mips/kernel/Makefile
+++ b/arch/mips/kernel/Makefile
@@ -33,6 +33,7 @@ obj-$(CONFIG_CPU_R4X00)		+= r4k_fpu.o r4k_switch.o
 obj-$(CONFIG_CPU_R5000)		+= r4k_fpu.o r4k_switch.o
 obj-$(CONFIG_CPU_R6000)		+= r6000_fpu.o r4k_switch.o
 obj-$(CONFIG_CPU_R5432)		+= r4k_fpu.o r4k_switch.o
+obj-$(CONFIG_CPU_R5500)		+= r4k_fpu.o r4k_switch.o
 obj-$(CONFIG_CPU_R8000)		+= r4k_fpu.o r4k_switch.o
 obj-$(CONFIG_CPU_RM7000)	+= r4k_fpu.o r4k_switch.o
 obj-$(CONFIG_CPU_RM9000)	+= r4k_fpu.o r4k_switch.o
diff --git a/arch/mips/lib/Makefile b/arch/mips/lib/Makefile
index 8810dfb..dbcf651 100644
--- a/arch/mips/lib/Makefile
+++ b/arch/mips/lib/Makefile
@@ -18,6 +18,7 @@ obj-$(CONFIG_CPU_R4300)		+= dump_tlb.o
 obj-$(CONFIG_CPU_R4X00)		+= dump_tlb.o
 obj-$(CONFIG_CPU_R5000)		+= dump_tlb.o
 obj-$(CONFIG_CPU_R5432)		+= dump_tlb.o
+obj-$(CONFIG_CPU_R5500)		+= dump_tlb.o
 obj-$(CONFIG_CPU_R6000)		+=
 obj-$(CONFIG_CPU_R8000)		+=
 obj-$(CONFIG_CPU_RM7000)	+= dump_tlb.o
diff --git a/arch/mips/lib/dump_tlb.c b/arch/mips/lib/dump_tlb.c
index 465ff0e..779821c 100644
--- a/arch/mips/lib/dump_tlb.c
+++ b/arch/mips/lib/dump_tlb.c
@@ -25,6 +25,7 @@ static inline const char *msk2str(unsigned int mask)
 	case PM_16M:	return "16Mb";
 	case PM_64M:	return "64Mb";
 	case PM_256M:	return "256Mb";
+	case PM_1G:	return "1Gb";
 #endif
 	}
 	return "";
diff --git a/arch/mips/mm/Makefile b/arch/mips/mm/Makefile
index 44e8dd8..95ba32b 100644
--- a/arch/mips/mm/Makefile
+++ b/arch/mips/mm/Makefile
@@ -19,6 +19,7 @@ obj-$(CONFIG_CPU_R4300)		+= c-r4k.o cex-gen.o tlb-r4k.o
 obj-$(CONFIG_CPU_R4X00)		+= c-r4k.o cex-gen.o tlb-r4k.o
 obj-$(CONFIG_CPU_R5000)		+= c-r4k.o cex-gen.o tlb-r4k.o
 obj-$(CONFIG_CPU_R5432)		+= c-r4k.o cex-gen.o tlb-r4k.o
+obj-$(CONFIG_CPU_R5500)		+= c-r4k.o cex-gen.o tlb-r4k.o
 obj-$(CONFIG_CPU_R8000)		+= c-r4k.o cex-gen.o tlb-r8k.o
 obj-$(CONFIG_CPU_RM7000)	+= c-r4k.o cex-gen.o tlb-r4k.o
 obj-$(CONFIG_CPU_RM9000)	+= c-r4k.o cex-gen.o tlb-r4k.o
