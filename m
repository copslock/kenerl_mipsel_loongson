Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 20 Oct 2005 08:02:15 +0100 (BST)
Received: from mms3.broadcom.com ([216.31.210.19]:41225 "EHLO
	MMS3.broadcom.com") by ftp.linux-mips.org with ESMTP
	id S3465586AbVJTG6K (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 20 Oct 2005 07:58:10 +0100
Received: from 10.10.64.121 by MMS3.broadcom.com with SMTP (Broadcom
 SMTP Relay (Email Firewall v6.2.0)); Wed, 19 Oct 2005 23:58:00 -0700
X-Server-Uuid: B238DE4C-2139-4D32-96A8-DD564EF2313E
Received: from mail-irva-8.broadcom.com ([10.10.64.221]) by
 mail-irva-1.broadcom.com (Post.Office MTA v3.5.3 release 223 ID#
 0-72233U7200L2200S0V35) with ESMTP id com for
 <linux-mips@linux-mips.org>; Wed, 19 Oct 2005 23:57:58 -0700
Received: from mon-irva-10.broadcom.com (mon-irva-10.broadcom.com
 [10.10.64.171]) by mail-irva-8.broadcom.com (MOS 3.5.6-GR) with ESMTP
 id CAW10978; Wed, 19 Oct 2005 23:57:57 -0700 (PDT)
Received: from mail-sj1-5.sj.broadcom.com (mail-sj1-5.sj.broadcom.com
 [10.16.128.236]) by mon-irva-10.broadcom.com (8.9.1/8.9.1) with ESMTP
 id XAA28283 for <linux-mips@linux-mips.org>; Wed, 19 Oct 2005 23:57:57
 -0700 (PDT)
Received: from localhost.localdomain (ldt-sj3-054 [10.21.3.41]) by
 mail-sj1-5.sj.broadcom.com (8.12.9/8.12.9/SSF) with ESMTP id
 j9K6vvov008720 for <linux-mips@linux-mips.org>; Wed, 19 Oct 2005
 23:57:57 -0700 (PDT)
Received: (from adi@localhost) by localhost.localdomain (8.11.6/8.9.3)
 id j9K6vvq24000 for linux-mips@linux-mips.org; Wed, 19 Oct 2005
 23:57:57 -0700
Date:	Wed, 19 Oct 2005 23:57:57 -0700
From:	"Andrew Isaacson" <adi@broadcom.com>
To:	linux-mips@linux-mips.org
Subject: [PATCH 8/12]  cerr-printk-not-prom-printf
Message-ID: <20051020065757.GH23899@broadcom.com>
References: <20051020065320.GA23857@broadcom.com>
MIME-Version: 1.0
In-Reply-To: <20051020065320.GA23857@broadcom.com>
User-Agent: Mutt/1.4.2.1i
X-WSS-ID: 6F49E0724NK4416508-01-01
Content-Type: text/plain;
 charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 7bit
Return-Path: <adi@broadcom.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 9296
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: adi@broadcom.com
Precedence: bulk
X-list: linux-mips

Use printk rather than prom_printf in cache error handlers.
prom_printf does not handle SMP locking, and shows up only
on console (not in dmesg(1) or syslog).

Signed-Off-By: Andy Isaacson <adi@broadcom.com>

 arch/mips/mm/cerr-sb1.c |  122 ++++++++++++++++++++++++------------------------
 1 files changed, 61 insertions(+), 61 deletions(-)

Index: lmo/arch/mips/mm/cerr-sb1.c
===================================================================
--- lmo.orig/arch/mips/mm/cerr-sb1.c	2005-10-19 22:34:12.000000000 -0700
+++ lmo/arch/mips/mm/cerr-sb1.c	2005-10-19 22:34:12.000000000 -0700
@@ -78,66 +78,66 @@
 static inline void breakout_errctl(unsigned int val)
 {
 	if (val & CP0_ERRCTL_RECOVERABLE)
-		prom_printf(" recoverable");
+		printk(" recoverable");
 	if (val & CP0_ERRCTL_DCACHE)
-		prom_printf(" dcache");
+		printk(" dcache");
 	if (val & CP0_ERRCTL_ICACHE)
-		prom_printf(" icache");
+		printk(" icache");
 	if (val & CP0_ERRCTL_MULTIBUS)
-		prom_printf(" multiple-buserr");
-	prom_printf("\n");
+		printk(" multiple-buserr");
+	printk("\n");
 }
 
 static inline void breakout_cerri(unsigned int val)
 {
 	if (val & CP0_CERRI_TAG_PARITY)
-		prom_printf(" tag-parity");
+		printk(" tag-parity");
 	if (val & CP0_CERRI_DATA_PARITY)
-		prom_printf(" data-parity");
+		printk(" data-parity");
 	if (val & CP0_CERRI_EXTERNAL)
-		prom_printf(" external");
-	prom_printf("\n");
+		printk(" external");
+	printk("\n");
 }
 
 static inline void breakout_cerrd(unsigned int val)
 {
 	switch (val & CP0_CERRD_CAUSES) {
 	case CP0_CERRD_LOAD:
-		prom_printf(" load,");
+		printk(" load,");
 		break;
 	case CP0_CERRD_STORE:
-		prom_printf(" store,");
+		printk(" store,");
 		break;
 	case CP0_CERRD_FILLWB:
-		prom_printf(" fill/wb,");
+		printk(" fill/wb,");
 		break;
 	case CP0_CERRD_COHERENCY:
-		prom_printf(" coherency,");
+		printk(" coherency,");
 		break;
 	case CP0_CERRD_DUPTAG:
-		prom_printf(" duptags,");
+		printk(" duptags,");
 		break;
 	default:
-		prom_printf(" NO CAUSE,");
+		printk(" NO CAUSE,");
 		break;
 	}
 	if (!(val & CP0_CERRD_TYPES))
-		prom_printf(" NO TYPE");
+		printk(" NO TYPE");
 	else {
 		if (val & CP0_CERRD_MULTIPLE)
-			prom_printf(" multi-err");
+			printk(" multi-err");
 		if (val & CP0_CERRD_TAG_STATE)
-			prom_printf(" tag-state");
+			printk(" tag-state");
 		if (val & CP0_CERRD_TAG_ADDRESS)
-			prom_printf(" tag-address");
+			printk(" tag-address");
 		if (val & CP0_CERRD_DATA_SBE)
-			prom_printf(" data-SBE");
+			printk(" data-SBE");
 		if (val & CP0_CERRD_DATA_DBE)
-			prom_printf(" data-DBE");
+			printk(" data-DBE");
 		if (val & CP0_CERRD_EXTERNAL)
-			prom_printf(" external");
+			printk(" external");
 	}
-	prom_printf("\n");
+	printk("\n");
 }
 
 #ifndef CONFIG_SIBYTE_BUS_WATCHER
@@ -158,18 +158,18 @@
 		l2_tag = in64(IO_SPACE_BASE | A_L2_ECC_TAG);
 #endif
 		memio_err = csr_in32(IOADDR(A_BUS_MEM_IO_ERRORS));
-		prom_printf("Bus watcher error counters: %08x %08x\n", l2_err, memio_err);
-		prom_printf("\nLast recorded signature:\n");
-		prom_printf("Request %02x from %d, answered by %d with Dcode %d\n",
+		printk("Bus watcher error counters: %08x %08x\n", l2_err, memio_err);
+		printk("\nLast recorded signature:\n");
+		printk("Request %02x from %d, answered by %d with Dcode %d\n",
 		       (unsigned int)(G_SCD_BERR_TID(status) & 0x3f),
 		       (int)(G_SCD_BERR_TID(status) >> 6),
 		       (int)G_SCD_BERR_RID(status),
 		       (int)G_SCD_BERR_DCODE(status));
 #ifdef DUMP_L2_ECC_TAG_ON_ERROR
-		prom_printf("Last L2 tag w/ bad ECC: %016llx\n", l2_tag);
+		printk("Last L2 tag w/ bad ECC: %016llx\n", l2_tag);
 #endif
 	} else {
-		prom_printf("Bus watcher indicates no error\n");
+		printk("Bus watcher indicates no error\n");
 	}
 }
 #else
@@ -184,14 +184,14 @@
 #ifdef CONFIG_SIBYTE_BW_TRACE
 	/* Freeze the trace buffer now */
 #if defined(CONFIG_SIBYTE_BCM1x55) || defined(CONFIG_SIBYTE_BCM1x80)
-	csr_out32(M_BCM1480_SCD_TRACE_CFG_FREEZE, IO_SPACE_BASE | A_SCD_TRACE_CFG);
+	csr_out32(M_BCM1480_SCD_TRACE_CFG_FREEZE, IOADDR(A_SCD_TRACE_CFG));
 #else
-	csr_out32(M_SCD_TRACE_CFG_FREEZE, IO_SPACE_BASE | A_SCD_TRACE_CFG);
+	csr_out32(M_SCD_TRACE_CFG_FREEZE, IOADDR(A_SCD_TRACE_CFG));
 #endif
-	prom_printf("Trace buffer frozen\n");
+	printk("Trace buffer frozen\n");
 #endif
 
-	prom_printf("Cache error exception on CPU %x:\n",
+	printk("Cache error exception on CPU %x:\n",
 		    (read_c0_prid() >> 25) & 0x7);
 
 	__asm__ __volatile__ (
@@ -210,43 +210,43 @@
 	  "=r" (dpahi), "=r" (dpalo), "=r" (eepc));
 
 	cerr_dpa = (((uint64_t)dpahi) << 32) | dpalo;
-	prom_printf(" c0_errorepc ==   %08x\n", eepc);
-	prom_printf(" c0_errctl   ==   %08x", errctl);
+	printk(" c0_errorepc ==   %08x\n", eepc);
+	printk(" c0_errctl   ==   %08x", errctl);
 	breakout_errctl(errctl);
 	if (errctl & CP0_ERRCTL_ICACHE) {
-		prom_printf(" c0_cerr_i   ==   %08x", cerr_i);
+		printk(" c0_cerr_i   ==   %08x", cerr_i);
 		breakout_cerri(cerr_i);
 		if (CP0_CERRI_IDX_VALID(cerr_i)) {
 			/* Check index of EPC, allowing for delay slot */
 			if (((eepc & SB1_CACHE_INDEX_MASK) != (cerr_i & SB1_CACHE_INDEX_MASK)) &&
 			    ((eepc & SB1_CACHE_INDEX_MASK) != ((cerr_i & SB1_CACHE_INDEX_MASK) - 4)))
-				prom_printf(" cerr_i idx doesn't match eepc\n");
+				printk(" cerr_i idx doesn't match eepc\n");
 			else {
 				res = extract_ic(cerr_i & SB1_CACHE_INDEX_MASK,
 						 (cerr_i & CP0_CERRI_DATA) != 0);
 				if (!(res & cerr_i))
-					prom_printf("...didn't see indicated icache problem\n");
+					printk("...didn't see indicated icache problem\n");
 			}
 		}
 	}
 	if (errctl & CP0_ERRCTL_DCACHE) {
-		prom_printf(" c0_cerr_d   ==   %08x", cerr_d);
+		printk(" c0_cerr_d   ==   %08x", cerr_d);
 		breakout_cerrd(cerr_d);
 		if (CP0_CERRD_DPA_VALID(cerr_d)) {
-			prom_printf(" c0_cerr_dpa == %010llx\n", cerr_dpa);
+			printk(" c0_cerr_dpa == %010llx\n", cerr_dpa);
 			if (!CP0_CERRD_IDX_VALID(cerr_d)) {
 				res = extract_dc(cerr_dpa & SB1_CACHE_INDEX_MASK,
 						 (cerr_d & CP0_CERRD_DATA) != 0);
 				if (!(res & cerr_d))
-					prom_printf("...didn't see indicated dcache problem\n");
+					printk("...didn't see indicated dcache problem\n");
 			} else {
 				if ((cerr_dpa & SB1_CACHE_INDEX_MASK) != (cerr_d & SB1_CACHE_INDEX_MASK))
-					prom_printf(" cerr_d idx doesn't match cerr_dpa\n");
+					printk(" cerr_d idx doesn't match cerr_dpa\n");
 				else {
 					res = extract_dc(cerr_d & SB1_CACHE_INDEX_MASK,
 							 (cerr_d & CP0_CERRD_DATA) != 0);
 					if (!(res & cerr_d))
-						prom_printf("...didn't see indicated problem\n");
+						printk("...didn't see indicated problem\n");
 				}
 			}
 		}
@@ -335,7 +335,7 @@
 	uint8_t lru;
 	int res = 0;
 
-	prom_printf("Icache index 0x%04x  ", addr);
+	printk("Icache index 0x%04x  ", addr);
 	for (way = 0; way < 4; way++) {
 		/* Index-load-tag-I */
 		__asm__ __volatile__ (
@@ -355,7 +355,7 @@
 		taglo = ((unsigned long long)taglohi << 32) | taglolo;
 		if (way == 0) {
 			lru = (taghi >> 14) & 0xff;
-			prom_printf("[Bank %d Set 0x%02x]  LRU > %d %d %d %d > MRU\n",
+			printk("[Bank %d Set 0x%02x]  LRU > %d %d %d %d > MRU\n",
 				    ((addr >> 5) & 0x3), /* bank */
 				    ((addr >> 7) & 0x3f), /* index */
 				    (lru & 0x3),
@@ -370,19 +370,19 @@
 		if (valid) {
 			tlo_tmp = taglo & 0xfff3ff;
 			if (((taglo >> 10) & 1) ^ range_parity(tlo_tmp, 23, 0)) {
-				prom_printf("   ** bad parity in VTag0/G/ASID\n");
+				printk("   ** bad parity in VTag0/G/ASID\n");
 				res |= CP0_CERRI_TAG_PARITY;
 			}
 			if (((taglo >> 11) & 1) ^ range_parity(taglo, 63, 24)) {
-				prom_printf("   ** bad parity in R/VTag1\n");
+				printk("   ** bad parity in R/VTag1\n");
 				res |= CP0_CERRI_TAG_PARITY;
 			}
 		}
 		if (valid ^ ((taghi >> 27) & 1)) {
-			prom_printf("   ** bad parity for valid bit\n");
+			printk("   ** bad parity for valid bit\n");
 			res |= CP0_CERRI_TAG_PARITY;
 		}
-		prom_printf(" %d  [VA %016llx]  [Vld? %d]  raw tags: %08X-%016llX\n",
+		printk(" %d  [VA %016llx]  [Vld? %d]  raw tags: %08X-%016llX\n",
 			    way, va, valid, taghi, taglo);
 
 		if (data) {
@@ -408,21 +408,21 @@
 				: "r" ((way << 13) | addr | (offset << 3)));
 				predecode = (datahi >> 8) & 0xff;
 				if (((datahi >> 16) & 1) != (uint32_t)range_parity(predecode, 7, 0)) {
-					prom_printf("   ** bad parity in predecode\n");
+					printk("   ** bad parity in predecode\n");
 					res |= CP0_CERRI_DATA_PARITY;
 				}
 				/* XXXKW should/could check predecode bits themselves */
 				if (((datahi >> 4) & 0xf) ^ inst_parity(insta)) {
-					prom_printf("   ** bad parity in instruction a\n");
+					printk("   ** bad parity in instruction a\n");
 					res |= CP0_CERRI_DATA_PARITY;
 				}
 				if ((datahi & 0xf) ^ inst_parity(instb)) {
-					prom_printf("   ** bad parity in instruction b\n");
+					printk("   ** bad parity in instruction b\n");
 					res |= CP0_CERRI_DATA_PARITY;
 				}
-				prom_printf("  %05X-%08X%08X", datahi, insta, instb);
+				printk("  %05X-%08X%08X", datahi, insta, instb);
 			}
-			prom_printf("\n");
+			printk("\n");
 		}
 	}
 	return res;
@@ -490,7 +490,7 @@
 	uint8_t ecc, lru;
 	int res = 0;
 
-	prom_printf("Dcache index 0x%04x  ", addr);
+	printk("Dcache index 0x%04x  ", addr);
 	for (way = 0; way < 4; way++) {
 		__asm__ __volatile__ (
 		"	.set	push\n\t"
@@ -510,7 +510,7 @@
 		pa = (taglo & 0xFFFFFFE000ULL) | addr;
 		if (way == 0) {
 			lru = (taghi >> 14) & 0xff;
-			prom_printf("[Bank %d Set 0x%02x]  LRU > %d %d %d %d > MRU\n",
+			printk("[Bank %d Set 0x%02x]  LRU > %d %d %d %d > MRU\n",
 				    ((addr >> 11) & 0x2) | ((addr >> 5) & 1), /* bank */
 				    ((addr >> 6) & 0x3f), /* index */
 				    (lru & 0x3),
@@ -520,15 +520,15 @@
 		}
 		state = (taghi >> 25) & 0x1f;
 		valid = DC_TAG_VALID(state);
-		prom_printf(" %d  [PA %010llx]  [state %s (%02x)]  raw tags: %08X-%016llX\n",
+		printk(" %d  [PA %010llx]  [state %s (%02x)]  raw tags: %08X-%016llX\n",
 			    way, pa, dc_state_str(state), state, taghi, taglo);
 		if (valid) {
 			if (((taglo >> 11) & 1) ^ range_parity(taglo, 39, 26)) {
-				prom_printf("   ** bad parity in PTag1\n");
+				printk("   ** bad parity in PTag1\n");
 				res |= CP0_CERRD_TAG_ADDRESS;
 			}
 			if (((taglo >> 10) & 1) ^ range_parity(taglo, 25, 13)) {
-				prom_printf("   ** bad parity in PTag0\n");
+				printk("   ** bad parity in PTag0\n");
 				res |= CP0_CERRD_TAG_ADDRESS;
 			}
 		} else {
@@ -568,11 +568,11 @@
 					}
 					res |= (bits == 1) ? CP0_CERRD_DATA_SBE : CP0_CERRD_DATA_DBE;
 				}
-				prom_printf("  %02X-%016llX", datahi, datalo);
+				printk("  %02X-%016llX", datahi, datalo);
 			}
-			prom_printf("\n");
+			printk("\n");
 			if (bad_ecc)
-				prom_printf("  dwords w/ bad ECC: %d %d %d %d\n",
+				printk("  dwords w/ bad ECC: %d %d %d %d\n",
 					    !!(bad_ecc & 8), !!(bad_ecc & 4),
 					    !!(bad_ecc & 2), !!(bad_ecc & 1));
 		}
