Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 19 Aug 2013 10:52:39 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr ([192.134.164.83]:34202 "EHLO
        mail2-relais-roc.national.inria.fr" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6817548Ab3HSIwEOmI1X (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 19 Aug 2013 10:52:04 +0200
X-IronPort-AV: E=Sophos;i="4.89,912,1367964000"; 
   d="scan'208";a="29716862"
Received: from palace.lip6.fr (HELO localhost.localdomain) ([132.227.105.202])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-SHA; 19 Aug 2013 10:51:58 +0200
From:   Julia Lawall <Julia.Lawall@lip6.fr>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     kernel-janitors@vger.kernel.org, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 6/6] MIPS: ath79: simplify platform_get_resource_byname/devm_ioremap_resource
Date:   Mon, 19 Aug 2013 10:51:56 +0200
Message-Id: <1376902316-18520-7-git-send-email-Julia.Lawall@lip6.fr>
X-Mailer: git-send-email 1.7.8.6
In-Reply-To: <1376902316-18520-1-git-send-email-Julia.Lawall@lip6.fr>
References: <1376902316-18520-1-git-send-email-Julia.Lawall@lip6.fr>
Return-Path: <Julia.Lawall@lip6.fr>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 37584
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: Julia.Lawall@lip6.fr
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

From: Julia Lawall <Julia.Lawall@lip6.fr>

Remove unneeded error handling on the result of a call to
platform_get_resource_byname when the value is passed to devm_ioremap_resource.

A simplified version of the semantic patch that makes this change is as
follows: (http://coccinelle.lip6.fr/)

// <smpl>
@@
expression pdev,res,e,e1;
expression ret != 0;
identifier l;
@@

  res = platform_get_resource_byname(...);
- if (res == NULL) { ... \(goto l;\|return ret;\) }
  e = devm_ioremap_resource(e1, res);
// </smpl>

Signed-off-by: Julia Lawall <Julia.Lawall@lip6.fr>

---
 arch/mips/pci/pci-ar71xx.c |    3 ---
 arch/mips/pci/pci-ar724x.c |    9 ---------
 2 files changed, 12 deletions(-)

diff --git a/arch/mips/pci/pci-ar71xx.c b/arch/mips/pci/pci-ar71xx.c
index 18517dd..d471a26 100644
--- a/arch/mips/pci/pci-ar71xx.c
+++ b/arch/mips/pci/pci-ar71xx.c
@@ -363,9 +363,6 @@ static int ar71xx_pci_probe(struct platform_device *pdev)
 	spin_lock_init(&apc->lock);
 
 	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "cfg_base");
-	if (!res)
-		return -EINVAL;
-
 	apc->cfg_base = devm_ioremap_resource(&pdev->dev, res);
 	if (IS_ERR(apc->cfg_base))
 		return PTR_ERR(apc->cfg_base);
diff --git a/arch/mips/pci/pci-ar724x.c b/arch/mips/pci/pci-ar724x.c
index 65ec032..785b265 100644
--- a/arch/mips/pci/pci-ar724x.c
+++ b/arch/mips/pci/pci-ar724x.c
@@ -362,25 +362,16 @@ static int ar724x_pci_probe(struct platform_device *pdev)
 		return -ENOMEM;
 
 	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "ctrl_base");
-	if (!res)
-		return -EINVAL;
-
 	apc->ctrl_base = devm_ioremap_resource(&pdev->dev, res);
 	if (IS_ERR(apc->ctrl_base))
 		return PTR_ERR(apc->ctrl_base);
 
 	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "cfg_base");
-	if (!res)
-		return -EINVAL;
-
 	apc->devcfg_base = devm_ioremap_resource(&pdev->dev, res);
 	if (IS_ERR(apc->devcfg_base))
 		return PTR_ERR(apc->devcfg_base);
 
 	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "crp_base");
-	if (!res)
-		return -EINVAL;
-
 	apc->crp_base = devm_ioremap_resource(&pdev->dev, res);
 	if (IS_ERR(apc->crp_base))
 		return PTR_ERR(apc->crp_base);
