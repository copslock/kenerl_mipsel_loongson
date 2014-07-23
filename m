Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 23 Jul 2014 16:43:01 +0200 (CEST)
Received: from mail-we0-f177.google.com ([74.125.82.177]:51919 "EHLO
        mail-we0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6842536AbaGWOhazQItI (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 23 Jul 2014 16:37:30 +0200
Received: by mail-we0-f177.google.com with SMTP id w62so1266233wes.22
        for <linux-mips@linux-mips.org>; Wed, 23 Jul 2014 07:37:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=y3zNH0c92ObXbampkDxyjOREqMJjx+Lkwq+iGsrGCd0=;
        b=DiTq1nWmLnL8BZsTOGqdp7sGe6srSnZxduUXgzy5QA6nKt+vsp/HpWvbT9E0I4AtPJ
         wyL0NlA5zCcr9nS8Ep2PNTiSpDovpTSQZa5ShLAJ1pGY+Q/zi02dGqjoUex0bZiF4LWs
         mlAwQTUJJZ34KTNhn+Euk4scJzPh2GhPwy2CW+pRuRcLoigwE/N6/xW/Cy/Kv5TTjYBM
         jTF5y/t4naYm1bIs8A3tsYYU27wsV4c9cjuDpBmN0nH31N+IF5u5kys3zQv/ubwgY+Y4
         mJqh9ysOP4Gcqjud2RmVR5kZODsqLGC3m5h6v5SP0ZBVwlQDx81L51BZX++VDL6lVHxy
         350w==
X-Received: by 10.194.123.105 with SMTP id lz9mr2531632wjb.122.1406126238017;
        Wed, 23 Jul 2014 07:37:18 -0700 (PDT)
Received: from localhost.localdomain (p57A349C7.dip0.t-ipconnect.de. [87.163.73.199])
        by mx.google.com with ESMTPSA id ex4sm10196560wic.2.2014.07.23.07.37.17
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 23 Jul 2014 07:37:17 -0700 (PDT)
From:   Manuel Lauss <manuel.lauss@gmail.com>
To:     Linux-MIPS <linux-mips@linux-mips.org>
Cc:     Manuel Lauss <manuel.lauss@gmail.com>
Subject: [PATCH 04/10] MIPS: Alchemy: pci: use clk framework to enable PCI clock
Date:   Wed, 23 Jul 2014 16:36:51 +0200
Message-Id: <1406126217-471265-5-git-send-email-manuel.lauss@gmail.com>
X-Mailer: git-send-email 2.0.1
In-Reply-To: <1406126217-471265-1-git-send-email-manuel.lauss@gmail.com>
References: <1406126217-471265-1-git-send-email-manuel.lauss@gmail.com>
Return-Path: <manuel.lauss@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 41542
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: manuel.lauss@gmail.com
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

Use the clock framework to get at the PCI clock source and enable
it on driver initialization.

Signed-off-by: Manuel Lauss <manuel.lauss@gmail.com>
---
 arch/mips/pci/pci-alchemy.c | 24 +++++++++++++++++++++++-
 1 file changed, 23 insertions(+), 1 deletion(-)

diff --git a/arch/mips/pci/pci-alchemy.c b/arch/mips/pci/pci-alchemy.c
index 563d1f6..c19600a 100644
--- a/arch/mips/pci/pci-alchemy.c
+++ b/arch/mips/pci/pci-alchemy.c
@@ -7,6 +7,7 @@
  * Support for all devices (greater than 16) added by David Gathright.
  */
 
+#include <linux/clk.h>
 #include <linux/export.h>
 #include <linux/types.h>
 #include <linux/pci.h>
@@ -364,6 +365,7 @@ static int alchemy_pci_probe(struct platform_device *pdev)
 	void __iomem *virt_io;
 	unsigned long val;
 	struct resource *r;
+	struct clk *c;
 	int ret;
 
 	/* need at least PCI IRQ mapping table */
@@ -393,11 +395,24 @@ static int alchemy_pci_probe(struct platform_device *pdev)
 		goto out1;
 	}
 
+	c = clk_get(&pdev->dev, "pci_clko");
+	if (IS_ERR(c)) {
+		dev_err(&pdev->dev, "unable to find PCI clock\n");
+		ret = PTR_ERR(c);
+		goto out2;
+	}
+
+	ret = clk_prepare_enable(c);
+	if (ret) {
+		dev_err(&pdev->dev, "cannot enable PCI clock\n");
+		goto out6;
+	}
+
 	ctx->regs = ioremap_nocache(r->start, resource_size(r));
 	if (!ctx->regs) {
 		dev_err(&pdev->dev, "cannot map pci regs\n");
 		ret = -ENODEV;
-		goto out2;
+		goto out5;
 	}
 
 	/* map parts of the PCI IO area */
@@ -465,12 +480,19 @@ static int alchemy_pci_probe(struct platform_device *pdev)
 	register_syscore_ops(&alchemy_pci_pmops);
 	register_pci_controller(&ctx->alchemy_pci_ctrl);
 
+	dev_info(&pdev->dev, "PCI controller at %ld MHz\n",
+		 clk_get_rate(c) / 1000000);
+
 	return 0;
 
 out4:
 	iounmap(virt_io);
 out3:
 	iounmap(ctx->regs);
+out5:
+	clk_disable_unprepare(c);
+out6:
+	clk_put(c);
 out2:
 	release_mem_region(r->start, resource_size(r));
 out1:
-- 
2.0.1
