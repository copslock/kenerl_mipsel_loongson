Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 26 Aug 2010 15:16:52 +0200 (CEST)
Received: from mail-pz0-f49.google.com ([209.85.210.49]:56931 "EHLO
        mail-pz0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491766Ab0HZNQq (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 26 Aug 2010 15:16:46 +0200
Received: by pzk3 with SMTP id 3so715790pzk.36
        for <multiple recipients>; Thu, 26 Aug 2010 06:16:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=7n52Hu7UghW3rAB/uOaoB2AhgfEZemHKA8QHL1KrJPk=;
        b=lY0LTNWbEc32hOzwPMY7fa/Wfe1HALCFGl3sw7rW91mdzQTOgUj/OUGCFLPXmqnMcy
         ssCTdoKJ4zUQ4Xa7ar1gvGowia0HchDDZIMRDKZyDltv7VwHVmWH64WPQxnxlrEZ/w0g
         oIIH5Hsjk/SKBDY89bU0rW++8YOnaJCfsB4CU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=vlKvj+fX3w+8ask1jk/7sTORUHMXla+c5Y5lRF/NKvKZ1euSz3y8RlyJV9cY4ZEaTP
         WAasNVlEVt7bf/cuZbDOMjohjn5XSgAyRL0sb14InW41qn2UoCpX3h9kEJWVeg8Tp1gS
         wTIijIJ1ilwvcrT//k9QCdhzHKbjsgltMgckI=
Received: by 10.142.187.6 with SMTP id k6mr8411776wff.3.1282828597144;
        Thu, 26 Aug 2010 06:16:37 -0700 (PDT)
Received: from localhost (KD118154228076.ppp-bb.dion.ne.jp [118.154.228.76])
        by mx.google.com with ESMTPS id z1sm2970169wfd.3.2010.08.26.06.16.34
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 26 Aug 2010 06:16:36 -0700 (PDT)
From:   Adam Jiang <jiang.adam@gmail.com>
To:     ralf@linux-mips.org
Cc:     dmitri.vorobiev@movial.com, wuzhangjin@gmail.com,
        ddaney@caviumnetworks.com, peterz@infradead.org,
        fweisbec@gmail.com, tj@kernel.org, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org, Adam Jiang <jiang.adam@gmail.com>
Subject: [PATCH] mips: irq: add stackoverflow detection
Date:   Thu, 26 Aug 2010 22:19:15 +0900
Message-Id: <1282828755-11953-1-git-send-email-jiang.adam@gmail.com>
X-Mailer: git-send-email 1.7.1
In-Reply-To: <linux-mips@linux-mips.org>
References: <linux-mips@linux-mips.org>
Return-Path: <jiang.adam@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 27674
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jiang.adam@gmail.com
Precedence: bulk
X-list: linux-mips

Add stackoverflow detection to mips arch
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
index c6345f5..8fdf79e 100644
--- a/arch/mips/kernel/irq.c
+++ b/arch/mips/kernel/irq.c
@@ -151,6 +151,25 @@ void __init init_IRQ(void)
 #endif
 }
 
+#ifdef DEBUG_STACKOVERFLOW
+static inline void check_stack_overflow(void)
+{
+	long sp;
+
+	asm volatile("move %0, $sp" : "=r" (sp));
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
 /*
  * do_IRQ handles all normal device IRQ's (the special
  * SMP cross-CPU interrupts have their own specific
-- 
1.7.1
