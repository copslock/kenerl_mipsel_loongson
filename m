Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 12 Sep 2011 13:36:38 +0200 (CEST)
Received: from www.linutronix.de ([62.245.132.108]:44173 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S1491080Ab1ILLgb (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 12 Sep 2011 13:36:31 +0200
Received: from localhost ([127.0.0.1])
        by Galois.linutronix.de with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
        (Exim 4.72)
        (envelope-from <tglx@linutronix.de>)
        id 1R34oQ-00020q-Ir; Mon, 12 Sep 2011 13:36:30 +0200
Date:   Mon, 12 Sep 2011 13:36:29 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     linux-mips@linux-mips.org
cc:     Ralf Baechle <ralf@linux-mips.org>
Subject: [PATCH] mips: i8259: Mark cascade interrupt non-threaded
Message-ID: <alpine.LFD.2.02.1109121334460.2723@ionos>
User-Agent: Alpine 2.02 (LFD 1266 2009-07-14)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
X-archive-position: 31059
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: tglx@linutronix.de
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 5758

From: Liming Wang <liming.wang@windriver.com>
Date: Fri, 26 Aug 2011 23:00:04 +0800

Cascade interrupts cannot be threaded.

Signed-off-by: Liming Wang <liming.wang@windriver.com>
Signed-off-by: Bruce Ashfield <bruce.ashfield@windriver.com>
Cc: Peter Zijlstra <a.p.zijlstra@chello.nl>
Link: http://lkml.kernel.org/r/1314370804-21266-1-git-send-email-liming.wang@windriver.com
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 arch/mips/kernel/i8259.c |    1 +
 1 file changed, 1 insertion(+)

Index: linux-2.6/arch/mips/kernel/i8259.c
===================================================================
--- linux-2.6.orig/arch/mips/kernel/i8259.c
+++ linux-2.6/arch/mips/kernel/i8259.c
@@ -295,6 +295,7 @@ static void init_8259A(int auto_eoi)
 static struct irqaction irq2 = {
 	.handler = no_action,
 	.name = "cascade",
+	.flags = IRQF_NO_THREAD,
 };
 
 static struct resource pic1_io_resource = {
