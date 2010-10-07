Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 08 Oct 2010 01:11:08 +0200 (CEST)
Received: from smtp2.caviumnetworks.com ([209.113.159.134]:18321 "EHLO
        smtp2.caviumnetworks.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491767Ab0JGXFK (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 8 Oct 2010 01:05:10 +0200
Received: from caexch01.caveonetworks.com (Not Verified[192.168.16.9]) by smtp2.caviumnetworks.com with MailMarshal (v6,7,2,8378)
        id <B4cae50e00001>; Thu, 07 Oct 2010 18:59:44 -0400
Received: from caexch01.caveonetworks.com ([192.168.16.9]) by caexch01.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.4675);
         Thu, 7 Oct 2010 16:04:24 -0700
Received: from dd1.caveonetworks.com ([12.108.191.236]) by caexch01.caveonetworks.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.4675);
         Thu, 7 Oct 2010 16:04:24 -0700
Received: from dd1.caveonetworks.com (localhost.localdomain [127.0.0.1])
        by dd1.caveonetworks.com (8.14.4/8.14.3) with ESMTP id o97N4BmR026988;
        Thu, 7 Oct 2010 16:04:11 -0700
Received: (from ddaney@localhost)
        by dd1.caveonetworks.com (8.14.4/8.14.4/Submit) id o97N4B50026987;
        Thu, 7 Oct 2010 16:04:11 -0700
From:   David Daney <ddaney@caviumnetworks.com>
To:     linux-mips@linux-mips.org, ralf@linux-mips.org
Cc:     David Daney <ddaney@caviumnetworks.com>
Subject: [PATCH 14/14] MIPS: Octeon: Apply CN63XXP1 errata workarounds.
Date:   Thu,  7 Oct 2010 16:03:53 -0700
Message-Id: <1286492633-26885-15-git-send-email-ddaney@caviumnetworks.com>
X-Mailer: git-send-email 1.7.2.3
In-Reply-To: <1286492633-26885-1-git-send-email-ddaney@caviumnetworks.com>
References: <1286492633-26885-1-git-send-email-ddaney@caviumnetworks.com>
X-OriginalArrivalTime: 07 Oct 2010 23:04:24.0449 (UTC) FILETIME=[FBF34F10:01CB6673]
Return-Path: <David.Daney@caviumnetworks.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 27987
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@caviumnetworks.com
Precedence: bulk
X-list: linux-mips

The CN63XXP1 needs a couple of workarounds to ensure memory is not
written in unexpected ways.

All PREF with hints in the range 0-4,6-24 are replaced with PREF 28.
We pass a flag to the assembler to cover compiler generated code, and
patch uasm for the dynamically generated code.

The write buffer threshold is reduced to 4.

Signed-off-by: David Daney <ddaney@caviumnetworks.com>
---
 arch/mips/Makefile              |    1 +
 arch/mips/cavium-octeon/Kconfig |   11 ++++++++++
 arch/mips/cavium-octeon/setup.c |   42 +++++++++++++++++++++++++++++++++++---
 arch/mips/mm/uasm.c             |   20 +++++++++++++++++-
 4 files changed, 69 insertions(+), 5 deletions(-)

diff --git a/arch/mips/Makefile b/arch/mips/Makefile
index f4a4b66..28c03ab 100644
--- a/arch/mips/Makefile
+++ b/arch/mips/Makefile
@@ -159,6 +159,7 @@ cflags-$(CONFIG_CPU_CAVIUM_OCTEON) += $(call cc-option,-march=octeon) -Wa,--trap
 ifeq (,$(findstring march=octeon, $(cflags-$(CONFIG_CPU_CAVIUM_OCTEON))))
 cflags-$(CONFIG_CPU_CAVIUM_OCTEON) += -Wa,-march=octeon
 endif
+cflags-$(CONFIG_CAVIUM_CN63XXP1) += -Wa,-mfix-cn63xxp1
 
 cflags-$(CONFIG_CPU_R4000_WORKAROUNDS)	+= $(call cc-option,-mfix-r4000,)
 cflags-$(CONFIG_CPU_R4400_WORKAROUNDS)	+= $(call cc-option,-mfix-r4400,)
diff --git a/arch/mips/cavium-octeon/Kconfig b/arch/mips/cavium-octeon/Kconfig
index 475156b..caae228 100644
--- a/arch/mips/cavium-octeon/Kconfig
+++ b/arch/mips/cavium-octeon/Kconfig
@@ -3,6 +3,17 @@ config CAVIUM_OCTEON_SPECIFIC_OPTIONS
 	depends on CPU_CAVIUM_OCTEON
 	default "y"
 
+config CAVIUM_CN63XXP1
+	bool "Enable CN63XXP1 errata worarounds"
+	depends on CAVIUM_OCTEON_SPECIFIC_OPTIONS
+	default "n"
+	help
+	  The CN63XXP1 chip requires build time workarounds to
+	  function reliably, select this option to enable them.  These
+	  workarounds will cause a slight decrease in performance on
+	  non-CN63XXP1 hardware, so it is recommended to select "n"
+	  unless it is known the workarounds are needed.
+
 config CAVIUM_OCTEON_2ND_KERNEL
 	bool "Build the kernel to be used as a 2nd kernel on the same chip"
 	depends on CAVIUM_OCTEON_SPECIFIC_OPTIONS
diff --git a/arch/mips/cavium-octeon/setup.c b/arch/mips/cavium-octeon/setup.c
index c072b24..b0c3686 100644
--- a/arch/mips/cavium-octeon/setup.c
+++ b/arch/mips/cavium-octeon/setup.c
@@ -356,8 +356,18 @@ void octeon_user_io_init(void)
 	cvmmemctl.s.wbfltime = 0;
 	/* R/W If set, do not put Istream in the L2 cache. */
 	cvmmemctl.s.istrnol2 = 0;
-	/* R/W The write buffer threshold. */
-	cvmmemctl.s.wbthresh = 10;
+
+	/*
+	 * R/W The write buffer threshold. As per erratum Core-14752
+	 * for CN63XX, a sc/scd might fail if the write buffer is
+	 * full.  Lowering WBTHRESH greatly lowers the chances of the
+	 * write buffer ever being full and triggering the erratum.
+	 */
+	if (OCTEON_IS_MODEL(OCTEON_CN63XX_PASS1_X))
+		cvmmemctl.s.wbthresh = 4;
+	else
+		cvmmemctl.s.wbthresh = 10;
+
 	/* R/W If set, CVMSEG is available for loads/stores in
 	 * kernel/debug mode. */
 #if CONFIG_CAVIUM_OCTEON_CVMSEG_SIZE > 0
@@ -375,14 +385,13 @@ void octeon_user_io_init(void)
 	 * is max legal value. */
 	cvmmemctl.s.lmemsz = CONFIG_CAVIUM_OCTEON_CVMSEG_SIZE;
 
+	write_c0_cvmmemctl(cvmmemctl.u64);
 
 	if (smp_processor_id() == 0)
 		pr_notice("CVMSEG size: %d cache lines (%d bytes)\n",
 			  CONFIG_CAVIUM_OCTEON_CVMSEG_SIZE,
 			  CONFIG_CAVIUM_OCTEON_CVMSEG_SIZE * 128);
 
-	write_c0_cvmmemctl(cvmmemctl.u64);
-
 	/* Move the performance counter interrupts to IRQ 6 */
 	cvmctl = read_c0_cvmctl();
 	cvmctl &= ~(7 << 7);
@@ -758,6 +767,31 @@ EXPORT_SYMBOL(prom_putchar);
 
 void prom_free_prom_memory(void)
 {
+	if (OCTEON_IS_MODEL(OCTEON_CN63XX_PASS1_X)) {
+		/* Check for presence of Core-14449 fix.  */
+		u32 insn;
+		u32 *foo;
+
+		foo = &insn;
+
+		asm volatile("# before" : : : "memory");
+		prefetch(foo);
+		asm volatile(
+			".set push\n\t"
+			".set noreorder\n\t"
+			"bal 1f\n\t"
+			"nop\n"
+			"1:\tlw %0,-12($31)\n\t"
+			".set pop\n\t"
+			: "=r" (insn) : : "$31", "memory");
+
+		if ((insn >> 26) != 0x33)
+			panic("No PREF instruction at Core-14449 probe point.\n");
+
+		if (((insn >> 16) & 0x1f) != 28)
+			panic("Core-14449 WAR not in place (%04x).\n"
+			      "Please build kernel with proper options (CONFIG_CAVIUM_CN63XXP1).\n", insn);
+	}
 #ifdef CONFIG_CAVIUM_DECODE_RSL
 	cvmx_interrupt_rsl_enable();
 
diff --git a/arch/mips/mm/uasm.c b/arch/mips/mm/uasm.c
index d2647a4..23afdeb 100644
--- a/arch/mips/mm/uasm.c
+++ b/arch/mips/mm/uasm.c
@@ -405,7 +405,6 @@ I_u1u2u3(_mfc0)
 I_u1u2u3(_mtc0)
 I_u2u1u3(_ori)
 I_u3u1u2(_or)
-I_u2s3u1(_pref)
 I_0(_rfe)
 I_u2s3u1(_sc)
 I_u2s3u1(_scd)
@@ -427,6 +426,25 @@ I_u1(_syscall);
 I_u1u2s3(_bbit0);
 I_u1u2s3(_bbit1);
 
+#ifdef CONFIG_CPU_CAVIUM_OCTEON
+#include <asm/octeon/octeon.h>
+void __uasminit uasm_i_pref(u32 **buf, unsigned int a, signed int b,
+			    unsigned int c)
+{
+	if (OCTEON_IS_MODEL(OCTEON_CN63XX_PASS1_X) && a <= 24 && a != 5)
+		/*
+		 * As per erratum Core-14449, replace prefetches 0-4,
+		 * 6-24 with 'pref 28'.
+		 */
+		build_insn(buf, insn_pref, c, 28, b);
+	else
+		build_insn(buf, insn_pref, c, a, b);
+}
+UASM_EXPORT_SYMBOL(uasm_i_pref);
+#else
+I_u2s3u1(_pref)
+#endif
+
 /* Handle labels. */
 void __uasminit uasm_build_label(struct uasm_label **lab, u32 *addr, int lid)
 {
-- 
1.7.2.3
