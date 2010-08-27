Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 27 Aug 2010 11:30:19 +0200 (CEST)
Received: from mail-px0-f177.google.com ([209.85.212.177]:61885 "EHLO
        mail-px0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491809Ab0H0JaN (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 27 Aug 2010 11:30:13 +0200
Received: by pxi4 with SMTP id 4so1164502pxi.36
        for <multiple recipients>; Fri, 27 Aug 2010 02:30:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=qsGEjnBSKpml4UIv7ZnA/VEb7qF+OdgxZ6Z8GG+IY3M=;
        b=Cn33/x+IETh7mOHGPlUDP3J8i+kGrRsrkQgdv0dZPt/z6/V4thEIjrQfRiXfLinarb
         nIVl2HEr9CCBVaNIROgs1JxTarKeAphq53WMMf+oenyNiMbS70ukYJSLbq6AmsFr7wmm
         IpmcSJDLXgOjdo0C5G3DK290dGgBAkOhD3iuA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=PvcNEdmhCu4lEkDHwy6d/NXIp27vcTkgHojlYvWqKHqbgUQH7Uy53cEIH5w9rYSJQY
         PMegxt8NdOZ+A9w4geG18eVQtSSGnnTRI1JSejdnaKuaRrzzaVSQXdhQthPERTKkapH6
         Cw+7sNrYgm6U6casRLMRFMALPwVG2hAyJh+Uw=
Received: by 10.115.109.6 with SMTP id l6mr175556wam.164.1282901406784;
        Fri, 27 Aug 2010 02:30:06 -0700 (PDT)
Received: from localhost (KD113150081245.ppp-bb.dion.ne.jp [113.150.81.245])
        by mx.google.com with ESMTPS id s5sm6245279wak.0.2010.08.27.02.30.03
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 27 Aug 2010 02:30:05 -0700 (PDT)
From:   jiang.adam@gmail.com
To:     ralf@linux-mips.org
Cc:     dmitri.vorobiev@movial.com, wuzhangjin@gmail.com,
        ddaney@caviumnetworks.com, peterz@infradead.org,
        fweisbec@gmail.com, tj@kernel.org, tglx@linutronix.de,
        mingo@elte.hu, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org, Adam Jiang <jiang.adam@gmail.com>
Subject: [[PATCH V2]] mips: irq: add stackoverflow detection
Date:   Fri, 27 Aug 2010 18:29:25 +0900
Message-Id: <1282901365-28364-1-git-send-email-jiang.adam@gmail.com>
X-Mailer: git-send-email 1.7.2.2
In-Reply-To: <linux-mips@linux-mips.org>
References: <linux-mips@linux-mips.org>
Return-Path: <jiang.adam@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 27680
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
