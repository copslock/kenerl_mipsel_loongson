Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 07 Nov 2014 07:47:40 +0100 (CET)
Received: from mail-pd0-f172.google.com ([209.85.192.172]:44963 "EHLO
        mail-pd0-f172.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27012035AbaKGGpUvdeDO (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 7 Nov 2014 07:45:20 +0100
Received: by mail-pd0-f172.google.com with SMTP id r10so2736371pdi.17
        for <multiple recipients>; Thu, 06 Nov 2014 22:45:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=x+k1st+9eghd/5a+JeGjwi6jh5QZCbY6YqHagPVR5oY=;
        b=cbt2UGAFp2apty8ROtpNqzwLJL+/geMzMox4N8nlkxZlBHEi99dd5r0G1GMSzV0vdZ
         Vk1Hb+XF11gz3ERKcgn6cgVR+CJj+v/935ZslyKUgZuk13ApNSShyhH3MhUsc/CkW4CY
         svLfNlQXUcuQRw2qTC9yBkjL0PjXgySE8lnrPDTC2hoi0PwIxOS4anqr4YeiAlM4zLC0
         6eIjH/LprMvQUbGUd5wI30I/NY/uahacjXrVBprrMus5jq7mLOwZnZ8hQA+WxZNPIu1U
         SkRs4igWQ8L2Pk+cG1E2fMcklxLL8LRpu1m6P7mauuzcdi7Rh3jcVYeph8Q0xrPphElu
         0mVA==
X-Received: by 10.68.217.197 with SMTP id pa5mr7647355pbc.3.1415342715251;
        Thu, 06 Nov 2014 22:45:15 -0800 (PST)
Received: from localhost (b32.net. [192.81.132.72])
        by mx.google.com with ESMTPSA id fy4sm7686827pbb.42.2014.11.06.22.45.13
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Thu, 06 Nov 2014 22:45:14 -0800 (PST)
From:   Kevin Cernekee <cernekee@gmail.com>
To:     tglx@linutronix.de, jason@lakedaemon.net, linux-sh@vger.kernel.org
Cc:     arnd@arndb.de, f.fainelli@gmail.com, ralf@linux-mips.org,
        sergei.shtylyov@cogentembedded.com, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, mbizon@freebox.fr, jogo@openwrt.org,
        linux-mips@linux-mips.org
Subject: [PATCH V4 09/14] irqchip: bcm7120-l2: Fix missing nibble in gc->unused mask
Date:   Thu,  6 Nov 2014 22:44:24 -0800
Message-Id: <1415342669-30640-10-git-send-email-cernekee@gmail.com>
X-Mailer: git-send-email 2.1.1
In-Reply-To: <1415342669-30640-1-git-send-email-cernekee@gmail.com>
References: <1415342669-30640-1-git-send-email-cernekee@gmail.com>
Return-Path: <cernekee@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 43902
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

This mask should have been 0xffff_ffff, not 0x0fff_ffff.

The change should not have an effect on current users (STB) because bits
31:27 are unused.

Signed-off-by: Kevin Cernekee <cernekee@gmail.com>
Acked-by: Arnd Bergmann <arnd@arndb.de>
Acked-by: Florian Fainelli <f.fainelli@gmail.com>
---
 drivers/irqchip/irq-bcm7120-l2.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/irqchip/irq-bcm7120-l2.c b/drivers/irqchip/irq-bcm7120-l2.c
index 22d3fa1..b70679f8 100644
--- a/drivers/irqchip/irq-bcm7120-l2.c
+++ b/drivers/irqchip/irq-bcm7120-l2.c
@@ -171,7 +171,7 @@ int __init bcm7120_l2_intc_of_init(struct device_node *dn,
 	}
 
 	gc = irq_get_domain_generic_chip(data->domain, 0);
-	gc->unused = 0xfffffff & ~data->irq_map_mask;
+	gc->unused = 0xffffffff & ~data->irq_map_mask;
 	gc->reg_base = data->base;
 	gc->private = data;
 	ct = gc->chip_types;
-- 
2.1.1
