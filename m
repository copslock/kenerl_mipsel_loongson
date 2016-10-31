Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 31 Oct 2016 22:19:10 +0100 (CET)
Received: from mail-pf0-f193.google.com ([209.85.192.193]:35842 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992437AbcJaVRsp6GQ0 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 31 Oct 2016 22:17:48 +0100
Received: by mail-pf0-f193.google.com with SMTP id n85so9650425pfi.3;
        Mon, 31 Oct 2016 14:17:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=dny7xnoaTngzbK93ZpXabvz7OhNkidsP8tpDABfN528=;
        b=pcjUrV4/7GaaSMDYhWn8/K8FvWETpGPir0ZxCsydQSPaox631kp9rZo1u4JiGAdiE4
         74tZ1H7lgis7RVCvJErWQC7d0B5AsxdmdONph1iGfkutklTA8xAbx+WTIT/qVZqHgAQv
         o+07vWVPjKv9cAEkis9Tk0mnHohW29R+Er1mUF3Bvjahl5jUhHL8rUoTCXA/xD0r646/
         gJBcX8qD3R7sPd11h71gHWMEJjJALbiWOGJLkAvNAYiRXLmA2JhKPkOvkErVP2teOaxA
         TOamKztSQkYaCHjQs5p7WLB8zSzLZzCp7qyxqoNaCiRATj9j7G+zcmnBT6kpJx2O0ULY
         tKIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=dny7xnoaTngzbK93ZpXabvz7OhNkidsP8tpDABfN528=;
        b=XDePYbKYnwl3tr4E6SyOFGd/Ca8+DSqplNOpIwzuPb+Y+1MQCMz2gjSPeBE8rkEsGK
         vEWiW3kATUTbi6I9O3S17r4GkjbxMUNHFM0AzmG8mXW/tKZl97M6I/9MvvhRZvmCBwUF
         YkhWGrgIMPaUFidRSi+C+p6lZL4XKVzavoJBo258ayrO9izWGvziL8HtPrZJRt7CIwAy
         YCz//uGuvMSu/Q2JDe3PTdc6eBG3/m+DAQykO7xC3B5jdyouZbeYhK7FgB3lR4luse5u
         bY6Rs1TJ5XuYYokJBfc/AXV+K352vDKARqzG1dL1JhJlXLciigpvpEWh7Ic21Q2iCf04
         NbFA==
X-Gm-Message-State: ABUngvcBoJtXDHU1yY8d3Jc7TKGvfy+T7Z8YuLPloT+tIqpWhw81/LFffpYpscqd/yCkPQ==
X-Received: by 10.99.117.3 with SMTP id q3mr43230396pgc.50.1477948662973;
        Mon, 31 Oct 2016 14:17:42 -0700 (PDT)
Received: from fainelli-desktop.broadcom.com ([192.19.255.250])
        by smtp.gmail.com with ESMTPSA id w85sm25592601pfk.57.2016.10.31.14.17.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 31 Oct 2016 14:17:42 -0700 (PDT)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     linux-mips@linux-mips.org
Cc:     ralf@linux-mips.org, cernekee@gmail.com, jaedon.shin@gmail.com,
        justinpopo6@gmail.com, tglx@linutronix.de, marc.zyngier@arm.com,
        jason@lakedaemon.net, linux-kernel@vger.kernel.org,
        Florian Fainelli <f.fainelli@gmail.com>
Subject: [PATCH 1/2] irqchip/bcm7038-l1: Implement irq_cpu_offline
Date:   Mon, 31 Oct 2016 14:17:35 -0700
Message-Id: <1477948656-12966-2-git-send-email-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1477948656-12966-1-git-send-email-f.fainelli@gmail.com>
References: <1477948656-12966-1-git-send-email-f.fainelli@gmail.com>
Return-Path: <f.fainelli@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 55627
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: f.fainelli@gmail.com
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

We did not implement an irq_cpu_offline callback for our irqchip, yet we
support setting a given IRQ's affinity. This resulted in interrupts
whose affinity mask included CPUs being taken offline not to work
correctly once the CPU had been put offline.

Fixes: 5f7f0317ed28 ("IRQCHIP: Add new driver for BCM7038-style level 1 interrupt controllers")
Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 drivers/irqchip/irq-bcm7038-l1.c | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/drivers/irqchip/irq-bcm7038-l1.c b/drivers/irqchip/irq-bcm7038-l1.c
index 0fea985ef1dc..529968ac38c0 100644
--- a/drivers/irqchip/irq-bcm7038-l1.c
+++ b/drivers/irqchip/irq-bcm7038-l1.c
@@ -216,6 +216,30 @@ static int bcm7038_l1_set_affinity(struct irq_data *d,
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
+		/* Multiple CPU affinity, remove this CPU from the affinity
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
@@ -267,6 +291,7 @@ static struct irq_chip bcm7038_l1_irq_chip = {
 	.irq_mask		= bcm7038_l1_mask,
 	.irq_unmask		= bcm7038_l1_unmask,
 	.irq_set_affinity	= bcm7038_l1_set_affinity,
+	.irq_cpu_offline	= bcm7038_l1_cpu_offline,
 };
 
 static int bcm7038_l1_map(struct irq_domain *d, unsigned int virq,
-- 
2.7.4
