Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 16 Nov 2014 01:20:04 +0100 (CET)
Received: from mail-pd0-f173.google.com ([209.85.192.173]:33114 "EHLO
        mail-pd0-f173.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27013751AbaKPAT2Wc80W (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 16 Nov 2014 01:19:28 +0100
Received: by mail-pd0-f173.google.com with SMTP id v10so18956310pde.32
        for <multiple recipients>; Sat, 15 Nov 2014 16:19:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=n+TVPFzqgMZjVnVI+Je3ShUtsk2de6qHZEE/a1wfJSc=;
        b=qGRqPtmw+aPDgX0tod7nN12ufwXppWJY+B/GaoNhJUn4wFfTIXT4KZ2oylDnVfVV1r
         JuU7UcOqTSo15fqtS512PrzRIHNRUmgRx+SyW0AjETWZEGMPWFcZSQ1RDOwJDmB56Qes
         P1dY+acLCOZ0WJ427nyPJ5r6WOOB05YjFl8MhM4W/wzKBjADHbZWmNHji29D75uXaKmm
         10tqpiVeChvc0ZtmZhNQHzGjSnu0y9uX6TIY7kmQeMYTy+BeX6X6IAwviCASZ6RSoo8J
         J4NITIAav/JqSgpVPHqMLXJqT50qY7rfk8nguVVvPF0Q3688RoOrcHhdKL4ZPzMdMIaj
         5/eQ==
X-Received: by 10.70.92.201 with SMTP id co9mr62413pdb.134.1416097162418;
        Sat, 15 Nov 2014 16:19:22 -0800 (PST)
Received: from localhost (b32.net. [192.81.132.72])
        by mx.google.com with ESMTPSA id xn4sm11099440pab.9.2014.11.15.16.19.20
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sat, 15 Nov 2014 16:19:21 -0800 (PST)
From:   Kevin Cernekee <cernekee@gmail.com>
To:     ralf@linux-mips.org
Cc:     f.fainelli@gmail.com, jfraser@broadcom.com, dtor@chromium.org,
        tglx@linutronix.de, jason@lakedaemon.net,
        linux-mips@linux-mips.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH V2 02/22] irqchip: brcmstb-l2: fix error handling of irq_of_parse_and_map
Date:   Sat, 15 Nov 2014 16:17:26 -0800
Message-Id: <1416097066-20452-3-git-send-email-cernekee@gmail.com>
X-Mailer: git-send-email 2.1.1
In-Reply-To: <1416097066-20452-1-git-send-email-cernekee@gmail.com>
References: <1416097066-20452-1-git-send-email-cernekee@gmail.com>
Return-Path: <cernekee@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 44193
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
index 4aa653a..313c2c6 100644
--- a/drivers/irqchip/irq-brcmstb-l2.c
+++ b/drivers/irqchip/irq-brcmstb-l2.c
@@ -139,9 +139,9 @@ int __init brcmstb_l2_intc_of_init(struct device_node *np,
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
