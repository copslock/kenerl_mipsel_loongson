Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 06 Oct 2010 12:44:14 +0200 (CEST)
Received: from mail-pw0-f49.google.com ([209.85.160.49]:53698 "EHLO
        mail-pw0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1490948Ab0JFKoK (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 6 Oct 2010 12:44:10 +0200
Received: by pwi5 with SMTP id 5so3294492pwi.36
        for <multiple recipients>; Wed, 06 Oct 2010 03:44:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=C+jVV0Uaid+jCmugZ9Uey+zMxlUEhXEQDAzkngO2NLM=;
        b=o6EHv20LEjvSIYNU9wdk2ZuUzZkZHtn3j1HGMw3WN01w6wNVsOe1egLFg2hQ14LT8s
         ZMNK/yElKsrshRrnTk+1MEgojbeECo+vR3AtCJt/PB+Qx4RQEwFjrwmTean29bpPI+Pw
         MUc2V+HX+qEhORjJ6ZTus0gZlvexgSEyNjAyo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=C9P2Q0dKpk9M1kakr/Urve7zYpfYK5wrBTvyrBawXGmGTHq3OP5lymslMA3JF1B15l
         JkCRrIC3azNqZ2Tt9lhXkmrAq98LJXyfoLmwpaNrChdAZ2ILNpU8ctSXF+HAT7Qgi/nu
         HjNfytsz+5P6I31+YU8Yhz8ujgEOCKreuDE3E=
Received: by 10.114.66.5 with SMTP id o5mr15166970waa.219.1286361843507;
        Wed, 06 Oct 2010 03:44:03 -0700 (PDT)
Received: from localhost (KD113150081245.ppp-bb.dion.ne.jp [113.150.81.245])
        by mx.google.com with ESMTPS id s5sm1164451wak.0.2010.10.06.03.44.00
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 06 Oct 2010 03:44:02 -0700 (PDT)
From:   Adam Jiang <jiang.adam@gmail.com>
To:     ralf@linux-mips.org
Cc:     linux-mips@linux-mips.org, linux-kernel@vger.kernel.org,
        Adam Jiang <jiang.adam@gmail.com>
Subject: [PATCH v3] mips: irq: add stackoverflow detection
Date:   Wed,  6 Oct 2010 19:41:16 +0900
Message-Id: <1286361676-10743-1-git-send-email-jiang.adam@gmail.com>
X-Mailer: git-send-email 1.7.2.2
Return-Path: <jiang.adam@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 27955
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jiang.adam@gmail.com
Precedence: bulk
X-list: linux-mips

Add stackoverflow detection to mips arch

This is the 3rd version of the smiple patch. 2K is too big for many
system, so I Modified the warning line by following Ralf's suggestion.

Signed-off-by: Adam Jiang <jiang.adam@gmail.com>
---
 arch/mips/Kconfig.debug             |    7 +++++++
 arch/mips/include/asm/thread_info.h |    2 ++
 arch/mips/kernel/irq.c              |   25 +++++++++++++++++++++++++
 3 files changed, 34 insertions(+), 0 deletions(-)

diff --git a/arch/mips/Kconfig.debug b/arch/mips/Kconfig.debug
index 43dc279..30c58d4 100644
--- a/arch/mips/Kconfig.debug
+++ b/arch/mips/Kconfig.debug
@@ -67,6 +67,13 @@ config CMDLINE_OVERRIDE
 
 	  Normally, you will choose 'N' here.
 
+config DEBUG_STACKOVERFLOW
+	bool "Check for stack overflows"
+	depends on DEBUG_KERNEL
+	help
+	  This option will cause messages to be printed if free stack
+	  space drops below a certain limit.
+
 config DEBUG_STACK_USAGE
 	bool "Enable stack utilization instrumentation"
 	depends on DEBUG_KERNEL
diff --git a/arch/mips/include/asm/thread_info.h b/arch/mips/include/asm/thread_info.h
index 70df9c0..b60b28d 100644
--- a/arch/mips/include/asm/thread_info.h
+++ b/arch/mips/include/asm/thread_info.h
@@ -83,6 +83,8 @@ register struct thread_info *__current_thread_info __asm__("$28");
 #define THREAD_SIZE (PAGE_SIZE << THREAD_SIZE_ORDER)
 #define THREAD_MASK (THREAD_SIZE - 1UL)
 
+#define STACK_WARN  (THREAD_SIZE/8)
+
 #define __HAVE_ARCH_THREAD_INFO_ALLOCATOR
 
 #ifdef CONFIG_DEBUG_STACK_USAGE
diff --git a/arch/mips/kernel/irq.c b/arch/mips/kernel/irq.c
index c6345f5..b43edb7 100644
--- a/arch/mips/kernel/irq.c
+++ b/arch/mips/kernel/irq.c
@@ -151,6 +151,28 @@ void __init init_IRQ(void)
 #endif
 }
 
+#ifdef CONFIG_DEBUG_STACKOVERFLOW
+static inline void check_stack_overflow(void)
+{
+	unsigned long sp;
+
+	asm volatile("move %0, $sp" : "=r" (sp));
+	sp = sp & THREAD_MASK;
+
+	/*
+	 * check for stack overflow: is there less than STACK_WARN free?
+	 * STACK_WARN is defined as 1/8 of THREAD_SIZE by default.
+	 */
+	if (unlikely(sp < (sizeof(struct thread_info) + STACK_WARN))) {
+		printk("do_IRQ: stack overflow: %ld\n",
+		       sp - sizeof(struct thread_info));
+		dump_stack();
+	}
+}
+#else
+static inline void check_stack_overflow(void) {}
+#endif
+
 /*
  * do_IRQ handles all normal device IRQ's (the special
  * SMP cross-CPU interrupts have their own specific
@@ -159,6 +181,9 @@ void __init init_IRQ(void)
 void __irq_entry do_IRQ(unsigned int irq)
 {
 	irq_enter();
+
+	check_stack_overflow();
+
 	__DO_IRQ_SMTC_HOOK(irq);
 	generic_handle_irq(irq);
 	irq_exit();
-- 
1.7.2.2
