Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 11 Mar 2013 08:42:43 +0100 (CET)
Received: from mail-we0-f178.google.com ([74.125.82.178]:36377 "EHLO
        mail-we0-f178.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6823668Ab3CKHmmxncpa (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 11 Mar 2013 08:42:42 +0100
Received: by mail-we0-f178.google.com with SMTP id o45so3126104wer.37
        for <multiple recipients>; Mon, 11 Mar 2013 00:42:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer;
        bh=SEPmgOT2Iq4mDz8GWKIHHMaoUpn6QPT/p5wmF8+1UOM=;
        b=084tD4rk5e/5/+NU6X+yjukj7xUH0TV2AaRMQtynOLevpaTzZymHjw0CNBf1ElKR20
         bFlQKVNfKG6VTTrNCZSdwUq04I1CXBP1J1BzZsOeZICsaH06TZRrKrambVE8pIS6a0GC
         Aau6VqbezXP12HN5+ry1NWhTwpsM2BOu1Z4VDXSUqP0uZg5zMI3WHKiH7szHqjDVMFQb
         2OQBzU1OifVUvElokAPJEqSRXsiskEX5tqOrjikaJDNZLcTW9zOFjijD5ZcxdOQyeMX+
         oQVQ19e7DvziEk+KE1FT1CHjn2mNYNABF6gLuvJLHF0bmAywQKhbdtPsg1B2hRyD+qsW
         FKXg==
X-Received: by 10.194.9.166 with SMTP id a6mr17093654wjb.2.1362987757163;
        Mon, 11 Mar 2013 00:42:37 -0700 (PDT)
Received: from localhost.localdomain (p5.eregie.pub.ro. [141.85.0.105])
        by mx.google.com with ESMTPS id n2sm6340406wiy.6.2013.03.11.00.42.35
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Mon, 11 Mar 2013 00:42:36 -0700 (PDT)
From:   Silviu-Mihai Popescu <silviupopescu1990@gmail.com>
To:     linux-mips@linux-mips.org
Cc:     ralf@linux-mips.org, juhosg@openwrt.org, blogic@openwrt.org,
        xsecute@googlemail.com, linux-kernel@vger.kernel.org,
        Silviu-Mihai Popescu <silviupopescu1990@gmail.com>
Subject: [PATCH] pci: convert to devm_ioremap_resource()
Date:   Mon, 11 Mar 2013 09:42:33 +0200
Message-Id: <1362987753-6607-1-git-send-email-silviupopescu1990@gmail.com>
X-Mailer: git-send-email 1.7.9.5
X-archive-position: 35862
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
 arch/mips/pci/pci-ar724x.c |   18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

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
