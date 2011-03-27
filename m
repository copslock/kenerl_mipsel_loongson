Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 27 Mar 2011 18:23:55 +0200 (CEST)
Received: from www.linutronix.de ([62.245.132.108]:40558 "EHLO linutronix.de"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1491918Ab1C0QWL (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Sun, 27 Mar 2011 18:22:11 +0200
Received: from localhost ([127.0.0.1] helo=localhost6.localdomain6)
        by linutronix.de with esmtp (Exim 4.72)
        (envelope-from <tglx@linutronix.de>)
        id 1Q3sj7-000550-RZ; Sun, 27 Mar 2011 18:22:05 +0200
Message-Id: <20110327161118.832008208@linutronix.de>
User-Agent: quilt/0.48-1
Date:   Sun, 27 Mar 2011 16:22:05 -0000
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     David Daney <ddaney@caviumnetworks.com>, linux-mips@linux-mips.org
Subject: [patch 4/5] MIPS: alchemy: Use proper irq accessors
References: <20110327155637.623706071@linutronix.de>
Content-Disposition: inline; filename=mips-alchemy-use-proper-accessors.patch
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Return-Path: <tglx@linutronix.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 29577
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: tglx@linutronix.de
Precedence: bulk
X-list: linux-mips

This really starts to be a sysiphean task.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 arch/mips/alchemy/devboards/db1200/setup.c |   13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

Index: linux-2.6-tip/arch/mips/alchemy/devboards/db1200/setup.c
===================================================================
--- linux-2.6-tip.orig/arch/mips/alchemy/devboards/db1200/setup.c
+++ linux-2.6-tip/arch/mips/alchemy/devboards/db1200/setup.c
@@ -70,13 +70,12 @@ static int __init db1200_arch_init(void)
 	 * issues they must not be automatically enabled when initially
 	 * requested.
 	 */
-	irq_to_desc(DB1200_SD0_INSERT_INT)->status |= IRQ_NOAUTOEN;
-	irq_to_desc(DB1200_SD0_EJECT_INT)->status |= IRQ_NOAUTOEN;
-	irq_to_desc(DB1200_PC0_INSERT_INT)->status |= IRQ_NOAUTOEN;
-	irq_to_desc(DB1200_PC0_EJECT_INT)->status |= IRQ_NOAUTOEN;
-	irq_to_desc(DB1200_PC1_INSERT_INT)->status |= IRQ_NOAUTOEN;
-	irq_to_desc(DB1200_PC1_EJECT_INT)->status |= IRQ_NOAUTOEN;
-
+	irq_set_status_flags(DB1200_SD0_INSERT_INT, IRQ_NOAUTOEN);
+	irq_set_status_flags(DB1200_SD0_EJECT_INT, IRQ_NOAUTOEN);
+	irq_set_status_flags(DB1200_PC0_INSERT_INT, IRQ_NOAUTOEN);
+	irq_set_status_flags(DB1200_PC0_EJECT_INT, IRQ_NOAUTOEN);
+	irq_set_status_flags(DB1200_PC1_INSERT_INT, IRQ_NOAUTOEN);
+	irq_set_status_flags(DB1200_PC1_EJECT_INT, IRQ_NOAUTOEN);
 	return 0;
 }
 arch_initcall(db1200_arch_init);
