Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 17 Jun 2013 22:36:40 +0200 (CEST)
Received: from mail-pa0-f43.google.com ([209.85.220.43]:39451 "EHLO
        mail-pa0-f43.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6835851Ab3FQUg3D7AVs (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 17 Jun 2013 22:36:29 +0200
Received: by mail-pa0-f43.google.com with SMTP id hz11so3235925pad.2
        for <multiple recipients>; Mon, 17 Jun 2013 13:36:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer;
        bh=DcVywaK/+x59KtQOQOxcI1NDf4bqgw3oD7XuwTLoz8s=;
        b=QumFG9BvH0rjp22VAI5yx1arX6EflvgIOh1ZZSsZJ1aCSrOiw5WMauvl22miuIgPMR
         SfjEkJ+ClxH/iaC1WuYvJfk0huZy05+4Mxdp+gv+q8tK1itRFqq1HVqGE70J88JnSqeg
         RAG1KrNoQfOMUdYXqB0V5LsTVkLX8V0pU5HIt52LaTnRYOp9OL7LxXWLWj+kVE6bbwTd
         8K20mChmxF/cCSzxqac9idWWSTnBdr3uUA/WpY7ygmV6IjPSQWvYjCGs93i6opbB2UXa
         1RXmIzn1NC8C7RpW8gdCEwoH4nq79PX3jwVq7OZiDK8pxkWPjNYV9fP/5nyhwG/iP288
         A7Zw==
X-Received: by 10.68.48.197 with SMTP id o5mr14705525pbn.184.1371501382040;
        Mon, 17 Jun 2013 13:36:22 -0700 (PDT)
Received: from gregory-irv-00.broadcom.com (5520-maca-inet1-outside.broadcom.com. [216.31.211.11])
        by mx.google.com with ESMTPSA id kq2sm1820608pab.19.2013.06.17.13.36.20
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Mon, 17 Jun 2013 13:36:21 -0700 (PDT)
From:   Gregory Fong <gregory.0xf0@gmail.com>
To:     ralf@linux-mips.org
Cc:     linux-mips@linux-mips.org, Gregory Fong <gregory.0xf0@gmail.com>
Subject: [PATCH] MIPS: r4k,octeon,r2300: stack protector: change canary per task
Date:   Mon, 17 Jun 2013 13:36:07 -0700
Message-Id: <1371501367-26108-1-git-send-email-gregory.0xf0@gmail.com>
X-Mailer: git-send-email 1.8.1.2
Return-Path: <gregory.0xf0@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 36959
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: gregory.0xf0@gmail.com
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

For non-SMP, uses the new random canary value that is stored in the
task struct whenever a new task is forked.  Based on ARM version in
df0698be14c6683606d5df2d83e3ae40f85ed0d9 and subject to the same
limitations: the variable GCC expects, __stack_chk_guard, is global,
so this will not work on SMP.

Quoting Nicolas Pitre <nico@fluxnic.net>: "One way to overcome this
GCC limitation would be to locate the __stack_chk_guard variable into
a memory page of its own for each CPU, and then use TLB locking to
have each CPU see its own page at the same virtual address for each of
them."

Signed-off-by: Gregory Fong <gregory.0xf0@gmail.com>
---
 arch/mips/kernel/asm-offsets.c   | 3 +++
 arch/mips/kernel/octeon_switch.S | 7 +++++++
 arch/mips/kernel/r2300_switch.S  | 7 +++++++
 arch/mips/kernel/r4k_switch.S    | 6 ++++++
 4 files changed, 23 insertions(+)

This patch depends on patch "MIPS: initial stack protector support"
(5448 in patchwork)

I only have the hardware to test r4k.  I don't see why it shouldn't
work on r2300 and octeon as well, but it should probably be checked
anyway.  If some kind volunteers could verify r2300 and octeon, it'd
be much appreciated!

diff --git a/arch/mips/kernel/asm-offsets.c b/arch/mips/kernel/asm-offsets.c
index 0845091..0c2e853 100644
--- a/arch/mips/kernel/asm-offsets.c
+++ b/arch/mips/kernel/asm-offsets.c
@@ -82,6 +82,9 @@ void output_task_defines(void)
 	OFFSET(TASK_FLAGS, task_struct, flags);
 	OFFSET(TASK_MM, task_struct, mm);
 	OFFSET(TASK_PID, task_struct, pid);
+#if defined(CONFIG_CC_STACKPROTECTOR)
+	OFFSET(TASK_STACK_CANARY, task_struct, stack_canary);
+#endif
 	DEFINE(TASK_STRUCT_SIZE, sizeof(struct task_struct));
 	BLANK();
 }
diff --git a/arch/mips/kernel/octeon_switch.S b/arch/mips/kernel/octeon_switch.S
index 0e23343..94c29ec 100644
--- a/arch/mips/kernel/octeon_switch.S
+++ b/arch/mips/kernel/octeon_switch.S
@@ -98,6 +98,13 @@
 	mtc0	t0, $11,7	/* CvmMemCtl */
 #endif
 3:
+
+#if defined(CONFIG_CC_STACKPROTECTOR) && !defined(CONFIG_SMP)
+	PTR_L	t8, __stack_chk_guard
+	LONG_L	t9, TASK_STACK_CANARY(a1)
+	LONG_S	t9, 0(t8)
+#endif
+
 	/*
 	 * The order of restoring the registers takes care of the race
 	 * updating $28, $29 and kernelsp without disabling ints.
diff --git a/arch/mips/kernel/r2300_switch.S b/arch/mips/kernel/r2300_switch.S
index 5266c6e..38af83f 100644
--- a/arch/mips/kernel/r2300_switch.S
+++ b/arch/mips/kernel/r2300_switch.S
@@ -65,6 +65,13 @@ LEAF(resume)
 	fpu_save_single a0, t0			# clobbers t0
 
 1:
+
+#if defined(CONFIG_CC_STACKPROTECTOR) && !defined(CONFIG_SMP)
+	PTR_L	t8, __stack_chk_guard
+	LONG_L	t9, TASK_STACK_CANARY(a1)
+	LONG_S	t9, 0(t8)
+#endif
+
 	/*
 	 * The order of restoring the registers takes care of the race
 	 * updating $28, $29 and kernelsp without disabling ints.
diff --git a/arch/mips/kernel/r4k_switch.S b/arch/mips/kernel/r4k_switch.S
index 5e51219..921238a 100644
--- a/arch/mips/kernel/r4k_switch.S
+++ b/arch/mips/kernel/r4k_switch.S
@@ -68,6 +68,12 @@
 						# clobbers t1
 1:
 
+#if defined(CONFIG_CC_STACKPROTECTOR) && !defined(CONFIG_SMP)
+	PTR_L	t8, __stack_chk_guard
+	LONG_L	t9, TASK_STACK_CANARY(a1)
+	LONG_S	t9, 0(t8)
+#endif
+
 	/*
 	 * The order of restoring the registers takes care of the race
 	 * updating $28, $29 and kernelsp without disabling ints.
-- 
1.8.1.2
