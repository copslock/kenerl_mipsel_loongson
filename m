Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 10 Jan 2017 14:49:59 +0100 (CET)
Received: from mail.linuxfoundation.org ([140.211.169.12]:35826 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23993891AbdAJNttYdYwS (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 10 Jan 2017 14:49:49 +0100
Received: from localhost (unknown [78.192.101.3])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 81EA3910;
        Tue, 10 Jan 2017 13:49:40 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Florian Fainelli <f.fainelli@gmail.com>,
        linux-mips@linux-mips.org, jason@lakedaemon.net,
        marc.zyngier@arm.com, cernekee@gmail.com, jaedon.shin@gmail.com,
        ralf@linux-mips.org, justinpopo6@gmail.com,
        Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH 4.9 134/206] irqchip/bcm7038-l1: Implement irq_cpu_offline() callback
Date:   Tue, 10 Jan 2017 14:36:57 +0100
Message-Id: <20170110131508.907302071@linuxfoundation.org>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20170110131502.767555407@linuxfoundation.org>
References: <20170110131502.767555407@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-Path: <gregkh@linuxfoundation.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 56251
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: gregkh@linuxfoundation.org
Precedence: bulk
List-help: <mailto:ecartis@linux-mips.org?Subject=help>
List-unsubscribe: <mailto:ecartis@linux-mips.org?subject=unsubscribe%20linux-mips>
List-software: Ecartis version 1.0.0
List-Id: linux-mips <linux-mips.eddie.linux-mips.org>
X-List-ID: linux-mips <linux-mips.eddie.linux-mips.org>
List-subscribe: <mailto:ecartis@linux-mips.org?subject=subscribe%20linux-mips>
List-owner: <mailto:ralf@linux-mips.org>
List-post: <mailto:linux-mips@linux-mips.org>
List-archive: <http://www.linux-mips.org/archives/linux-mips/>
X-list: linux-mips

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Florian Fainelli <f.fainelli@gmail.com>

commit 34c535793bcbf9263cf22f8a52101f796cdfab8e upstream.

We did not implement an irq_cpu_offline callback for our irqchip, yet we
support setting a given IRQ's affinity. This resulted in interrupts
whose affinity mask included CPUs being taken offline not to work
correctly once the CPU had been put offline.

Fixes: 5f7f0317ed28 ("IRQCHIP: Add new driver for BCM7038-style level 1 interrupt controllers")
Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
Cc: linux-mips@linux-mips.org
Cc: jason@lakedaemon.net
Cc: marc.zyngier@arm.com
Cc: cernekee@gmail.com
Cc: jaedon.shin@gmail.com
Cc: ralf@linux-mips.org
Cc: justinpopo6@gmail.com
Link: http://lkml.kernel.org/r/1477948656-12966-2-git-send-email-f.fainelli@gmail.com
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/irqchip/irq-bcm7038-l1.c |   26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

--- a/drivers/irqchip/irq-bcm7038-l1.c
+++ b/drivers/irqchip/irq-bcm7038-l1.c
@@ -215,6 +215,31 @@ static int bcm7038_l1_set_affinity(struc
 	return 0;
 }
 
+static void bcm7038_l1_cpu_offline(struct irq_data *d)
+{
+	struct cpumask *mask = irq_data_get_affinity_mask(d);
+	int cpu = smp_processor_id();
+	cpumask_t new_affinity;
+
+	/* This CPU was not on the affinity mask */
+	if (!cpumask_test_cpu(cpu, mask))
+		return;
+
+	if (cpumask_weight(mask) > 1) {
+		/*
+		 * Multiple CPU affinity, remove this CPU from the affinity
+		 * mask
+		 */
+		cpumask_copy(&new_affinity, mask);
+		cpumask_clear_cpu(cpu, &new_affinity);
+	} else {
+		/* Only CPU, put on the lowest online CPU */
+		cpumask_clear(&new_affinity);
+		cpumask_set_cpu(cpumask_first(cpu_online_mask), &new_affinity);
+	}
+	irq_set_affinity_locked(d, &new_affinity, false);
+}
+
 static int __init bcm7038_l1_init_one(struct device_node *dn,
 				      unsigned int idx,
 				      struct bcm7038_l1_chip *intc)
@@ -266,6 +291,7 @@ static struct irq_chip bcm7038_l1_irq_ch
 	.irq_mask		= bcm7038_l1_mask,
 	.irq_unmask		= bcm7038_l1_unmask,
 	.irq_set_affinity	= bcm7038_l1_set_affinity,
+	.irq_cpu_offline	= bcm7038_l1_cpu_offline,
 };
 
 static int bcm7038_l1_map(struct irq_domain *d, unsigned int virq,
