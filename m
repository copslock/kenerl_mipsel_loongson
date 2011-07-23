Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 23 Jul 2011 14:44:34 +0200 (CEST)
Received: from www.linutronix.de ([62.245.132.108]:60707 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S1491198Ab1GWMlZ (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 23 Jul 2011 14:41:25 +0200
Received: from localhost ([127.0.0.1] helo=localhost6.localdomain6)
        by Galois.linutronix.de with esmtp (Exim 4.72)
        (envelope-from <tglx@linutronix.de>)
        id 1QkbWH-0003v0-Jc; Sat, 23 Jul 2011 14:41:25 +0200
Message-Id: <20110723124016.378250745@linutronix.de>
User-Agent: quilt/0.48-1
Date:   Sat, 23 Jul 2011 12:41:25 -0000
From:   Thomas Gleixner <tglx@linutronix.de>
To:     linux-mips@linux-mips.org
Cc:     Ralf Baechle <ralf@linux-mips.org>
Subject: [patch 7/7] mips: Allow forced irq threading
References: <20110723123948.573545817@linutronix.de>
Content-Disposition: inline; filename=mips-allow-irq-threading.patch
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
X-archive-position: 30697
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: tglx@linutronix.de
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 16790

All low level interrupts have been marked NO_THREAD, so MIPS can enjoy
the wonderful world of forced threaded interrupt handlers.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 arch/mips/Kconfig |    1 +
 1 file changed, 1 insertion(+)

Index: linux-2.6/arch/mips/Kconfig
===================================================================
--- linux-2.6.orig/arch/mips/Kconfig
+++ linux-2.6/arch/mips/Kconfig
@@ -24,6 +24,7 @@ config MIPS
 	select GENERIC_IRQ_PROBE
 	select GENERIC_IRQ_SHOW
 	select HAVE_ARCH_JUMP_LABEL
+	select IRQ_FORCED_THREADING
 
 menu "Machine selection"
 
