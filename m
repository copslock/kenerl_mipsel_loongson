Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 19 Jan 2011 20:29:25 +0100 (CET)
Received: from mail-px0-f177.google.com ([209.85.212.177]:52059 "EHLO
        mail-px0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491144Ab1AST24 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 19 Jan 2011 20:28:56 +0100
Received: by mail-px0-f177.google.com with SMTP id 7so231768pxi.36
        for <multiple recipients>; Wed, 19 Jan 2011 11:28:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :in-reply-to:references:in-reply-to:references;
        bh=fcHfNZPVR7wg0uMgEpREkDA8nHy2/iemzp8wJ4DCVyg=;
        b=gywPayuf1ByDELoUBR4JYrkRuGC/tpe70rzwKS6xew8gvoxAWnHe2cTakhBgfkieHy
         GW0KyXLKtqOt3GdR2egMoCqiX+ipw+qcMM/RgYYJOHLSqj/rOSJ74F8LRt+zVV9V6HzW
         IkSaA2l1N6cUwOYrY0sfqc7LWm2F8o5Cwngok=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=ZAMoeIijTATctysNDr5YJWHna1r0HeTtqHQbYSkhtZZ8LDRYN9JpNpV0vL90mrClx4
         POOnaJ6xW2yJpUiTKB7p4o0vE6rgF1DwGDWDp/XyzdfalXTrKs00o85u4cx3h777wewA
         r3Wrsk413xfkdvsjfscH9LKa7RIn2IqZkepio=
Received: by 10.142.171.14 with SMTP id t14mr1109153wfe.198.1295465334962;
        Wed, 19 Jan 2011 11:28:54 -0800 (PST)
Received: from localhost.localdomain ([221.220.250.179])
        by mx.google.com with ESMTPS id v19sm9985333wfh.12.2011.01.19.11.28.51
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 19 Jan 2011 11:28:53 -0800 (PST)
From:   Wu Zhangjin <wuzhangjin@gmail.com>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     Wu Zhangjin <wuzhangjin@gmail.com>,
        Steven Rostedt <srostedt@redhat.com>, linux-mips@linux-mips.org
Subject: [PATCH 2/5] tracing, MIPS: replace in_module() with a generic in_kernel_space()
Date:   Thu, 20 Jan 2011 03:28:28 +0800
Message-Id: <40f92f8a1acdd1a0afae9a014d38d2cfea5557cf.1295464564.git.wuzhangjin@gmail.com>
X-Mailer: git-send-email 1.7.1
In-Reply-To: <cover.1295464855.git.wuzhangjin@gmail.com>
References: <cover.1295464855.git.wuzhangjin@gmail.com>
In-Reply-To: <cover.1295464564.git.wuzhangjin@gmail.com>
References: <cover.1295464564.git.wuzhangjin@gmail.com>
Return-Path: <wuzhangjin@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 28975
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wuzhangjin@gmail.com
Precedence: bulk
X-list: linux-mips

The old in_module() may not work in some situations(e.g. when module &
kernel are in the same address space when CONFIG_MAPPED_KERNEL=y), The
in_kernel_space() is more generic and it is also easy to be implemented
via cloning the existing core_kernel_text(), so, replace the in_module()
with in_kernel_space().

Signed-off-by: Wu Zhangjin <wuzhangjin@gmail.com>
---
 arch/mips/kernel/ftrace.c |   54 ++++++++++++++++++++++----------------------
 1 files changed, 27 insertions(+), 27 deletions(-)

diff --git a/arch/mips/kernel/ftrace.c b/arch/mips/kernel/ftrace.c
index 635c1dc..5970286 100644
--- a/arch/mips/kernel/ftrace.c
+++ b/arch/mips/kernel/ftrace.c
@@ -17,21 +17,7 @@
 #include <asm/cacheflush.h>
 #include <asm/uasm.h>
 
-/*
- * If the Instruction Pointer is in module space (0xc0000000), return true;
- * otherwise, it is in kernel space (0x80000000), return false.
- *
- * FIXME: This will not work when the kernel space and module space are the
- * same. If they are the same, we need to modify scripts/recordmcount.pl,
- * ftrace_make_nop/call() and the other related parts to ensure the
- * enabling/disabling of the calling site to _mcount is right for both kernel
- * and module.
- */
-
-static inline int in_module(unsigned long ip)
-{
-	return ip & 0x40000000;
-}
+#include <asm-generic/sections.h>
 
 #ifdef CONFIG_DYNAMIC_FTRACE
 
@@ -69,6 +55,20 @@ static inline void ftrace_dyn_arch_init_insns(void)
 #endif
 }
 
+/*
+ * Check if the address is in kernel space
+ *
+ * Clone core_kernel_text() from kernel/extable.c, but doesn't call
+ * init_kernel_text() for Ftrace doesn't trace functions in init sections.
+ */
+static inline int in_kernel_space(unsigned long ip)
+{
+	if (ip >= (unsigned long)_stext &&
+	    ip <= (unsigned long)_etext)
+		return 1;
+	return 0;
+}
+
 static int ftrace_modify_code(unsigned long ip, unsigned int new_code)
 {
 	int faulted;
@@ -91,10 +91,16 @@ int ftrace_make_nop(struct module *mod,
 	unsigned long ip = rec->ip;
 
 	/*
-	 * We have compiled module with -mlong-calls, but compiled the kernel
-	 * without it, we need to cope with them respectively.
+	 * If ip is in kernel space, no long call, otherwise, long call is
+	 * needed.
 	 */
-	if (in_module(ip)) {
+	if (in_kernel_space(ip)) {
+		/*
+		 * move at, ra
+		 * jal _mcount		--> nop
+		 */
+		new = INSN_NOP;
+	} else {
 #if defined(KBUILD_MCOUNT_RA_ADDRESS) && defined(CONFIG_32BIT)
 		/*
 		 * lui v1, hi_16bit_of_mcount        --> b 1f (0x10000005)
@@ -117,12 +123,6 @@ int ftrace_make_nop(struct module *mod,
 		 */
 		new = INSN_B_1F_4;
 #endif
-	} else {
-		/*
-		 * move at, ra
-		 * jal _mcount		--> nop
-		 */
-		new = INSN_NOP;
 	}
 	return ftrace_modify_code(ip, new);
 }
@@ -132,8 +132,8 @@ int ftrace_make_call(struct dyn_ftrace *rec, unsigned long addr)
 	unsigned int new;
 	unsigned long ip = rec->ip;
 
-	/* ip, module: 0xc0000000, kernel: 0x80000000 */
-	new = in_module(ip) ? insn_lui_v1_hi16_mcount : insn_jal_ftrace_caller;
+	new = in_kernel_space(ip) ? insn_jal_ftrace_caller :
+		insn_lui_v1_hi16_mcount;
 
 	return ftrace_modify_code(ip, new);
 }
@@ -204,7 +204,7 @@ unsigned long ftrace_get_parent_addr(unsigned long self_addr,
 	 * instruction "lui v1, hi_16bit_of_mcount"(offset is 24), but for
 	 * kernel, move after the instruction "move ra, at"(offset is 16)
 	 */
-	ip = self_addr - (in_module(self_addr) ? 24 : 16);
+	ip = self_addr - (in_kernel_space(self_addr) ? 16 : 24);
 
 	/*
 	 * search the text until finding the non-store instruction or "s{d,w}
-- 
1.7.1
