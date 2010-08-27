Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 27 Aug 2010 11:32:54 +0200 (CEST)
Received: from mail-px0-f177.google.com ([209.85.212.177]:40358 "EHLO
        mail-px0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491809Ab0H0Jcu (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 27 Aug 2010 11:32:50 +0200
Received: by pxi4 with SMTP id 4so1165436pxi.36
        for <multiple recipients>; Fri, 27 Aug 2010 02:32:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=qsGEjnBSKpml4UIv7ZnA/VEb7qF+OdgxZ6Z8GG+IY3M=;
        b=Ne+YPG9h5ZRxXct/WdonqBUyza8yDyrj9cx+il+R8WpeI9uVKieRAXAvnQoROhAQT3
         omCinuhS/LLbjkuv2Yj2SRgZ9bsz21uK1lrIkjjBBGb42w2M9l7EMT1Mgg4TS8ABgLws
         iyB8MQ4KVzQqg4UR/VNoVrHn+WP+ydoe6VsKo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=eUx3hpTjZVXrkokisCnvN3WQR8GVX3j6aGR+YaTPaRBRfbiFniPHSRbqoI5j/6I4th
         tA5yFHsPSh4Qke8Vm6t6PxjRf3TB7vHW3uTjLksuBVpxgRWX/9Binzpg70XKnHIbDlKG
         gDHJQn3/Bltme448IxfA+oVjCFaAZO+UkkHZA=
Received: by 10.142.212.6 with SMTP id k6mr1057036wfg.94.1282901564112;
        Fri, 27 Aug 2010 02:32:44 -0700 (PDT)
Received: from localhost (KD113150081245.ppp-bb.dion.ne.jp [113.150.81.245])
        by mx.google.com with ESMTPS id y16sm4148445wff.14.2010.08.27.02.32.40
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 27 Aug 2010 02:32:43 -0700 (PDT)
From:   jiang.adam@gmail.com
To:     ralf@linux-mips.org
Cc:     dmitri.vorobiev@movial.com, wuzhangjin@gmail.com,
        ddaney@caviumnetworks.com, peterz@infradead.org,
        fweisbec@gmail.com, tj@kernel.org, tglx@linutronix.de,
        mingo@elte.hu, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org, Adam Jiang <jiang.adam@gmail.com>
Subject: [PATCH V2] mips: irq: add stackoverflow detection
Date:   Fri, 27 Aug 2010 18:32:06 +0900
Message-Id: <1282901526-28405-1-git-send-email-jiang.adam@gmail.com>
X-Mailer: git-send-email 1.7.2.2
In-Reply-To: <linux-mips@linux-mips.org>
References: <linux-mips@linux-mips.org>
Return-Path: <jiang.adam@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 27681
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
 arch/mips/Kconfig.debug |    9 +++++++++
 arch/mips/kernel/irq.c  |   21 +++++++++++++++++++++
 2 files changed, 30 insertions(+), 0 deletions(-)

diff --git a/arch/mips/Kconfig.debug b/arch/mips/Kconfig.debug
index 43dc279..f437cd1 100644
--- a/arch/mips/Kconfig.debug
+++ b/arch/mips/Kconfig.debug
@@ -67,6 +67,15 @@ config CMDLINE_OVERRIDE
 
 	  Normally, you will choose 'N' here.
 
+config DEBUG_STACKOVERFLOW
+	bool "Check for stack overflows"
+	depends on DEBUG_KERNEL
+	help
+	  This option will cause messages to be printed if free stack space
+	  drops below a certain limit(2GB on MIPS). The debugging option
+	  provides another way to check stack overflow happened on kernel mode
+	  stack usually caused by nested interruption.
+
 config DEBUG_STACK_USAGE
 	bool "Enable stack utilization instrumentation"
 	depends on DEBUG_KERNEL
diff --git a/arch/mips/kernel/irq.c b/arch/mips/kernel/irq.c
index c6345f5..d0b924d 100644
--- a/arch/mips/kernel/irq.c
+++ b/arch/mips/kernel/irq.c
@@ -151,6 +151,26 @@ void __init init_IRQ(void)
 #endif
 }
 
+#ifdef DEBUG_STACKOVERFLOW
+static inline void check_stack_overflow(void)
+{
+	long sp;
+
+	__asm__ __volatile__("move %0, $sp" : "=r" (sp));
+	sp = sp & (THREAD_SIZE-1);
+
+	/* check for stack overflow: is there less than 2KB free? */
+	if (unlikely(sp < (sizeof(struct thread_info) + 2048))) {
+		printk("do_IRQ: stack overflow: %ld\n",
+		       sp - sizeof(struct thread_info));
+		dump_stack();
+	}
+}
+#else
+static inline void check_stack_overflow(void) {}
+#endif
+
+
 /*
  * do_IRQ handles all normal device IRQ's (the special
  * SMP cross-CPU interrupts have their own specific
@@ -159,6 +179,7 @@ void __init init_IRQ(void)
 void __irq_entry do_IRQ(unsigned int irq)
 {
 	irq_enter();
+	check_stack_overflow();
 	__DO_IRQ_SMTC_HOOK(irq);
 	generic_handle_irq(irq);
 	irq_exit();
-- 
1.7.2.2
