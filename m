Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 18 Mar 2011 22:49:49 +0100 (CET)
Received: from mail3.caviumnetworks.com ([12.108.191.235]:3465 "EHLO
        mail3.caviumnetworks.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491175Ab1CRVtH (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 18 Mar 2011 22:49:07 +0100
Received: from caexch01.caveonetworks.com (Not Verified[192.168.16.9]) by mail3.caviumnetworks.com with MailMarshal (v6,7,2,8378)
        id <B4d83d3870004>; Fri, 18 Mar 2011 14:49:59 -0700
Received: from caexch01.caveonetworks.com ([192.168.16.9]) by caexch01.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.4675);
         Fri, 18 Mar 2011 14:48:52 -0700
Received: from dd1.caveonetworks.com ([12.108.191.236]) by caexch01.caveonetworks.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.4675);
         Fri, 18 Mar 2011 14:48:52 -0700
Received: from dd1.caveonetworks.com (localhost.localdomain [127.0.0.1])
        by dd1.caveonetworks.com (8.14.4/8.14.3) with ESMTP id p2ILmleV011182;
        Fri, 18 Mar 2011 14:48:47 -0700
Received: (from ddaney@localhost)
        by dd1.caveonetworks.com (8.14.4/8.14.4/Submit) id p2ILmjeX011181;
        Fri, 18 Mar 2011 14:48:45 -0700
From:   David Daney <ddaney@caviumnetworks.com>
To:     tglx@linutronix.de, linux-mips@linux-mips.org
Cc:     linux-kernel@vger.kernel.org,
        David Daney <ddaney@caviumnetworks.com>
Subject: [RFC PATCH 1/2] genirq: Add chip hooks for taking CPUs on/off line.
Date:   Fri, 18 Mar 2011 14:48:35 -0700
Message-Id: <1300484916-11133-2-git-send-email-ddaney@caviumnetworks.com>
X-Mailer: git-send-email 1.7.2.3
In-Reply-To: <1300484916-11133-1-git-send-email-ddaney@caviumnetworks.com>
References: <1300484916-11133-1-git-send-email-ddaney@caviumnetworks.com>
X-OriginalArrivalTime: 18 Mar 2011 21:48:52.0329 (UTC) FILETIME=[45842D90:01CBE5B6]
Return-Path: <David.Daney@caviumnetworks.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 29415
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@caviumnetworks.com
Precedence: bulk
X-list: linux-mips

Signed-off-by: David Daney <ddaney@caviumnetworks.com>
---
 include/linux/irq.h     |    8 ++++++++
 include/linux/irqdesc.h |    6 ++++++
 kernel/irq/chip.c       |   35 +++++++++++++++++++++++++++++++++++
 3 files changed, 49 insertions(+), 0 deletions(-)

diff --git a/include/linux/irq.h b/include/linux/irq.h
index 1d3577f..0358fbd 100644
--- a/include/linux/irq.h
+++ b/include/linux/irq.h
@@ -270,6 +270,8 @@ static inline bool irqd_can_move_in_process_context(struct irq_data *d)
  * @irq_set_wake:	enable/disable power-management wake-on of an IRQ
  * @irq_bus_lock:	function to lock access to slow bus (i2c) chips
  * @irq_bus_sync_unlock:function to sync and unlock slow bus (i2c) chips
+ * @irq_cpu_online:	configure an interrupt source for a secondary CPU
+ * @irq_cpu_offline:	un-configure an interrupt source for a secondary CPU
  * @flags:		chip specific flags
  *
  * @release:		release function solely used by UML
@@ -317,6 +319,9 @@ struct irq_chip {
 	void		(*irq_bus_lock)(struct irq_data *data);
 	void		(*irq_bus_sync_unlock)(struct irq_data *data);
 
+	void		(*irq_cpu_online)(struct irq_data *data, bool enabled);
+	void		(*irq_cpu_offline)(struct irq_data *data, bool enabled);
+
 	unsigned long	flags;
 
 	/* Currently used only by UML, might disappear one day.*/
@@ -360,6 +365,9 @@ struct irqaction;
 extern int setup_irq(unsigned int irq, struct irqaction *new);
 extern void remove_irq(unsigned int irq, struct irqaction *act);
 
+extern void irq_cpu_online(unsigned int irq);
+extern void irq_cpu_offline(unsigned int irq);
+
 #ifdef CONFIG_GENERIC_HARDIRQS
 
 #if defined(CONFIG_SMP) && defined(CONFIG_GENERIC_PENDING_IRQ)
diff --git a/include/linux/irqdesc.h b/include/linux/irqdesc.h
index 0021837..f995fae 100644
--- a/include/linux/irqdesc.h
+++ b/include/linux/irqdesc.h
@@ -178,6 +178,12 @@ static inline int irq_has_action(unsigned int irq)
 	return desc->action != NULL;
 }
 
+/* Test to see if the irq is currently enabled */
+static inline int irq_desc_is_enabled(struct irq_desc *desc)
+{
+	return desc->depth == 0;
+}
+
 #ifndef CONFIG_GENERIC_HARDIRQS_NO_COMPAT
 static inline int irq_balancing_disabled(unsigned int irq)
 {
diff --git a/kernel/irq/chip.c b/kernel/irq/chip.c
index c9c0601..40736f7 100644
--- a/kernel/irq/chip.c
+++ b/kernel/irq/chip.c
@@ -689,3 +689,38 @@ void irq_modify_status(unsigned int irq, unsigned long clr, unsigned long set)
 
 	irq_put_desc_unlock(desc, flags);
 }
+
+void irq_cpu_online(unsigned int irq)
+{
+	unsigned long flags;
+	struct irq_chip *chip;
+	struct irq_desc *desc = irq_to_desc(irq);
+
+	raw_spin_lock_irqsave(&desc->lock, flags);
+
+	chip = irq_data_get_irq_chip(&desc->irq_data);
+
+	if (chip && chip->irq_cpu_online)
+		chip->irq_cpu_online(&desc->irq_data,
+				     irq_desc_is_enabled(desc));
+
+	raw_spin_unlock_irqrestore(&desc->lock, flags);
+}
+
+void irq_cpu_offline(unsigned int irq)
+{
+	unsigned long flags;
+	struct irq_chip *chip;
+	struct irq_desc *desc = irq_to_desc(irq);
+
+
+	raw_spin_lock_irqsave(&desc->lock, flags);
+
+	chip = irq_data_get_irq_chip(&desc->irq_data);
+
+	if (chip && chip->irq_cpu_offline)
+		chip->irq_cpu_offline(&desc->irq_data,
+				      irq_desc_is_enabled(desc));
+
+	raw_spin_unlock_irqrestore(&desc->lock, flags);
+}
-- 
1.7.2.3
