Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 09 Aug 2018 10:59:31 +0200 (CEST)
Received: from mail-wr1-x443.google.com ([IPv6:2a00:1450:4864:20::443]:34450
        "EHLO mail-wr1-x443.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23994741AbeHII72HgPy9 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 9 Aug 2018 10:59:28 +0200
Received: by mail-wr1-x443.google.com with SMTP id c13-v6so4477016wrt.1
        for <linux-mips@linux-mips.org>; Thu, 09 Aug 2018 01:59:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=F7KHAUGCcRku+LbHtcagWA+vrgOv2XDa19iGg6969S8=;
        b=oaI4opN9upeJCU/58x3Ksgl5A2I3sw6YNleoHpt2tl+JuoK3nswJW6zwccE/6bwipm
         Nz9StJceVWLxs1GmVV3PMKXuRLWGRX8Qgld/uXTjaFMWM27ejoURQbSbXUKqfpZc45zc
         tUZEWZzdJy94fQTJGu4TO4F22n9wFmyNP9d+zx3rgIdMtPRayOKhWmVo2DTZORJgpwj/
         mhzQle7MGwBPsQK7DCGSbXC9+LcO48S0onMmzh+Pe22qASg1s1T4Eqv3xacwBSj9dZUr
         mYBEXljzLF1wppn8MctD8fexcRNOgWwztKH73iaJNwyT5wrs80YvYhMj3wTOGn2pCryw
         IsIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=F7KHAUGCcRku+LbHtcagWA+vrgOv2XDa19iGg6969S8=;
        b=uYNsUlJNi2/cCw+8fdpXfDneTdW6vVixZHKVmyVqgoCrKKEqdjvON/KPvlTRDdcXn/
         +W3rkZuikAdpWw+A4gtWA+yTByBlrptqgZnm/GE88uDH+33uAUBmE5iBxnquVqNhrPC6
         xw7RsWN+Xzr9YzGme3jBvWHX9pZ/RYNmra66+VTBQzy7aososH7KP79JvOSVoUEEb0zr
         7K9frvk+vMiqodY/oevFh133eh6NU9iVfwjQEEk2i/RgdW4TXlwt14TxBh5PlZCsBT7F
         6DQ3HLYKKLNZF8/wuZ04RZObWyz/k1RRdgZeRy5BHIY/UP8JuqVz4skGuexadunhAXkn
         NCZg==
X-Gm-Message-State: AOUpUlFGY+FGgH88OYjxRt98QR8WgvopWjfL+199boJ4pRw+vLwsnVZr
        87+gp241C5ibHM/a0QVUR94=
X-Google-Smtp-Source: AA+uWPy6tZUAHO9qho/G9ya7Zrzi9ECrrrHGUq2LmMakQD+6WIx54GFG5SEOOj0ZTRa9g+bfA1WRGQ==
X-Received: by 2002:adf:b309:: with SMTP id j9-v6mr800998wrd.207.1533805162758;
        Thu, 09 Aug 2018 01:59:22 -0700 (PDT)
Received: from localhost.localdomain ([2001:470:9e39::64])
        by smtp.gmail.com with ESMTPSA id a6-v6sm11219702wmf.22.2018.08.09.01.59.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 09 Aug 2018 01:59:21 -0700 (PDT)
From:   Jonas Gorski <jonas.gorski@gmail.com>
To:     linux-kernel@vger.kernel.org, linux-mips@linux-mips.org
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Kevin Cernekee <cernekee@gmail.com>,
        Florian Fainelli <f.fainelli@gmail.com>
Subject: [PATCH] irqchip/bcm7038-l1: hide cpu offline callback when building for !SMP
Date:   Thu,  9 Aug 2018 10:59:01 +0200
Message-Id: <20180809085901.26568-1-jonas.gorski@gmail.com>
X-Mailer: git-send-email 2.13.2
Return-Path: <jonas.gorski@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 65493
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jonas.gorski@gmail.com
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

When compiling bmips with SMP disabled, the build fails with:

drivers/irqchip/irq-bcm7038-l1.o: In function `bcm7038_l1_cpu_offline':
drivers/irqchip/irq-bcm7038-l1.c:242: undefined reference to `irq_set_affinity_locked'
make[5]: *** [vmlinux] Error 1

Fix this by adding and setting bcm7038_l1_cpu_offline only when actually
compiling for SMP. It wouldn't have been used anyway, as it requires
CPU_HOTPLUG, which in turn requires SMP.

Fixes: 34c535793bcb ("irqchip/bcm7038-l1: Implement irq_cpu_offline() callback")
Signed-off-by: Jonas Gorski <jonas.gorski@gmail.com>
---
 drivers/irqchip/irq-bcm7038-l1.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/irqchip/irq-bcm7038-l1.c b/drivers/irqchip/irq-bcm7038-l1.c
index faf734ff4cf3..0f6e30e9009d 100644
--- a/drivers/irqchip/irq-bcm7038-l1.c
+++ b/drivers/irqchip/irq-bcm7038-l1.c
@@ -217,6 +217,7 @@ static int bcm7038_l1_set_affinity(struct irq_data *d,
 	return 0;
 }
 
+#ifdef CONFIG_SMP
 static void bcm7038_l1_cpu_offline(struct irq_data *d)
 {
 	struct cpumask *mask = irq_data_get_affinity_mask(d);
@@ -241,6 +242,7 @@ static void bcm7038_l1_cpu_offline(struct irq_data *d)
 	}
 	irq_set_affinity_locked(d, &new_affinity, false);
 }
+#endif
 
 static int __init bcm7038_l1_init_one(struct device_node *dn,
 				      unsigned int idx,
@@ -293,7 +295,9 @@ static struct irq_chip bcm7038_l1_irq_chip = {
 	.irq_mask		= bcm7038_l1_mask,
 	.irq_unmask		= bcm7038_l1_unmask,
 	.irq_set_affinity	= bcm7038_l1_set_affinity,
+#ifdef CONFIG_SMP
 	.irq_cpu_offline	= bcm7038_l1_cpu_offline,
+#endif
 };
 
 static int bcm7038_l1_map(struct irq_domain *d, unsigned int virq,
-- 
2.13.2
