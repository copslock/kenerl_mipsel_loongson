Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 08 Oct 2010 01:07:08 +0200 (CEST)
Received: from smtp2.caviumnetworks.com ([209.113.159.134]:18313 "EHLO
        smtp2.caviumnetworks.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491201Ab0JGXFE (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 8 Oct 2010 01:05:04 +0200
Received: from caexch01.caveonetworks.com (Not Verified[192.168.16.9]) by smtp2.caviumnetworks.com with MailMarshal (v6,7,2,8378)
        id <B4cae50dd0000>; Thu, 07 Oct 2010 18:59:41 -0400
Received: from caexch01.caveonetworks.com ([192.168.16.9]) by caexch01.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.4675);
         Thu, 7 Oct 2010 16:04:16 -0700
Received: from dd1.caveonetworks.com ([12.108.191.236]) by caexch01.caveonetworks.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.4675);
         Thu, 7 Oct 2010 16:04:16 -0700
Received: from dd1.caveonetworks.com (localhost.localdomain [127.0.0.1])
        by dd1.caveonetworks.com (8.14.4/8.14.3) with ESMTP id o97N43ve026944;
        Thu, 7 Oct 2010 16:04:03 -0700
Received: (from ddaney@localhost)
        by dd1.caveonetworks.com (8.14.4/8.14.4/Submit) id o97N42Mi026943;
        Thu, 7 Oct 2010 16:04:02 -0700
From:   David Daney <ddaney@caviumnetworks.com>
To:     linux-mips@linux-mips.org, ralf@linux-mips.org
Cc:     David Daney <ddaney@caviumnetworks.com>
Subject: [PATCH 03/14] MIPS: Octeon: Update L2 Cache code for CN63XX
Date:   Thu,  7 Oct 2010 16:03:42 -0700
Message-Id: <1286492633-26885-4-git-send-email-ddaney@caviumnetworks.com>
X-Mailer: git-send-email 1.7.2.3
In-Reply-To: <1286492633-26885-1-git-send-email-ddaney@caviumnetworks.com>
References: <1286492633-26885-1-git-send-email-ddaney@caviumnetworks.com>
X-OriginalArrivalTime: 07 Oct 2010 23:04:16.0793 (UTC) FILETIME=[F7631890:01CB6673]
Return-Path: <David.Daney@caviumnetworks.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 27978
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@caviumnetworks.com
Precedence: bulk
X-list: linux-mips

The CN63XX has a different L2 cache architecture.  Update the helper
functions to reflect this.

Some joining of split lines was also done to improve readability, as
well as reformatting of comments.

Signed-off-by: David Daney <ddaney@caviumnetworks.com>
---
 arch/mips/cavium-octeon/executive/cvmx-l2c.c |  811 ++++++++++++++++----------
 arch/mips/include/asm/octeon/cvmx-asm.h      |   11 +
 arch/mips/include/asm/octeon/cvmx-l2c.h      |  225 ++++---
 3 files changed, 630 insertions(+), 417 deletions(-)

diff --git a/arch/mips/cavium-octeon/executive/cvmx-l2c.c b/arch/mips/cavium-octeon/executive/cvmx-l2c.c
index 6abe56f..fc7112d 100644
--- a/arch/mips/cavium-octeon/executive/cvmx-l2c.c
+++ b/arch/mips/cavium-octeon/executive/cvmx-l2c.c
@@ -4,7 +4,7 @@
  * Contact: support@caviumnetworks.com
  * This file is part of the OCTEON SDK
  *
- * Copyright (c) 2003-2008 Cavium Networks
+ * Copyright (c) 2003-2010 Cavium Networks
  *
  * This file is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License, Version 2, as
@@ -26,8 +26,8 @@
  ***********************license end**************************************/
 
 /*
- * Implementation of the Level 2 Cache (L2C) control, measurement, and
- * debugging facilities.
+ * Implementation of the Level 2 Cache (L2C) control,
+ * measurement, and debugging facilities.
  */
 
 #include <asm/octeon/cvmx.h>
@@ -42,13 +42,7 @@
  * if multiple applications or operating systems are running, then it
  * is up to the user program to coordinate between them.
  */
-static cvmx_spinlock_t cvmx_l2c_spinlock;
-
-static inline int l2_size_half(void)
-{
-	uint64_t val = cvmx_read_csr(CVMX_L2D_FUS3);
-	return !!(val & (1ull << 34));
-}
+cvmx_spinlock_t cvmx_l2c_spinlock;
 
 int cvmx_l2c_get_core_way_partition(uint32_t core)
 {
@@ -58,6 +52,9 @@ int cvmx_l2c_get_core_way_partition(uint32_t core)
 	if (core >= cvmx_octeon_num_cores())
 		return -1;
 
+	if (OCTEON_IS_MODEL(OCTEON_CN63XX))
+		return cvmx_read_csr(CVMX_L2C_WPAR_PPX(core)) & 0xffff;
+
 	/*
 	 * Use the lower two bits of the coreNumber to determine the
 	 * bit offset of the UMSK[] field in the L2C_SPAR register.
@@ -71,17 +68,13 @@ int cvmx_l2c_get_core_way_partition(uint32_t core)
 
 	switch (core & 0xC) {
 	case 0x0:
-		return (cvmx_read_csr(CVMX_L2C_SPAR0) & (0xFF << field)) >>
-			field;
+		return (cvmx_read_csr(CVMX_L2C_SPAR0) & (0xFF << field)) >> field;
 	case 0x4:
-		return (cvmx_read_csr(CVMX_L2C_SPAR1) & (0xFF << field)) >>
-			field;
+		return (cvmx_read_csr(CVMX_L2C_SPAR1) & (0xFF << field)) >> field;
 	case 0x8:
-		return (cvmx_read_csr(CVMX_L2C_SPAR2) & (0xFF << field)) >>
-			field;
+		return (cvmx_read_csr(CVMX_L2C_SPAR2) & (0xFF << field)) >> field;
 	case 0xC:
-		return (cvmx_read_csr(CVMX_L2C_SPAR3) & (0xFF << field)) >>
-			field;
+		return (cvmx_read_csr(CVMX_L2C_SPAR3) & (0xFF << field)) >> field;
 	}
 	return 0;
 }
@@ -95,48 +88,50 @@ int cvmx_l2c_set_core_way_partition(uint32_t core, uint32_t mask)
 
 	mask &= valid_mask;
 
-	/* A UMSK setting which blocks all L2C Ways is an error. */
-	if (mask == valid_mask)
+	/* A UMSK setting which blocks all L2C Ways is an error on some chips */
+	if (mask == valid_mask && !OCTEON_IS_MODEL(OCTEON_CN63XX))
 		return -1;
 
 	/* Validate the core number */
 	if (core >= cvmx_octeon_num_cores())
 		return -1;
 
-	/* Check to make sure current mask & new mask don't block all ways */
-	if (((mask | cvmx_l2c_get_core_way_partition(core)) & valid_mask) ==
-	    valid_mask)
-		return -1;
+	if (OCTEON_IS_MODEL(OCTEON_CN63XX)) {
+		cvmx_write_csr(CVMX_L2C_WPAR_PPX(core), mask);
+		return 0;
+	}
 
-	/* Use the lower two bits of core to determine the bit offset of the
+	/*
+	 * Use the lower two bits of core to determine the bit offset of the
 	 * UMSK[] field in the L2C_SPAR register.
 	 */
 	field = (core & 0x3) * 8;
 
-	/* Assign the new mask setting to the UMSK[] field in the appropriate
+	/*
+	 * Assign the new mask setting to the UMSK[] field in the appropriate
 	 * L2C_SPAR register based on the core_num.
 	 *
 	 */
 	switch (core & 0xC) {
 	case 0x0:
 		cvmx_write_csr(CVMX_L2C_SPAR0,
-			       (cvmx_read_csr(CVMX_L2C_SPAR0) &
-				~(0xFF << field)) | mask << field);
+			       (cvmx_read_csr(CVMX_L2C_SPAR0) & ~(0xFF << field)) |
+			       mask << field);
 		break;
 	case 0x4:
 		cvmx_write_csr(CVMX_L2C_SPAR1,
-			       (cvmx_read_csr(CVMX_L2C_SPAR1) &
-				~(0xFF << field)) | mask << field);
+			       (cvmx_read_csr(CVMX_L2C_SPAR1) & ~(0xFF << field)) |
+			       mask << field);
 		break;
 	case 0x8:
 		cvmx_write_csr(CVMX_L2C_SPAR2,
-			       (cvmx_read_csr(CVMX_L2C_SPAR2) &
-				~(0xFF << field)) | mask << field);
+			       (cvmx_read_csr(CVMX_L2C_SPAR2) & ~(0xFF << field)) |
+			       mask << field);
 		break;
 	case 0xC:
 		cvmx_write_csr(CVMX_L2C_SPAR3,
-			       (cvmx_read_csr(CVMX_L2C_SPAR3) &
-				~(0xFF << field)) | mask << field);
+			       (cvmx_read_csr(CVMX_L2C_SPAR3) & ~(0xFF << field)) |
+			       mask << field);
 		break;
 	}
 	return 0;
@@ -146,84 +141,137 @@ int cvmx_l2c_set_hw_way_partition(uint32_t mask)
 {
 	uint32_t valid_mask;
 
-	valid_mask = 0xff;
-
-	if (OCTEON_IS_MODEL(OCTEON_CN58XX) || OCTEON_IS_MODEL(OCTEON_CN38XX)) {
-		if (l2_size_half())
-			valid_mask = 0xf;
-	} else if (l2_size_half())
-		valid_mask = 0x3;
-
+	valid_mask = (0x1 << cvmx_l2c_get_num_assoc()) - 1;
 	mask &= valid_mask;
 
-	/* A UMSK setting which blocks all L2C Ways is an error. */
-	if (mask == valid_mask)
-		return -1;
-	/* Check to make sure current mask & new mask don't block all ways */
-	if (((mask | cvmx_l2c_get_hw_way_partition()) & valid_mask) ==
-	    valid_mask)
+	/* A UMSK setting which blocks all L2C Ways is an error on some chips */
+	if (mask == valid_mask  && !OCTEON_IS_MODEL(OCTEON_CN63XX))
 		return -1;
 
-	cvmx_write_csr(CVMX_L2C_SPAR4,
-		       (cvmx_read_csr(CVMX_L2C_SPAR4) & ~0xFF) | mask);
+	if (OCTEON_IS_MODEL(OCTEON_CN63XX))
+		cvmx_write_csr(CVMX_L2C_WPAR_IOBX(0), mask);
+	else
+		cvmx_write_csr(CVMX_L2C_SPAR4,
+			       (cvmx_read_csr(CVMX_L2C_SPAR4) & ~0xFF) | mask);
 	return 0;
 }
 
 int cvmx_l2c_get_hw_way_partition(void)
 {
-	return cvmx_read_csr(CVMX_L2C_SPAR4) & (0xFF);
+	if (OCTEON_IS_MODEL(OCTEON_CN63XX))
+		return cvmx_read_csr(CVMX_L2C_WPAR_IOBX(0)) & 0xffff;
+	else
+		return cvmx_read_csr(CVMX_L2C_SPAR4) & (0xFF);
 }
 
 void cvmx_l2c_config_perf(uint32_t counter, enum cvmx_l2c_event event,
 			  uint32_t clear_on_read)
 {
-	union cvmx_l2c_pfctl pfctl;
+	if (OCTEON_IS_MODEL(OCTEON_CN5XXX) || OCTEON_IS_MODEL(OCTEON_CN3XXX)) {
+		union cvmx_l2c_pfctl pfctl;
 
-	pfctl.u64 = cvmx_read_csr(CVMX_L2C_PFCTL);
+		pfctl.u64 = cvmx_read_csr(CVMX_L2C_PFCTL);
 
-	switch (counter) {
-	case 0:
-		pfctl.s.cnt0sel = event;
-		pfctl.s.cnt0ena = 1;
-		if (!cvmx_octeon_is_pass1())
+		switch (counter) {
+		case 0:
+			pfctl.s.cnt0sel = event;
+			pfctl.s.cnt0ena = 1;
 			pfctl.s.cnt0rdclr = clear_on_read;
-		break;
-	case 1:
-		pfctl.s.cnt1sel = event;
-		pfctl.s.cnt1ena = 1;
-		if (!cvmx_octeon_is_pass1())
+			break;
+		case 1:
+			pfctl.s.cnt1sel = event;
+			pfctl.s.cnt1ena = 1;
 			pfctl.s.cnt1rdclr = clear_on_read;
-		break;
-	case 2:
-		pfctl.s.cnt2sel = event;
-		pfctl.s.cnt2ena = 1;
-		if (!cvmx_octeon_is_pass1())
+			break;
+		case 2:
+			pfctl.s.cnt2sel = event;
+			pfctl.s.cnt2ena = 1;
 			pfctl.s.cnt2rdclr = clear_on_read;
-		break;
-	case 3:
-	default:
-		pfctl.s.cnt3sel = event;
-		pfctl.s.cnt3ena = 1;
-		if (!cvmx_octeon_is_pass1())
+			break;
+		case 3:
+		default:
+			pfctl.s.cnt3sel = event;
+			pfctl.s.cnt3ena = 1;
 			pfctl.s.cnt3rdclr = clear_on_read;
-		break;
-	}
+			break;
+		}
 
-	cvmx_write_csr(CVMX_L2C_PFCTL, pfctl.u64);
+		cvmx_write_csr(CVMX_L2C_PFCTL, pfctl.u64);
+	} else {
+		union cvmx_l2c_tadx_prf l2c_tadx_prf;
+		int tad;
+
+		cvmx_dprintf("L2C performance counter events are different for this chip, mapping 'event' to cvmx_l2c_tad_event_t\n");
+		if (clear_on_read)
+			cvmx_dprintf("L2C counters don't support clear on read for this chip\n");
+
+		l2c_tadx_prf.u64 = cvmx_read_csr(CVMX_L2C_TADX_PRF(0));
+
+		switch (counter) {
+		case 0:
+			l2c_tadx_prf.s.cnt0sel = event;
+			break;
+		case 1:
+			l2c_tadx_prf.s.cnt1sel = event;
+			break;
+		case 2:
+			l2c_tadx_prf.s.cnt2sel = event;
+			break;
+		default:
+		case 3:
+			l2c_tadx_prf.s.cnt3sel = event;
+			break;
+		}
+		for (tad = 0; tad < CVMX_L2C_TADS; tad++)
+			cvmx_write_csr(CVMX_L2C_TADX_PRF(tad),
+				       l2c_tadx_prf.u64);
+	}
 }
 
 uint64_t cvmx_l2c_read_perf(uint32_t counter)
 {
 	switch (counter) {
 	case 0:
-		return cvmx_read_csr(CVMX_L2C_PFC0);
+		if (OCTEON_IS_MODEL(OCTEON_CN5XXX) || OCTEON_IS_MODEL(OCTEON_CN3XXX))
+			return cvmx_read_csr(CVMX_L2C_PFC0);
+		else {
+			uint64_t counter = 0;
+			int tad;
+			for (tad = 0; tad < CVMX_L2C_TADS; tad++)
+				counter += cvmx_read_csr(CVMX_L2C_TADX_PFC0(tad));
+			return counter;
+		}
 	case 1:
-		return cvmx_read_csr(CVMX_L2C_PFC1);
+		if (OCTEON_IS_MODEL(OCTEON_CN5XXX) || OCTEON_IS_MODEL(OCTEON_CN3XXX))
+			return cvmx_read_csr(CVMX_L2C_PFC1);
+		else {
+			uint64_t counter = 0;
+			int tad;
+			for (tad = 0; tad < CVMX_L2C_TADS; tad++)
+				counter += cvmx_read_csr(CVMX_L2C_TADX_PFC1(tad));
+			return counter;
+		}
 	case 2:
-		return cvmx_read_csr(CVMX_L2C_PFC2);
+		if (OCTEON_IS_MODEL(OCTEON_CN5XXX) || OCTEON_IS_MODEL(OCTEON_CN3XXX))
+			return cvmx_read_csr(CVMX_L2C_PFC2);
+		else {
+			uint64_t counter = 0;
+			int tad;
+			for (tad = 0; tad < CVMX_L2C_TADS; tad++)
+				counter += cvmx_read_csr(CVMX_L2C_TADX_PFC2(tad));
+			return counter;
+		}
 	case 3:
 	default:
-		return cvmx_read_csr(CVMX_L2C_PFC3);
+		if (OCTEON_IS_MODEL(OCTEON_CN5XXX) || OCTEON_IS_MODEL(OCTEON_CN3XXX))
+			return cvmx_read_csr(CVMX_L2C_PFC3);
+		else {
+			uint64_t counter = 0;
+			int tad;
+			for (tad = 0; tad < CVMX_L2C_TADS; tad++)
+				counter += cvmx_read_csr(CVMX_L2C_TADX_PFC3(tad));
+			return counter;
+		}
 	}
 }
 
@@ -240,7 +288,7 @@ static void fault_in(uint64_t addr, int len)
 	volatile char dummy;
 	/*
 	 * Adjust addr and length so we get all cache lines even for
-	 * small ranges spanning two cache lines
+	 * small ranges spanning two cache lines.
 	 */
 	len += addr & CVMX_CACHE_LINE_MASK;
 	addr &= ~CVMX_CACHE_LINE_MASK;
@@ -259,67 +307,100 @@ static void fault_in(uint64_t addr, int len)
 
 int cvmx_l2c_lock_line(uint64_t addr)
 {
-	int retval = 0;
-	union cvmx_l2c_dbg l2cdbg;
-	union cvmx_l2c_lckbase lckbase;
-	union cvmx_l2c_lckoff lckoff;
-	union cvmx_l2t_err l2t_err;
-	l2cdbg.u64 = 0;
-	lckbase.u64 = 0;
-	lckoff.u64 = 0;
-
-	cvmx_spinlock_lock(&cvmx_l2c_spinlock);
-
-	/* Clear l2t error bits if set */
-	l2t_err.u64 = cvmx_read_csr(CVMX_L2T_ERR);
-	l2t_err.s.lckerr = 1;
-	l2t_err.s.lckerr2 = 1;
-	cvmx_write_csr(CVMX_L2T_ERR, l2t_err.u64);
+	if (OCTEON_IS_MODEL(OCTEON_CN63XX)) {
+		int shift = CVMX_L2C_TAG_ADDR_ALIAS_SHIFT;
+		uint64_t assoc = cvmx_l2c_get_num_assoc();
+		uint64_t tag = addr >> shift;
+		uint64_t index = CVMX_ADD_SEG(CVMX_MIPS_SPACE_XKPHYS, cvmx_l2c_address_to_index(addr) << CVMX_L2C_IDX_ADDR_SHIFT);
+		uint64_t way;
+		union cvmx_l2c_tadx_tag l2c_tadx_tag;
+
+		CVMX_CACHE_LCKL2(CVMX_ADD_SEG(CVMX_MIPS_SPACE_XKPHYS, addr), 0);
+
+		/* Make sure we were able to lock the line */
+		for (way = 0; way < assoc; way++) {
+			CVMX_CACHE_LTGL2I(index | (way << shift), 0);
+			/* make sure CVMX_L2C_TADX_TAG is updated */
+			CVMX_SYNC;
+			l2c_tadx_tag.u64 = cvmx_read_csr(CVMX_L2C_TADX_TAG(0));
+			if (l2c_tadx_tag.s.valid && l2c_tadx_tag.s.tag == tag)
+				break;
+		}
 
-	addr &= ~CVMX_CACHE_LINE_MASK;
+		/* Check if a valid line is found */
+		if (way >= assoc) {
+			/* cvmx_dprintf("ERROR: cvmx_l2c_lock_line: line not found for locking at 0x%llx address\n", (unsigned long long)addr); */
+			return -1;
+		}
 
-	/* Set this core as debug core */
-	l2cdbg.s.ppnum = cvmx_get_core_num();
-	CVMX_SYNC;
-	cvmx_write_csr(CVMX_L2C_DBG, l2cdbg.u64);
-	cvmx_read_csr(CVMX_L2C_DBG);
-
-	lckoff.s.lck_offset = 0;	/* Only lock 1 line at a time */
-	cvmx_write_csr(CVMX_L2C_LCKOFF, lckoff.u64);
-	cvmx_read_csr(CVMX_L2C_LCKOFF);
-
-	if (((union cvmx_l2c_cfg) (cvmx_read_csr(CVMX_L2C_CFG))).s.idxalias) {
-		int alias_shift =
-		    CVMX_L2C_IDX_ADDR_SHIFT + 2 * CVMX_L2_SET_BITS - 1;
-		uint64_t addr_tmp =
-		    addr ^ (addr & ((1 << alias_shift) - 1)) >>
-		    CVMX_L2_SET_BITS;
-		lckbase.s.lck_base = addr_tmp >> 7;
+		/* Check if lock bit is not set */
+		if (!l2c_tadx_tag.s.lock) {
+			/* cvmx_dprintf("ERROR: cvmx_l2c_lock_line: Not able to lock at 0x%llx address\n", (unsigned long long)addr); */
+			return -1;
+		}
+		return way;
 	} else {
-		lckbase.s.lck_base = addr >> 7;
-	}
+		int retval = 0;
+		union cvmx_l2c_dbg l2cdbg;
+		union cvmx_l2c_lckbase lckbase;
+		union cvmx_l2c_lckoff lckoff;
+		union cvmx_l2t_err l2t_err;
 
-	lckbase.s.lck_ena = 1;
-	cvmx_write_csr(CVMX_L2C_LCKBASE, lckbase.u64);
-	cvmx_read_csr(CVMX_L2C_LCKBASE);	/* Make sure it gets there */
+		cvmx_spinlock_lock(&cvmx_l2c_spinlock);
 
-	fault_in(addr, CVMX_CACHE_LINE_SIZE);
+		l2cdbg.u64 = 0;
+		lckbase.u64 = 0;
+		lckoff.u64 = 0;
 
-	lckbase.s.lck_ena = 0;
-	cvmx_write_csr(CVMX_L2C_LCKBASE, lckbase.u64);
-	cvmx_read_csr(CVMX_L2C_LCKBASE);	/* Make sure it gets there */
+		/* Clear l2t error bits if set */
+		l2t_err.u64 = cvmx_read_csr(CVMX_L2T_ERR);
+		l2t_err.s.lckerr = 1;
+		l2t_err.s.lckerr2 = 1;
+		cvmx_write_csr(CVMX_L2T_ERR, l2t_err.u64);
 
-	/* Stop being debug core */
-	cvmx_write_csr(CVMX_L2C_DBG, 0);
-	cvmx_read_csr(CVMX_L2C_DBG);
+		addr &= ~CVMX_CACHE_LINE_MASK;
 
-	l2t_err.u64 = cvmx_read_csr(CVMX_L2T_ERR);
-	if (l2t_err.s.lckerr || l2t_err.s.lckerr2)
-		retval = 1;	/* We were unable to lock the line */
+		/* Set this core as debug core */
+		l2cdbg.s.ppnum = cvmx_get_core_num();
+		CVMX_SYNC;
+		cvmx_write_csr(CVMX_L2C_DBG, l2cdbg.u64);
+		cvmx_read_csr(CVMX_L2C_DBG);
+
+		lckoff.s.lck_offset = 0; /* Only lock 1 line at a time */
+		cvmx_write_csr(CVMX_L2C_LCKOFF, lckoff.u64);
+		cvmx_read_csr(CVMX_L2C_LCKOFF);
+
+		if (((union cvmx_l2c_cfg)(cvmx_read_csr(CVMX_L2C_CFG))).s.idxalias) {
+			int alias_shift = CVMX_L2C_IDX_ADDR_SHIFT + 2 * CVMX_L2_SET_BITS - 1;
+			uint64_t addr_tmp = addr ^ (addr & ((1 << alias_shift) - 1)) >> CVMX_L2_SET_BITS;
+			lckbase.s.lck_base = addr_tmp >> 7;
+		} else {
+			lckbase.s.lck_base = addr >> 7;
+		}
 
-	cvmx_spinlock_unlock(&cvmx_l2c_spinlock);
+		lckbase.s.lck_ena = 1;
+		cvmx_write_csr(CVMX_L2C_LCKBASE, lckbase.u64);
+		/* Make sure it gets there */
+		cvmx_read_csr(CVMX_L2C_LCKBASE);
 
-	return retval;
+		fault_in(addr, CVMX_CACHE_LINE_SIZE);
+
+		lckbase.s.lck_ena = 0;
+		cvmx_write_csr(CVMX_L2C_LCKBASE, lckbase.u64);
+		/* Make sure it gets there */
+		cvmx_read_csr(CVMX_L2C_LCKBASE);
+
+		/* Stop being debug core */
+		cvmx_write_csr(CVMX_L2C_DBG, 0);
+		cvmx_read_csr(CVMX_L2C_DBG);
+
+		l2t_err.u64 = cvmx_read_csr(CVMX_L2T_ERR);
+		if (l2t_err.s.lckerr || l2t_err.s.lckerr2)
+			retval = 1;  /* We were unable to lock the line */
+
+		cvmx_spinlock_unlock(&cvmx_l2c_spinlock);
+		return retval;
+	}
 }
 
 int cvmx_l2c_lock_mem_region(uint64_t start, uint64_t len)
@@ -336,7 +417,6 @@ int cvmx_l2c_lock_mem_region(uint64_t start, uint64_t len)
 		start += CVMX_CACHE_LINE_SIZE;
 		len -= CVMX_CACHE_LINE_SIZE;
 	}
-
 	return retval;
 }
 
@@ -344,80 +424,73 @@ void cvmx_l2c_flush(void)
 {
 	uint64_t assoc, set;
 	uint64_t n_assoc, n_set;
-	union cvmx_l2c_dbg l2cdbg;
-
-	cvmx_spinlock_lock(&cvmx_l2c_spinlock);
 
-	l2cdbg.u64 = 0;
-	if (!OCTEON_IS_MODEL(OCTEON_CN30XX))
-		l2cdbg.s.ppnum = cvmx_get_core_num();
-	l2cdbg.s.finv = 1;
-	n_set = CVMX_L2_SETS;
-	n_assoc = l2_size_half() ? (CVMX_L2_ASSOC / 2) : CVMX_L2_ASSOC;
-	for (set = 0; set < n_set; set++) {
-		for (assoc = 0; assoc < n_assoc; assoc++) {
-			l2cdbg.s.set = assoc;
-			/* Enter debug mode, and make sure all other
-			 ** writes complete before we enter debug
-			 ** mode */
-			CVMX_SYNCW;
-			cvmx_write_csr(CVMX_L2C_DBG, l2cdbg.u64);
-			cvmx_read_csr(CVMX_L2C_DBG);
-
-			CVMX_PREPARE_FOR_STORE(CVMX_ADD_SEG
-					       (CVMX_MIPS_SPACE_XKPHYS,
-						set * CVMX_CACHE_LINE_SIZE), 0);
-			CVMX_SYNCW;	/* Push STF out to L2 */
-			/* Exit debug mode */
-			CVMX_SYNC;
-			cvmx_write_csr(CVMX_L2C_DBG, 0);
-			cvmx_read_csr(CVMX_L2C_DBG);
+	n_set = cvmx_l2c_get_num_sets();
+	n_assoc = cvmx_l2c_get_num_assoc();
+
+	if (OCTEON_IS_MODEL(OCTEON_CN6XXX)) {
+		uint64_t address;
+		/* These may look like constants, but they aren't... */
+		int assoc_shift = CVMX_L2C_TAG_ADDR_ALIAS_SHIFT;
+		int set_shift = CVMX_L2C_IDX_ADDR_SHIFT;
+		for (set = 0; set < n_set; set++) {
+			for (assoc = 0; assoc < n_assoc; assoc++) {
+				address = CVMX_ADD_SEG(CVMX_MIPS_SPACE_XKPHYS,
+						       (assoc << assoc_shift) |	(set << set_shift));
+				CVMX_CACHE_WBIL2I(address, 0);
+			}
 		}
+	} else {
+		for (set = 0; set < n_set; set++)
+			for (assoc = 0; assoc < n_assoc; assoc++)
+				cvmx_l2c_flush_line(assoc, set);
 	}
-
-	cvmx_spinlock_unlock(&cvmx_l2c_spinlock);
 }
 
+
 int cvmx_l2c_unlock_line(uint64_t address)
 {
-	int assoc;
-	union cvmx_l2c_tag tag;
-	union cvmx_l2c_dbg l2cdbg;
-	uint32_t tag_addr;
 
-	uint32_t index = cvmx_l2c_address_to_index(address);
+	if (OCTEON_IS_MODEL(OCTEON_CN63XX)) {
+		int assoc;
+		union cvmx_l2c_tag tag;
+		uint32_t tag_addr;
+		uint32_t index = cvmx_l2c_address_to_index(address);
+
+		tag_addr = ((address >> CVMX_L2C_TAG_ADDR_ALIAS_SHIFT) & ((1 << CVMX_L2C_TAG_ADDR_ALIAS_SHIFT) - 1));
+
+		/*
+		 * For 63XX, we can flush a line by using the physical
+		 * address directly, so finding the cache line used by
+		 * the address is only required to provide the proper
+		 * return value for the function.
+		 */
+		for (assoc = 0; assoc < CVMX_L2_ASSOC; assoc++) {
+			tag = cvmx_l2c_get_tag(assoc, index);
+
+			if (tag.s.V && (tag.s.addr == tag_addr)) {
+				CVMX_CACHE_WBIL2(CVMX_ADD_SEG(CVMX_MIPS_SPACE_XKPHYS, address), 0);
+				return tag.s.L;
+			}
+		}
+	} else {
+		int assoc;
+		union cvmx_l2c_tag tag;
+		uint32_t tag_addr;
 
-	cvmx_spinlock_lock(&cvmx_l2c_spinlock);
-	/* Compute portion of address that is stored in tag */
-	tag_addr =
-	    ((address >> CVMX_L2C_TAG_ADDR_ALIAS_SHIFT) &
-	     ((1 << CVMX_L2C_TAG_ADDR_ALIAS_SHIFT) - 1));
-	for (assoc = 0; assoc < CVMX_L2_ASSOC; assoc++) {
-		tag = cvmx_get_l2c_tag(assoc, index);
+		uint32_t index = cvmx_l2c_address_to_index(address);
 
-		if (tag.s.V && (tag.s.addr == tag_addr)) {
-			l2cdbg.u64 = 0;
-			l2cdbg.s.ppnum = cvmx_get_core_num();
-			l2cdbg.s.set = assoc;
-			l2cdbg.s.finv = 1;
+		/* Compute portion of address that is stored in tag */
+		tag_addr = ((address >> CVMX_L2C_TAG_ADDR_ALIAS_SHIFT) & ((1 << CVMX_L2C_TAG_ADDR_ALIAS_SHIFT) - 1));
+		for (assoc = 0; assoc < CVMX_L2_ASSOC; assoc++) {
+			tag = cvmx_l2c_get_tag(assoc, index);
 
-			CVMX_SYNC;
-			/* Enter debug mode */
-			cvmx_write_csr(CVMX_L2C_DBG, l2cdbg.u64);
-			cvmx_read_csr(CVMX_L2C_DBG);
-
-			CVMX_PREPARE_FOR_STORE(CVMX_ADD_SEG
-					       (CVMX_MIPS_SPACE_XKPHYS,
-						address), 0);
-			CVMX_SYNC;
-			/* Exit debug mode */
-			cvmx_write_csr(CVMX_L2C_DBG, 0);
-			cvmx_read_csr(CVMX_L2C_DBG);
-			cvmx_spinlock_unlock(&cvmx_l2c_spinlock);
-			return tag.s.L;
+			if (tag.s.V && (tag.s.addr == tag_addr)) {
+				cvmx_l2c_flush_line(assoc, index);
+				return tag.s.L;
+			}
 		}
 	}
-	cvmx_spinlock_unlock(&cvmx_l2c_spinlock);
 	return 0;
 }
 
@@ -445,48 +518,49 @@ union __cvmx_l2c_tag {
 	uint64_t u64;
 	struct cvmx_l2c_tag_cn50xx {
 		uint64_t reserved:40;
-		uint64_t V:1;	/* Line valid */
-		uint64_t D:1;	/* Line dirty */
-		uint64_t L:1;	/* Line locked */
-		uint64_t U:1;	/* Use, LRU eviction */
+		uint64_t V:1;		/* Line valid */
+		uint64_t D:1;		/* Line dirty */
+		uint64_t L:1;		/* Line locked */
+		uint64_t U:1;		/* Use, LRU eviction */
 		uint64_t addr:20;	/* Phys mem addr (33..14) */
 	} cn50xx;
 	struct cvmx_l2c_tag_cn30xx {
 		uint64_t reserved:41;
-		uint64_t V:1;	/* Line valid */
-		uint64_t D:1;	/* Line dirty */
-		uint64_t L:1;	/* Line locked */
-		uint64_t U:1;	/* Use, LRU eviction */
+		uint64_t V:1;		/* Line valid */
+		uint64_t D:1;		/* Line dirty */
+		uint64_t L:1;		/* Line locked */
+		uint64_t U:1;		/* Use, LRU eviction */
 		uint64_t addr:19;	/* Phys mem addr (33..15) */
 	} cn30xx;
 	struct cvmx_l2c_tag_cn31xx {
 		uint64_t reserved:42;
-		uint64_t V:1;	/* Line valid */
-		uint64_t D:1;	/* Line dirty */
-		uint64_t L:1;	/* Line locked */
-		uint64_t U:1;	/* Use, LRU eviction */
+		uint64_t V:1;		/* Line valid */
+		uint64_t D:1;		/* Line dirty */
+		uint64_t L:1;		/* Line locked */
+		uint64_t U:1;		/* Use, LRU eviction */
 		uint64_t addr:18;	/* Phys mem addr (33..16) */
 	} cn31xx;
 	struct cvmx_l2c_tag_cn38xx {
 		uint64_t reserved:43;
-		uint64_t V:1;	/* Line valid */
-		uint64_t D:1;	/* Line dirty */
-		uint64_t L:1;	/* Line locked */
-		uint64_t U:1;	/* Use, LRU eviction */
+		uint64_t V:1;		/* Line valid */
+		uint64_t D:1;		/* Line dirty */
+		uint64_t L:1;		/* Line locked */
+		uint64_t U:1;		/* Use, LRU eviction */
 		uint64_t addr:17;	/* Phys mem addr (33..17) */
 	} cn38xx;
 	struct cvmx_l2c_tag_cn58xx {
 		uint64_t reserved:44;
-		uint64_t V:1;	/* Line valid */
-		uint64_t D:1;	/* Line dirty */
-		uint64_t L:1;	/* Line locked */
-		uint64_t U:1;	/* Use, LRU eviction */
+		uint64_t V:1;		/* Line valid */
+		uint64_t D:1;		/* Line dirty */
+		uint64_t L:1;		/* Line locked */
+		uint64_t U:1;		/* Use, LRU eviction */
 		uint64_t addr:16;	/* Phys mem addr (33..18) */
 	} cn58xx;
 	struct cvmx_l2c_tag_cn58xx cn56xx;	/* 2048 sets */
 	struct cvmx_l2c_tag_cn31xx cn52xx;	/* 512 sets */
 };
 
+
 /**
  * @INTERNAL
  * Function to read a L2C tag.  This code make the current core
@@ -503,7 +577,7 @@ union __cvmx_l2c_tag {
 static union __cvmx_l2c_tag __read_l2_tag(uint64_t assoc, uint64_t index)
 {
 
-	uint64_t debug_tag_addr = (((1ULL << 63) | (index << 7)) + 96);
+	uint64_t debug_tag_addr = CVMX_ADD_SEG(CVMX_MIPS_SPACE_XKPHYS, (index << 7) + 96);
 	uint64_t core = cvmx_get_core_num();
 	union __cvmx_l2c_tag tag_val;
 	uint64_t dbg_addr = CVMX_L2C_DBG;
@@ -512,12 +586,15 @@ static union __cvmx_l2c_tag __read_l2_tag(uint64_t assoc, uint64_t index)
 	union cvmx_l2c_dbg debug_val;
 	debug_val.u64 = 0;
 	/*
-	 * For low core count parts, the core number is always small enough
-	 * to stay in the correct field and not set any reserved bits.
+	 * For low core count parts, the core number is always small
+	 * enough to stay in the correct field and not set any
+	 * reserved bits.
 	 */
 	debug_val.s.ppnum = core;
 	debug_val.s.l2t = 1;
 	debug_val.s.set = assoc;
+
+	local_irq_save(flags);
 	/*
 	 * Make sure core is quiet (no prefetches, etc.) before
 	 * entering debug mode.
@@ -526,112 +603,139 @@ static union __cvmx_l2c_tag __read_l2_tag(uint64_t assoc, uint64_t index)
 	/* Flush L1 to make sure debug load misses L1 */
 	CVMX_DCACHE_INVALIDATE;
 
-	local_irq_save(flags);
-
 	/*
 	 * The following must be done in assembly as when in debug
 	 * mode all data loads from L2 return special debug data, not
-	 * normal memory contents.  Also, interrupts must be
-	 * disabled, since if an interrupt occurs while in debug mode
-	 * the ISR will get debug data from all its memory reads
-	 * instead of the contents of memory
+	 * normal memory contents.  Also, interrupts must be disabled,
+	 * since if an interrupt occurs while in debug mode the ISR
+	 * will get debug data from all its memory * reads instead of
+	 * the contents of memory.
 	 */
 
-	asm volatile (".set push              \n"
-		"        .set mips64              \n"
-		"        .set noreorder           \n"
-		/* Enter debug mode, wait for store */
-		"        sd    %[dbg_val], 0(%[dbg_addr])  \n"
-		"        ld    $0, 0(%[dbg_addr]) \n"
-		/* Read L2C tag data */
-		"        ld    %[tag_val], 0(%[tag_addr]) \n"
-		/* Exit debug mode, wait for store */
-		"        sd    $0, 0(%[dbg_addr])  \n"
-		"        ld    $0, 0(%[dbg_addr]) \n"
-		/* Invalidate dcache to discard debug data */
-		"        cache 9, 0($0) \n"
-		"        .set pop" :
-		[tag_val] "=r"(tag_val.u64) : [dbg_addr] "r"(dbg_addr),
-		[dbg_val] "r"(debug_val.u64),
-		[tag_addr] "r"(debug_tag_addr) : "memory");
+	asm volatile (
+		".set push\n\t"
+		".set mips64\n\t"
+		".set noreorder\n\t"
+		"sd    %[dbg_val], 0(%[dbg_addr])\n\t"   /* Enter debug mode, wait for store */
+		"ld    $0, 0(%[dbg_addr])\n\t"
+		"ld    %[tag_val], 0(%[tag_addr])\n\t"   /* Read L2C tag data */
+		"sd    $0, 0(%[dbg_addr])\n\t"          /* Exit debug mode, wait for store */
+		"ld    $0, 0(%[dbg_addr])\n\t"
+		"cache 9, 0($0)\n\t"             /* Invalidate dcache to discard debug data */
+		".set pop"
+		: [tag_val] "=r" (tag_val)
+		: [dbg_addr] "r" (dbg_addr), [dbg_val] "r" (debug_val), [tag_addr] "r" (debug_tag_addr)
+		: "memory");
 
 	local_irq_restore(flags);
-	return tag_val;
 
+	return tag_val;
 }
 
+
 union cvmx_l2c_tag cvmx_l2c_get_tag(uint32_t association, uint32_t index)
 {
-	union __cvmx_l2c_tag tmp_tag;
 	union cvmx_l2c_tag tag;
 	tag.u64 = 0;
 
 	if ((int)association >= cvmx_l2c_get_num_assoc()) {
-		cvmx_dprintf
-		    ("ERROR: cvmx_get_l2c_tag association out of range\n");
+		cvmx_dprintf("ERROR: cvmx_l2c_get_tag association out of range\n");
 		return tag;
 	}
 	if ((int)index >= cvmx_l2c_get_num_sets()) {
-		cvmx_dprintf("ERROR: cvmx_get_l2c_tag "
-			     "index out of range (arg: %d, max: %d\n",
-		     index, cvmx_l2c_get_num_sets());
+		cvmx_dprintf("ERROR: cvmx_l2c_get_tag index out of range (arg: %d, max: %d)\n",
+			     (int)index, cvmx_l2c_get_num_sets());
 		return tag;
 	}
-	/* __read_l2_tag is intended for internal use only */
-	tmp_tag = __read_l2_tag(association, index);
-
-	/*
-	 * Convert all tag structure types to generic version, as it
-	 * can represent all models.
-	 */
-	if (OCTEON_IS_MODEL(OCTEON_CN58XX) || OCTEON_IS_MODEL(OCTEON_CN56XX)) {
-		tag.s.V = tmp_tag.cn58xx.V;
-		tag.s.D = tmp_tag.cn58xx.D;
-		tag.s.L = tmp_tag.cn58xx.L;
-		tag.s.U = tmp_tag.cn58xx.U;
-		tag.s.addr = tmp_tag.cn58xx.addr;
-	} else if (OCTEON_IS_MODEL(OCTEON_CN38XX)) {
-		tag.s.V = tmp_tag.cn38xx.V;
-		tag.s.D = tmp_tag.cn38xx.D;
-		tag.s.L = tmp_tag.cn38xx.L;
-		tag.s.U = tmp_tag.cn38xx.U;
-		tag.s.addr = tmp_tag.cn38xx.addr;
-	} else if (OCTEON_IS_MODEL(OCTEON_CN31XX)
-		   || OCTEON_IS_MODEL(OCTEON_CN52XX)) {
-		tag.s.V = tmp_tag.cn31xx.V;
-		tag.s.D = tmp_tag.cn31xx.D;
-		tag.s.L = tmp_tag.cn31xx.L;
-		tag.s.U = tmp_tag.cn31xx.U;
-		tag.s.addr = tmp_tag.cn31xx.addr;
-	} else if (OCTEON_IS_MODEL(OCTEON_CN30XX)) {
-		tag.s.V = tmp_tag.cn30xx.V;
-		tag.s.D = tmp_tag.cn30xx.D;
-		tag.s.L = tmp_tag.cn30xx.L;
-		tag.s.U = tmp_tag.cn30xx.U;
-		tag.s.addr = tmp_tag.cn30xx.addr;
-	} else if (OCTEON_IS_MODEL(OCTEON_CN50XX)) {
-		tag.s.V = tmp_tag.cn50xx.V;
-		tag.s.D = tmp_tag.cn50xx.D;
-		tag.s.L = tmp_tag.cn50xx.L;
-		tag.s.U = tmp_tag.cn50xx.U;
-		tag.s.addr = tmp_tag.cn50xx.addr;
+	if (OCTEON_IS_MODEL(OCTEON_CN63XX)) {
+		union cvmx_l2c_tadx_tag l2c_tadx_tag;
+		uint64_t address = CVMX_ADD_SEG(CVMX_MIPS_SPACE_XKPHYS,
+						(association << CVMX_L2C_TAG_ADDR_ALIAS_SHIFT) |
+						(index << CVMX_L2C_IDX_ADDR_SHIFT));
+		/*
+		 * Use L2 cache Index load tag cache instruction, as
+		 * hardware loads the virtual tag for the L2 cache
+		 * block with the contents of L2C_TAD0_TAG
+		 * register.
+		 */
+		CVMX_CACHE_LTGL2I(address, 0);
+		CVMX_SYNC;   /* make sure CVMX_L2C_TADX_TAG is updated */
+		l2c_tadx_tag.u64 = cvmx_read_csr(CVMX_L2C_TADX_TAG(0));
+
+		tag.s.V     = l2c_tadx_tag.s.valid;
+		tag.s.D     = l2c_tadx_tag.s.dirty;
+		tag.s.L     = l2c_tadx_tag.s.lock;
+		tag.s.U     = l2c_tadx_tag.s.use;
+		tag.s.addr  = l2c_tadx_tag.s.tag;
 	} else {
-		cvmx_dprintf("Unsupported OCTEON Model in %s\n", __func__);
+		union __cvmx_l2c_tag tmp_tag;
+		/* __read_l2_tag is intended for internal use only */
+		tmp_tag = __read_l2_tag(association, index);
+
+		/*
+		 * Convert all tag structure types to generic version,
+		 * as it can represent all models.
+		 */
+		if (OCTEON_IS_MODEL(OCTEON_CN58XX) || OCTEON_IS_MODEL(OCTEON_CN56XX)) {
+			tag.s.V    = tmp_tag.cn58xx.V;
+			tag.s.D    = tmp_tag.cn58xx.D;
+			tag.s.L    = tmp_tag.cn58xx.L;
+			tag.s.U    = tmp_tag.cn58xx.U;
+			tag.s.addr = tmp_tag.cn58xx.addr;
+		} else if (OCTEON_IS_MODEL(OCTEON_CN38XX)) {
+			tag.s.V    = tmp_tag.cn38xx.V;
+			tag.s.D    = tmp_tag.cn38xx.D;
+			tag.s.L    = tmp_tag.cn38xx.L;
+			tag.s.U    = tmp_tag.cn38xx.U;
+			tag.s.addr = tmp_tag.cn38xx.addr;
+		} else if (OCTEON_IS_MODEL(OCTEON_CN31XX) || OCTEON_IS_MODEL(OCTEON_CN52XX)) {
+			tag.s.V    = tmp_tag.cn31xx.V;
+			tag.s.D    = tmp_tag.cn31xx.D;
+			tag.s.L    = tmp_tag.cn31xx.L;
+			tag.s.U    = tmp_tag.cn31xx.U;
+			tag.s.addr = tmp_tag.cn31xx.addr;
+		} else if (OCTEON_IS_MODEL(OCTEON_CN30XX)) {
+			tag.s.V    = tmp_tag.cn30xx.V;
+			tag.s.D    = tmp_tag.cn30xx.D;
+			tag.s.L    = tmp_tag.cn30xx.L;
+			tag.s.U    = tmp_tag.cn30xx.U;
+			tag.s.addr = tmp_tag.cn30xx.addr;
+		} else if (OCTEON_IS_MODEL(OCTEON_CN50XX)) {
+			tag.s.V    = tmp_tag.cn50xx.V;
+			tag.s.D    = tmp_tag.cn50xx.D;
+			tag.s.L    = tmp_tag.cn50xx.L;
+			tag.s.U    = tmp_tag.cn50xx.U;
+			tag.s.addr = tmp_tag.cn50xx.addr;
+		} else {
+			cvmx_dprintf("Unsupported OCTEON Model in %s\n", __func__);
+		}
 	}
-
 	return tag;
 }
 
 uint32_t cvmx_l2c_address_to_index(uint64_t addr)
 {
 	uint64_t idx = addr >> CVMX_L2C_IDX_ADDR_SHIFT;
-	union cvmx_l2c_cfg l2c_cfg;
-	l2c_cfg.u64 = cvmx_read_csr(CVMX_L2C_CFG);
+	int indxalias = 0;
 
-	if (l2c_cfg.s.idxalias) {
-		idx ^=
-		    ((addr & CVMX_L2C_ALIAS_MASK) >>
-		     CVMX_L2C_TAG_ADDR_ALIAS_SHIFT);
+	if (OCTEON_IS_MODEL(OCTEON_CN6XXX)) {
+		union cvmx_l2c_ctl l2c_ctl;
+		l2c_ctl.u64 = cvmx_read_csr(CVMX_L2C_CTL);
+		indxalias = !l2c_ctl.s.disidxalias;
+	} else {
+		union cvmx_l2c_cfg l2c_cfg;
+		l2c_cfg.u64 = cvmx_read_csr(CVMX_L2C_CFG);
+		indxalias = l2c_cfg.s.idxalias;
+	}
+
+	if (indxalias) {
+		if (OCTEON_IS_MODEL(OCTEON_CN63XX)) {
+			uint32_t a_14_12 = (idx / (CVMX_L2C_MEMBANK_SELECT_SIZE/(1<<CVMX_L2C_IDX_ADDR_SHIFT))) & 0x7;
+			idx ^= idx / cvmx_l2c_get_num_sets();
+			idx ^= a_14_12;
+		} else {
+			idx ^= ((addr & CVMX_L2C_ALIAS_MASK) >> CVMX_L2C_TAG_ADDR_ALIAS_SHIFT);
+		}
 	}
 	idx &= CVMX_L2C_IDX_MASK;
 	return idx;
@@ -652,10 +756,9 @@ int cvmx_l2c_get_set_bits(void)
 	int l2_set_bits;
 	if (OCTEON_IS_MODEL(OCTEON_CN56XX) || OCTEON_IS_MODEL(OCTEON_CN58XX))
 		l2_set_bits = 11;	/* 2048 sets */
-	else if (OCTEON_IS_MODEL(OCTEON_CN38XX))
+	else if (OCTEON_IS_MODEL(OCTEON_CN38XX) || OCTEON_IS_MODEL(OCTEON_CN63XX))
 		l2_set_bits = 10;	/* 1024 sets */
-	else if (OCTEON_IS_MODEL(OCTEON_CN31XX)
-		 || OCTEON_IS_MODEL(OCTEON_CN52XX))
+	else if (OCTEON_IS_MODEL(OCTEON_CN31XX) || OCTEON_IS_MODEL(OCTEON_CN52XX))
 		l2_set_bits = 9;	/* 512 sets */
 	else if (OCTEON_IS_MODEL(OCTEON_CN30XX))
 		l2_set_bits = 8;	/* 256 sets */
@@ -666,7 +769,6 @@ int cvmx_l2c_get_set_bits(void)
 		l2_set_bits = 11;	/* 2048 sets */
 	}
 	return l2_set_bits;
-
 }
 
 /* Return the number of sets in the L2 Cache */
@@ -682,8 +784,11 @@ int cvmx_l2c_get_num_assoc(void)
 	if (OCTEON_IS_MODEL(OCTEON_CN56XX) ||
 	    OCTEON_IS_MODEL(OCTEON_CN52XX) ||
 	    OCTEON_IS_MODEL(OCTEON_CN58XX) ||
-	    OCTEON_IS_MODEL(OCTEON_CN50XX) || OCTEON_IS_MODEL(OCTEON_CN38XX))
+	    OCTEON_IS_MODEL(OCTEON_CN50XX) ||
+	    OCTEON_IS_MODEL(OCTEON_CN38XX))
 		l2_assoc = 8;
+	else if (OCTEON_IS_MODEL(OCTEON_CN63XX))
+		l2_assoc = 16;
 	else if (OCTEON_IS_MODEL(OCTEON_CN31XX) ||
 		 OCTEON_IS_MODEL(OCTEON_CN30XX))
 		l2_assoc = 4;
@@ -693,11 +798,42 @@ int cvmx_l2c_get_num_assoc(void)
 	}
 
 	/* Check to see if part of the cache is disabled */
-	if (cvmx_fuse_read(265))
-		l2_assoc = l2_assoc >> 2;
-	else if (cvmx_fuse_read(264))
-		l2_assoc = l2_assoc >> 1;
-
+	if (OCTEON_IS_MODEL(OCTEON_CN63XX)) {
+		union cvmx_mio_fus_dat3 mio_fus_dat3;
+
+		mio_fus_dat3.u64 = cvmx_read_csr(CVMX_MIO_FUS_DAT3);
+		/*
+		 * cvmx_mio_fus_dat3.s.l2c_crip fuses map as follows
+		 * <2> will be not used for 63xx
+		 * <1> disables 1/2 ways
+		 * <0> disables 1/4 ways
+		 * They are cumulative, so for 63xx:
+		 * <1> <0>
+		 * 0 0 16-way 2MB cache
+		 * 0 1 12-way 1.5MB cache
+		 * 1 0 8-way 1MB cache
+		 * 1 1 4-way 512KB cache
+		 */
+
+		if (mio_fus_dat3.s.l2c_crip == 3)
+			l2_assoc = 4;
+		else if (mio_fus_dat3.s.l2c_crip == 2)
+			l2_assoc = 8;
+		else if (mio_fus_dat3.s.l2c_crip == 1)
+			l2_assoc = 12;
+	} else {
+		union cvmx_l2d_fus3 val;
+		val.u64 = cvmx_read_csr(CVMX_L2D_FUS3);
+		/*
+		 * Using shifts here, as bit position names are
+		 * different for each model but they all mean the
+		 * same.
+		 */
+		if ((val.u64 >> 35) & 0x1)
+			l2_assoc = l2_assoc >> 2;
+		else if ((val.u64 >> 34) & 0x1)
+			l2_assoc = l2_assoc >> 1;
+	}
 	return l2_assoc;
 }
 
@@ -711,24 +847,55 @@ int cvmx_l2c_get_num_assoc(void)
  */
 void cvmx_l2c_flush_line(uint32_t assoc, uint32_t index)
 {
-	union cvmx_l2c_dbg l2cdbg;
+	/* Check the range of the index. */
+	if (index > (uint32_t)cvmx_l2c_get_num_sets()) {
+		cvmx_dprintf("ERROR: cvmx_l2c_flush_line index out of range.\n");
+		return;
+	}
 
-	l2cdbg.u64 = 0;
-	l2cdbg.s.ppnum = cvmx_get_core_num();
-	l2cdbg.s.finv = 1;
+	/* Check the range of association. */
+	if (assoc > (uint32_t)cvmx_l2c_get_num_assoc()) {
+		cvmx_dprintf("ERROR: cvmx_l2c_flush_line association out of range.\n");
+		return;
+	}
 
-	l2cdbg.s.set = assoc;
-	/*
-	 * Enter debug mode, and make sure all other writes complete
-	 * before we enter debug mode.
-	 */
-	asm volatile ("sync" : : : "memory");
-	cvmx_write_csr(CVMX_L2C_DBG, l2cdbg.u64);
-	cvmx_read_csr(CVMX_L2C_DBG);
-
-	CVMX_PREPARE_FOR_STORE(((1ULL << 63) + (index) * 128), 0);
-	/* Exit debug mode */
-	asm volatile ("sync" : : : "memory");
-	cvmx_write_csr(CVMX_L2C_DBG, 0);
-	cvmx_read_csr(CVMX_L2C_DBG);
+	if (OCTEON_IS_MODEL(OCTEON_CN63XX)) {
+		uint64_t address;
+		/* Create the address based on index and association.
+		 * Bits<20:17> select the way of the cache block involved in
+		 *             the operation
+		 * Bits<16:7> of the effect address select the index
+		 */
+		address = CVMX_ADD_SEG(CVMX_MIPS_SPACE_XKPHYS,
+				(assoc << CVMX_L2C_TAG_ADDR_ALIAS_SHIFT) |
+				(index << CVMX_L2C_IDX_ADDR_SHIFT));
+		CVMX_CACHE_WBIL2I(address, 0);
+	} else {
+		union cvmx_l2c_dbg l2cdbg;
+
+		l2cdbg.u64 = 0;
+		if (!OCTEON_IS_MODEL(OCTEON_CN30XX))
+			l2cdbg.s.ppnum = cvmx_get_core_num();
+		l2cdbg.s.finv = 1;
+
+		l2cdbg.s.set = assoc;
+		cvmx_spinlock_lock(&cvmx_l2c_spinlock);
+		/*
+		 * Enter debug mode, and make sure all other writes
+		 * complete before we enter debug mode
+		 */
+		CVMX_SYNC;
+		cvmx_write_csr(CVMX_L2C_DBG, l2cdbg.u64);
+		cvmx_read_csr(CVMX_L2C_DBG);
+
+		CVMX_PREPARE_FOR_STORE(CVMX_ADD_SEG(CVMX_MIPS_SPACE_XKPHYS,
+						    index * CVMX_CACHE_LINE_SIZE),
+				       0);
+		/* Exit debug mode */
+		CVMX_SYNC;
+		cvmx_write_csr(CVMX_L2C_DBG, 0);
+		cvmx_read_csr(CVMX_L2C_DBG);
+		cvmx_spinlock_unlock(&cvmx_l2c_spinlock);
+	}
 }
+
diff --git a/arch/mips/include/asm/octeon/cvmx-asm.h b/arch/mips/include/asm/octeon/cvmx-asm.h
index b21d3fc..5de5de9 100644
--- a/arch/mips/include/asm/octeon/cvmx-asm.h
+++ b/arch/mips/include/asm/octeon/cvmx-asm.h
@@ -114,6 +114,17 @@
 #define CVMX_DCACHE_INVALIDATE \
 	{ CVMX_SYNC; asm volatile ("cache 9, 0($0)" : : ); }
 
+#define CVMX_CACHE(op, address, offset)					\
+	asm volatile ("cache " CVMX_TMP_STR(op) ", " CVMX_TMP_STR(offset) "(%[rbase])" \
+		: : [rbase] "d" (address) )
+/* fetch and lock the state. */
+#define CVMX_CACHE_LCKL2(address, offset) CVMX_CACHE(31, address, offset)
+/* unlock the state. */
+#define CVMX_CACHE_WBIL2(address, offset) CVMX_CACHE(23, address, offset)
+/* invalidate the cache block and clear the USED bits for the block */
+#define CVMX_CACHE_WBIL2I(address, offset) CVMX_CACHE(3, address, offset)
+/* load virtual tag and data for the L2 cache block into L2C_TAD0_TAG register */
+#define CVMX_CACHE_LTGL2I(address, offset) CVMX_CACHE(7, address, offset)
 
 #define CVMX_POP(result, input) \
 	asm ("pop %[rd],%[rs]" : [rd] "=d" (result) : [rs] "d" (input))
diff --git a/arch/mips/include/asm/octeon/cvmx-l2c.h b/arch/mips/include/asm/octeon/cvmx-l2c.h
index 2a8c090..0b32c5b 100644
--- a/arch/mips/include/asm/octeon/cvmx-l2c.h
+++ b/arch/mips/include/asm/octeon/cvmx-l2c.h
@@ -4,7 +4,7 @@
  * Contact: support@caviumnetworks.com
  * This file is part of the OCTEON SDK
  *
- * Copyright (c) 2003-2008 Cavium Networks
+ * Copyright (c) 2003-2010 Cavium Networks
  *
  * This file is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License, Version 2, as
@@ -26,7 +26,6 @@
  ***********************license end**************************************/
 
 /*
- *
  * Interface to the Level 2 Cache (L2C) control, measurement, and debugging
  * facilities.
  */
@@ -34,93 +33,126 @@
 #ifndef __CVMX_L2C_H__
 #define __CVMX_L2C_H__
 
-/* Deprecated macro, use function */
-#define CVMX_L2_ASSOC     cvmx_l2c_get_num_assoc()
-
-/* Deprecated macro, use function */
-#define CVMX_L2_SET_BITS  cvmx_l2c_get_set_bits()
+#define CVMX_L2_ASSOC     cvmx_l2c_get_num_assoc()   /* Deprecated macro, use function */
+#define CVMX_L2_SET_BITS  cvmx_l2c_get_set_bits()    /* Deprecated macro, use function */
+#define CVMX_L2_SETS      cvmx_l2c_get_num_sets()    /* Deprecated macro, use function */
 
-/* Deprecated macro, use function */
-#define CVMX_L2_SETS      cvmx_l2c_get_num_sets()
 
 #define CVMX_L2C_IDX_ADDR_SHIFT 7  /* based on 128 byte cache line size */
 #define CVMX_L2C_IDX_MASK       (cvmx_l2c_get_num_sets() - 1)
 
 /* Defines for index aliasing computations */
-#define CVMX_L2C_TAG_ADDR_ALIAS_SHIFT \
-	(CVMX_L2C_IDX_ADDR_SHIFT + cvmx_l2c_get_set_bits())
+#define CVMX_L2C_TAG_ADDR_ALIAS_SHIFT (CVMX_L2C_IDX_ADDR_SHIFT + cvmx_l2c_get_set_bits())
+#define CVMX_L2C_ALIAS_MASK (CVMX_L2C_IDX_MASK << CVMX_L2C_TAG_ADDR_ALIAS_SHIFT)
+#define CVMX_L2C_MEMBANK_SELECT_SIZE  4096
 
-#define CVMX_L2C_ALIAS_MASK \
-	(CVMX_L2C_IDX_MASK << CVMX_L2C_TAG_ADDR_ALIAS_SHIFT)
+/* Defines for Virtualizations, valid only from Octeon II onwards. */
+#define CVMX_L2C_VRT_MAX_VIRTID_ALLOWED ((OCTEON_IS_MODEL(OCTEON_CN63XX)) ? 64 : 0)
+#define CVMX_L2C_VRT_MAX_MEMSZ_ALLOWED ((OCTEON_IS_MODEL(OCTEON_CN63XX)) ? 32 : 0)
 
 union cvmx_l2c_tag {
 	uint64_t u64;
 	struct {
 		uint64_t reserved:28;
-		uint64_t V:1;	/* Line valid */
-		uint64_t D:1;	/* Line dirty */
-		uint64_t L:1;	/* Line locked */
-		uint64_t U:1;	/* Use, LRU eviction */
+		uint64_t V:1;		/* Line valid */
+		uint64_t D:1;		/* Line dirty */
+		uint64_t L:1;		/* Line locked */
+		uint64_t U:1;		/* Use, LRU eviction */
 		uint64_t addr:32;	/* Phys mem (not all bits valid) */
 	} s;
 };
 
+/* Number of L2C Tag-and-data sections (TADs) that are connected to LMC. */
+#define CVMX_L2C_TADS  1
+
   /* L2C Performance Counter events. */
 enum cvmx_l2c_event {
-	CVMX_L2C_EVENT_CYCLES = 0,
-	CVMX_L2C_EVENT_INSTRUCTION_MISS = 1,
-	CVMX_L2C_EVENT_INSTRUCTION_HIT = 2,
-	CVMX_L2C_EVENT_DATA_MISS = 3,
-	CVMX_L2C_EVENT_DATA_HIT = 4,
-	CVMX_L2C_EVENT_MISS = 5,
-	CVMX_L2C_EVENT_HIT = 6,
-	CVMX_L2C_EVENT_VICTIM_HIT = 7,
-	CVMX_L2C_EVENT_INDEX_CONFLICT = 8,
-	CVMX_L2C_EVENT_TAG_PROBE = 9,
-	CVMX_L2C_EVENT_TAG_UPDATE = 10,
-	CVMX_L2C_EVENT_TAG_COMPLETE = 11,
-	CVMX_L2C_EVENT_TAG_DIRTY = 12,
-	CVMX_L2C_EVENT_DATA_STORE_NOP = 13,
-	CVMX_L2C_EVENT_DATA_STORE_READ = 14,
+	CVMX_L2C_EVENT_CYCLES           =  0,
+	CVMX_L2C_EVENT_INSTRUCTION_MISS =  1,
+	CVMX_L2C_EVENT_INSTRUCTION_HIT  =  2,
+	CVMX_L2C_EVENT_DATA_MISS        =  3,
+	CVMX_L2C_EVENT_DATA_HIT         =  4,
+	CVMX_L2C_EVENT_MISS             =  5,
+	CVMX_L2C_EVENT_HIT              =  6,
+	CVMX_L2C_EVENT_VICTIM_HIT       =  7,
+	CVMX_L2C_EVENT_INDEX_CONFLICT   =  8,
+	CVMX_L2C_EVENT_TAG_PROBE        =  9,
+	CVMX_L2C_EVENT_TAG_UPDATE       = 10,
+	CVMX_L2C_EVENT_TAG_COMPLETE     = 11,
+	CVMX_L2C_EVENT_TAG_DIRTY        = 12,
+	CVMX_L2C_EVENT_DATA_STORE_NOP   = 13,
+	CVMX_L2C_EVENT_DATA_STORE_READ  = 14,
 	CVMX_L2C_EVENT_DATA_STORE_WRITE = 15,
-	CVMX_L2C_EVENT_FILL_DATA_VALID = 16,
-	CVMX_L2C_EVENT_WRITE_REQUEST = 17,
-	CVMX_L2C_EVENT_READ_REQUEST = 18,
+	CVMX_L2C_EVENT_FILL_DATA_VALID  = 16,
+	CVMX_L2C_EVENT_WRITE_REQUEST    = 17,
+	CVMX_L2C_EVENT_READ_REQUEST     = 18,
 	CVMX_L2C_EVENT_WRITE_DATA_VALID = 19,
-	CVMX_L2C_EVENT_XMC_NOP = 20,
-	CVMX_L2C_EVENT_XMC_LDT = 21,
-	CVMX_L2C_EVENT_XMC_LDI = 22,
-	CVMX_L2C_EVENT_XMC_LDD = 23,
-	CVMX_L2C_EVENT_XMC_STF = 24,
-	CVMX_L2C_EVENT_XMC_STT = 25,
-	CVMX_L2C_EVENT_XMC_STP = 26,
-	CVMX_L2C_EVENT_XMC_STC = 27,
-	CVMX_L2C_EVENT_XMC_DWB = 28,
-	CVMX_L2C_EVENT_XMC_PL2 = 29,
-	CVMX_L2C_EVENT_XMC_PSL1 = 30,
-	CVMX_L2C_EVENT_XMC_IOBLD = 31,
-	CVMX_L2C_EVENT_XMC_IOBST = 32,
-	CVMX_L2C_EVENT_XMC_IOBDMA = 33,
-	CVMX_L2C_EVENT_XMC_IOBRSP = 34,
-	CVMX_L2C_EVENT_XMC_BUS_VALID = 35,
-	CVMX_L2C_EVENT_XMC_MEM_DATA = 36,
-	CVMX_L2C_EVENT_XMC_REFL_DATA = 37,
-	CVMX_L2C_EVENT_XMC_IOBRSP_DATA = 38,
-	CVMX_L2C_EVENT_RSC_NOP = 39,
-	CVMX_L2C_EVENT_RSC_STDN = 40,
-	CVMX_L2C_EVENT_RSC_FILL = 41,
-	CVMX_L2C_EVENT_RSC_REFL = 42,
-	CVMX_L2C_EVENT_RSC_STIN = 43,
-	CVMX_L2C_EVENT_RSC_SCIN = 44,
-	CVMX_L2C_EVENT_RSC_SCFL = 45,
-	CVMX_L2C_EVENT_RSC_SCDN = 46,
-	CVMX_L2C_EVENT_RSC_DATA_VALID = 47,
-	CVMX_L2C_EVENT_RSC_VALID_FILL = 48,
-	CVMX_L2C_EVENT_RSC_VALID_STRSP = 49,
-	CVMX_L2C_EVENT_RSC_VALID_REFL = 50,
-	CVMX_L2C_EVENT_LRF_REQ = 51,
-	CVMX_L2C_EVENT_DT_RD_ALLOC = 52,
-	CVMX_L2C_EVENT_DT_WR_INVAL = 53
+	CVMX_L2C_EVENT_XMC_NOP          = 20,
+	CVMX_L2C_EVENT_XMC_LDT          = 21,
+	CVMX_L2C_EVENT_XMC_LDI          = 22,
+	CVMX_L2C_EVENT_XMC_LDD          = 23,
+	CVMX_L2C_EVENT_XMC_STF          = 24,
+	CVMX_L2C_EVENT_XMC_STT          = 25,
+	CVMX_L2C_EVENT_XMC_STP          = 26,
+	CVMX_L2C_EVENT_XMC_STC          = 27,
+	CVMX_L2C_EVENT_XMC_DWB          = 28,
+	CVMX_L2C_EVENT_XMC_PL2          = 29,
+	CVMX_L2C_EVENT_XMC_PSL1         = 30,
+	CVMX_L2C_EVENT_XMC_IOBLD        = 31,
+	CVMX_L2C_EVENT_XMC_IOBST        = 32,
+	CVMX_L2C_EVENT_XMC_IOBDMA       = 33,
+	CVMX_L2C_EVENT_XMC_IOBRSP       = 34,
+	CVMX_L2C_EVENT_XMC_BUS_VALID    = 35,
+	CVMX_L2C_EVENT_XMC_MEM_DATA     = 36,
+	CVMX_L2C_EVENT_XMC_REFL_DATA    = 37,
+	CVMX_L2C_EVENT_XMC_IOBRSP_DATA  = 38,
+	CVMX_L2C_EVENT_RSC_NOP          = 39,
+	CVMX_L2C_EVENT_RSC_STDN         = 40,
+	CVMX_L2C_EVENT_RSC_FILL         = 41,
+	CVMX_L2C_EVENT_RSC_REFL         = 42,
+	CVMX_L2C_EVENT_RSC_STIN         = 43,
+	CVMX_L2C_EVENT_RSC_SCIN         = 44,
+	CVMX_L2C_EVENT_RSC_SCFL         = 45,
+	CVMX_L2C_EVENT_RSC_SCDN         = 46,
+	CVMX_L2C_EVENT_RSC_DATA_VALID   = 47,
+	CVMX_L2C_EVENT_RSC_VALID_FILL   = 48,
+	CVMX_L2C_EVENT_RSC_VALID_STRSP  = 49,
+	CVMX_L2C_EVENT_RSC_VALID_REFL   = 50,
+	CVMX_L2C_EVENT_LRF_REQ          = 51,
+	CVMX_L2C_EVENT_DT_RD_ALLOC      = 52,
+	CVMX_L2C_EVENT_DT_WR_INVAL      = 53,
+	CVMX_L2C_EVENT_MAX
+};
+
+/* L2C Performance Counter events for Octeon2. */
+enum cvmx_l2c_tad_event {
+	CVMX_L2C_TAD_EVENT_NONE          = 0,
+	CVMX_L2C_TAD_EVENT_TAG_HIT       = 1,
+	CVMX_L2C_TAD_EVENT_TAG_MISS      = 2,
+	CVMX_L2C_TAD_EVENT_TAG_NOALLOC   = 3,
+	CVMX_L2C_TAD_EVENT_TAG_VICTIM    = 4,
+	CVMX_L2C_TAD_EVENT_SC_FAIL       = 5,
+	CVMX_L2C_TAD_EVENT_SC_PASS       = 6,
+	CVMX_L2C_TAD_EVENT_LFB_VALID     = 7,
+	CVMX_L2C_TAD_EVENT_LFB_WAIT_LFB  = 8,
+	CVMX_L2C_TAD_EVENT_LFB_WAIT_VAB  = 9,
+	CVMX_L2C_TAD_EVENT_QUAD0_INDEX   = 128,
+	CVMX_L2C_TAD_EVENT_QUAD0_READ    = 129,
+	CVMX_L2C_TAD_EVENT_QUAD0_BANK    = 130,
+	CVMX_L2C_TAD_EVENT_QUAD0_WDAT    = 131,
+	CVMX_L2C_TAD_EVENT_QUAD1_INDEX   = 144,
+	CVMX_L2C_TAD_EVENT_QUAD1_READ    = 145,
+	CVMX_L2C_TAD_EVENT_QUAD1_BANK    = 146,
+	CVMX_L2C_TAD_EVENT_QUAD1_WDAT    = 147,
+	CVMX_L2C_TAD_EVENT_QUAD2_INDEX   = 160,
+	CVMX_L2C_TAD_EVENT_QUAD2_READ    = 161,
+	CVMX_L2C_TAD_EVENT_QUAD2_BANK    = 162,
+	CVMX_L2C_TAD_EVENT_QUAD2_WDAT    = 163,
+	CVMX_L2C_TAD_EVENT_QUAD3_INDEX   = 176,
+	CVMX_L2C_TAD_EVENT_QUAD3_READ    = 177,
+	CVMX_L2C_TAD_EVENT_QUAD3_BANK    = 178,
+	CVMX_L2C_TAD_EVENT_QUAD3_WDAT    = 179,
+	CVMX_L2C_TAD_EVENT_MAX
 };
 
 /**
@@ -132,10 +164,10 @@ enum cvmx_l2c_event {
  * @clear_on_read:  When asserted, any read of the performance counter
  *                       clears the counter.
  *
- * The routine does not clear the counter.
+ * @note The routine does not clear the counter.
  */
-void cvmx_l2c_config_perf(uint32_t counter,
-			  enum cvmx_l2c_event event, uint32_t clear_on_read);
+void cvmx_l2c_config_perf(uint32_t counter, enum cvmx_l2c_event event, uint32_t clear_on_read);
+
 /**
  * Read the given L2 Cache performance counter. The counter must be configured
  * before reading, but this routine does not enforce this requirement.
@@ -160,18 +192,18 @@ int cvmx_l2c_get_core_way_partition(uint32_t core);
 /**
  * Partitions the L2 cache for a core
  *
- * @core:  The core that the partitioning applies to.
+ * @core: The core that the partitioning applies to.
+ * @mask: The partitioning of the ways expressed as a binary
+ *             mask. A 0 bit allows the core to evict cache lines from
+ *             a way, while a 1 bit blocks the core from evicting any
+ *             lines from that way. There must be at least one allowed
+ *             way (0 bit) in the mask.
  *
- * @mask: The partitioning of the ways expressed as a binary mask. A 0
- *        bit allows the core to evict cache lines from a way, while a
- *        1 bit blocks the core from evicting any lines from that
- *        way. There must be at least one allowed way (0 bit) in the
- *        mask.
- *
- * If any ways are blocked for all cores and the HW blocks, then those
- * ways will never have any cache lines evicted from them.  All cores
- * and the hardware blocks are free to read from all ways regardless
- * of the partitioning.
+
+ * @note If any ways are blocked for all cores and the HW blocks, then
+ *       those ways will never have any cache lines evicted from them.
+ *       All cores and the hardware blocks are free to read from all
+ *       ways regardless of the partitioning.
  */
 int cvmx_l2c_set_core_way_partition(uint32_t core, uint32_t mask);
 
@@ -187,19 +219,21 @@ int cvmx_l2c_get_hw_way_partition(void);
 /**
  * Partitions the L2 cache for the hardware blocks.
  *
- * @mask: The partitioning of the ways expressed as a binary mask. A 0
- *        bit allows the core to evict cache lines from a way, while a
- *        1 bit blocks the core from evicting any lines from that
- *        way. There must be at least one allowed way (0 bit) in the
- *        mask.
+ * @mask: The partitioning of the ways expressed as a binary
+ *             mask. A 0 bit allows the core to evict cache lines from
+ *             a way, while a 1 bit blocks the core from evicting any
+ *             lines from that way. There must be at least one allowed
+ *             way (0 bit) in the mask.
  *
- * If any ways are blocked for all cores and the HW blocks, then those
- * ways will never have any cache lines evicted from them.  All cores
- * and the hardware blocks are free to read from all ways regardless
- * of the partitioning.
+
+ * @note If any ways are blocked for all cores and the HW blocks, then
+ *       those ways will never have any cache lines evicted from them.
+ *       All cores and the hardware blocks are free to read from all
+ *       ways regardless of the partitioning.
  */
 int cvmx_l2c_set_hw_way_partition(uint32_t mask);
 
+
 /**
  * Locks a line in the L2 cache at the specified physical address
  *
@@ -263,13 +297,14 @@ int cvmx_l2c_unlock_mem_region(uint64_t start, uint64_t len);
  */
 union cvmx_l2c_tag cvmx_l2c_get_tag(uint32_t association, uint32_t index);
 
-/* Wrapper around deprecated old function name */
-static inline union cvmx_l2c_tag cvmx_get_l2c_tag(uint32_t association,
-					      uint32_t index)
+/* Wrapper providing a deprecated old function name */
+static inline union cvmx_l2c_tag cvmx_get_l2c_tag(uint32_t association, uint32_t index) __attribute__((deprecated));
+static inline union cvmx_l2c_tag cvmx_get_l2c_tag(uint32_t association, uint32_t index)
 {
 	return cvmx_l2c_get_tag(association, index);
 }
 
+
 /**
  * Returns the cache index for a given physical address
  *
-- 
1.7.2.3
