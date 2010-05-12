Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 12 May 2010 15:27:43 +0200 (CEST)
Received: from mail-px0-f177.google.com ([209.85.212.177]:34407 "EHLO
        mail-px0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1492003Ab0ELNYm (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 12 May 2010 15:24:42 +0200
Received: by mail-px0-f177.google.com with SMTP id 1so2779303pxi.36
        for <multiple recipients>; Wed, 12 May 2010 06:24:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:in-reply-to:references;
        bh=I8JRmkr+fV68WxqFuR83ENCOl9Xj+vJTPPakt5z9O7Y=;
        b=uVFXDYOmp30jJlEw6YC2QWejWyVPtMN8+aAPbwaPQ8owfW2NPHbgf+XFIPOdPVlJam
         u/kmAYJ6ivQE0+tg8wOuo9dxAFpqyKfj5SXI0IdiYwefJi9VTYlPCOPaHpdSsnvdQzYi
         YJ8KkQ/8Rh2xrd9DRg7WxN4/HeLUg1uV5F+zs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=obY4ChJqwaD4FkSMVEuyjtcD6832urMyDE4qyP8i8zm9yroodAKhqB4NHQzHmiWeb5
         5bdfo/XlhtV7aGvIx4BjTak2aH81R36wz9P0tafJhtnjpTwksqZJFQ1qcoV3Ae/xQPQI
         eD+xnq2Tgxq336b4AIfSY8a+MJvxcf2Imf0Fc=
Received: by 10.115.87.32 with SMTP id p32mr5850985wal.86.1273670681351;
        Wed, 12 May 2010 06:24:41 -0700 (PDT)
Received: from localhost.localdomain ([202.201.14.140])
        by mx.google.com with ESMTPS id b6sm1273475wam.21.2010.05.12.06.24.39
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 12 May 2010 06:24:40 -0700 (PDT)
From:   Wu Zhangjin <wuzhangjin@gmail.com>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     linux-mips <linux-mips@linux-mips.org>,
        Wu Zhangjin <wuzhangjin@gmail.com>
Subject: [PATCH 9/9] tracing: MIPS: cleanup of the address space checking
Date:   Wed, 12 May 2010 21:23:17 +0800
Message-Id: <86404e31ca5c4c33b785bad7f6223ac775f4f879.1273669419.git.wuzhangjin@gmail.com>
X-Mailer: git-send-email 1.7.0.4
In-Reply-To: <cover.1273669419.git.wuzhangjin@gmail.com>
References: <cover.1273669419.git.wuzhangjin@gmail.com>
In-Reply-To: <cover.1273669419.git.wuzhangjin@gmail.com>
References: <cover.1273669419.git.wuzhangjin@gmail.com>
Return-Path: <wuzhangjin@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 26690
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wuzhangjin@gmail.com
Precedence: bulk
X-list: linux-mips

From: Wu Zhangjin <wuzhangjin@gmail.com>

This patch adds an inline function in_module() to check which space the
instruction pointer in, kernel space or module space.

Note: This may not work when the kernel is compiled with -msym32.

Signed-off-by: Wu Zhangjin <wuzhangjin@gmail.com>
---
 arch/mips/kernel/ftrace.c |   17 ++++++++++++++---
 1 files changed, 14 insertions(+), 3 deletions(-)

diff --git a/arch/mips/kernel/ftrace.c b/arch/mips/kernel/ftrace.c
index 628e90b..37f15b6 100644
--- a/arch/mips/kernel/ftrace.c
+++ b/arch/mips/kernel/ftrace.c
@@ -17,6 +17,17 @@
 #include <asm/cacheflush.h>
 #include <asm/uasm.h>
 
+/*
+ * If the Instruction Pointer is in module space (0xc0000000), return true;
+ * otherwise, it is in kernel space (0x80000000), return false.
+ *
+ * FIXME: This may not work when the kernel is compiled with -msym32.
+ */
+static inline int in_module(unsigned long ip)
+{
+	return ip & 0x40000000;
+}
+
 #ifdef CONFIG_DYNAMIC_FTRACE
 
 #define JAL 0x0c000000		/* jump & link: ip --> ra, jump to target */
@@ -78,7 +89,7 @@ int ftrace_make_nop(struct module *mod,
 	 * We have compiled module with -mlong-calls, but compiled the kernel
 	 * without it, we need to cope with them respectively.
 	 */
-	if (ip & 0x40000000) {
+	if (in_module(ip)) {
 #if defined(KBUILD_MCOUNT_RA_ADDRESS) && defined(CONFIG_32BIT)
 		/*
 		 * lui v1, hi_16bit_of_mcount        --> b 1f (0x10000005)
@@ -117,7 +128,7 @@ int ftrace_make_call(struct dyn_ftrace *rec, unsigned long addr)
 	unsigned long ip = rec->ip;
 
 	/* ip, module: 0xc0000000, kernel: 0x80000000 */
-	new = (ip & 0x40000000) ? insn_lui_v1_hi16_mcount : insn_jal_ftrace_caller;
+	new = in_module(ip) ? insn_lui_v1_hi16_mcount : insn_jal_ftrace_caller;
 
 	return ftrace_modify_code(ip, new);
 }
@@ -188,7 +199,7 @@ unsigned long ftrace_get_parent_addr(unsigned long self_addr,
 	 * instruction "lui v1, hi_16bit_of_mcount"(offset is 20), but for
 	 * kernel, move to the instruction "move ra, at"(offset is 12)
 	 */
-	ip = self_addr - ((self_addr & 0x40000000) ? 20 : 12);
+	ip = self_addr - (in_module(self_addr) ? 20 : 12);
 
 	/*
 	 * search the text until finding the non-store instruction or "s{d,w}
-- 
1.7.0.4
