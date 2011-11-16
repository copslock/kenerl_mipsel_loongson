Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 16 Nov 2011 16:43:44 +0100 (CET)
Received: from mail-fx0-f49.google.com ([209.85.161.49]:60660 "EHLO
        mail-fx0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903834Ab1KPPmp (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 16 Nov 2011 16:42:45 +0100
Received: by faar25 with SMTP id r25so2091290faa.36
        for <multiple recipients>; Wed, 16 Nov 2011 07:42:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=WS2CNhfNfGv+vn9zJOfH8ypWTm2lqdMH09BJ2DPMCNs=;
        b=STKEuCAJSB+ok1sjAhmebU0NXgs42kXRvDfoTOxGbC75l2i7Or7c6z/x1kmSBNnAAS
         Bngif/p9CBjIELTLI9DmR3bW31mK9YdEcdjfQzPM6St1XZn9Sv9HhdHizJsenuc688Ad
         UoP/zX+hB1q0uE0Ykm7Z8A02n1CCcCtKkL8/I=
Received: by 10.152.0.138 with SMTP id 10mr20836514lae.3.1321458159927;
        Wed, 16 Nov 2011 07:42:39 -0800 (PST)
Received: from flagship.roarinelk.net (188-22-3-28.adsl.highway.telekom.at. [188.22.3.28])
        by mx.google.com with ESMTPS id pi7sm17044221lab.5.2011.11.16.07.42.38
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 16 Nov 2011 07:42:39 -0800 (PST)
From:   Manuel Lauss <manuel.lauss@googlemail.com>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     Linux-MIPS <linux-mips@linux-mips.org>,
        Manuel Lauss <manuel.lauss@googlemail.com>
Subject: [PATCH 3/3] MIPS: Alchemy: fix PCI PM
Date:   Wed, 16 Nov 2011 16:42:28 +0100
Message-Id: <1321458148-7894-3-git-send-email-manuel.lauss@googlemail.com>
X-Mailer: git-send-email 1.7.8.rc1
In-Reply-To: <1321458148-7894-1-git-send-email-manuel.lauss@googlemail.com>
References: <1321458148-7894-1-git-send-email-manuel.lauss@googlemail.com>
X-archive-position: 31676
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: manuel.lauss@googlemail.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 13531

Move PCI Controller PM to syscore_ops since the platform_driver PM methods
are called way too late on resume and far too early on suspend (after and
before PCI device resume/suspend).
This also allows to simplify wired entry management a bit.

Signed-off-by: Manuel Lauss <manuel.lauss@googlemail.com>
---
 arch/mips/pci/pci-alchemy.c |  137 +++++++++++++++++++++----------------------
 1 files changed, 67 insertions(+), 70 deletions(-)

diff --git a/arch/mips/pci/pci-alchemy.c b/arch/mips/pci/pci-alchemy.c
index b5ce041..b5eddf5 100644
--- a/arch/mips/pci/pci-alchemy.c
+++ b/arch/mips/pci/pci-alchemy.c
@@ -13,6 +13,7 @@
 #include <linux/platform_device.h>
 #include <linux/kernel.h>
 #include <linux/init.h>
+#include <linux/syscore_ops.h>
 #include <linux/vmalloc.h>
 
 #include <asm/mach-au1x00/au1000.h>
@@ -41,6 +42,12 @@ struct alchemy_pci_context {
 	int (*board_pci_idsel)(unsigned int devsel, int assert);
 };
 
+/* for syscore_ops. There's only one PCI controller on Alchemy chips, so this
+ * should suffice for now.
+ */
+static struct alchemy_pci_context *__alchemy_pci_ctx;
+
+
 /* IO/MEM resources for PCI. Keep the memres in sync with __fixup_bigphys_addr
  * in arch/mips/alchemy/common/setup.c
  */
@@ -99,18 +106,6 @@ static int config_access(unsigned char access_type, struct pci_bus *bus,
 		return -1;
 	}
 
-	/* YAMON on all db1xxx boards wipes the TLB and writes zero to C0_wired
-	 * on resume, clearing our wired entry.  Unfortunately the ->resume()
-	 * callback is called way way way too late (and ->suspend() too early)
-	 * to have them destroy and recreate it.  Instead just test if c0_wired
-	 * is now lower than the index we retrieved before suspending and then
-	 * recreate the entry if necessary.  Of course this is totally bonkers
-	 * and breaks as soon as someone else adds another wired entry somewhere
-	 * else.  Anyone have any ideas how to handle this better?
-	 */
-	if (unlikely(read_c0_wired() < ctx->wired_entry))
-		alchemy_pci_wired_entry(ctx);
-
 	local_irq_save(flags);
 	r = __raw_readl(ctx->regs + PCI_REG_STATCMD) & 0x0000ffff;
 	r |= PCI_STATCMD_STATUS(0x2000);
@@ -304,6 +299,62 @@ static int alchemy_pci_def_idsel(unsigned int devsel, int assert)
 	return 1;	/* success */
 }
 
+/* save PCI controller register contents. */
+static int alchemy_pci_suspend(void)
+{
+	struct alchemy_pci_context *ctx = __alchemy_pci_ctx;
+	if (!ctx)
+		return 0;
+
+	ctx->pm[0]  = __raw_readl(ctx->regs + PCI_REG_CMEM);
+	ctx->pm[1]  = __raw_readl(ctx->regs + PCI_REG_CONFIG) & 0x0009ffff;
+	ctx->pm[2]  = __raw_readl(ctx->regs + PCI_REG_B2BMASK_CCH);
+	ctx->pm[3]  = __raw_readl(ctx->regs + PCI_REG_B2BBASE0_VID);
+	ctx->pm[4]  = __raw_readl(ctx->regs + PCI_REG_B2BBASE1_SID);
+	ctx->pm[5]  = __raw_readl(ctx->regs + PCI_REG_MWMASK_DEV);
+	ctx->pm[6]  = __raw_readl(ctx->regs + PCI_REG_MWBASE_REV_CCL);
+	ctx->pm[7]  = __raw_readl(ctx->regs + PCI_REG_ID);
+	ctx->pm[8]  = __raw_readl(ctx->regs + PCI_REG_CLASSREV);
+	ctx->pm[9]  = __raw_readl(ctx->regs + PCI_REG_PARAM);
+	ctx->pm[10] = __raw_readl(ctx->regs + PCI_REG_MBAR);
+	ctx->pm[11] = __raw_readl(ctx->regs + PCI_REG_TIMEOUT);
+
+	return 0;
+}
+
+static void alchemy_pci_resume(void)
+{
+	struct alchemy_pci_context *ctx = __alchemy_pci_ctx;
+	if (!ctx)
+		return;
+
+	__raw_writel(ctx->pm[0],  ctx->regs + PCI_REG_CMEM);
+	__raw_writel(ctx->pm[2],  ctx->regs + PCI_REG_B2BMASK_CCH);
+	__raw_writel(ctx->pm[3],  ctx->regs + PCI_REG_B2BBASE0_VID);
+	__raw_writel(ctx->pm[4],  ctx->regs + PCI_REG_B2BBASE1_SID);
+	__raw_writel(ctx->pm[5],  ctx->regs + PCI_REG_MWMASK_DEV);
+	__raw_writel(ctx->pm[6],  ctx->regs + PCI_REG_MWBASE_REV_CCL);
+	__raw_writel(ctx->pm[7],  ctx->regs + PCI_REG_ID);
+	__raw_writel(ctx->pm[8],  ctx->regs + PCI_REG_CLASSREV);
+	__raw_writel(ctx->pm[9],  ctx->regs + PCI_REG_PARAM);
+	__raw_writel(ctx->pm[10], ctx->regs + PCI_REG_MBAR);
+	__raw_writel(ctx->pm[11], ctx->regs + PCI_REG_TIMEOUT);
+	wmb();
+	__raw_writel(ctx->pm[1],  ctx->regs + PCI_REG_CONFIG);
+	wmb();
+
+	/* YAMON on all db1xxx boards wipes the TLB and writes zero to C0_wired
+	 * on resume, making it necessary to recreate it as soon as possible.
+	 */
+	ctx->wired_entry = 8191;	/* impossibly high value */
+	alchemy_pci_wired_entry(ctx);	/* install it */
+}
+
+static struct syscore_ops alchemy_pci_pmops = {
+	.suspend	= alchemy_pci_suspend,
+	.resume		= alchemy_pci_resume,
+};
+
 static int __devinit alchemy_pci_probe(struct platform_device *pdev)
 {
 	struct alchemy_pci_platdata *pd = pdev->dev.platform_data;
@@ -396,7 +447,8 @@ static int __devinit alchemy_pci_probe(struct platform_device *pdev)
 		ret = -ENOMEM;
 		goto out4;
 	}
-	ctx->wired_entry = 8192;	/* impossibly high value */
+	ctx->wired_entry = 8191;	/* impossibly high value */
+	alchemy_pci_wired_entry(ctx);	/* install it */
 
 	set_io_port_base((unsigned long)ctx->alchemy_pci_ctrl.io_map_base);
 
@@ -408,7 +460,9 @@ static int __devinit alchemy_pci_probe(struct platform_device *pdev)
 	__raw_writel(val, ctx->regs + PCI_REG_CONFIG);
 	wmb();
 
+	__alchemy_pci_ctx = ctx;
 	platform_set_drvdata(pdev, ctx);
+	register_syscore_ops(&alchemy_pci_pmops);
 	register_pci_controller(&ctx->alchemy_pci_ctrl);
 
 	return 0;
@@ -425,68 +479,11 @@ out:
 	return ret;
 }
 
-
-#ifdef CONFIG_PM
-/* save PCI controller register contents. */
-static int alchemy_pci_suspend(struct device *dev)
-{
-	struct alchemy_pci_context *ctx = dev_get_drvdata(dev);
-
-	ctx->pm[0]  = __raw_readl(ctx->regs + PCI_REG_CMEM);
-	ctx->pm[1]  = __raw_readl(ctx->regs + PCI_REG_CONFIG) & 0x0009ffff;
-	ctx->pm[2]  = __raw_readl(ctx->regs + PCI_REG_B2BMASK_CCH);
-	ctx->pm[3]  = __raw_readl(ctx->regs + PCI_REG_B2BBASE0_VID);
-	ctx->pm[4]  = __raw_readl(ctx->regs + PCI_REG_B2BBASE1_SID);
-	ctx->pm[5]  = __raw_readl(ctx->regs + PCI_REG_MWMASK_DEV);
-	ctx->pm[6]  = __raw_readl(ctx->regs + PCI_REG_MWBASE_REV_CCL);
-	ctx->pm[7]  = __raw_readl(ctx->regs + PCI_REG_ID);
-	ctx->pm[8]  = __raw_readl(ctx->regs + PCI_REG_CLASSREV);
-	ctx->pm[9]  = __raw_readl(ctx->regs + PCI_REG_PARAM);
-	ctx->pm[10] = __raw_readl(ctx->regs + PCI_REG_MBAR);
-	ctx->pm[11] = __raw_readl(ctx->regs + PCI_REG_TIMEOUT);
-
-	return 0;
-}
-
-static int alchemy_pci_resume(struct device *dev)
-{
-	struct alchemy_pci_context *ctx = dev_get_drvdata(dev);
-
-	__raw_writel(ctx->pm[0],  ctx->regs + PCI_REG_CMEM);
-	__raw_writel(ctx->pm[2],  ctx->regs + PCI_REG_B2BMASK_CCH);
-	__raw_writel(ctx->pm[3],  ctx->regs + PCI_REG_B2BBASE0_VID);
-	__raw_writel(ctx->pm[4],  ctx->regs + PCI_REG_B2BBASE1_SID);
-	__raw_writel(ctx->pm[5],  ctx->regs + PCI_REG_MWMASK_DEV);
-	__raw_writel(ctx->pm[6],  ctx->regs + PCI_REG_MWBASE_REV_CCL);
-	__raw_writel(ctx->pm[7],  ctx->regs + PCI_REG_ID);
-	__raw_writel(ctx->pm[8],  ctx->regs + PCI_REG_CLASSREV);
-	__raw_writel(ctx->pm[9],  ctx->regs + PCI_REG_PARAM);
-	__raw_writel(ctx->pm[10], ctx->regs + PCI_REG_MBAR);
-	__raw_writel(ctx->pm[11], ctx->regs + PCI_REG_TIMEOUT);
-	wmb();
-	__raw_writel(ctx->pm[1],  ctx->regs + PCI_REG_CONFIG);
-	wmb();
-
-	return 0;
-}
-
-static const struct dev_pm_ops alchemy_pci_pmops = {
-	.suspend	= alchemy_pci_suspend,
-	.resume		= alchemy_pci_resume,
-};
-
-#define ALCHEMY_PCICTL_PM	(&alchemy_pci_pmops)
-
-#else
-#define ALCHEMY_PCICTL_PM	NULL
-#endif
-
 static struct platform_driver alchemy_pcictl_driver = {
 	.probe		= alchemy_pci_probe,
 	.driver	= {
 		.name	= "alchemy-pci",
 		.owner	= THIS_MODULE,
-		.pm	= ALCHEMY_PCICTL_PM,
 	},
 };
 
-- 
1.7.8.rc1
