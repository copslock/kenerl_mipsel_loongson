Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 16 Aug 2017 06:58:43 +0200 (CEST)
Received: from smtp10.smtpout.orange.fr ([80.12.242.132]:42660 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23991061AbdHPE6ca50WA (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 16 Aug 2017 06:58:32 +0200
Received: from localhost.localdomain ([90.21.173.186])
        by mwinf5d87 with ME
        id xgyQ1v00941fZiq03gyR8s; Wed, 16 Aug 2017 06:58:26 +0200
X-ME-Helo: localhost.localdomain
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Wed, 16 Aug 2017 06:58:26 +0200
X-ME-IP: 90.21.173.186
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     ralf@linux-mips.org, david.daney@cavium.com, bp@alien8.de,
        mchehab@kernel.org
Cc:     linux-edac@vger.kernel.org, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: [PATCH] EDAC, thunderx: Fix an error handling path in 'thunderx_lmc_probe()'
Date:   Wed, 16 Aug 2017 06:58:21 +0200
Message-Id: <20170816045821.14165-1-christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.11.0
Return-Path: <christophe.jaillet@wanadoo.fr>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 59597
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: christophe.jaillet@wanadoo.fr
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

'ret' is known to be 0 at this point.
If 'ioremap()' fails, returns -ENOMEM instead of 0 which means success.

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
 drivers/edac/thunderx_edac.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/edac/thunderx_edac.c b/drivers/edac/thunderx_edac.c
index c8e8b9fd4772..00b89f057695 100644
--- a/drivers/edac/thunderx_edac.c
+++ b/drivers/edac/thunderx_edac.c
@@ -779,6 +779,7 @@ static int thunderx_lmc_probe(struct pci_dev *pdev,
 
 	if (!l2c_ioaddr) {
 		dev_err(&pdev->dev, "Cannot map L2C_CTL\n");
+		ret = -ENOMEM;
 		goto err_free;
 	}
 
-- 
2.11.0
