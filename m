Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 03 Jul 2014 15:25:31 +0200 (CEST)
Received: from mail-we0-f181.google.com ([74.125.82.181]:38015 "EHLO
        mail-we0-f181.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6861103AbaGCNXMwzQF6 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 3 Jul 2014 15:23:12 +0200
Received: by mail-we0-f181.google.com with SMTP id q59so233753wes.40
        for <linux-mips@linux-mips.org>; Thu, 03 Jul 2014 06:23:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=lWni2P81p+XjDgvMNNYnZ0cuuPtTs3cZzJyECaRZo0s=;
        b=CdnCeFIJSEIeOJP8MuwQj+04j8ptcIxnuxMD5zxjQFrSeQFRjmojedvR9CpHYhPoQY
         umaHIuLr620RGu2bA1td0vdt+rL68KwcCdrLkqNHNbGZaOGIPU2ea8o4mEEgc6y6PZ2c
         tFMnmn20/N8z7n0oqzwD2PgJB6uceFL6aE4CjcVDJHpN8/3348I/fT77mEtNJGaJ9xz5
         D9brwXzVI17AReImBKbAuG8V5tuIasFNlN079CQ5fNPegikr9mmtURJ3eVv7NUaR33tW
         49egLg4VMTNLeWCAlnW/7mnw8KHwqffGJfFbyVDQpdYtPrU5SesT9d6lgMd86sYFrLPr
         xbXA==
X-Received: by 10.180.14.196 with SMTP id r4mr49470576wic.2.1404393786408;
        Thu, 03 Jul 2014 06:23:06 -0700 (PDT)
Received: from localhost.localdomain (p57A34891.dip0.t-ipconnect.de. [87.163.72.145])
        by mx.google.com with ESMTPSA id ev9sm67079017wic.24.2014.07.03.06.23.05
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 03 Jul 2014 06:23:06 -0700 (PDT)
From:   Manuel Lauss <manuel.lauss@gmail.com>
To:     Linux-MIPS <linux-mips@linux-mips.org>,
        Mike Turquette <mturquette@linaro.org>
Cc:     linux-kernel@vger.kernel.org, Manuel Lauss <manuel.lauss@gmail.com>
Subject: [RFC PATCH v2 05/11] MIPS: Alchemy: pci: use clk framework to enable PCI clock
Date:   Thu,  3 Jul 2014 15:22:36 +0200
Message-Id: <1404393762-858019-6-git-send-email-manuel.lauss@gmail.com>
X-Mailer: git-send-email 2.0.0
In-Reply-To: <1404393762-858019-1-git-send-email-manuel.lauss@gmail.com>
References: <1404393762-858019-1-git-send-email-manuel.lauss@gmail.com>
Return-Path: <manuel.lauss@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 41001
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
 arch/mips/pci/pci-alchemy.c | 23 ++++++++++++++++++++++-
 1 file changed, 22 insertions(+), 1 deletion(-)

diff --git a/arch/mips/pci/pci-alchemy.c b/arch/mips/pci/pci-alchemy.c
index 912c5f2..adc810f 100644
--- a/arch/mips/pci/pci-alchemy.c
+++ b/arch/mips/pci/pci-alchemy.c
@@ -7,6 +7,7 @@
  * Support for all devices (greater than 16) added by David Gathright.
  */
 
+#include <linux/clk.h>
 #include <linux/export.h>
 #include <linux/types.h>
 #include <linux/pci.h>
@@ -365,6 +366,7 @@ static int alchemy_pci_probe(struct platform_device *pdev)
 	void __iomem *virt_io;
 	unsigned long val;
 	struct resource *r;
+	struct clk *c;
 	int ret;
 
 	/* need at least PCI IRQ mapping table */
@@ -394,11 +396,24 @@ static int alchemy_pci_probe(struct platform_device *pdev)
 		goto out1;
 	}
 
+	c = clk_get(&pdev->dev, "pci_clko");
+	if (IS_ERR(c)) {
+		dev_err(&pdev->dev, "unable to find PCI clock\n");
+		ret = PTR_ERR(c);
+		goto out2;
+	}
+	ret = clk_prepare_enable(c);
+	if (ret) {
+		dev_err(&pdev->dev, "cannot enable PCI clock\n");
+		clk_put(c);
+		goto out2;
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
@@ -466,12 +481,18 @@ static int alchemy_pci_probe(struct platform_device *pdev)
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
+	clk_put(c);
 out2:
 	release_mem_region(r->start, resource_size(r));
 out1:
-- 
2.0.0
