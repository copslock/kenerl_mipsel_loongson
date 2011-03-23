Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 23 Mar 2011 22:23:48 +0100 (CET)
Received: from www.linutronix.de ([62.245.132.108]:47517 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S1491945Ab1CWVJZ (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 23 Mar 2011 22:09:25 +0100
Received: from localhost ([127.0.0.1] helo=localhost6.localdomain6)
        by Galois.linutronix.de with esmtp (Exim 4.72)
        (envelope-from <tglx@linutronix.de>)
        id 1Q2VIu-0001xM-4v; Wed, 23 Mar 2011 22:09:20 +0100
Message-Id: <20110323210538.163607499@linutronix.de>
User-Agent: quilt/0.48-1
Date:   Wed, 23 Mar 2011 21:09:19 -0000
From:   Thomas Gleixner <tglx@linutronix.de>
To:     linux-mips@linux-mips.org
Cc:     Ralf Baechle <ralf@linux-mips.org>
Subject: [patch 38/38] mips: Select GENERIC_HARDIRQS_NO_DEPRECATED
References: <20110323210437.398062704@linutronix.de>
Content-Disposition: inline; filename=mips-set-nodepr.patch
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1
Return-Path: <tglx@linutronix.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 29467
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: tglx@linutronix.de
Precedence: bulk
X-list: linux-mips

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 arch/mips/Kconfig |    1 +
 1 file changed, 1 insertion(+)

Index: linux-mips-next/arch/mips/Kconfig
===================================================================
--- linux-mips-next.orig/arch/mips/Kconfig
+++ linux-mips-next/arch/mips/Kconfig
@@ -23,6 +23,7 @@ config MIPS
 	select HAVE_GENERIC_HARDIRQS
 	select GENERIC_IRQ_PROBE
 	select GENERIC_IRQ_SHOW
+	select GENERIC_HARDIRQS_NO_DEPRECATED
 	select HAVE_ARCH_JUMP_LABEL
 
 menu "Machine selection"
