Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 20 Nov 2009 13:38:56 +0100 (CET)
Received: from mail-pz0-f197.google.com ([209.85.222.197]:34367 "EHLO
	mail-pz0-f197.google.com" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S1494124AbZKTMgT (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Fri, 20 Nov 2009 13:36:19 +0100
Received: by pzk35 with SMTP id 35so2380953pzk.22
        for <multiple recipients>; Fri, 20 Nov 2009 04:36:12 -0800 (PST)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:in-reply-to:references;
        bh=8BhmlBez2LRRTph6bOZb2GsazkYyYEOi0ZpAcMaYYyU=;
        b=jN2RB97CEZ7ateCeXlT+Cpe52Oh2F0axPX64HHDpPekLxpEIflGEX9usEvbDqZN/F8
         hgUGRKPgLuJHTZNC4gsOfg36ftl+TN/1tsuR0mjmYQoBBVnvXPf6AoDJUaXgDpuXQXmw
         J/rqc/tbVMILFbsxgW4Y+FFJg0iFgLpVrD220=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=tulEfl/8e1RI7pJpXmkzJgTWElrwiD9/I//Me7fcdqMr70ROXu5oMrrGrgsDd7wXik
         Fpp84pulHxm22Rpp3vsv9cTHjZi8Y432L+y7r2B/TNo5GSfzDsbXcgoFJ709euj+Y7oQ
         U44dn7GJV4mt/EvcJkjIpyUv2u00MEIadjw9k=
Received: by 10.114.2.19 with SMTP id 19mr1978664wab.26.1258720572391;
        Fri, 20 Nov 2009 04:36:12 -0800 (PST)
Received: from localhost.localdomain ([222.92.8.142])
        by mx.google.com with ESMTPS id 22sm931632pzk.2.2009.11.20.04.36.04
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 20 Nov 2009 04:36:11 -0800 (PST)
From:	Wu Zhangjin <wuzhangjin@gmail.com>
To:	Ralf Baechle <ralf@linux-mips.org>, rostedt@goodmis.org
Cc:	Nicholas Mc Guire <der.herr@hofr.at>, zhangfx@lemote.com,
	Wu Zhangjin <wuzhangjin@gmail.com>,
	Ingo Molnar <mingo@elte.hu>,
	Thomas Gleixner <tglx@linutronix.de>,
	Frederic Weisbecker <fweisbec@gmail.com>,
	linux-kernel@vger.kernel.org, linux-mips@linux-mips.org
Subject: [PATCH v9 10/10] tracing: make function graph tracer work with -mmcount-ra-address
Date:	Fri, 20 Nov 2009 20:34:38 +0800
Message-Id: <7f3448d0d795a7f60dc9731e95123ae9e0f4d56a.1258719323.git.wuzhangjin@gmail.com>
X-Mailer: git-send-email 1.6.2.1
In-Reply-To: <76ddc2b8164e0e2f239ddd81ef1ef6a241540004.1258719323.git.wuzhangjin@gmail.com>
References: <adf867c5a6864fa196c667d3f09a6a694f3903c5.1258719323.git.wuzhangjin@gmail.com>
 <51e30436a435480f1f0dec146a82f2b250900690.1258719323.git.wuzhangjin@gmail.com>
 <267c0824194b659b46fc038ba43492df30369fec.1258719323.git.wuzhangjin@gmail.com>
 <6a25a6132d64830bbd7339fe8b3841a51d02ac6d.1258719323.git.wuzhangjin@gmail.com>
 <2ffd3ecb5f0c96b43150968ce270dee71f6afdb8.1258719323.git.wuzhangjin@gmail.com>
 <2276758e661b2b2362432851003df1d7c99d6cc0.1258719323.git.wuzhangjin@gmail.com>
 <c08257b0ef370f6e04ff9719bf7499bae28c70f4.1258719323.git.wuzhangjin@gmail.com>
 <16e57c64d806acc5fc3440370aa0ff97a5db7dc3.1258719323.git.wuzhangjin@gmail.com>
 <76ddc2b8164e0e2f239ddd81ef1ef6a241540004.1258719323.git.wuzhangjin@gmail.com>
In-Reply-To: <cover.1258719323.git.wuzhangjin@gmail.com>
References: <cover.1258719323.git.wuzhangjin@gmail.com>
Return-Path: <wuzhangjin@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 25001
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wuzhangjin@gmail.com
Precedence: bulk
X-list: linux-mips

From: Wu Zhangjin <wuzhangjin@gmail.com>

That thread "MIPS: Add option to pass return address location to
_mcount" from "David Daney <ddaney@caviumnetworks.com>" have added a new
option -mmcount-ra-address to gcc(4.5) for MIPS to transfer the location
of the return address to _mcount.

Benefit from this new feature, function graph tracer on MIPS will be
easier and safer to hijack the return address of the kernel function,
which will save some overhead and make the whole thing more reliable.

In this patch, at first, try to enable the option -mmcount-ra-address in
arch/mips/Makefile with cc-option, if gcc support it, it will be
enabled, otherwise, no side effect.

and then, we need to support this new option of gcc 4.5 and also support
the old gcc versions.

with _mcount in the old gcc versions, it's not easy to get the location
of return address(tracing: add function graph tracer support for MIPS),
   so, we do it in a C function: ftrace_get_parent_addr(ftrace.c), but
   with -mmcount-ra-address, only several instructions need to get what
   we want, so, I put into asm(mcount.S). and also, as the $12(t0) is
   used by -mmcount-ra-address for transferring the localtion of return
   address to _mcount, we need to save it into the stack and restore it
   when enabled dynamic function tracer, 'Cause we have called
   "ftrace_call" before "ftrace_graph_caller", which may destroy
   $12(t0).

(Thanks to David for providing that -mcount-ra-address and giving the
 idea of KBUILD_MCOUNT_RA_ADDRESS, both of them have made the whole
 thing more beautiful!)

Signed-off-by: Wu Zhangjin <wuzhangjin@gmail.com>
---
 arch/mips/Makefile        |    7 +++++++
 arch/mips/kernel/ftrace.c |   24 +++++++++++++++++-------
 arch/mips/kernel/mcount.S |   14 ++++++++++++++
 3 files changed, 38 insertions(+), 7 deletions(-)

diff --git a/arch/mips/Makefile b/arch/mips/Makefile
index 0a2073e..50039e8 100644
--- a/arch/mips/Makefile
+++ b/arch/mips/Makefile
@@ -51,6 +51,13 @@ endif
 ifndef CONFIG_FUNCTION_TRACER
 cflags-y := -ffunction-sections
 endif
+ifdef CONFIG_FUNCTION_GRAPH_TRACER
+  ifndef KBUILD_MCOUNT_RA_ADDRESS
+    ifeq ($(call cc-option-yn,-mmcount-ra-address), y)
+      cflags-y += -mmcount-ra-address -DKBUILD_MCOUNT_RA_ADDRESS
+    endif
+  endif
+endif
 cflags-y += $(call cc-option, -mno-check-zero-division)
 
 ifdef CONFIG_32BIT
diff --git a/arch/mips/kernel/ftrace.c b/arch/mips/kernel/ftrace.c
index e363fc6..68b0670 100644
--- a/arch/mips/kernel/ftrace.c
+++ b/arch/mips/kernel/ftrace.c
@@ -148,6 +148,7 @@ int ftrace_disable_ftrace_graph_caller(void)
 
 #endif				/* !CONFIG_DYNAMIC_FTRACE */
 
+#ifndef KBUILD_MCOUNT_RA_ADDRESS
 #define S_RA_SP	(0xafbf << 16)	/* s{d,w} ra, offset(sp) */
 #define S_R_SP	(0xafb0 << 16)  /* s{d,w} R, offset(sp) */
 #define OFFSET_MASK	0xffff	/* stack offset range: 0 ~ PT_SIZE */
@@ -201,6 +202,8 @@ unsigned long ftrace_get_parent_addr(unsigned long self_addr,
 	return 0;
 }
 
+#endif
+
 /*
  * Hook the return address and push it in the stack of return addrs
  * in current thread info.
@@ -218,19 +221,26 @@ void prepare_ftrace_return(unsigned long *parent, unsigned long self_addr,
 		return;
 
 	/* "parent" is the stack address saved the return address of the caller
-	 * of _mcount, for a leaf function not save the return address in the
-	 * stack address, so, we "emulate" one in _mcount's stack space, and
-	 * hijack it directly, but for a non-leaf function, it will save the
-	 * return address to the its stack space, so, we can not hijack the
-	 * "parent" directly, but need to find the real stack address,
+	 * of _mcount.
+	 *
+	 * if the gcc < 4.5, a leaf function does not save the return address
+	 * in the stack address, so, we "emulate" one in _mcount's stack space,
+	 * and hijack it directly, but for a non-leaf function, it save the
+	 * return address to the its own stack space, we can not hijack it
+	 * directly, but need to find the real stack address,
 	 * ftrace_get_parent_addr() does it!
+	 *
+	 * if gcc>= 4.5, with the new -mmcount-ra-address option, for a
+	 * non-leaf function, the location of the return address will be saved
+	 * to $12 for us, and for a leaf function, only put a zero into $12. we
+	 * do it in ftrace_graph_caller of mcount.S.
 	 */
 
 	/* old = *parent; */
 	safe_load_stack(old, parent, faulted);
 	if (unlikely(faulted))
 		goto out;
-
+#ifndef KBUILD_MCOUNT_RA_ADDRESS
 	parent = (unsigned long *)ftrace_get_parent_addr(self_addr, old,
 							 (unsigned long)parent,
 							 fp);
@@ -238,7 +248,7 @@ void prepare_ftrace_return(unsigned long *parent, unsigned long self_addr,
 	 * ra, stop function graph tracer and return */
 	if (parent == 0)
 		goto out;
-
+#endif
 	/* *parent = return_hooker; */
 	safe_store_stack(return_hooker, parent, faulted);
 	if (unlikely(faulted))
diff --git a/arch/mips/kernel/mcount.S b/arch/mips/kernel/mcount.S
index 522e91c..0a9cfdb 100644
--- a/arch/mips/kernel/mcount.S
+++ b/arch/mips/kernel/mcount.S
@@ -70,6 +70,9 @@ _mcount:
 	 nop
 
 	MCOUNT_SAVE_REGS
+#ifdef KBUILD_MCOUNT_RA_ADDRESS
+	PTR_S	t0, PT_R12(sp)	/* t0 saved the location of the return address(at) by -mmcount-ra-address */
+#endif
 
 	move	a0, ra		/* arg1: next ip, selfaddr */
 	.globl ftrace_call
@@ -133,11 +136,22 @@ ftrace_stub:
 NESTED(ftrace_graph_caller, PT_SIZE, ra)
 #ifdef CONFIG_DYNAMIC_FTRACE
 	PTR_L	a1, PT_R31(sp)	/* load the original ra from the stack */
+#ifdef KBUILD_MCOUNT_RA_ADDRESS
+	PTR_L	t0, PT_R12(sp)	/* load the original t0 from the stack */
+#endif
 #else
 	MCOUNT_SAVE_REGS
 	move	a1, ra		/* arg2: next ip, selfaddr */
 #endif
+
+#ifdef KBUILD_MCOUNT_RA_ADDRESS
+	bnez	t0, 1f		/* non-leaf func: t0 saved the location of the return address */
+	 nop
+	PTR_LA	t0, PT_R1(sp)	/* leaf func: get the location of at(old ra) from our own stack */
+1:	move	a0, t0		/* arg1: the location of the return address */
+#else
 	PTR_LA	a0, PT_R1(sp)	/* arg1: &AT -> a0 */
+#endif
 	jal	prepare_ftrace_return
 #ifdef CONFIG_FRAME_POINTER
 	 move	a2, fp		/* arg3: frame pointer */
-- 
1.6.2.1
