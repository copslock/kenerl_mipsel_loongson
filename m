Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 27 Jan 2014 21:27:12 +0100 (CET)
Received: from multi.imgtec.com ([194.200.65.239]:43584 "EHLO multi.imgtec.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6831301AbaA0UXCNPs2z (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 27 Jan 2014 21:23:02 +0100
From:   Markos Chandras <markos.chandras@imgtec.com>
To:     <linux-mips@linux-mips.org>
CC:     Markos Chandras <markos.chandras@imgtec.com>
Subject: [PATCH 20/58] MIPS: lib: memset: Whitespace fixes
Date:   Mon, 27 Jan 2014 20:19:07 +0000
Message-ID: <1390853985-14246-21-git-send-email-markos.chandras@imgtec.com>
X-Mailer: git-send-email 1.8.5.3
In-Reply-To: <1390853985-14246-1-git-send-email-markos.chandras@imgtec.com>
References: <1390853985-14246-1-git-send-email-markos.chandras@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.154.47]
X-SEF-Processed: 7_3_0_01192__2014_01_27_20_22_57
Return-Path: <Markos.Chandras@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 39139
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

Signed-off-by: Markos Chandras <markos.chandras@imgtec.com>
---
 arch/mips/lib/memset.S | 30 +++++++++++++++---------------
 1 file changed, 15 insertions(+), 15 deletions(-)

diff --git a/arch/mips/lib/memset.S b/arch/mips/lib/memset.S
index 0580194..d857985 100644
--- a/arch/mips/lib/memset.S
+++ b/arch/mips/lib/memset.S
@@ -74,7 +74,7 @@
 	.align	5
 LEAF(memset)
 	beqz		a1, 1f
-	 move		v0, a0			/* result */
+	move		v0, a0			/* result */
 
 	andi		a1, 0xff		/* spread fillword */
 	LONG_SLL		t1, a1, 8
@@ -90,7 +90,7 @@ LEAF(memset)
 FEXPORT(__bzero)
 	sltiu		t0, a2, STORSIZE	/* very small region? */
 	bnez		t0, .Lsmall_memset
-	 andi		t0, a0, STORMASK	/* aligned? */
+	andi		t0, a0, STORMASK	/* aligned? */
 
 #ifdef CONFIG_CPU_MICROMIPS
 	move		t8, a1			/* used by 'swp' instruction */
@@ -98,12 +98,12 @@ FEXPORT(__bzero)
 #endif
 #ifndef CONFIG_CPU_DADDI_WORKAROUNDS
 	beqz		t0, 1f
-	 PTR_SUBU	t0, STORSIZE		/* alignment in bytes */
+	PTR_SUBU	t0, STORSIZE		/* alignment in bytes */
 #else
 	.set		noat
 	li		AT, STORSIZE
 	beqz		t0, 1f
-	 PTR_SUBU	t0, AT			/* alignment in bytes */
+	PTR_SUBU	t0, AT			/* alignment in bytes */
 	.set		at
 #endif
 
@@ -120,7 +120,7 @@ FEXPORT(__bzero)
 1:	ori		t1, a2, 0x3f		/* # of full blocks */
 	xori		t1, 0x3f
 	beqz		t1, .Lmemset_partial	/* no block to fill */
-	 andi		t0, a2, 0x40-STORSIZE
+	andi		t0, a2, 0x40-STORSIZE
 
 	PTR_ADDU	t1, a0			/* end address */
 	.set		reorder
@@ -145,7 +145,7 @@ FEXPORT(__bzero)
 	.set		at
 #endif
 	jr		t1
-	 PTR_ADDU	a0, t0			/* dest ptr */
+	PTR_ADDU	a0, t0			/* dest ptr */
 
 	.set		push
 	.set		noreorder
@@ -155,7 +155,7 @@ FEXPORT(__bzero)
 	andi		a2, STORMASK		/* At most one long to go */
 
 	beqz		a2, 1f
-	 PTR_ADDU	a0, a2			/* What's left */
+	PTR_ADDU	a0, a2			/* What's left */
 	R10KCBARRIER(0(ra))
 #ifdef __MIPSEB__
 	EX(LONG_S_R, a1, -1(a0), .Llast_fixup)
@@ -164,24 +164,24 @@ FEXPORT(__bzero)
 	EX(LONG_S_L, a1, -1(a0), .Llast_fixup)
 #endif
 1:	jr		ra
-	 move		a2, zero
+	move		a2, zero
 
 .Lsmall_memset:
 	beqz		a2, 2f
-	 PTR_ADDU	t1, a0, a2
+	PTR_ADDU	t1, a0, a2
 
 1:	PTR_ADDIU	a0, 1			/* fill bytewise */
 	R10KCBARRIER(0(ra))
 	bne		t1, a0, 1b
-	 sb		a1, -1(a0)
+	sb		a1, -1(a0)
 
 2:	jr		ra			/* done */
-	 move		a2, zero
+	move		a2, zero
 	END(memset)
 
 .Lfirst_fixup:
 	jr	ra
-	 nop
+	nop
 
 .Lfwd_fixup:
 	PTR_L		t0, TI_TASK($28)
@@ -189,7 +189,7 @@ FEXPORT(__bzero)
 	LONG_L		t0, THREAD_BUADDR(t0)
 	LONG_ADDU	a2, t1
 	jr		ra
-	 LONG_SUBU	a2, t0
+	LONG_SUBU	a2, t0
 
 .Lpartial_fixup:
 	PTR_L		t0, TI_TASK($28)
@@ -197,8 +197,8 @@ FEXPORT(__bzero)
 	LONG_L		t0, THREAD_BUADDR(t0)
 	LONG_ADDU	a2, t1
 	jr		ra
-	 LONG_SUBU	a2, t0
+	LONG_SUBU	a2, t0
 
 .Llast_fixup:
 	jr		ra
-	 andi		v1, a2, STORMASK
+	andi		v1, a2, STORMASK
-- 
1.8.5.3
