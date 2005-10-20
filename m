Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 20 Oct 2005 08:01:20 +0100 (BST)
Received: from mms3.broadcom.com ([216.31.210.19]:41225 "EHLO
	MMS3.broadcom.com") by ftp.linux-mips.org with ESMTP
	id S3465584AbVJTG5u (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 20 Oct 2005 07:57:50 +0100
Received: from 10.10.64.121 by MMS3.broadcom.com with SMTP (Broadcom
 SMTP Relay (Email Firewall v6.2.0)); Wed, 19 Oct 2005 23:57:42 -0700
X-Server-Uuid: B238DE4C-2139-4D32-96A8-DD564EF2313E
Received: from mail-irva-8.broadcom.com ([10.10.64.221]) by
 mail-irva-1.broadcom.com (Post.Office MTA v3.5.3 release 223 ID#
 0-72233U7200L2200S0V35) with ESMTP id com for
 <linux-mips@linux-mips.org>; Wed, 19 Oct 2005 23:57:40 -0700
Received: from mon-irva-10.broadcom.com (mon-irva-10.broadcom.com
 [10.10.64.171]) by mail-irva-8.broadcom.com (MOS 3.5.6-GR) with ESMTP
 id CAW10959; Wed, 19 Oct 2005 23:57:41 -0700 (PDT)
Received: from mail-sj1-5.sj.broadcom.com (mail-sj1-5.sj.broadcom.com
 [10.16.128.236]) by mon-irva-10.broadcom.com (8.9.1/8.9.1) with ESMTP
 id XAA28273 for <linux-mips@linux-mips.org>; Wed, 19 Oct 2005 23:57:40
 -0700 (PDT)
Received: from localhost.localdomain (ldt-sj3-054 [10.21.3.41]) by
 mail-sj1-5.sj.broadcom.com (8.12.9/8.12.9/SSF) with ESMTP id
 j9K6veov008717 for <linux-mips@linux-mips.org>; Wed, 19 Oct 2005
 23:57:40 -0700 (PDT)
Received: (from adi@localhost) by localhost.localdomain (8.11.6/8.9.3)
 id j9K6veL23989 for linux-mips@linux-mips.org; Wed, 19 Oct 2005
 23:57:40 -0700
Date:	Wed, 19 Oct 2005 23:57:40 -0700
From:	"Andrew Isaacson" <adi@broadcom.com>
To:	linux-mips@linux-mips.org
Subject: [PATCH 7/12]  sb1-cache-exc-handling
Message-ID: <20051020065740.GG23899@broadcom.com>
References: <20051020065320.GA23857@broadcom.com>
MIME-Version: 1.0
In-Reply-To: <20051020065320.GA23857@broadcom.com>
User-Agent: Mutt/1.4.2.1i
X-WSS-ID: 6F49E06C4NK4416437-01-01
Content-Type: text/plain;
 charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 7bit
Return-Path: <adi@broadcom.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 9295
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: adi@broadcom.com
Precedence: bulk
X-list: linux-mips

Expand SB1 cache error handling by adding SB1_CEX_ALWAYS_FATAL and
SB1_CEX_STALL, allowing configurable behavior on cache errors.

Signed-Off-By: Andy Isaacson <adi@broadcom.com>

 arch/mips/mm/cerr-sb1.c  |   54 ++++++++++++++++++++++++++++++++++++++++-------
 arch/mips/mm/cex-sb1.S   |    5 ++++
 arch/mips/sibyte/Kconfig |    8 ++++++
 3 files changed, 59 insertions(+), 8 deletions(-)

Index: lmo/arch/mips/mm/cerr-sb1.c
===================================================================
--- lmo.orig/arch/mips/mm/cerr-sb1.c	2005-10-19 22:34:07.000000000 -0700
+++ lmo/arch/mips/mm/cerr-sb1.c	2005-10-19 22:34:12.000000000 -0700
@@ -19,13 +19,19 @@
 #include <linux/sched.h>
 #include <asm/mipsregs.h>
 #include <asm/sibyte/sb1250.h>
+#include <asm/sibyte/sb1250_regs.h>
 
-#ifndef CONFIG_SIBYTE_BUS_WATCHER
+#if !defined(CONFIG_SIBYTE_BUS_WATCHER) || defined(CONFIG_SIBYTE_BW_TRACE)
 #include <asm/io.h>
-#include <asm/sibyte/sb1250_regs.h>
 #include <asm/sibyte/sb1250_scd.h>
 #endif
 
+/*
+ * We'd like to dump the L2_ECC_TAG register on errors, but errata make
+ * that unsafe... So for now we don't.  (BCM1250/BCM112x erratum SOC-48.)
+ */
+#undef DUMP_L2_ECC_TAG_ON_ERROR
+
 /* SB1 definitions */
 
 /* XXX should come from config1 XXX */
@@ -139,12 +145,18 @@
 static void check_bus_watcher(void)
 {
 	uint32_t status, l2_err, memio_err;
+#ifdef DUMP_L2_ECC_TAG_ON_ERROR
+	uint64_t l2_tag;
+#endif
 
 	/* Destructive read, clears register and interrupt */
 	status = csr_in32(IOADDR(A_SCD_BUS_ERR_STATUS));
 	/* Bit 31 is always on, but there's no #define for that */
 	if (status & ~(1UL << 31)) {
 		l2_err = csr_in32(IOADDR(A_BUS_L2_ERRORS));
+#ifdef DUMP_L2_ECC_TAG_ON_ERROR
+		l2_tag = in64(IO_SPACE_BASE | A_L2_ECC_TAG);
+#endif
 		memio_err = csr_in32(IOADDR(A_BUS_MEM_IO_ERRORS));
 		prom_printf("Bus watcher error counters: %08x %08x\n", l2_err, memio_err);
 		prom_printf("\nLast recorded signature:\n");
@@ -153,6 +165,9 @@
 		       (int)(G_SCD_BERR_TID(status) >> 6),
 		       (int)G_SCD_BERR_RID(status),
 		       (int)G_SCD_BERR_DCODE(status));
+#ifdef DUMP_L2_ECC_TAG_ON_ERROR
+		prom_printf("Last L2 tag w/ bad ECC: %016llx\n", l2_tag);
+#endif
 	} else {
 		prom_printf("Bus watcher indicates no error\n");
 	}
@@ -166,6 +181,16 @@
 	uint64_t cerr_dpa;
 	uint32_t errctl, cerr_i, cerr_d, dpalo, dpahi, eepc, res;
 
+#ifdef CONFIG_SIBYTE_BW_TRACE
+	/* Freeze the trace buffer now */
+#if defined(CONFIG_SIBYTE_BCM1x55) || defined(CONFIG_SIBYTE_BCM1x80)
+	csr_out32(M_BCM1480_SCD_TRACE_CFG_FREEZE, IO_SPACE_BASE | A_SCD_TRACE_CFG);
+#else
+	csr_out32(M_SCD_TRACE_CFG_FREEZE, IO_SPACE_BASE | A_SCD_TRACE_CFG);
+#endif
+	prom_printf("Trace buffer frozen\n");
+#endif
+
 	prom_printf("Cache error exception on CPU %x:\n",
 		    (read_c0_prid() >> 25) & 0x7);
 
@@ -229,11 +254,19 @@
 
 	check_bus_watcher();
 
-	while (1);
 	/*
-	 * This tends to make things get really ugly; let's just stall instead.
-	 *    panic("Can't handle the cache error!");
+	 * Calling panic() when a fatal cache error occurs scrambles the
+	 * state of the system (and the cache), making it difficult to
+	 * investigate after the fact.  However, if you just stall the CPU,
+	 * the other CPU may keep on running, which is typically very
+	 * undesirable.
 	 */
+#ifdef CONFIG_SB1_CERR_STALL
+	while (1)
+		;
+#else
+	panic("unhandled cache error");
+#endif
 }
 
 
@@ -434,7 +467,8 @@
 };
 
 #define DC_TAG_VALID(state) \
-    (((state) == 0xf) || ((state) == 0x13) || ((state) == 0x19) || ((state == 0x16)) || ((state) == 0x1c))
+    (((state) == 0x0) || ((state) == 0xf) || ((state) == 0x13) || \
+     ((state) == 0x19) || ((state) == 0x16) || ((state) == 0x1c))
 
 static char *dc_state_str(unsigned char state)
 {
@@ -505,6 +539,7 @@
 			uint64_t datalo;
 			uint32_t datalohi, datalolo, datahi;
 			int offset;
+			char bad_ecc = 0;
 
 			for (offset = 0; offset < 4; offset++) {
 				/* Index-load-data-D */
@@ -525,8 +560,7 @@
 				ecc = dc_ecc(datalo);
 				if (ecc != datahi) {
 					int bits = 0;
-					prom_printf("  ** bad ECC (%02x %02x) ->",
-						    datahi, ecc);
+					bad_ecc |= 1 << (3-offset);
 					ecc ^= datahi;
 					while (ecc) {
 						if (ecc & 1) bits++;
@@ -537,6 +571,10 @@
 				prom_printf("  %02X-%016llX", datahi, datalo);
 			}
 			prom_printf("\n");
+			if (bad_ecc)
+				prom_printf("  dwords w/ bad ECC: %d %d %d %d\n",
+					    !!(bad_ecc & 8), !!(bad_ecc & 4),
+					    !!(bad_ecc & 2), !!(bad_ecc & 1));
 		}
 	}
 	return res;
Index: lmo/arch/mips/mm/cex-sb1.S
===================================================================
--- lmo.orig/arch/mips/mm/cex-sb1.S	2005-10-19 22:34:07.000000000 -0700
+++ lmo/arch/mips/mm/cex-sb1.S	2005-10-19 22:34:12.000000000 -0700
@@ -64,6 +64,10 @@
 	sd	k0,0x170($0)
 	sd	k1,0x178($0)
 
+#if CONFIG_SB1_CEX_ALWAYS_FATAL
+	j	handle_vec2_sb1
+	 nop
+#else
 	/*
 	 * M_ERRCTL_RECOVERABLE is bit 31, which makes it easy to tell
 	 * if we can fast-path out of here for a h/w-recovered error.
@@ -134,6 +138,7 @@
 	/* Unrecoverable Icache or Dcache error; log it and/or fail */
 	j	handle_vec2_sb1
 	 nop
+#endif
 
 END(except_vec2_sb1)
 
Index: lmo/arch/mips/sibyte/Kconfig
===================================================================
--- lmo.orig/arch/mips/sibyte/Kconfig	2005-10-19 22:34:12.000000000 -0700
+++ lmo/arch/mips/sibyte/Kconfig	2005-10-19 22:34:12.000000000 -0700
@@ -102,6 +102,14 @@
 	  Build a kernel suitable for running under the GDB simulator.
 	  Primarily adjusts the kernel's notion of time.
 
+config CONFIG_SB1_CEX_ALWAYS_FATAL
+	bool "All cache exceptions considered fatal (no recovery attempted)"
+	depends on SIBYTE_SB1xxx_SOC
+
+config CONFIG_SB1_CERR_STALL
+	bool "Stall (rather than panic) on fatal cache error"
+	depends on SIBYTE_SB1xxx_SOC
+
 config SIBYTE_CFE
 	bool "Booting from CFE"
 	depends on SIBYTE_SB1xxx_SOC
