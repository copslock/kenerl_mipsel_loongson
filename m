Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 17 Feb 2011 23:08:42 +0100 (CET)
Received: from mail3.caviumnetworks.com ([12.108.191.235]:9593 "EHLO
        mail3.caviumnetworks.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491115Ab1BQWIj (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 17 Feb 2011 23:08:39 +0100
Received: from caexch01.caveonetworks.com (Not Verified[192.168.16.9]) by mail3.caviumnetworks.com with MailMarshal (v6,7,2,8378)
        id <B4d5d9c980000>; Thu, 17 Feb 2011 14:09:29 -0800
Received: from caexch01.caveonetworks.com ([192.168.16.9]) by caexch01.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.4675);
         Thu, 17 Feb 2011 14:08:36 -0800
Received: from dd1.caveonetworks.com ([12.108.191.236]) by caexch01.caveonetworks.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.4675);
         Thu, 17 Feb 2011 14:08:35 -0800
Received: from dd1.caveonetworks.com (localhost.localdomain [127.0.0.1])
        by dd1.caveonetworks.com (8.14.4/8.14.3) with ESMTP id p1HM8V3W026089;
        Thu, 17 Feb 2011 14:08:32 -0800
Received: (from ddaney@localhost)
        by dd1.caveonetworks.com (8.14.4/8.14.4/Submit) id p1HM8Uu3026088;
        Thu, 17 Feb 2011 14:08:30 -0800
From:   David Daney <ddaney@caviumnetworks.com>
To:     linux-mips@linux-mips.org, ralf@linux-mips.org
Cc:     David Daney <ddaney@caviumnetworks.com>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH] MIPS: Fix show_interrupts() for CONFIG_GENERIC_HARDIRQS_NO_DEPRECATED.
Date:   Thu, 17 Feb 2011 14:08:29 -0800
Message-Id: <1297980509-26056-1-git-send-email-ddaney@caviumnetworks.com>
X-Mailer: git-send-email 1.7.2.3
X-OriginalArrivalTime: 17 Feb 2011 22:08:35.0947 (UTC) FILETIME=[390733B0:01CBCEEF]
Return-Path: <David.Daney@caviumnetworks.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 29221
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@caviumnetworks.com
Precedence: bulk
X-list: linux-mips

When GENERIC_HARDIRQS_NO_DEPRECATED is selected, the 'chip' field of
the irq descriptor is absent.  Fix up show_interrupts() to handle this
case.

Signed-off-by: David Daney <ddaney@caviumnetworks.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
---
 arch/mips/kernel/irq.c |    6 ++++--
 1 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/mips/kernel/irq.c b/arch/mips/kernel/irq.c
index 4f93db5..10f0b9c 100644
--- a/arch/mips/kernel/irq.c
+++ b/arch/mips/kernel/irq.c
@@ -99,9 +99,11 @@ int show_interrupts(struct seq_file *p, void *v)
 	}
 
 	if (i < NR_IRQS) {
+		struct irq_chip *chip;
 		raw_spin_lock_irqsave(&irq_desc[i].lock, flags);
 		action = irq_desc[i].action;
-		if (!action)
+		chip = get_irq_chip(i);
+		if (!action || !chip)
 			goto skip;
 		seq_printf(p, "%3d: ", i);
 #ifndef CONFIG_SMP
@@ -110,7 +112,7 @@ int show_interrupts(struct seq_file *p, void *v)
 		for_each_online_cpu(j)
 			seq_printf(p, "%10u ", kstat_irqs_cpu(i, j));
 #endif
-		seq_printf(p, " %14s", irq_desc[i].chip->name);
+		seq_printf(p, " %14s", chip->name);
 		seq_printf(p, "  %s", action->name);
 
 		for (action=action->next; action; action = action->next)
-- 
1.7.2.3
