Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 21 Jan 2014 17:18:58 +0100 (CET)
Received: from home.bethel-hill.org ([63.228.164.32]:32782 "EHLO localhost"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S6822344AbaAUQS4p3192 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 21 Jan 2014 17:18:56 +0100
Received: by home.bethel-hill.org with esmtpsa (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
        (Exim 4.72)
        (envelope-from <Steven.Hill@imgtec.com>)
        id 1W5e2K-00078z-1n; Tue, 21 Jan 2014 10:18:48 -0600
From:   "Steven J. Hill" <Steven.Hill@imgtec.com>
To:     linux-mips@linux-mips.org
Cc:     ralf@linux-mips.org
Subject: [PATCH] MIPS: lib: Optimize partial checksum ops using prefetching.
Date:   Tue, 21 Jan 2014 10:18:42 -0600
Message-Id: <1390321122-25634-1-git-send-email-Steven.Hill@imgtec.com>
X-Mailer: git-send-email 1.8.3.2
Return-Path: <Steven.Hill@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 39038
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: Steven.Hill@imgtec.com
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

From: Leonid Yegoshin <Leonid.Yegoshin@imgtec.com>

Use the PREF instruction to optimize partial checksum operations.

Signed-off-by: Leonid Yegoshin <Leonid.Yegoshin@imgtec.com>
Signed-off-by: Steven J. Hill <Steven.Hill@imgtec.com>
---
 arch/mips/lib/csum_partial.S | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/mips/lib/csum_partial.S b/arch/mips/lib/csum_partial.S
index a6adffb..272820e 100644
--- a/arch/mips/lib/csum_partial.S
+++ b/arch/mips/lib/csum_partial.S
@@ -417,13 +417,19 @@ FEXPORT(csum_partial_copy_nocheck)
 	 *
 	 * If len < NBYTES use byte operations.
 	 */
+	PREF(	0, 0(src))
+	PREF(	1, 0(dst))
 	sltu	t2, len, NBYTES
 	and	t1, dst, ADDRMASK
 	bnez	t2, .Lcopy_bytes_checklen
+	PREF(	0, 32(src))
+	PREF(	1, 32(dst))
 	 and	t0, src, ADDRMASK
 	andi	odd, dst, 0x1			/* odd buffer? */
 	bnez	t1, .Ldst_unaligned
 	 nop
+	PREF(	0, 2*32(src))
+	PREF(	1, 2*32(dst))
 	bnez	t0, .Lsrc_unaligned_dst_aligned
 	/*
 	 * use delay slot for fall-through
@@ -434,6 +440,8 @@ FEXPORT(csum_partial_copy_nocheck)
 	beqz	t0, .Lcleanup_both_aligned # len < 8*NBYTES
 	 nop
 	SUB	len, 8*NBYTES		# subtract here for bgez loop
+	PREF(	0, 3*32(src))
+	PREF(	1, 3*32(dst))
 	.align	4
 1:
 EXC(	LOAD	t0, UNIT(0)(src),	.Ll_exc)
@@ -464,6 +472,8 @@ EXC(	STORE	t7, UNIT(7)(dst),	.Ls_exc)
 	ADDC(sum, t7)
 	.set	reorder				/* DADDI_WAR */
 	ADD	dst, dst, 8*NBYTES
+	PREF(	0, 8*32(src))
+	PREF(	1, 8*32(dst))
 	bgez	len, 1b
 	.set	noreorder
 	ADD	len, 8*NBYTES		# revert len (see above)
@@ -569,8 +579,10 @@ EXC(	STFIRST t3, FIRST(0)(dst),	.Ls_exc)
 
 .Lsrc_unaligned_dst_aligned:
 	SRL	t0, len, LOG_NBYTES+2	 # +2 for 4 units/iter
+	PREF(	0, 3*32(src))
 	beqz	t0, .Lcleanup_src_unaligned
 	 and	rem, len, (4*NBYTES-1)	 # rem = len % 4*NBYTES
+	PREF(	1, 3*32(dst))
 1:
 /*
  * Avoid consecutive LD*'s to the same register since some mips
-- 
1.8.3.2
