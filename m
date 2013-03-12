Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 12 Mar 2013 08:28:11 +0100 (CET)
Received: from mail-we0-f176.google.com ([74.125.82.176]:35004 "EHLO
        mail-we0-f176.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6816671Ab3CLH2KiauV6 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 12 Mar 2013 08:28:10 +0100
Received: by mail-we0-f176.google.com with SMTP id s43so4245347wey.21
        for <multiple recipients>; Tue, 12 Mar 2013 00:28:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer;
        bh=//w1vSHI6EHpF2BjiyERot35VPqYiZDdTgScXakeSxc=;
        b=ilyvQn6/eAiRETuQuaS5hP8tvMKFf1IR0OI960EgO1rzIn4K2t5yUOvTssKf0SGG/i
         JgaFiFDg18EtPhfMTWv5egaYzidCxMDN0sjz1Ehl1uOEbG7ooRPEN2YlxlAu3ODTXJTE
         Exkjdf9bOoMl0kgnfbAOcTwyMBakkhoFgm2R4sHSVzh5u/re+S704aYrv4LKQOlhrLd7
         NT8wWI50WSD5inAlgYk7J7bveuKx3q4c0jDOILT3PJl3EFPB4f4w3cgX2CtI/dj1gcHZ
         0U0L0uiaXYpSyf32PlsGoaIRlZGHPpL9SxBPxK7QCJ+V03GvyMgQYnaKQiVo7PzoZQIW
         gQzA==
X-Received: by 10.194.84.8 with SMTP id u8mr24352302wjy.29.1363073285195;
        Tue, 12 Mar 2013 00:28:05 -0700 (PDT)
Received: from localhost.localdomain (p5.eregie.pub.ro. [141.85.0.105])
        by mx.google.com with ESMTPS id fg6sm22050790wib.10.2013.03.12.00.28.03
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Tue, 12 Mar 2013 00:28:04 -0700 (PDT)
From:   Silviu-Mihai Popescu <silviupopescu1990@gmail.com>
To:     linux-mips@linux-mips.org
Cc:     ralf@linux-mips.org, juhosg@openwrt.org, blogic@openwrt.org,
        kaloz@openwrt.org, xsecute@googlemail.com,
        linux-kernel@vger.kernel.org,
        Silviu-Mihai Popescu <silviupopescu1990@gmail.com>
Subject: [PATCH v2] pci: convert to devm_ioremap_resource()
Date:   Tue, 12 Mar 2013 09:28:00 +0200
Message-Id: <1363073281-9939-1-git-send-email-silviupopescu1990@gmail.com>
X-Mailer: git-send-email 1.7.9.5
X-archive-position: 35869
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: silviupopescu1990@gmail.com
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
Return-Path: <linux-mips-bounce@linux-mips.org>

Convert all uses of devm_request_and_ioremap() to the newly introduced
devm_ioremap_resource() which provides more consistent error handling.

devm_ioremap_resource() provides its own error messages so all explicit
error messages can be removed from the failure code paths.

Signed-off-by: Silviu-Mihai Popescu <silviupopescu1990@gmail.com>
---
 arch/mips/pci/pci-ar71xx.c |    6 +++---
 arch/mips/pci/pci-ar724x.c |   18 +++++++++---------
 2 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/arch/mips/pci/pci-ar71xx.c b/arch/mips/pci/pci-ar71xx.c
index 412ec02..18517dd 100644
--- a/arch/mips/pci/pci-ar71xx.c
+++ b/arch/mips/pci/pci-ar71xx.c
@@ -366,9 +366,9 @@ static int ar71xx_pci_probe(struct platform_device *pdev)
 	if (!res)
 		return -EINVAL;
 
-	apc->cfg_base = devm_request_and_ioremap(&pdev->dev, res);
-	if (!apc->cfg_base)
-		return -ENOMEM;
+	apc->cfg_base = devm_ioremap_resource(&pdev->dev, res);
+	if (IS_ERR(apc->cfg_base))
+		return PTR_ERR(apc->cfg_base);
 
 	apc->irq = platform_get_irq(pdev, 0);
 	if (apc->irq < 0)
diff --git a/arch/mips/pci/pci-ar724x.c b/arch/mips/pci/pci-ar724x.c
index 8a0700d..65ec032 100644
--- a/arch/mips/pci/pci-ar724x.c
+++ b/arch/mips/pci/pci-ar724x.c
@@ -365,25 +365,25 @@ static int ar724x_pci_probe(struct platform_device *pdev)
 	if (!res)
 		return -EINVAL;
 
-	apc->ctrl_base = devm_request_and_ioremap(&pdev->dev, res);
-	if (apc->ctrl_base == NULL)
-		return -EBUSY;
+	apc->ctrl_base = devm_ioremap_resource(&pdev->dev, res);
+	if (IS_ERR(apc->ctrl_base))
+		return PTR_ERR(apc->ctrl_base);
 
 	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "cfg_base");
 	if (!res)
 		return -EINVAL;
 
-	apc->devcfg_base = devm_request_and_ioremap(&pdev->dev, res);
-	if (!apc->devcfg_base)
-		return -EBUSY;
+	apc->devcfg_base = devm_ioremap_resource(&pdev->dev, res);
+	if (IS_ERR(apc->devcfg_base))
+		return PTR_ERR(apc->devcfg_base);
 
 	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "crp_base");
 	if (!res)
 		return -EINVAL;
 
-	apc->crp_base = devm_request_and_ioremap(&pdev->dev, res);
-	if (apc->crp_base == NULL)
-		return -EBUSY;
+	apc->crp_base = devm_ioremap_resource(&pdev->dev, res);
+	if (IS_ERR(apc->crp_base))
+		return PTR_ERR(apc->crp_base);
 
 	apc->irq = platform_get_irq(pdev, 0);
 	if (apc->irq < 0)
-- 
1.7.9.5
