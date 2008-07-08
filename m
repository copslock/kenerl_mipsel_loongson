Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 08 Jul 2008 13:46:50 +0100 (BST)
Received: from elvis.franken.de ([193.175.24.41]:40128 "EHLO elvis.franken.de")
	by ftp.linux-mips.org with ESMTP id S20023015AbYGHMql (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 8 Jul 2008 13:46:41 +0100
Received: from uucp (helo=solo.franken.de)
	by elvis.franken.de with local-bsmtp (Exim 3.36 #1)
	id 1KGCad-0007gY-00; Tue, 08 Jul 2008 14:46:39 +0200
Received: by solo.franken.de (Postfix, from userid 1000)
	id 4EDFBC3562; Tue,  8 Jul 2008 14:46:34 +0200 (CEST)
From:	Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Subject: [PATCH] Fix 32bit kernels on R4k with 128 byte cache line size
To:	linux-mips@linux-mips.org
cc:	ralf@linux-mips.org
Message-Id: <20080708124634.4EDFBC3562@solo.franken.de>
Date:	Tue,  8 Jul 2008 14:46:34 +0200 (CEST)
Return-Path: <tsbogend@alpha.franken.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 19736
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: tsbogend@alpha.franken.de
Precedence: bulk
X-list: linux-mips

The generated copy_page for R4k CPU with a 128 byte cache line size used
Create Dirty Exclusive cache line operations even if only part of the
cache line was filled.  This change avoids generating cache operations,
if only part of the cache line size is copied in one loop. It also
increases the maxmimum loop size, because the generated code even fits
into the available space for r4k CPUs with 128 byte cache line size.

Signed-off-by: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
---

 arch/mips/mm/page.c |   61 ++++++++++++++++++++++++++------------------------
 1 files changed, 32 insertions(+), 29 deletions(-)

diff --git a/arch/mips/mm/page.c b/arch/mips/mm/page.c
index 1edf0cb..1417c64 100644
--- a/arch/mips/mm/page.c
+++ b/arch/mips/mm/page.c
@@ -235,13 +235,12 @@ static void __cpuinit set_prefetch_parameters(void)
 	}
 	/*
 	 * Too much unrolling will overflow the available space in
-	 * clear_space_array / copy_page_array. 8 words sounds generous,
-	 * but a R4000 with 128 byte L2 line length can exceed even that.
+	 * clear_space_array / copy_page_array.
 	 */
-	half_clear_loop_size = min(8 * clear_word_size,
+	half_clear_loop_size = min(16 * clear_word_size,
 				   max(cache_line_size >> 1,
 				       4 * clear_word_size));
-	half_copy_loop_size = min(8 * copy_word_size,
+	half_copy_loop_size = min(16 * copy_word_size,
 				  max(cache_line_size >> 1,
 				      4 * copy_word_size));
 }
@@ -263,21 +262,23 @@ static inline void __cpuinit build_clear_pref(u32 **buf, int off)
 	if (pref_bias_clear_store) {
 		uasm_i_pref(buf, pref_dst_mode, pref_bias_clear_store + off,
 			    A0);
-	} else if (cpu_has_cache_cdex_s) {
-		uasm_i_cache(buf, Create_Dirty_Excl_SD, off, A0);
-	} else if (cpu_has_cache_cdex_p) {
-		if (R4600_V1_HIT_CACHEOP_WAR && cpu_is_r4600_v1_x()) {
-			uasm_i_nop(buf);
-			uasm_i_nop(buf);
-			uasm_i_nop(buf);
-			uasm_i_nop(buf);
-		}
+	} else if (cache_line_size == (half_clear_loop_size << 1)) {
+		if (cpu_has_cache_cdex_s) {
+			uasm_i_cache(buf, Create_Dirty_Excl_SD, off, A0);
+		} else if (cpu_has_cache_cdex_p) {
+			if (R4600_V1_HIT_CACHEOP_WAR && cpu_is_r4600_v1_x()) {
+				uasm_i_nop(buf);
+				uasm_i_nop(buf);
+				uasm_i_nop(buf);
+				uasm_i_nop(buf);
+			}
 
-		if (R4600_V2_HIT_CACHEOP_WAR && cpu_is_r4600_v2_x())
-			uasm_i_lw(buf, ZERO, ZERO, AT);
+			if (R4600_V2_HIT_CACHEOP_WAR && cpu_is_r4600_v2_x())
+				uasm_i_lw(buf, ZERO, ZERO, AT);
 
-		uasm_i_cache(buf, Create_Dirty_Excl_D, off, A0);
-	}
+			uasm_i_cache(buf, Create_Dirty_Excl_D, off, A0);
+		}
+		}
 }
 
 void __cpuinit build_clear_page(void)
@@ -403,20 +404,22 @@ static inline void build_copy_store_pref(u32 **buf, int off)
 	if (pref_bias_copy_store) {
 		uasm_i_pref(buf, pref_dst_mode, pref_bias_copy_store + off,
 			    A0);
-	} else if (cpu_has_cache_cdex_s) {
-		uasm_i_cache(buf, Create_Dirty_Excl_SD, off, A0);
-	} else if (cpu_has_cache_cdex_p) {
-		if (R4600_V1_HIT_CACHEOP_WAR && cpu_is_r4600_v1_x()) {
-			uasm_i_nop(buf);
-			uasm_i_nop(buf);
-			uasm_i_nop(buf);
-			uasm_i_nop(buf);
-		}
+	} else if (cache_line_size == (half_copy_loop_size << 1)) {
+		if (cpu_has_cache_cdex_s) {
+			uasm_i_cache(buf, Create_Dirty_Excl_SD, off, A0);
+		} else if (cpu_has_cache_cdex_p) {
+			if (R4600_V1_HIT_CACHEOP_WAR && cpu_is_r4600_v1_x()) {
+				uasm_i_nop(buf);
+				uasm_i_nop(buf);
+				uasm_i_nop(buf);
+				uasm_i_nop(buf);
+			}
 
-		if (R4600_V2_HIT_CACHEOP_WAR && cpu_is_r4600_v2_x())
-			uasm_i_lw(buf, ZERO, ZERO, AT);
+			if (R4600_V2_HIT_CACHEOP_WAR && cpu_is_r4600_v2_x())
+				uasm_i_lw(buf, ZERO, ZERO, AT);
 
-		uasm_i_cache(buf, Create_Dirty_Excl_D, off, A0);
+			uasm_i_cache(buf, Create_Dirty_Excl_D, off, A0);
+		}
 	}
 }
 
