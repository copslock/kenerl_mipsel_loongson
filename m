Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 02 Nov 2014 02:06:16 +0100 (CET)
Received: from mail-pd0-f177.google.com ([209.85.192.177]:40836 "EHLO
        mail-pd0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27012448AbaKBBE755rd- (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 2 Nov 2014 02:04:59 +0100
Received: by mail-pd0-f177.google.com with SMTP id v10so9372754pde.22
        for <multiple recipients>; Sat, 01 Nov 2014 18:04:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=udvpDKhKvHkEF5vqe7BV5K9F+++jjnkjjXY9egMM0Tg=;
        b=DpAw9SNl+sQy+uYPJTRGSCqWOEX6g0kUUFKAjRqrHVWnglmoKAFFQJ9o+ZoI9lcYjr
         2WMSa9dgio7SRM4ps18OeoYYnVrxmIyDkj9aTjcLVuMZXF8vXs1+XnqPqmyBpY/NLaPr
         FIEF99OwcKjseLRExOK3wgO9TRS7JIgpNci62As5uFnvQYtbPcobKGh5KKXChJ9uDjkv
         /vqQaSYNNLjf5vfdgBnrCI0MdKy5c2URGIuMl43zUVeLfuq4M5LI8m6bfz0ZxnzuWdGU
         s5MdhPX3xB8hE6CydY0CnMyLrgxOKF4Xm/YowR1aYWKskPQjRTSuEm9rK449ZD3R7bb4
         djAw==
X-Received: by 10.66.188.167 with SMTP id gb7mr3905768pac.23.1414890293735;
        Sat, 01 Nov 2014 18:04:53 -0700 (PDT)
Received: from localhost (b32.net. [192.81.132.72])
        by mx.google.com with ESMTPSA id f7sm13488343pdj.15.2014.11.01.18.04.51
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sat, 01 Nov 2014 18:04:52 -0700 (PDT)
From:   Kevin Cernekee <cernekee@gmail.com>
To:     arnd@arndb.de, f.fainelli@gmail.com, tglx@linutronix.de,
        jason@lakedaemon.net, ralf@linux-mips.org
Cc:     linux-sh@vger.kernel.org, sergei.shtylyov@cogentembedded.com,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        mbizon@freebox.fr, jogo@openwrt.org, linux-mips@linux-mips.org
Subject: [PATCH V3 05/14] irqchip: brcmstb-l2: Eliminate dependency on ARM code
Date:   Sat,  1 Nov 2014 18:03:52 -0700
Message-Id: <1414890241-9938-6-git-send-email-cernekee@gmail.com>
X-Mailer: git-send-email 2.1.1
In-Reply-To: <1414890241-9938-1-git-send-email-cernekee@gmail.com>
References: <1414890241-9938-1-git-send-email-cernekee@gmail.com>
Return-Path: <cernekee@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 43827
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

The irq-brcmstb-l2 driver has a single dependency on the ARM code, the
do_bad_IRQ macro.  Expand this macro in-place so that the driver can be
built on non-ARM platforms.

Signed-off-by: Kevin Cernekee <cernekee@gmail.com>
Acked-by: Arnd Bergmann <arnd@arndb.de>
Acked-by: Florian Fainelli <f.fainelli@gmail.com>
---
 drivers/irqchip/irq-brcmstb-l2.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/irqchip/irq-brcmstb-l2.c b/drivers/irqchip/irq-brcmstb-l2.c
index c15c840..c9bdf20 100644
--- a/drivers/irqchip/irq-brcmstb-l2.c
+++ b/drivers/irqchip/irq-brcmstb-l2.c
@@ -19,6 +19,7 @@
 #include <linux/slab.h>
 #include <linux/module.h>
 #include <linux/platform_device.h>
+#include <linux/spinlock.h>
 #include <linux/of.h>
 #include <linux/of_irq.h>
 #include <linux/of_address.h>
@@ -30,8 +31,6 @@
 #include <linux/irqchip.h>
 #include <linux/irqchip/chained_irq.h>
 
-#include <asm/mach/irq.h>
-
 #include "irqchip.h"
 
 /* Register offsets in the L2 interrupt controller */
@@ -63,7 +62,9 @@ static void brcmstb_l2_intc_irq_handle(unsigned int irq, struct irq_desc *desc)
 		~(__raw_readl(b->base + CPU_MASK_STATUS));
 
 	if (status == 0) {
-		do_bad_IRQ(irq, desc);
+		raw_spin_lock(&desc->lock);
+		handle_bad_irq(irq, desc);
+		raw_spin_unlock(&desc->lock);
 		goto out;
 	}
 
-- 
2.1.1
