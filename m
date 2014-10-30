Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 30 Oct 2014 03:24:55 +0100 (CET)
Received: from mail-pd0-f171.google.com ([209.85.192.171]:39331 "EHLO
        mail-pd0-f171.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27012266AbaJ3CUJoYeLp (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 30 Oct 2014 03:20:09 +0100
Received: by mail-pd0-f171.google.com with SMTP id r10so4160933pdi.30
        for <multiple recipients>; Wed, 29 Oct 2014 19:20:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=l0UW4vjW5BTXEkBSI9xBmNpRZZKZl6xrpgccFpmfzvc=;
        b=rJ+mjn/m//kNOC9bv22pJivEGh9Cff7OpE8wqfE4gV4R3xrz+6RuyAWCuwRaP/W7UX
         WGK09Ftc4j+4zgRoRH401EIgBrY8cy9KiRzNJuu1+BhElVCk68Sx6xmKQh3KSTaB7DMN
         0U9Ec3wOGPrWBUpUIZceypsn0rKEoV7MctH5jP3TsckPJnM8kKCZtgS4QAygzjnYXvEY
         +gjlWgb7F+9DcSXu3YDCPURU7LSYI/5oD3BjIZGInwxm4oaRpKlcetNtop8duL8ptmkl
         W9Q5Tq0gcURRDZIW2Wnd11ekOsZvanTc3XsTbd8sN2Mxrtk61W+sO6p0r6Va2oha5AWg
         aQ6g==
X-Received: by 10.68.235.103 with SMTP id ul7mr14062826pbc.63.1414635601843;
        Wed, 29 Oct 2014 19:20:01 -0700 (PDT)
Received: from localhost (b32.net. [192.81.132.72])
        by mx.google.com with ESMTPSA id d17sm5524269pdj.32.2014.10.29.19.20.00
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Wed, 29 Oct 2014 19:20:01 -0700 (PDT)
From:   Kevin Cernekee <cernekee@gmail.com>
To:     arnd@arndb.de, f.fainelli@gmail.com, tglx@linutronix.de,
        jason@lakedaemon.net, ralf@linux-mips.org, lethal@linux-sh.org
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        mbizon@freebox.fr, jogo@openwrt.org, linux-mips@linux-mips.org
Subject: [PATCH V2 15/15] irqchip: bcm7120-l2: Enable big endian register accesses on BE kernels
Date:   Wed, 29 Oct 2014 19:18:08 -0700
Message-Id: <1414635488-14137-16-git-send-email-cernekee@gmail.com>
X-Mailer: git-send-email 2.1.1
In-Reply-To: <1414635488-14137-1-git-send-email-cernekee@gmail.com>
References: <1414635488-14137-1-git-send-email-cernekee@gmail.com>
Return-Path: <cernekee@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 43754
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: cernekee@gmail.com
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

On all supported SoCs, the kernel will be built with CONFIG_CPU_BIG_ENDIAN
iff the CPU is running in BE mode.  Leverage this fact to autodetect
the MMIO byte ordering to use in generic-chip.c.

Signed-off-by: Kevin Cernekee <cernekee@gmail.com>
---
 drivers/irqchip/Kconfig          | 2 ++
 drivers/irqchip/irq-bcm7120-l2.c | 9 ++++++---
 2 files changed, 8 insertions(+), 3 deletions(-)

diff --git a/drivers/irqchip/Kconfig b/drivers/irqchip/Kconfig
index afdc1f3..db44694 100644
--- a/drivers/irqchip/Kconfig
+++ b/drivers/irqchip/Kconfig
@@ -51,11 +51,13 @@ config ATMEL_AIC5_IRQ
 config BCM7120_L2_IRQ
 	bool
 	select GENERIC_IRQ_CHIP
+	select GENERIC_IRQ_CHIP_BE
 	select IRQ_DOMAIN
 
 config BRCMSTB_L2_IRQ
 	bool
 	select GENERIC_IRQ_CHIP
+	select GENERIC_IRQ_CHIP_BE
 	select IRQ_DOMAIN
 
 config DW_APB_ICTL
diff --git a/drivers/irqchip/irq-bcm7120-l2.c b/drivers/irqchip/irq-bcm7120-l2.c
index e53a3a6..5324249 100644
--- a/drivers/irqchip/irq-bcm7120-l2.c
+++ b/drivers/irqchip/irq-bcm7120-l2.c
@@ -132,7 +132,7 @@ int __init bcm7120_l2_intc_of_init(struct device_node *dn,
 	const __be32 *map_mask;
 	int num_parent_irqs;
 	int ret = 0, len;
-	unsigned int idx, irq;
+	unsigned int idx, irq, flags;
 
 	data = kzalloc(sizeof(*data), GFP_KERNEL);
 	if (!data)
@@ -195,9 +195,12 @@ int __init bcm7120_l2_intc_of_init(struct device_node *dn,
 		goto out_unmap;
 	}
 
+	flags = IRQ_GC_INIT_MASK_CACHE;
+	if (IS_ENABLED(CONFIG_CPU_BIG_ENDIAN))
+		flags |= IRQ_GC_BE_IO;
+
 	ret = irq_alloc_domain_generic_chips(data->domain, IRQS_PER_WORD, 1,
-				dn->full_name, handle_level_irq, clr, 0,
-				IRQ_GC_INIT_MASK_CACHE);
+				dn->full_name, handle_level_irq, clr, 0, flags);
 	if (ret) {
 		pr_err("failed to allocate generic irq chip\n");
 		goto out_free_domain;
-- 
2.1.1
