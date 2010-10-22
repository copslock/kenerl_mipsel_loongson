Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 22 Oct 2010 22:59:20 +0200 (CEST)
Received: from mail-pv0-f177.google.com ([74.125.83.177]:47067 "EHLO
        mail-pv0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491178Ab0JVU60 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 22 Oct 2010 22:58:26 +0200
Received: by pvg7 with SMTP id 7so388484pvg.36
        for <multiple recipients>; Fri, 22 Oct 2010 13:58:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:in-reply-to:references;
        bh=J9N0rpKNFv8OZj83XLbS0KYuGVW+Wr0QHSlq5r1fMzo=;
        b=Wvfvb5SZZgrzQNd0GmjfBmcv1PLryEboyfrrWzFiJs4+TtVvCeUbNUrWEJLfiCr3F5
         hyGXdrx3EBHNJDmwxSiPjko8LC9vwmfQVuapD7CWRjx45UG6DnfXScQXBjZ3lrag2l5N
         p94GWzB8uWvpF26Km9pdXsFvHPUUGRRiV/dyk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=OjWs9NFguCxkb0m5UGTH+xExidfBxVIWNJfKro9aHSAaMFfnliyo+u4uKoFqQSdTd2
         IZBV/rYgBUaejB6nhRcuftG6vxBarcJrs6snyUDcA4ndExMW6DDEux8n/lYSu0RDZooC
         UT7Q3hS7PnkHjZ7FM9DXCLySH9Qi5I14tiO70=
Received: by 10.142.188.11 with SMTP id l11mr2702634wff.246.1287781100078;
        Fri, 22 Oct 2010 13:58:20 -0700 (PDT)
Received: from localhost.localdomain ([61.48.68.246])
        by mx.google.com with ESMTPS id v19sm5109741wfh.12.2010.10.22.13.58.16
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 22 Oct 2010 13:58:19 -0700 (PDT)
From:   Wu Zhangjin <wuzhangjin@gmail.com>
To:     linux-mips@linux-mips.org, ralf@linux-mips.org
Cc:     David Daney <ddaney@caviumnetworks.com>, rostedt@goodmis.org,
        Wu Zhangjin <wuzhangjin@gmail.com>
Subject: [RFC 1/2] MIPS: tracing/ftrace: Replace in_module() with a generic in_kernel_space()
Date:   Sat, 23 Oct 2010 04:58:02 +0800
Message-Id: <ed5f624f16b4b8ff1ee9fa688b3a5b715a0b913d.1287779153.git.wuzhangjin@gmail.com>
X-Mailer: git-send-email 1.7.1
In-Reply-To: <cover.1287779153.git.wuzhangjin@gmail.com>
References: <cover.1287779153.git.wuzhangjin@gmail.com>
In-Reply-To: <cover.1287779153.git.wuzhangjin@gmail.com>
References: <cover.1287779153.git.wuzhangjin@gmail.com>
Return-Path: <wuzhangjin@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 28206
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wuzhangjin@gmail.com
Precedence: bulk
X-list: linux-mips

From: Wu Zhangjin <wuzhangjin@gmail.com>

The module space may be the same as the kernel space sometimes(with
related kernel config and gcc options), but the current in_module()
assume they are always different, so, it should be fixed.

As we know, for the limitation of the fixed 32bit long instruction of
MIPS, the "jal target" can only jump to an address whose offset from the
jal instruction is smaller than 2^28=256M, which means if the address is
in kernel space(the kernel image should be always smaller than 256M), no
long call is needed to jump from the address to _mcount, and further, if
the module use the same space as kernel space, the situation for module
will be the same as the kernel. but currently for MIPS, in most of the
situations, module has different space(0xc0000000) from the kernel
space(0x80000000) and the offset is bigger than 256M, a register is
needed to load the address of _mcount and another instruction "jal
<register>" is needed to jump from an address to _mcount.

The above can be explained as:

if (in_kernel_space(addr)) {
	jal _mcount;
} else {
	load the address of _mcount to a register
	jalr <register>
}

As we can see, the above explanation covers all of the situations well
and reflect the reality, so, we decide to add a new in_kernel_space()
instead of the old in_module().

Based on core_kernel_text() from kernel/extable.c, in_kernel_space() is
easily to be added. Because all of the functions in the init sections is
anotated with notrace, so, differ from core_kernel_text(),
in_kernel_space() doesn't care about init section.

With this new in_kernel_space(), the ftrace_make_{nop,call} can be
explained as following.

ftrace_make_call()					ftrace_make_nop()

if (in_kernel_space(addr)) {
	jal _mcount;	(jal ftrace_caller)	  <-->	nop
} else {
	load the address of _mcount to a register <-->	b label
	jalr <register>
	label:
}

Signed-off-by: Wu Zhangjin <wuzhangjin@gmail.com>
---
 arch/mips/kernel/ftrace.c |   66 ++++++++++++++++++++++++--------------------
 1 files changed, 36 insertions(+), 30 deletions(-)

diff --git a/arch/mips/kernel/ftrace.c b/arch/mips/kernel/ftrace.c
index 65f1949..6ff5a54 100644
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
+ * Clone core_kernel_text() from kernel/extable.c, but don't call
+ * init_kernel_text() for Ftrace don't trace functions in init sections.
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
+	 * If ip is in kernel space, long call is not needed, otherwise, it is
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
@@ -132,8 +132,12 @@ int ftrace_make_call(struct dyn_ftrace *rec, unsigned long addr)
 	unsigned int new;
 	unsigned long ip = rec->ip;
 
-	/* ip, module: 0xc0000000, kernel: 0x80000000 */
-	new = in_module(ip) ? insn_lui_v1_hi16_mcount : insn_jal_ftrace_caller;
+	/*
+	 * If ip is in kernel space, long call is not needed, otherwise, it is
+	 * needed.
+	 */
+	new = in_kernel_space(ip) ? insn_jal_ftrace_caller :
+		insn_lui_v1_hi16_mcount;
 
 	return ftrace_modify_code(ip, new);
 }
@@ -200,11 +204,13 @@ unsigned long ftrace_get_parent_addr(unsigned long self_addr,
 	int faulted;
 
 	/*
-	 * For module, move the ip from calling site of mcount after the
-	 * instruction "lui v1, hi_16bit_of_mcount"(offset is 24), but for
-	 * kernel, move after the instruction "move ra, at"(offset is 16)
+	 * If self_addr is in kernel space, long call is not needed, only need
+	 * to move ip after the instruction "move ra, at"(offset is 16),
+	 * otherwise, long call is needed, need to move ip from calling site of
+	 * mcount after the instruction "lui v1, hi_16bit_of_mcount"(offset is
+	 * 24).
 	 */
-	ip = self_addr - (in_module(self_addr) ? 24 : 16);
+	ip = self_addr - (in_kernel_space(self_addr) ? 16 : 24);
 
 	/*
 	 * search the text until finding the non-store instruction or "s{d,w}
-- 
1.7.1
