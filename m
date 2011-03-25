Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 25 Mar 2011 02:08:15 +0100 (CET)
Received: from mail3.caviumnetworks.com ([12.108.191.235]:11498 "EHLO
        mail3.caviumnetworks.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491923Ab1CYBHD (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 25 Mar 2011 02:07:03 +0100
Received: from caexch01.caveonetworks.com (Not Verified[192.168.16.9]) by mail3.caviumnetworks.com with MailMarshal (v6,7,2,8378)
        id <B4d8beaee0000>; Thu, 24 Mar 2011 18:07:58 -0700
Received: from caexch01.caveonetworks.com ([192.168.16.9]) by caexch01.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.4675);
         Thu, 24 Mar 2011 18:07:01 -0700
Received: from dd1.caveonetworks.com ([12.108.191.236]) by caexch01.caveonetworks.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.4675);
         Thu, 24 Mar 2011 18:07:01 -0700
Received: from dd1.caveonetworks.com (localhost.localdomain [127.0.0.1])
        by dd1.caveonetworks.com (8.14.4/8.14.3) with ESMTP id p2P16qL1025582;
        Thu, 24 Mar 2011 18:06:52 -0700
Received: (from ddaney@localhost)
        by dd1.caveonetworks.com (8.14.4/8.14.4/Submit) id p2P16qwd025581;
        Thu, 24 Mar 2011 18:06:52 -0700
From:   David Daney <ddaney@caviumnetworks.com>
To:     tglx@linutronix.de, linux-mips@linux-mips.org
Cc:     linux-kernel@vger.kernel.org,
        David Daney <ddaney@caviumnetworks.com>
Subject: [PATCH v2 2/3] genirq: Split irq_set_affinity() so it can be called with lock held.
Date:   Thu, 24 Mar 2011 18:06:37 -0700
Message-Id: <1301015198-25535-3-git-send-email-ddaney@caviumnetworks.com>
X-Mailer: git-send-email 1.7.2.3
In-Reply-To: <1301015198-25535-1-git-send-email-ddaney@caviumnetworks.com>
References: <1301015198-25535-1-git-send-email-ddaney@caviumnetworks.com>
X-OriginalArrivalTime: 25 Mar 2011 01:07:01.0421 (UTC) FILETIME=[F27225D0:01CBEA88]
Return-Path: <David.Daney@caviumnetworks.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 29538
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@caviumnetworks.com
Precedence: bulk
X-list: linux-mips

The .irq_cpu_online() and .irq_cpu_offline() functions may need to
adjust affinity, but they are called with the descriptor lock held.
Create __irq_set_affinity() which is called with the lock held.  Make
irq_set_affinity() just a wrapper that acquires the lock.

Signed-off-by: David Daney <ddaney@caviumnetworks.com>
---
 include/linux/interrupt.h |    2 ++
 kernel/irq/manage.c       |   40 ++++++++++++++++++++++++++--------------
 2 files changed, 28 insertions(+), 14 deletions(-)

diff --git a/include/linux/interrupt.h b/include/linux/interrupt.h
index 59b72ca..44548f8 100644
--- a/include/linux/interrupt.h
+++ b/include/linux/interrupt.h
@@ -229,6 +229,8 @@ static inline int check_wakeup_irqs(void) { return 0; }
 extern cpumask_var_t irq_default_affinity;
 
 extern int irq_set_affinity(unsigned int irq, const struct cpumask *cpumask);
+extern int __irq_set_affinity(struct irq_desc *desc,
+			      const struct cpumask *cpumask);
 extern int irq_can_set_affinity(unsigned int irq);
 extern int irq_select_affinity(unsigned int irq);
 
diff --git a/kernel/irq/manage.c b/kernel/irq/manage.c
index 0a2aa73..b7ba026 100644
--- a/kernel/irq/manage.c
+++ b/kernel/irq/manage.c
@@ -139,24 +139,12 @@ static inline void
 irq_get_pending(struct cpumask *mask, struct irq_desc *desc) { }
 #endif
 
-/**
- *	irq_set_affinity - Set the irq affinity of a given irq
- *	@irq:		Interrupt to set affinity
- *	@cpumask:	cpumask
- *
- */
-int irq_set_affinity(unsigned int irq, const struct cpumask *mask)
+
+int __irq_set_affinity(struct irq_desc *desc, const struct cpumask *mask)
 {
-	struct irq_desc *desc = irq_to_desc(irq);
 	struct irq_chip *chip = desc->irq_data.chip;
-	unsigned long flags;
 	int ret = 0;
 
-	if (!chip->irq_set_affinity)
-		return -EINVAL;
-
-	raw_spin_lock_irqsave(&desc->lock, flags);
-
 	if (irq_can_move_pcntxt(desc)) {
 		ret = chip->irq_set_affinity(&desc->irq_data, mask, false);
 		switch (ret) {
@@ -177,6 +165,30 @@ int irq_set_affinity(unsigned int irq, const struct cpumask *mask)
 	}
 	irq_compat_set_affinity(desc);
 	irqd_set(&desc->irq_data, IRQD_AFFINITY_SET);
+
+	return ret;
+}
+
+/**
+ *	irq_set_affinity - Set the irq affinity of a given irq
+ *	@irq:		Interrupt to set affinity
+ *	@cpumask:	cpumask
+ *
+ */
+int irq_set_affinity(unsigned int irq, const struct cpumask *mask)
+{
+	struct irq_desc *desc = irq_to_desc(irq);
+	struct irq_chip *chip = desc->irq_data.chip;
+	unsigned long flags;
+	int ret;
+
+	if (!chip->irq_set_affinity)
+		return -EINVAL;
+
+	raw_spin_lock_irqsave(&desc->lock, flags);
+
+	ret =  __irq_set_affinity(desc, mask);
+
 	raw_spin_unlock_irqrestore(&desc->lock, flags);
 	return ret;
 }
-- 
1.7.2.3
