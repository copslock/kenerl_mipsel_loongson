Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 27 Jan 2014 21:26:16 +0100 (CET)
Received: from multi.imgtec.com ([194.200.65.239]:43582 "EHLO multi.imgtec.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6827443AbaA0UWyQ75jg (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 27 Jan 2014 21:22:54 +0100
From:   Markos Chandras <markos.chandras@imgtec.com>
To:     <linux-mips@linux-mips.org>
CC:     Markos Chandras <markos.chandras@imgtec.com>
Subject: [PATCH 17/58] MIPS: lib: memcpy: Split source and destination prefetch macros
Date:   Mon, 27 Jan 2014 20:19:04 +0000
Message-ID: <1390853985-14246-18-git-send-email-markos.chandras@imgtec.com>
X-Mailer: git-send-email 1.8.5.3
In-Reply-To: <1390853985-14246-1-git-send-email-markos.chandras@imgtec.com>
References: <1390853985-14246-1-git-send-email-markos.chandras@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.154.47]
X-SEF-Processed: 7_3_0_01192__2014_01_27_20_22_49
Return-Path: <Markos.Chandras@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 39136
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: markos.chandras@imgtec.com
Precedence: bulk
List-help: <mailto:ecartis@linux-mips.org?Subject=help>
List-unsubscribe: <mailto:ecartis@linux-mips.org?subject=unsubscribe%20linux-mips>
List-software: Ecartis version 1.0.0
List-Id: linux-mips <linux-mips.eddie.linux-mips.org>
X-List-ID: linux-mips <linux-mips.eddie.linux-mips.org>
List-subscribe: <mailto:ecartis@linux-mips.org?subject=subscribe%20linux-mips>
List-owner: <mailto:ralf@linux-mips.org>
List-post: <mailto:linux-mips@linux-mips.org>
List-archive: <http://www.linux-mips.org/archives/linux-mips/>
X-list: linux-mips

In preparation for EVA support, the PREF macro is split into two
separate macros, PREFS and PREFD, for source and destination data
prefetching respectively.

Signed-off-by: Markos Chandras <markos.chandras@imgtec.com>
---
 arch/mips/lib/memcpy.S | 36 ++++++++++++++++++++++--------------
 1 file changed, 22 insertions(+), 14 deletions(-)

diff --git a/arch/mips/lib/memcpy.S b/arch/mips/lib/memcpy.S
index ab9f046..eed6e07 100644
--- a/arch/mips/lib/memcpy.S
+++ b/arch/mips/lib/memcpy.S
@@ -89,6 +89,9 @@
 /* Instruction type */
 #define LD_INSN 1
 #define ST_INSN 2
+/* Pretech type */
+#define SRC_PREFETCH 1
+#define DST_PREFETCH 2
 
 /*
  * Wrapper to add an entry in the exception table
@@ -174,6 +177,11 @@
 #define LOADB(reg, addr, handler)	EXC(lb, LD_INSN, reg, addr, handler)
 #define STOREB(reg, addr, handler)	EXC(sb, ST_INSN, reg, addr, handler)
 
+#define _PREF(hint, addr, type)	        PREF(hint, addr)
+
+#define PREFS(hint, addr) _PREF(hint, addr, SRC_PREFETCH)
+#define PREFD(hint, addr) _PREF(hint, addr, DST_PREFETCH)
+
 #ifdef CONFIG_CPU_LITTLE_ENDIAN
 #define LDFIRST LOADR
 #define LDREST	LOADL
@@ -237,16 +245,16 @@ __copy_user_common:
 	 *
 	 * If len < NBYTES use byte operations.
 	 */
-	PREF(	0, 0(src) )
-	PREF(	1, 0(dst) )
+	PREFS(	0, 0(src) )
+	PREFD(	1, 0(dst) )
 	sltu	t2, len, NBYTES
 	and	t1, dst, ADDRMASK
-	PREF(	0, 1*32(src) )
-	PREF(	1, 1*32(dst) )
+	PREFS(	0, 1*32(src) )
+	PREFD(	1, 1*32(dst) )
 	bnez	t2, .Lcopy_bytes_checklen
 	 and	t0, src, ADDRMASK
-	PREF(	0, 2*32(src) )
-	PREF(	1, 2*32(dst) )
+	PREFS(	0, 2*32(src) )
+	PREFD(	1, 2*32(dst) )
 	bnez	t1, .Ldst_unaligned
 	 nop
 	bnez	t0, .Lsrc_unaligned_dst_aligned
@@ -258,8 +266,8 @@ __copy_user_common:
 	 SRL	t0, len, LOG_NBYTES+3	 # +3 for 8 units/iter
 	beqz	t0, .Lcleanup_both_aligned # len < 8*NBYTES
 	 and	rem, len, (8*NBYTES-1)	 # rem = len % (8*NBYTES)
-	PREF(	0, 3*32(src) )
-	PREF(	1, 3*32(dst) )
+	PREFS(	0, 3*32(src) )
+	PREFD(	1, 3*32(dst) )
 	.align	4
 1:
 	R10KCBARRIER(0(ra))
@@ -282,8 +290,8 @@ __copy_user_common:
 	STORE(t7, UNIT(-3)(dst), .Ls_exc_p3u)
 	STORE(t0, UNIT(-2)(dst), .Ls_exc_p2u)
 	STORE(t1, UNIT(-1)(dst), .Ls_exc_p1u)
-	PREF(	0, 8*32(src) )
-	PREF(	1, 8*32(dst) )
+	PREFS(	0, 8*32(src) )
+	PREFD(	1, 8*32(dst) )
 	bne	len, rem, 1b
 	 nop
 
@@ -378,10 +386,10 @@ __copy_user_common:
 
 .Lsrc_unaligned_dst_aligned:
 	SRL	t0, len, LOG_NBYTES+2	 # +2 for 4 units/iter
-	PREF(	0, 3*32(src) )
+	PREFS(	0, 3*32(src) )
 	beqz	t0, .Lcleanup_src_unaligned
 	 and	rem, len, (4*NBYTES-1)	 # rem = len % 4*NBYTES
-	PREF(	1, 3*32(dst) )
+	PREFD(	1, 3*32(dst) )
 1:
 /*
  * Avoid consecutive LD*'s to the same register since some mips
@@ -399,7 +407,7 @@ __copy_user_common:
 	LDFIRST(t3, FIRST(3)(src), .Ll_exc_copy)
 	LDREST(t2, REST(2)(src), .Ll_exc_copy)
 	LDREST(t3, REST(3)(src), .Ll_exc_copy)
-	PREF(	0, 9*32(src) )		# 0 is PREF_LOAD  (not streamed)
+	PREFS(	0, 9*32(src) )		# 0 is PREF_LOAD  (not streamed)
 	ADD	src, src, 4*NBYTES
 #ifdef CONFIG_CPU_SB1
 	nop				# improves slotting
@@ -408,7 +416,7 @@ __copy_user_common:
 	STORE(t1, UNIT(1)(dst),	.Ls_exc_p3u)
 	STORE(t2, UNIT(2)(dst),	.Ls_exc_p2u)
 	STORE(t3, UNIT(3)(dst),	.Ls_exc_p1u)
-	PREF(	1, 9*32(dst) )		# 1 is PREF_STORE (not streamed)
+	PREFD(	1, 9*32(dst) )		# 1 is PREF_STORE (not streamed)
 	.set	reorder				/* DADDI_WAR */
 	ADD	dst, dst, 4*NBYTES
 	bne	len, rem, 1b
-- 
1.8.5.3
