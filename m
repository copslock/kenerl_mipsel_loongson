Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 28 Nov 2014 05:34:20 +0100 (CET)
Received: from mail-pa0-f47.google.com ([209.85.220.47]:50666 "EHLO
        mail-pa0-f47.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27007467AbaK1EdQz7AC- (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 28 Nov 2014 05:33:16 +0100
Received: by mail-pa0-f47.google.com with SMTP id kq14so6077355pab.20
        for <multiple recipients>; Thu, 27 Nov 2014 20:33:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=r5pfn6kRLpLK5CuGJ70qEwJYVALx2l4xbjhEYjl/m9s=;
        b=Zlm5KLVAwkli81kaP58yNG/p+41nhuSOg0mVI2DBkzaFSgy5k6hXOcTD45xr+TLYap
         xOD/I8X1UoBTa8XHEq+YnDXeHCfIO0BjNYLJmkyFv50Q50So8oyQL9on8ijoYtJjJnkt
         uKICfYOUxUGcOb3wIHGpxtcCjGq/OQdYyl1WjRIUPCcw0UfFuQd9snVDrxJ071oaC6It
         Mxg/eulr6c+YvS4CE/Zfo7BkJSp2qURn3O4I8Hp9e4KURghN2EwADNjwNP27wJKMOEMe
         PmIykb9vNkpPC+orumGs5r6jKGAjMhfrcEPMBbGyLf70wzYcqi0jLHGEWkNhnYKhy29v
         04eA==
X-Received: by 10.68.172.34 with SMTP id az2mr27264837pbc.113.1417149191165;
        Thu, 27 Nov 2014 20:33:11 -0800 (PST)
Received: from localhost (b32.net. [192.81.132.72])
        by mx.google.com with ESMTPSA id u5sm8482887pdc.79.2014.11.27.20.33.09
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Thu, 27 Nov 2014 20:33:10 -0800 (PST)
From:   Kevin Cernekee <cernekee@gmail.com>
To:     ralf@linux-mips.org
Cc:     f.fainelli@gmail.com, jfraser@broadcom.com, dtor@chromium.org,
        tglx@linutronix.de, jason@lakedaemon.net, jogo@openwrt.org,
        arnd@arndb.de, computersforpeace@gmail.com,
        linux-mips@linux-mips.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH V4 04/16] irqchip: bcm7120-l2: fix error handling of irq_of_parse_and_map
Date:   Thu, 27 Nov 2014 20:32:10 -0800
Message-Id: <1417149142-3756-5-git-send-email-cernekee@gmail.com>
X-Mailer: git-send-email 2.1.1
In-Reply-To: <1417149142-3756-1-git-send-email-cernekee@gmail.com>
References: <1417149142-3756-1-git-send-email-cernekee@gmail.com>
Return-Path: <cernekee@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 44495
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: cernekee@gmail.com
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

From: Dmitry Torokhov <dtor@chromium.org>

Return value of irq_of_parse_and_map() is unsigned int, with 0
indicating failure, so testing for negative result never works.

Signed-off-by: Dmitry Torokhov <dtor@chromium.org>
Acked-by: Florian Fainelli <f.fainelli@gmail.com>
Tested-by: Kevin Cernekee <cernekee@gmail.com>
---
 drivers/irqchip/irq-bcm7120-l2.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/irqchip/irq-bcm7120-l2.c b/drivers/irqchip/irq-bcm7120-l2.c
index e7c6155b23b8..8eec8e1201d9 100644
--- a/drivers/irqchip/irq-bcm7120-l2.c
+++ b/drivers/irqchip/irq-bcm7120-l2.c
@@ -102,9 +102,9 @@ static int bcm7120_l2_intc_init_one(struct device_node *dn,
 	unsigned int idx;
 
 	parent_irq = irq_of_parse_and_map(dn, irq);
-	if (parent_irq < 0) {
+	if (!parent_irq) {
 		pr_err("failed to map interrupt %d\n", irq);
-		return parent_irq;
+		return -EINVAL;
 	}
 
 	/* For multiple parent IRQs with multiple words, this looks like:
-- 
2.1.0
