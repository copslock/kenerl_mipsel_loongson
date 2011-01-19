Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 19 Jan 2011 20:31:44 +0100 (CET)
Received: from mail-px0-f177.google.com ([209.85.212.177]:52059 "EHLO
        mail-px0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491156Ab1AST3H (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 19 Jan 2011 20:29:07 +0100
Received: by mail-px0-f177.google.com with SMTP id 7so231768pxi.36
        for <multiple recipients>; Wed, 19 Jan 2011 11:29:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :in-reply-to:references:in-reply-to:references;
        bh=9PXrUxBEefBaa6CWd5TKX4L7HYPGO/xVgynAynDOjy4=;
        b=dCP9wOy9Sv4DHZM13tyKjnEDrR6KM49kMAlu1hbX7oi6yE6uz/kTPBczlDp8NQiG/1
         VyOLKImgmZTQWombX4jmlPMB27ECaa95HnPbEQCgD6lVGzmjCec5UyvmvitJXUXbr+PQ
         TKMbGVwwksejLXuNpVGtmfj4+TLH9vqRsJ+0k=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=AyVHOPTjUBnCjiOr6fF+vX0BED3EPj6qpQ2rZh/xLIunq/vnMRPs0cYZnADb3Urpob
         rXsoCTTV41muzHqRcahXHDH7ACootQSFrOwBuyHVx3ou3w+0qtKqZxbLeaLljwfwcVHO
         XI8y8mk++rdt/UnwIzKO27UDoAP09fQFx/UJY=
Received: by 10.142.203.12 with SMTP id a12mr1123130wfg.122.1295465346604;
        Wed, 19 Jan 2011 11:29:06 -0800 (PST)
Received: from localhost.localdomain ([221.220.250.179])
        by mx.google.com with ESMTPS id v19sm9985333wfh.12.2011.01.19.11.29.03
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 19 Jan 2011 11:29:05 -0800 (PST)
From:   Wu Zhangjin <wuzhangjin@gmail.com>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     Wu Zhangjin <wuzhangjin@gmail.com>,
        Steven Rostedt <srostedt@redhat.com>, linux-mips@linux-mips.org
Subject: [PATCH 4/5] tracing, MIPS: Clean up ftrace_make_nop()
Date:   Thu, 20 Jan 2011 03:28:31 +0800
Message-Id: <1294349774393cf262bbad304207db40333d807d.1295464855.git.wuzhangjin@gmail.com>
X-Mailer: git-send-email 1.7.1
In-Reply-To: <cover.1295464855.git.wuzhangjin@gmail.com>
References: <cover.1295464855.git.wuzhangjin@gmail.com>
In-Reply-To: <cover.1295464855.git.wuzhangjin@gmail.com>
References: <cover.1295464855.git.wuzhangjin@gmail.com>
Return-Path: <wuzhangjin@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 28980
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wuzhangjin@gmail.com
Precedence: bulk
X-list: linux-mips

This moves the comments out of ftrace_make_nop() and make it cleaner.
At the same time, a macro MCOUNT_OFFSET_INSNS is defined for sharing
with the next patch.

Signed-off-by: Wu Zhangjin <wuzhangjin@gmail.com>
---
 arch/mips/kernel/ftrace.c |   70 ++++++++++++++++++++++++--------------------
 1 files changed, 38 insertions(+), 32 deletions(-)

diff --git a/arch/mips/kernel/ftrace.c b/arch/mips/kernel/ftrace.c
index 40ef34c..bc91e4a 100644
--- a/arch/mips/kernel/ftrace.c
+++ b/arch/mips/kernel/ftrace.c
@@ -24,8 +24,6 @@
 #define JAL 0x0c000000		/* jump & link: ip --> ra, jump to target */
 #define ADDR_MASK 0x03ffffff	/*  op_code|addr : 31...26|25 ....0 */
 
-#define INSN_B_1F_4 0x10000004	/* b 1f; offset = 4 */
-#define INSN_B_1F_5 0x10000005	/* b 1f; offset = 5 */
 #define INSN_NOP 0x00000000	/* nop */
 #define INSN_JAL(addr)	\
 	((unsigned int)(JAL | (((addr) >> 2) & ADDR_MASK)))
@@ -84,6 +82,42 @@ static int ftrace_modify_code(unsigned long ip, unsigned int new_code)
 	return 0;
 }
 
+/*
+ * The details about the calling site of mcount on MIPS
+ *
+ * 1. For kernel:
+ *
+ * move at, ra
+ * jal _mcount		--> nop
+ *
+ * 2. For modules:
+ *
+ * 2.1 For KBUILD_MCOUNT_RA_ADDRESS and CONFIG_32BIT
+ *
+ * lui v1, hi_16bit_of_mcount        --> b 1f (0x10000005)
+ * addiu v1, v1, low_16bit_of_mcount
+ * move at, ra
+ * move $12, ra_address
+ * jalr v1
+ *  sub sp, sp, 8
+ *                                  1: offset = 5 instructions
+ * 2.2 For the Other situations
+ *
+ * lui v1, hi_16bit_of_mcount        --> b 1f (0x10000004)
+ * addiu v1, v1, low_16bit_of_mcount
+ * move at, ra
+ * jalr v1
+ *  nop | move $12, ra_address | sub sp, sp, 8
+ *                                  1: offset = 4 instructions
+ */
+
+#if defined(KBUILD_MCOUNT_RA_ADDRESS) && defined(CONFIG_32BIT)
+#define MCOUNT_OFFSET_INSNS 5
+#else
+#define MCOUNT_OFFSET_INSNS 4
+#endif
+#define INSN_B_1F (0x10000000 | MCOUNT_OFFSET_INSNS)
+
 int ftrace_make_nop(struct module *mod,
 		    struct dyn_ftrace *rec, unsigned long addr)
 {
@@ -94,36 +128,8 @@ int ftrace_make_nop(struct module *mod,
 	 * If ip is in kernel space, no long call, otherwise, long call is
 	 * needed.
 	 */
-	if (in_kernel_space(ip)) {
-		/*
-		 * move at, ra
-		 * jal _mcount		--> nop
-		 */
-		new = INSN_NOP;
-	} else {
-#if defined(KBUILD_MCOUNT_RA_ADDRESS) && defined(CONFIG_32BIT)
-		/*
-		 * lui v1, hi_16bit_of_mcount        --> b 1f (0x10000005)
-		 * addiu v1, v1, low_16bit_of_mcount
-		 * move at, ra
-		 * move $12, ra_address
-		 * jalr v1
-		 *  sub sp, sp, 8
-		 *                                  1: offset = 5 instructions
-		 */
-		new = INSN_B_1F_5;
-#else
-		/*
-		 * lui v1, hi_16bit_of_mcount        --> b 1f (0x10000004)
-		 * addiu v1, v1, low_16bit_of_mcount
-		 * move at, ra
-		 * jalr v1
-		 *  nop | move $12, ra_address | sub sp, sp, 8
-		 *                                  1: offset = 4 instructions
-		 */
-		new = INSN_B_1F_4;
-#endif
-	}
+	new = in_kernel_space(ip) ? INSN_NOP : INSN_B_1F;
+
 	return ftrace_modify_code(ip, new);
 }
 
-- 
1.7.1
