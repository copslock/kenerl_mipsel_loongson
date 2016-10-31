Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 31 Oct 2016 22:17:32 +0100 (CET)
Received: from mail-pf0-f194.google.com ([209.85.192.194]:35338 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23993008AbcJaVRAo9EA0 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 31 Oct 2016 22:17:00 +0100
Received: by mail-pf0-f194.google.com with SMTP id s8so9640598pfj.2;
        Mon, 31 Oct 2016 14:17:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=dny7xnoaTngzbK93ZpXabvz7OhNkidsP8tpDABfN528=;
        b=v6asDcZ/NpAj9iP5OtweOy+Pp7xeQFl3IEfHFEaXoKNATQYhfxRyLpjvXnhR5Lj6Kc
         szJziSBhHlwluZ5+Njo9gdXPi6msRH7hmW3u1m/5w0PlDmRsKGxj5KL/rFAmWn2xwcMv
         GIb29zKHde5inDfVT0JFC/5JZyfY8rxABXsu7EmT01k+wBn+v5ivnFFpTLGvknthF0cM
         JXgjhYv98WgRC+rx7iAOD27hHUwQyeyQL811p7XkwAXK4cNlIiVxLmiHNyxaw9IMofH9
         KU+ygZYMr4+ahw2TuWTOJmr+TsBNTtBFJovyfdk1EoJqrR7BX7rZV9n1j7Viw17wsXr7
         V1EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=dny7xnoaTngzbK93ZpXabvz7OhNkidsP8tpDABfN528=;
        b=CgTR7oQlmSfFT6gBtdfOHUrvcczPwjvaHLl5RCN/Yw8t3dIFBBE04SsppTp0ftXlDO
         MZYz3L+eXss3dX08A6Zg43RxvzmTtPpQVS5j3e1uj3pg4waTFadIgYZUnpS/xjpM3ZFH
         yUa6ZgcdsMi9BhcYHGoQNKRRLV7SbVSN/sF1kRPNCC2A7BIjrZP424e0RCUjHqLq7ShA
         dFtqZy4XOWhQYPA4Sw8HaMn3o0+jF7PptzklailolLDKSLyAiWRI+T63TIZ0y50t5/6A
         +vLm8tzVTQ6Bm/gnCSaz94FtZKU3WOvBcs0GLpDYNCVoR/51VlHV+qYtxkz16wO8ZPz7
         Arcg==
X-Gm-Message-State: ABUngvci7eVl7VNohkaOIVqwjWjo0UlvqC8HFM+gtO5kz2Kd8b8gYJTF63YY/9kFlY+zTw==
X-Received: by 10.98.9.147 with SMTP id 19mr52908201pfj.68.1477948614748;
        Mon, 31 Oct 2016 14:16:54 -0700 (PDT)
Received: from fainelli-desktop.broadcom.com ([192.19.255.250])
        by smtp.gmail.com with ESMTPSA id a7sm37628013pan.34.2016.10.31.14.16.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 31 Oct 2016 14:16:54 -0700 (PDT)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     linux-mips@linux-mips.org
Cc:     ralf@linux-mips.org, cernekee@gmail.com, jaedon.shin@gmail.com,
        justinpopo6@gmail.com, tglx@linuxtronix.de, marc.zyngier@arm.com,
        jason@lakedaemon.net, linux-kernel@vger.kernel.org,
        Florian Fainelli <f.fainelli@gmail.com>
Subject: [PATCH 1/2] irqchip/bcm7038-l1: Implement irq_cpu_offline
Date:   Mon, 31 Oct 2016 14:16:46 -0700
Message-Id: <1477948607-12899-2-git-send-email-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1477948607-12899-1-git-send-email-f.fainelli@gmail.com>
References: <1477948607-12899-1-git-send-email-f.fainelli@gmail.com>
Return-Path: <f.fainelli@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 55623
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
