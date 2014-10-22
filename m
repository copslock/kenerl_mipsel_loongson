Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 22 Oct 2014 06:04:27 +0200 (CEST)
Received: from mail-pa0-f45.google.com ([209.85.220.45]:45326 "EHLO
        mail-pa0-f45.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27011231AbaJVEE0WyiqT (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 22 Oct 2014 06:04:26 +0200
Received: by mail-pa0-f45.google.com with SMTP id lj1so2820728pab.18
        for <multiple recipients>; Tue, 21 Oct 2014 21:04:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=hZekczwIMZsaYxR9wL8BQBpGGKSe6nLUQh6yWvvLky8=;
        b=RmzUjvi80TtDNQ4jjimU84UzrJ10189oFru+F2uf/iKWovWEllP6aobFq6sPCVfuUv
         9GNZiZei1btGuw105zAoJSvASJYOa3J9nuyl4uWiVtgHf2yZprLMZYzJuCVkh14FanVI
         NckUEWkONfFBY9/i4e1JiMvIhKcv1HZMVvXisPlUlHjzREm9P3LbfaQnGLK/kOdNvVH1
         /SIKcO5lMRkni8aM6lAkJ/kCdL79Ayuq+Lb5cP9Fv5MIu4isZL005IxdAdxqHjVbDmJx
         3TUQoxjHk3ogryaS2EL4GwhcmZxUyjC+78IDIgqPhGVFSoVqMd9uQZMpWNETmgKqRxmh
         hRzg==
X-Received: by 10.68.57.135 with SMTP id i7mr21778447pbq.115.1413950659524;
        Tue, 21 Oct 2014 21:04:19 -0700 (PDT)
Received: from cdac.hyderabad.cdac.in ([196.12.45.164])
        by mx.google.com with ESMTPSA id yr3sm13369101pac.1.2014.10.21.21.04.16
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Tue, 21 Oct 2014 21:04:18 -0700 (PDT)
From:   Varka Bhadram <varkabhadram@gmail.com>
X-Google-Original-From: Varka Bhadram <varkab@cdac.in>
To:     linux-mips@linux-mips.org
Cc:     ralf@linux-mips.org, Varka Bhadram <varkab@cdac.in>
Subject: [PATCH mips] pci: pci-lantiq: remove duplicate check on resource
Date:   Wed, 22 Oct 2014 09:31:15 +0530
Message-Id: <1413950475-29451-1-git-send-email-varkab@cdac.in>
X-Mailer: git-send-email 1.7.9.5
Return-Path: <varkabhadram@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 43464
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: varkabhadram@gmail.com
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

Sanity check on resource happening with devm_ioremap_resource()

Signed-off-by: Varka Bhadram <varkab@cdac.in>
---

This patch based on master brnch of 
https://kernel.googlesource.com/pub/scm/linux/kernel/git/ralf/linux tree.

Thanks.

 arch/mips/pci/pci-lantiq.c |    7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/arch/mips/pci/pci-lantiq.c b/arch/mips/pci/pci-lantiq.c
index 37fe8e7..d3ed15b 100644
--- a/arch/mips/pci/pci-lantiq.c
+++ b/arch/mips/pci/pci-lantiq.c
@@ -215,17 +215,12 @@ static int ltq_pci_probe(struct platform_device *pdev)
 
 	pci_clear_flags(PCI_PROBE_ONLY);
 
-	res_cfg = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	res_bridge = platform_get_resource(pdev, IORESOURCE_MEM, 1);
-	if (!res_cfg || !res_bridge) {
-		dev_err(&pdev->dev, "missing memory resources\n");
-		return -EINVAL;
-	}
-
 	ltq_pci_membase = devm_ioremap_resource(&pdev->dev, res_bridge);
 	if (IS_ERR(ltq_pci_membase))
 		return PTR_ERR(ltq_pci_membase);
 
+	res_cfg = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	ltq_pci_mapped_cfg = devm_ioremap_resource(&pdev->dev, res_cfg);
 	if (IS_ERR(ltq_pci_mapped_cfg))
 		return PTR_ERR(ltq_pci_mapped_cfg);
-- 
1.7.9.5
