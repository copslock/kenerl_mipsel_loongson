Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 24 Nov 2014 03:41:51 +0100 (CET)
Received: from mail-pd0-f173.google.com ([209.85.192.173]:41045 "EHLO
        mail-pd0-f173.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27006763AbaKXClATbaaF (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 24 Nov 2014 03:41:00 +0100
Received: by mail-pd0-f173.google.com with SMTP id ft15so8846563pdb.18
        for <multiple recipients>; Sun, 23 Nov 2014 18:40:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=C3lgtcJhdXDLTXQVRaphu5/6OYyFsqhTwlh6yR99Eoc=;
        b=LlzcFX3tcXsIAd6lpCjbTDPRH21NbzLbb6yi3nKBsx54wWenGVHaAbD2f0CpxRKh+U
         mthLaHZLAC5XIvC9NWJo9NmuZOot54KxvjLp4W9kgXb9PSKAnY0FSrhCfD1xdv7w8CZV
         o7mwMFBspgil5QvsQxUAPa/tojrn65AMwyXiksv1NJPy9Iq6feW0lFvsFV9qbd54fTk/
         gpTxDZcXlmS2mabXS6NbZmQwHgei8VPhXxiu3lLOKZfCNMYjIjXsiQz8+WrsPoR7x5pJ
         EZbTb+ywvgn5hNXUu8q6G5GxHS9mRvNF4AgS/TVZCYGo1p2JTClYm3cFX3tOUJYwNNA6
         MLHg==
X-Received: by 10.67.16.106 with SMTP id fv10mr29018682pad.47.1416796854558;
        Sun, 23 Nov 2014 18:40:54 -0800 (PST)
Received: from localhost (b32.net. [192.81.132.72])
        by mx.google.com with ESMTPSA id ml5sm10930673pab.32.2014.11.23.18.40.52
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sun, 23 Nov 2014 18:40:53 -0800 (PST)
From:   Kevin Cernekee <cernekee@gmail.com>
To:     ralf@linux-mips.org
Cc:     f.fainelli@gmail.com, jfraser@broadcom.com, dtor@chromium.org,
        tglx@linutronix.de, jason@lakedaemon.net, jogo@openwrt.org,
        arnd@arndb.de, computersforpeace@gmail.com,
        linux-mips@linux-mips.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH V3 03/11] irqchip: brcmstb-l2: fix error handling of irq_of_parse_and_map
Date:   Sun, 23 Nov 2014 18:40:38 -0800
Message-Id: <1416796846-28149-4-git-send-email-cernekee@gmail.com>
X-Mailer: git-send-email 2.1.1
In-Reply-To: <1416796846-28149-1-git-send-email-cernekee@gmail.com>
References: <1416796846-28149-1-git-send-email-cernekee@gmail.com>
Return-Path: <cernekee@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 44356
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
 drivers/irqchip/irq-brcmstb-l2.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/irqchip/irq-brcmstb-l2.c b/drivers/irqchip/irq-brcmstb-l2.c
index 4edd27c486c4..d6bcc6be0777 100644
--- a/drivers/irqchip/irq-brcmstb-l2.c
+++ b/drivers/irqchip/irq-brcmstb-l2.c
@@ -143,9 +143,9 @@ int __init brcmstb_l2_intc_of_init(struct device_node *np,
 		writel(0xffffffff, data->base + CPU_CLEAR);
 
 	data->parent_irq = irq_of_parse_and_map(np, 0);
-	if (data->parent_irq < 0) {
+	if (!data->parent_irq) {
 		pr_err("failed to find parent interrupt\n");
-		ret = data->parent_irq;
+		ret = -EINVAL;
 		goto out_unmap;
 	}
 
-- 
2.1.1
