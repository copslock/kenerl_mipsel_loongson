Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 14 May 2010 13:11:33 +0200 (CEST)
Received: from mail-pz0-f194.google.com ([209.85.222.194]:50006 "EHLO
        mail-pz0-f194.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491806Ab0ENLJ2 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 14 May 2010 13:09:28 +0200
Received: by pzk32 with SMTP id 32so33004pzk.21
        for <multiple recipients>; Fri, 14 May 2010 04:09:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:in-reply-to:references;
        bh=sUV0UEyyeWUAUw2/qyY0IjOu+TLfxPukcfsMzXgGXLo=;
        b=tnEH71y1XAsf1lKyPcW5Ib2/ugrC1knfQ9Tl+UsaDdlsijRhZ7tBy4OMBnPNXHM9P8
         TWoEtPGIlUqAgXRDXiiw0BaZjIfkdvTsFHAHAtiha+wCgp5OMDAGk0Uw2BxUaVeKk0sW
         I0ks7P3NDHfCdDrzhZ5FjYNNwIBh7KdflRp/8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=qigzxQSZQbRYr2kvyZFi8j69hsDxymJDrTD55x5W04UbOOGsyacVGEXjWYkKUBqI89
         nYM2L567RAloIbSOp+dqvnByxhDreqjJIVIJBR6w2G4NfGzwXGzG2wJV/m9IPyn7Fsoo
         iDfakwpJV4VBuZTDGHaT2lBbPRbgReFseHcDk=
Received: by 10.114.3.2 with SMTP id 2mr999125wac.192.1273835360924;
        Fri, 14 May 2010 04:09:20 -0700 (PDT)
Received: from localhost.localdomain ([202.201.14.140])
        by mx.google.com with ESMTPS id c14sm19145160waa.13.2010.05.14.04.09.17
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 14 May 2010 04:09:20 -0700 (PDT)
From:   Wu Zhangjin <wuzhangjin@gmail.com>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     linux-mips <linux-mips@linux-mips.org>,
        David Daney <david.s.daney@gmail.com>,
        Wu Zhangjin <wuzhangjin@gmail.com>
Subject: [PATCH 6/9] tracing: MIPS: cleanup of the instructions
Date:   Fri, 14 May 2010 19:08:31 +0800
Message-Id: <03e5e022a66b563d2d736fbd91f4c8221b8bd4af.1273834562.git.wuzhangjin@gmail.com>
X-Mailer: git-send-email 1.7.0.4
In-Reply-To: <cover.1273834561.git.wuzhangjin@gmail.com>
References: <cover.1273834561.git.wuzhangjin@gmail.com>
In-Reply-To: <cover.1273834561.git.wuzhangjin@gmail.com>
References: <cover.1273834561.git.wuzhangjin@gmail.com>
Return-Path: <wuzhangjin@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 26715
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wuzhangjin@gmail.com
Precedence: bulk
X-list: linux-mips

From: Wu Zhangjin <wuzhangjin@gmail.com>

This patch adds some cleanups of the instructions:
  o use macro instead of magic numbers
  o use macro instead of variables to reduce some overhead
  o add a new macro for the jal instruction

Signed-off-by: Wu Zhangjin <wuzhangjin@gmail.com>
---
 arch/mips/kernel/ftrace.c |   19 +++++++++++--------
 1 files changed, 11 insertions(+), 8 deletions(-)

diff --git a/arch/mips/kernel/ftrace.c b/arch/mips/kernel/ftrace.c
index 37aa767..b1b8fec 100644
--- a/arch/mips/kernel/ftrace.c
+++ b/arch/mips/kernel/ftrace.c
@@ -23,7 +23,10 @@
 #define jump_insn_encode(op_code, addr) \
 	((unsigned int)((op_code) | (((addr) >> 2) & ADDR_MASK)))
 
-static unsigned int ftrace_nop = 0x00000000;
+#define INSN_B_1F_4 0x10000004	/* b 1f; offset = 4 */
+#define INSN_B_1F_5 0x10000005	/* b 1f; offset = 5 */
+#define INSN_NOP 0x00000000	/* nop */
+#define INSN_JAL(addr)	jump_insn_encode(JAL, addr)
 
 static int ftrace_modify_code(unsigned long ip, unsigned int new_code)
 {
@@ -71,7 +74,7 @@ int ftrace_make_nop(struct module *mod,
 		 *  sub sp, sp, 8
 		 *                                  1: offset = 5 instructions
 		 */
-		new = 0x10000005;
+		new = INSN_B_1F_5;
 #else
 		/* lui v1, hi_16bit_of_mcount        --> b 1f (0x10000004)
 		 * addiu v1, v1, low_16bit_of_mcount
@@ -80,7 +83,7 @@ int ftrace_make_nop(struct module *mod,
 		 *  nop | move $12, ra_address | sub sp, sp, 8
 		 *                                  1: offset = 4 instructions
 		 */
-		new = 0x10000004;
+		new = INSN_B_1F_4;
 #endif
 	} else {
 		/* record/calculate it for ftrace_make_call */
@@ -88,13 +91,13 @@ int ftrace_make_nop(struct module *mod,
 			/* We can record it directly like this:
 			 *     jal_mcount = *(unsigned int *)ip;
 			 * Herein, jump over the first two nop instructions */
-			jal_mcount = jump_insn_encode(JAL, (MCOUNT_ADDR + 8));
+			jal_mcount = INSN_JAL(MCOUNT_ADDR + 8);
 		}
 
 		/* move at, ra
 		 * jalr v1		--> nop
 		 */
-		new = ftrace_nop;
+		new = INSN_NOP;
 	}
 	return ftrace_modify_code(ip, new);
 }
@@ -109,7 +112,7 @@ int ftrace_make_call(struct dyn_ftrace *rec, unsigned long addr)
 	/* We just need to remove the "b ftrace_stub" at the fist time! */
 	if (modified == 0) {
 		modified = 1;
-		ftrace_modify_code(addr, ftrace_nop);
+		ftrace_modify_code(addr, INSN_NOP);
 	}
 	/* ip, module: 0xc0000000, kernel: 0x80000000 */
 	new = (ip & 0x40000000) ? lui_v1 : jal_mcount;
@@ -123,7 +126,7 @@ int ftrace_update_ftrace_func(ftrace_func_t func)
 {
 	unsigned int new;
 
-	new = jump_insn_encode(JAL, (unsigned long)func);
+	new = INSN_JAL((unsigned long)func);
 
 	return ftrace_modify_code(FTRACE_CALL_IP, new);
 }
@@ -155,7 +158,7 @@ int ftrace_enable_ftrace_graph_caller(void)
 
 int ftrace_disable_ftrace_graph_caller(void)
 {
-	return ftrace_modify_code(FTRACE_GRAPH_CALL_IP, ftrace_nop);
+	return ftrace_modify_code(FTRACE_GRAPH_CALL_IP, INSN_NOP);
 }
 
 #endif				/* !CONFIG_DYNAMIC_FTRACE */
-- 
1.7.0.4
