Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 21 Aug 2012 20:47:26 +0200 (CEST)
Received: from mail-pb0-f49.google.com ([209.85.160.49]:40128 "EHLO
        mail-pb0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903654Ab2HUSp0 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 21 Aug 2012 20:45:26 +0200
Received: by pbbrq8 with SMTP id rq8so322067pbb.36
        for <multiple recipients>; Tue, 21 Aug 2012 11:45:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=mt6tnuFnQSI1yMZdcCn/j8GMX56KT2cMhE78hyVaqR4=;
        b=T+SZV7gDrv7G+Xg0loZCynvd0yjIyUuOHxKrUNk9hfUHkJo4fXhTZiXqnL7L61QMsI
         NDcEWmAIM04wp3x2IOeLR0tEDKPEjcoJus3q5g6SifPuvd1PB+c5hc3v7mqx28Eklxbf
         BiFSDRBIjpEIvu7Swbp3rd8FAjQ0x5q7wGZCjFaCIdFqk1kGmC2dQ0giLjIP1paV9gEK
         EVidyDFaCpBEBabJMlTwY/gg9OviPBz2BvWMaBCL1K8qkcxtSGX483w+W0M/miZHkWW8
         J9Hj0uf5Skr94oQPRNf23+QPa/kqAjzh3FgLIR7//ho384n47gM0SN28CEmnTVoW/Tyk
         KMbA==
Received: by 10.68.224.133 with SMTP id rc5mr45996915pbc.130.1345574719658;
        Tue, 21 Aug 2012 11:45:19 -0700 (PDT)
Received: from dl.caveonetworks.com (64.2.3.195.ptr.us.xo.net. [64.2.3.195])
        by mx.google.com with ESMTPS id sj5sm1953639pbc.30.2012.08.21.11.45.18
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 21 Aug 2012 11:45:18 -0700 (PDT)
Received: from dl.caveonetworks.com (localhost.localdomain [127.0.0.1])
        by dl.caveonetworks.com (8.14.5/8.14.5) with ESMTP id q7LIjHvV021507;
        Tue, 21 Aug 2012 11:45:17 -0700
Received: (from ddaney@localhost)
        by dl.caveonetworks.com (8.14.5/8.14.5/Submit) id q7LIjGIZ021506;
        Tue, 21 Aug 2012 11:45:16 -0700
From:   David Daney <ddaney.cavm@gmail.com>
To:     linux-mips@linux-mips.org, ralf@linux-mips.org,
        "David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, David Daney <david.daney@cavium.com>
Subject: [PATCH 5/8] netdev: octeon_mgmt: Set the parent device.
Date:   Tue, 21 Aug 2012 11:45:09 -0700
Message-Id: <1345574712-21444-6-git-send-email-ddaney.cavm@gmail.com>
X-Mailer: git-send-email 1.7.11.4
In-Reply-To: <1345574712-21444-1-git-send-email-ddaney.cavm@gmail.com>
References: <1345574712-21444-1-git-send-email-ddaney.cavm@gmail.com>
X-archive-position: 34322
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney.cavm@gmail.com
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

From: David Daney <david.daney@cavium.com>

This establishes useful links in sysfs.

Signed-off-by: David Daney <david.daney@cavium.com>
---
 drivers/net/ethernet/octeon/octeon_mgmt.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/ethernet/octeon/octeon_mgmt.c b/drivers/net/ethernet/octeon/octeon_mgmt.c
index cf06cf2..3bae01f 100644
--- a/drivers/net/ethernet/octeon/octeon_mgmt.c
+++ b/drivers/net/ethernet/octeon/octeon_mgmt.c
@@ -1446,6 +1446,8 @@ static int __devinit octeon_mgmt_probe(struct platform_device *pdev)
 	if (netdev == NULL)
 		return -ENOMEM;
 
+	SET_NETDEV_DEV(netdev, &pdev->dev);
+
 	dev_set_drvdata(&pdev->dev, netdev);
 	p = netdev_priv(netdev);
 	netif_napi_add(netdev, &p->napi, octeon_mgmt_napi_poll,
-- 
1.7.11.4
