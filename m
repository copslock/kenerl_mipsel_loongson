Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 27 Jan 2014 21:27:31 +0100 (CET)
Received: from multi.imgtec.com ([194.200.65.239]:43586 "EHLO multi.imgtec.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6831312AbaA0UXGsPMiy (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 27 Jan 2014 21:23:06 +0100
From:   Markos Chandras <markos.chandras@imgtec.com>
To:     <linux-mips@linux-mips.org>
CC:     Markos Chandras <markos.chandras@imgtec.com>
Subject: [PATCH 22/58] MIPS: lib: memset: Add EVA support for the __bzero function.
Date:   Mon, 27 Jan 2014 20:19:09 +0000
Message-ID: <1390853985-14246-23-git-send-email-markos.chandras@imgtec.com>
X-Mailer: git-send-email 1.8.5.3
In-Reply-To: <1390853985-14246-1-git-send-email-markos.chandras@imgtec.com>
References: <1390853985-14246-1-git-send-email-markos.chandras@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.154.47]
X-SEF-Processed: 7_3_0_01192__2014_01_27_20_23_01
Return-Path: <Markos.Chandras@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 39140
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

Build the __bzero function using the EVA load/store instructions
when operating in the EVA mode. This function is only used when
accessing user code so there is no need to build two distinct symbols
for user and kernel operations respectively.

Signed-off-by: Markos Chandras <markos.chandras@imgtec.com>
---
 arch/mips/lib/memset.S | 27 +++++++++++++++++++++++----
 1 file changed, 23 insertions(+), 4 deletions(-)

diff --git a/arch/mips/lib/memset.S b/arch/mips/lib/memset.S
index 05fac19..7b0e546 100644
--- a/arch/mips/lib/memset.S
+++ b/arch/mips/lib/memset.S
@@ -37,13 +37,24 @@
 #define LEGACY_MODE 1
 #define EVA_MODE    2
 
+/*
+ * No need to protect it with EVA #ifdefery. The generated block of code
+ * will never be assembled if EVA is not enabled.
+ */
+#define __EVAFY(insn, reg, addr) __BUILD_EVA_INSN(insn##e, reg, addr)
+#define ___BUILD_EVA_INSN(insn, reg, addr) __EVAFY(insn, reg, addr)
+
 #define EX(insn,reg,addr,handler)			\
-9:	insn	reg, addr;				\
+	.if \mode == LEGACY_MODE;			\
+9:		insn	reg, addr;			\
+	.else;						\
+9:		___BUILD_EVA_INSN(insn, reg, addr);	\
+	.endif;						\
 	.section __ex_table,"a";			\
 	PTR	9b, handler;				\
 	.previous
 
-	.macro	f_fill64 dst, offset, val, fixup
+	.macro	f_fill64 dst, offset, val, fixup, mode
 	EX(LONG_S, \val, (\offset +  0 * STORSIZE)(\dst), \fixup)
 	EX(LONG_S, \val, (\offset +  1 * STORSIZE)(\dst), \fixup)
 	EX(LONG_S, \val, (\offset +  2 * STORSIZE)(\dst), \fixup)
@@ -119,7 +130,7 @@
 	.set		reorder
 1:	PTR_ADDIU	a0, 64
 	R10KCBARRIER(0(ra))
-	f_fill64 a0, -64, FILL64RG, .Lfwd_fixup\@
+	f_fill64 a0, -64, FILL64RG, .Lfwd_fixup\@, \mode
 	bne		t1, a0, 1b
 	.set		noreorder
 
@@ -144,7 +155,7 @@
 	.set		noreorder
 	.set		nomacro
 	/* ... but first do longs ... */
-	f_fill64 a0, -64, FILL64RG, .Lpartial_fixup\@
+	f_fill64 a0, -64, FILL64RG, .Lpartial_fixup\@, \mode
 2:	.set		pop
 	andi		a2, STORMASK		/* At most one long to go */
 
@@ -225,5 +236,13 @@ LEAF(memset)
 #endif
 	or		a1, t1
 1:
+#ifndef CONFIG_EVA
 FEXPORT(__bzero)
+#endif
 	__BUILD_BZERO LEGACY_MODE
+
+#ifdef CONFIG_EVA
+LEAF(__bzero)
+	__BUILD_BZERO EVA_MODE
+END(__bzero)
+#endif
-- 
1.8.5.3
