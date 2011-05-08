Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 08 May 2011 10:44:42 +0200 (CEST)
Received: from mail-ww0-f43.google.com ([74.125.82.43]:49933 "EHLO
        mail-ww0-f43.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491037Ab1EHImf (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 8 May 2011 10:42:35 +0200
Received: by wwb17 with SMTP id 17so3946490wwb.24
        for <linux-mips@linux-mips.org>; Sun, 08 May 2011 01:42:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :in-reply-to:references;
        bh=t+7IHzt2g7AEZV7M1GxKA4VwDcTC6m+aPRMTNRAv8u0=;
        b=IW4aStJ1Ws/+WOg0funAq9NOC85nrIfxqq1LHuOEpyoWWMakyRoTZAg0rj71M/vUHs
         Z3y2zN8ffUP7RZ76TuH/4GnHs1IyheHJZqy/Elhrib8jc1r5/H0rr+6eTLDRGCJxGByU
         5v8eE1n5RnLDNOi6YKZl4Brb2V18mjzuE/oz0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=REYfU149ushQ8QfG+ZYN/fiXFPiYhbHLVNDcHNyymn5E1RaOzsH++acNWKNqkIXwLK
         FgasM21jyOvhN6JKSB2QUuis755iPsvyWlKfwtcF59ojsSaVDHcsTVLIhfzFtxNYRcXG
         CNEePQv8PBkKQmiU+07tO5NN876bTAxuoqljE=
Received: by 10.227.201.13 with SMTP id ey13mr4182662wbb.57.1304844149504;
        Sun, 08 May 2011 01:42:29 -0700 (PDT)
Received: from localhost.localdomain (178-191-5-255.adsl.highway.telekom.at [178.191.5.255])
        by mx.google.com with ESMTPS id z9sm3022884wbx.34.2011.05.08.01.42.28
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 08 May 2011 01:42:29 -0700 (PDT)
From:   Manuel Lauss <manuel.lauss@googlemail.com>
To:     Linux-MIPS <linux-mips@linux-mips.org>
Cc:     Florian Fainelli <florian@openwrt.org>,
        Wolfgang Grandegger <wg@grandegger.com>,
        Manuel Lauss <manuel.lauss@googlemail.com>
Subject: [PATCH 4/9] MIPS: Alchemy: convert irq.c to syscore_ops.
Date:   Sun,  8 May 2011 10:42:15 +0200
Message-Id: <1304844140-3259-5-git-send-email-manuel.lauss@googlemail.com>
X-Mailer: git-send-email 1.7.5.rc3
In-Reply-To: <1304844140-3259-1-git-send-email-manuel.lauss@googlemail.com>
References: <1304844140-3259-1-git-send-email-manuel.lauss@googlemail.com>
Return-Path: <manuel.lauss@googlemail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 29871
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: manuel.lauss@googlemail.com
Precedence: bulk
X-list: linux-mips

convert the PM sysdev to use syscore_ops instead.

Signed-off-by: Manuel Lauss <manuel.lauss@googlemail.com>
---
 arch/mips/alchemy/common/irq.c |  101 ++++++++++++++++------------------------
 1 files changed, 41 insertions(+), 60 deletions(-)

diff --git a/arch/mips/alchemy/common/irq.c b/arch/mips/alchemy/common/irq.c
index b72e128..8b60ba0 100644
--- a/arch/mips/alchemy/common/irq.c
+++ b/arch/mips/alchemy/common/irq.c
@@ -30,7 +30,7 @@
 #include <linux/interrupt.h>
 #include <linux/irq.h>
 #include <linux/slab.h>
-#include <linux/sysdev.h>
+#include <linux/syscore_ops.h>
 
 #include <asm/irq_cpu.h>
 #include <asm/mipsregs.h>
@@ -585,81 +585,62 @@ void __init arch_init_irq(void)
 	}
 }
 
-struct alchemy_ic_sysdev {
-	struct sys_device sysdev;
-	void __iomem *base;
-	unsigned long pmdata[7];
-};
-
-static int alchemy_ic_suspend(struct sys_device *dev, pm_message_t state)
-{
-	struct alchemy_ic_sysdev *icdev =
-			container_of(dev, struct alchemy_ic_sysdev, sysdev);
 
-	icdev->pmdata[0] = __raw_readl(icdev->base + IC_CFG0RD);
-	icdev->pmdata[1] = __raw_readl(icdev->base + IC_CFG1RD);
-	icdev->pmdata[2] = __raw_readl(icdev->base + IC_CFG2RD);
-	icdev->pmdata[3] = __raw_readl(icdev->base + IC_SRCRD);
-	icdev->pmdata[4] = __raw_readl(icdev->base + IC_ASSIGNRD);
-	icdev->pmdata[5] = __raw_readl(icdev->base + IC_WAKERD);
-	icdev->pmdata[6] = __raw_readl(icdev->base + IC_MASKRD);
+static unsigned long alchemy_ic_pmdata[7 * 2];
 
-	return 0;
+static inline void alchemy_ic_suspend_one(void __iomem *base, unsigned long *d)
+{
+	d[0] = __raw_readl(base + IC_CFG0RD);
+	d[1] = __raw_readl(base + IC_CFG1RD);
+	d[2] = __raw_readl(base + IC_CFG2RD);
+	d[3] = __raw_readl(base + IC_SRCRD);
+	d[4] = __raw_readl(base + IC_ASSIGNRD);
+	d[5] = __raw_readl(base + IC_WAKERD);
+	d[6] = __raw_readl(base + IC_MASKRD);
+	ic_init(base);		/* shut it up too while at it */
 }
 
-static int alchemy_ic_resume(struct sys_device *dev)
+static inline void alchemy_ic_resume_one(void __iomem *base, unsigned long *d)
 {
-	struct alchemy_ic_sysdev *icdev =
-			container_of(dev, struct alchemy_ic_sysdev, sysdev);
-
-	ic_init(icdev->base);
-
-	__raw_writel(icdev->pmdata[0], icdev->base + IC_CFG0SET);
-	__raw_writel(icdev->pmdata[1], icdev->base + IC_CFG1SET);
-	__raw_writel(icdev->pmdata[2], icdev->base + IC_CFG2SET);
-	__raw_writel(icdev->pmdata[3], icdev->base + IC_SRCSET);
-	__raw_writel(icdev->pmdata[4], icdev->base + IC_ASSIGNSET);
-	__raw_writel(icdev->pmdata[5], icdev->base + IC_WAKESET);
+	ic_init(base);
+
+	__raw_writel(d[0], base + IC_CFG0SET);
+	__raw_writel(d[1], base + IC_CFG1SET);
+	__raw_writel(d[2], base + IC_CFG2SET);
+	__raw_writel(d[3], base + IC_SRCSET);
+	__raw_writel(d[4], base + IC_ASSIGNSET);
+	__raw_writel(d[5], base + IC_WAKESET);
 	wmb();
 
-	__raw_writel(icdev->pmdata[6], icdev->base + IC_MASKSET);
+	__raw_writel(d[6], base + IC_MASKSET);
 	wmb();
+}
 
+static int alchemy_ic_suspend(void)
+{
+	alchemy_ic_suspend_one((void __iomem *)KSEG1ADDR(AU1000_IC0_PHYS_ADDR),
+			       alchemy_ic_pmdata);
+	alchemy_ic_suspend_one((void __iomem *)KSEG1ADDR(AU1000_IC1_PHYS_ADDR),
+			       &alchemy_ic_pmdata[7]);
 	return 0;
 }
 
-static struct sysdev_class alchemy_ic_sysdev_class = {
-	.name		= "ic",
+static void alchemy_ic_resume(void)
+{
+	alchemy_ic_resume_one((void __iomem *)KSEG1ADDR(AU1000_IC1_PHYS_ADDR),
+			      &alchemy_ic_pmdata[7]);
+	alchemy_ic_resume_one((void __iomem *)KSEG1ADDR(AU1000_IC0_PHYS_ADDR),
+			      alchemy_ic_pmdata);
+}
+
+static struct syscore_ops alchemy_ic_syscore_ops = {
 	.suspend	= alchemy_ic_suspend,
 	.resume		= alchemy_ic_resume,
 };
 
-static int __init alchemy_ic_sysdev_init(void)
+static int __init alchemy_ic_pm_init(void)
 {
-	struct alchemy_ic_sysdev *icdev;
-	unsigned long icbase[2] = { AU1000_IC0_PHYS_ADDR, AU1000_IC1_PHYS_ADDR };
-	int err, i;
-
-	err = sysdev_class_register(&alchemy_ic_sysdev_class);
-	if (err)
-		return err;
-
-	for (i = 0; i < 2; i++) {
-		icdev = kzalloc(sizeof(struct alchemy_ic_sysdev), GFP_KERNEL);
-		if (!icdev)
-			return -ENOMEM;
-
-		icdev->base = ioremap(icbase[i], 0x1000);
-
-		icdev->sysdev.id = i;
-		icdev->sysdev.cls = &alchemy_ic_sysdev_class;
-		err = sysdev_register(&icdev->sysdev);
-		if (err) {
-			kfree(icdev);
-			return err;
-		}
-	}
-
+	register_syscore_ops(&alchemy_ic_syscore_ops);
 	return 0;
 }
-device_initcall(alchemy_ic_sysdev_init);
+device_initcall(alchemy_ic_pm_init);
-- 
1.7.5.rc3
