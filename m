Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 14 May 2010 13:12:48 +0200 (CEST)
Received: from mail-pz0-f194.google.com ([209.85.222.194]:50006 "EHLO
        mail-pz0-f194.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491825Ab0ENLJ5 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 14 May 2010 13:09:57 +0200
Received: by mail-pz0-f194.google.com with SMTP id 32so33004pzk.21
        for <multiple recipients>; Fri, 14 May 2010 04:09:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:in-reply-to:references;
        bh=dz49Sea2d++5expNBUvWgrkJ3UQmz82M7zPlDwBWkbQ=;
        b=HJy7lJBfONyT0w40NRlm81yVL5yCU+eONyNJm4lp1pwViD4sKTLJMvCp6zWYOQfcrM
         MuLkYi9uR0vxg5WQOolkHIgRPfF/DhVZrovLP0Rxa67jVluwpSuB/dmC22bdhPjTEi++
         VEL/NG5WAskVJwspjArCCaBui6w15BDqweSE8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=PHBbt9P+xopFwLIZKIZhcVh2TRR3Bdrv2m/7yS3eajgbWSOSl//jCHaNPBnZTOKTJ7
         E66F6UspbDc/pERZJ0rSIk1pM9szVoN+wp/o7IzMWK2QjRi5r/BX5sjWHp/TylrBZwvw
         px+VFkE0KsV/vEx+ckKGp1GtaHql2tFqqg59g=
Received: by 10.114.187.17 with SMTP id k17mr1054665waf.31.1273835395342;
        Fri, 14 May 2010 04:09:55 -0700 (PDT)
Received: from localhost.localdomain ([202.201.14.140])
        by mx.google.com with ESMTPS id c14sm19145160waa.13.2010.05.14.04.09.52
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 14 May 2010 04:09:54 -0700 (PDT)
From:   Wu Zhangjin <wuzhangjin@gmail.com>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     linux-mips <linux-mips@linux-mips.org>,
        David Daney <david.s.daney@gmail.com>,
        Wu Zhangjin <wuzhangjin@gmail.com>
Subject: [PATCH 9/9] tracing: MIPS: cleanup of the address space checking
Date:   Fri, 14 May 2010 19:08:34 +0800
Message-Id: <59ac6916a6080b4d2293db16701c3923a8e35aa8.1273834562.git.wuzhangjin@gmail.com>
X-Mailer: git-send-email 1.7.0.4
In-Reply-To: <cover.1273834561.git.wuzhangjin@gmail.com>
References: <cover.1273834561.git.wuzhangjin@gmail.com>
In-Reply-To: <cover.1273834561.git.wuzhangjin@gmail.com>
References: <cover.1273834561.git.wuzhangjin@gmail.com>
Return-Path: <wuzhangjin@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 26718
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wuzhangjin@gmail.com
Precedence: bulk
X-list: linux-mips

From: Wu Zhangjin <wuzhangjin@gmail.com>

This patch adds an inline function in_module() to check which space the
instruction pointer in, kernel space or module space.

Note:  This will not work when the kernel space and module space are the
same. If they are the same, we need to modify scripts/recordmcount.pl,
ftrace_make_nop/call() and the other related parts to ensure the
enabling/disabling of the calling site to _mcount is right for both
kernel and module.

Signed-off-by: Wu Zhangjin <wuzhangjin@gmail.com>
---
 arch/mips/kernel/ftrace.c |   22 +++++++++++++++++++---
 1 files changed, 19 insertions(+), 3 deletions(-)

diff --git a/arch/mips/kernel/ftrace.c b/arch/mips/kernel/ftrace.c
index 628e90b..5a84a1f 100644
--- a/arch/mips/kernel/ftrace.c
+++ b/arch/mips/kernel/ftrace.c
@@ -17,6 +17,22 @@
 #include <asm/cacheflush.h>
 #include <asm/uasm.h>
 
+/*
+ * If the Instruction Pointer is in module space (0xc0000000), return true;
+ * otherwise, it is in kernel space (0x80000000), return false.
+ *
+ * FIXME: This will not work when the kernel space and module space are the
+ * same. If they are the same, we need to modify scripts/recordmcount.pl,
+ * ftrace_make_nop/call() and the other related parts to ensure the
+ * enabling/disabling of the calling site to _mcount is right for both kernel
+ * and module.
+ */
+
+static inline int in_module(unsigned long ip)
+{
+	return ip & 0x40000000;
+}
+
 #ifdef CONFIG_DYNAMIC_FTRACE
 
 #define JAL 0x0c000000		/* jump & link: ip --> ra, jump to target */
@@ -78,7 +94,7 @@ int ftrace_make_nop(struct module *mod,
 	 * We have compiled module with -mlong-calls, but compiled the kernel
 	 * without it, we need to cope with them respectively.
 	 */
-	if (ip & 0x40000000) {
+	if (in_module(ip)) {
 #if defined(KBUILD_MCOUNT_RA_ADDRESS) && defined(CONFIG_32BIT)
 		/*
 		 * lui v1, hi_16bit_of_mcount        --> b 1f (0x10000005)
@@ -117,7 +133,7 @@ int ftrace_make_call(struct dyn_ftrace *rec, unsigned long addr)
 	unsigned long ip = rec->ip;
 
 	/* ip, module: 0xc0000000, kernel: 0x80000000 */
-	new = (ip & 0x40000000) ? insn_lui_v1_hi16_mcount : insn_jal_ftrace_caller;
+	new = in_module(ip) ? insn_lui_v1_hi16_mcount : insn_jal_ftrace_caller;
 
 	return ftrace_modify_code(ip, new);
 }
@@ -188,7 +204,7 @@ unsigned long ftrace_get_parent_addr(unsigned long self_addr,
 	 * instruction "lui v1, hi_16bit_of_mcount"(offset is 20), but for
 	 * kernel, move to the instruction "move ra, at"(offset is 12)
 	 */
-	ip = self_addr - ((self_addr & 0x40000000) ? 20 : 12);
+	ip = self_addr - (in_module(self_addr) ? 20 : 12);
 
 	/*
 	 * search the text until finding the non-store instruction or "s{d,w}
-- 
1.7.0.4
