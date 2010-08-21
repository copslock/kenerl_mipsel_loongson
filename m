Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 21 Aug 2010 08:29:10 +0200 (CEST)
Received: from mail-pw0-f49.google.com ([209.85.160.49]:64859 "EHLO
        mail-pw0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1490946Ab0HUG3F (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 21 Aug 2010 08:29:05 +0200
Received: by pwj3 with SMTP id 3so1149277pwj.36
        for <multiple recipients>; Fri, 20 Aug 2010 23:28:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=PYAW4zxyOvQTT2W3t9+71gEfqF/1Zd0Oxzm5MA68VME=;
        b=IxCQvfMMQbvjg15/hkJfLI84rE/bR/VCNhqLfl6ND0O5ZzZPZwe0s3ODF96xJhfO7N
         gyzJkivu11tFkB2lxreUqs7XSCDl4avAeEfCJPZvslcMpVfg7Sk+4l7kHwGOsVM4nMmP
         4Aw48myMA5er8/S5w3TM5TyuOAr4f+r5I014w=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=ODIToE9HmHs/EYhG3LpLgMkOSg8KBRR+ciGZMY289SjiqOvu3KI8jF/owxMTzf3di7
         JxEZyGHBmuc4OORJKFn9BtRJTGgkm0OKmIGt+YF34WOjDSyIefJjQM30nWHrPv7aH+46
         c8lTvxgiYqgcfgbO6Ble1f2PEVTb8WWd7jsxU=
Received: by 10.142.81.19 with SMTP id e19mr1837385wfb.203.1282372139141;
        Fri, 20 Aug 2010 23:28:59 -0700 (PDT)
Received: from localhost (KD118154228076.ppp-bb.dion.ne.jp [118.154.228.76])
        by mx.google.com with ESMTPS id 23sm4365966wfa.10.2010.08.20.23.28.55
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 20 Aug 2010 23:28:57 -0700 (PDT)
From:   jiang.adam@gmail.com
To:     ralf@linux-mips.org
Cc:     dmitri.vorobiev@movial.com, wuzhangjin@gmail.com,
        ddaney@caviumnetworks.com, peterz@infradead.org,
        fweisbec@gmail.com, tj@kernel.org, tglx@linutronix.de,
        mingo@elte.hu, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org, Adam Jiang <jiang.adam@gmail.com>
Subject: [PATCH] mips: irq: add statckoverflow detection
Date:   Sat, 21 Aug 2010 15:31:33 +0900
Message-Id: <1282372293-30211-1-git-send-email-jiang.adam@gmail.com>
X-Mailer: git-send-email 1.7.1
Return-Path: <jiang.adam@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 27656
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jiang.adam@gmail.com
Precedence: bulk
X-list: linux-mips

From: Adam Jiang <jiang.adam@gmail.com>

Add stackoverflow detection to mips arch

Signed-off-by: Adam Jiang <jiang.adam@gmail.com>
---
 arch/mips/Kconfig.debug |    7 +++++++
 arch/mips/kernel/irq.c  |   19 +++++++++++++++++++
 2 files changed, 26 insertions(+), 0 deletions(-)

diff --git a/arch/mips/Kconfig.debug b/arch/mips/Kconfig.debug
index 43dc279..f1a00a2 100644
--- a/arch/mips/Kconfig.debug
+++ b/arch/mips/Kconfig.debug
@@ -67,6 +67,13 @@ config CMDLINE_OVERRIDE
 
 	  Normally, you will choose 'N' here.
 
+config DEBUG_STACKOVERFLOW
+	bool "Check for stack overflows"
+	depends on DEBUG_KERNEL
+	help
+	  This option will cause messages to be printed if free stack space
+	  drops below a certain limit.
+
 config DEBUG_STACK_USAGE
 	bool "Enable stack utilization instrumentation"
 	depends on DEBUG_KERNEL
diff --git a/arch/mips/kernel/irq.c b/arch/mips/kernel/irq.c
index c6345f5..6334037 100644
--- a/arch/mips/kernel/irq.c
+++ b/arch/mips/kernel/irq.c
@@ -151,6 +151,22 @@ void __init init_IRQ(void)
 #endif
 }
 
+static inline void check_stack_overflow(void)
+{
+#ifdef CONFIG_DEBUG_STACKOVERFLOW
+	long sp;
+
+	asm volatile("move %0, $sp" : "=r" (sp));
+	sp = sp & (THREAD_SIZE-1);
+
+	/* check for stack overflow: is there less then 2KB free? */
+	if (unlikely(sp < (sizeof(struct thread_info) + 2048))) {
+		printk("do_IRQ: stack overflow: %ld\n",
+		       sp - sizeof(struct thread_info));
+		dump_stack();
+	}
+#endif
+}
 /*
  * do_IRQ handles all normal device IRQ's (the special
  * SMP cross-CPU interrupts have their own specific
@@ -159,6 +175,9 @@ void __init init_IRQ(void)
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
1.7.1
