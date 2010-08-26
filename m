Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 26 Aug 2010 05:56:23 +0200 (CEST)
Received: from mail-px0-f177.google.com ([209.85.212.177]:35058 "EHLO
        mail-px0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491101Ab0HZD4T (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 26 Aug 2010 05:56:19 +0200
Received: by pxi4 with SMTP id 4so553476pxi.36
        for <multiple recipients>; Wed, 25 Aug 2010 20:56:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=v1NZ4NZf+pmDUUi3/wkmNhxq8OH7//3BGA3cBNzmDU4=;
        b=Ti/bqr/oBY3GyHG4nnscGDGZyCXdkr/gP6+uMoilWjRHxxBl93HWUVQo8M3zAJdy1T
         46SAVvW6R3kkus3Uv6uaYzrdGTP1scf8yhhqaFdrwAGkDDr+Z8xHsu64kY0hbWxPrhsU
         qBVr42nfhGpfGVLILeJX98PFA0qDf1IWmEZRE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=VsmsUhVZUWdIIDC7Ij46Z1L9BX97IXhr4J+zAbB74GsSddyRElTyqLw1DXqc/lZ26X
         oLzCb1LQDPpTz+Sr8aI9i3dbxOjIXlq5Q+zVm5TqiH3krS81mXMjVeGLN9GAoL+iM89Q
         JavGEPnULANToNHigBiDqJocl5j4m2AO1DkDw=
Received: by 10.142.127.16 with SMTP id z16mr7744416wfc.50.1282794966066;
        Wed, 25 Aug 2010 20:56:06 -0700 (PDT)
Received: from localhost (KD113150081245.ppp-bb.dion.ne.jp [113.150.81.245])
        by mx.google.com with ESMTPS id d4sm2366318wfh.23.2010.08.25.20.56.02
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 25 Aug 2010 20:56:04 -0700 (PDT)
From:   Adam Jiang <jiang.adam@gmail.com>
To:     ralf@linux-mips.org
Cc:     dmitri.vorobiev@movial.com, wuzhangjin@gmail.com,
        ddaney@caviumnetworks.com, peterz@infradead.org,
        fweisbec@gmail.com, tj@kernel.org, tglx@linutronix.de,
        mingo@elte.hu, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org, Adam Jiang <jiang.adam@gmail.com>
Subject: [PATCH 3/3] mips: irq: add stackoverflow detection
Date:   Thu, 26 Aug 2010 12:55:33 +0900
Message-Id: <1282794933-20639-1-git-send-email-jiang.adam@gmail.com>
X-Mailer: git-send-email 1.7.2.2
In-Reply-To: <linux-kernel@vger.kernel.org>
References: <linux-kernel@vger.kernel.org>
Return-Path: <jiang.adam@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 27671
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jiang.adam@gmail.com
Precedence: bulk
X-list: linux-mips

Add stackoverflow detection to mips arch
---
 arch/mips/Kconfig.debug |    7 +++++++
 arch/mips/kernel/irq.c  |   22 ++++++++++++++++++++++
 2 files changed, 29 insertions(+), 0 deletions(-)

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
diff --git a/arch/mips/kernel/irq.c b/arch/mips/kernel/irq.c
index c6345f5..75c584d 100644
--- a/arch/mips/kernel/irq.c
+++ b/arch/mips/kernel/irq.c
@@ -151,6 +151,25 @@ void __init init_IRQ(void)
 #endif
 }
 
+#ifdef CONFIG_DEBUG_STACKOVERFLOW
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
+static inline void check_stack_overflow(void)
+#endif
+
 /*
  * do_IRQ handles all normal device IRQ's (the special
  * SMP cross-CPU interrupts have their own specific
@@ -159,6 +178,9 @@ void __init init_IRQ(void)
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
1.7.0.4
