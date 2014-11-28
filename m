Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 28 Nov 2014 05:34:04 +0100 (CET)
Received: from mail-pd0-f180.google.com ([209.85.192.180]:55965 "EHLO
        mail-pd0-f180.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27007466AbaK1EdPWx90B (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 28 Nov 2014 05:33:15 +0100
Received: by mail-pd0-f180.google.com with SMTP id p10so5953594pdj.11
        for <multiple recipients>; Thu, 27 Nov 2014 20:33:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=IxJ85eRNt9Jc8/bRU2XbX3PXLLFFfkG0OxTJue0ciQk=;
        b=pCm6Oe8FcXbQBKKpzah0hojiho6Tc/5lJowUrjzi9pPDK694K6ChCSyVqxOgFE8/3P
         uB9QJ8vINCaViHRxZmKfJxGF5ndwznUE2V4OZbKOoU/dL15yR7Jm94YG14wDHaNjrhqa
         CwRu7TFEV6Tl9ejGuYXWordd61jAWk2VXY36psG/NctIq4QVFNUEz5ybboR1Ri8j4ONe
         oJrjej5zuGR69bbNPAOO/nR5LEWXNo2u1C7qZl4RWd3nTyobVcCb3yqcYdvCCX03L4iB
         2nWPdWw1yHgFwaD6T9ruOHpIhDGhM1OKcx4FWLtxqY3zavfE1CKzArVddKddQ0HDOLC1
         BdiA==
X-Received: by 10.66.66.234 with SMTP id i10mr68984198pat.44.1417149189614;
        Thu, 27 Nov 2014 20:33:09 -0800 (PST)
Received: from localhost (b32.net. [192.81.132.72])
        by mx.google.com with ESMTPSA id u5sm8482887pdc.79.2014.11.27.20.33.07
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Thu, 27 Nov 2014 20:33:08 -0800 (PST)
From:   Kevin Cernekee <cernekee@gmail.com>
To:     ralf@linux-mips.org
Cc:     f.fainelli@gmail.com, jfraser@broadcom.com, dtor@chromium.org,
        tglx@linutronix.de, jason@lakedaemon.net, jogo@openwrt.org,
        arnd@arndb.de, computersforpeace@gmail.com,
        linux-mips@linux-mips.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH V4 03/16] irqchip: brcmstb-l2: fix error handling of irq_of_parse_and_map
Date:   Thu, 27 Nov 2014 20:32:09 -0800
Message-Id: <1417149142-3756-4-git-send-email-cernekee@gmail.com>
X-Mailer: git-send-email 2.1.1
In-Reply-To: <1417149142-3756-1-git-send-email-cernekee@gmail.com>
References: <1417149142-3756-1-git-send-email-cernekee@gmail.com>
Return-Path: <cernekee@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 44494
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
2.1.0
