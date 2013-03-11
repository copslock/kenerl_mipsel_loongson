Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 11 Mar 2013 16:24:47 +0100 (CET)
Received: from mail-we0-f169.google.com ([74.125.82.169]:45245 "EHLO
        mail-we0-f169.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6825729Ab3CKPYqAJt-c (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 11 Mar 2013 16:24:46 +0100
Received: by mail-we0-f169.google.com with SMTP id t11so3718068wey.14
        for <multiple recipients>; Mon, 11 Mar 2013 08:24:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer;
        bh=0ouuIq4BJ3NCSJhyYrbJHSvcI6Zap1PVamdS6KOCvQg=;
        b=WH1HcKyGrPY4noLZjS7wFG29yStScf/0Sj4dN7PRXHyuRRCQRDq8QLPE+984RWsTsQ
         mbUeFrt8LvDQh59GC92RdMt1qZH25L0njRlJ0IDr0wq7KPXFxZ10j4j6OuOmTEvzSTVt
         qWX3Ns+QiSo5JkXhA1t36/X86btcpkpB8U6DAzOM7+LowcbrWatnHilOcEK+puIG0OrA
         lf6qh361KePThd+xMB8s13dl/q2XT4EMd00qN6F98hD2Yl3SGNhI0tA9rR5RRW/Vka4n
         q1KhMtL3juY3UeFFzv9uQe5etK3Lvd4R4vztpjhomhmWBqIZCC6Bmyw/yEgDfTW/NM1d
         Dd6w==
X-Received: by 10.195.12.133 with SMTP id eq5mr19877617wjd.52.1363015480585;
        Mon, 11 Mar 2013 08:24:40 -0700 (PDT)
Received: from localhost.localdomain (p5.eregie.pub.ro. [141.85.0.105])
        by mx.google.com with ESMTPS id fv2sm17854997wib.6.2013.03.11.08.24.38
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Mon, 11 Mar 2013 08:24:39 -0700 (PDT)
From:   Silviu-Mihai Popescu <silviupopescu1990@gmail.com>
To:     linux-mips@linux-mips.org
Cc:     ralf@linux-mips.org, juhosg@openwrt.org, blogic@openwrt.org,
        kaloz@openwrt.org, linux-kernel@vger.kernel.org,
        Silviu-Mihai Popescu <silviupopescu1990@gmail.com>
Subject: [PATCH] pci: use newly introduced devm_ioremap_resource()
Date:   Mon, 11 Mar 2013 17:24:37 +0200
Message-Id: <1363015477-29685-1-git-send-email-silviupopescu1990@gmail.com>
X-Mailer: git-send-email 1.7.9.5
X-archive-position: 35866
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
 1 file changed, 3 insertions(+), 3 deletions(-)

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
-- 
1.7.9.5
