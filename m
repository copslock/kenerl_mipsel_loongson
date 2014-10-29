Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 29 Oct 2014 04:59:31 +0100 (CET)
Received: from mail-pa0-f44.google.com ([209.85.220.44]:39102 "EHLO
        mail-pa0-f44.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27011817AbaJ2D7PUMPRE (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 29 Oct 2014 04:59:15 +0100
Received: by mail-pa0-f44.google.com with SMTP id bj1so2263762pad.31
        for <multiple recipients>; Tue, 28 Oct 2014 20:59:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Ih/BQaiP3fiC0jShnZWMkcoM4tOY0nMGr3eXtzmx2bs=;
        b=fudMB1h1DgygMJfG4Pt4cCmq2cUkA872Bw7bYWIj5HtTvMoFCjToDGNMUMTUz+9aXB
         3UYNZo41zkRmDkoUOUFblUuhPs7Ks4hZdQ5XO1oX3XHVlVHVAZZPuT4RR9AkgqR6+Cm+
         0Vw8UpsES317ltiwCvcz/bnHd3/8cwQT0i9ZrznyH/VuECj1wDXR7gL+QrZY03Pf9Zfj
         ea1W2BIPzNgVspN4Ft+Oob3M2IZL6S3md51cS3qfc6Z5w39AOMhjQicRo96Wki6PmAuV
         cnDM/oVppISOoqJieDUyBlpl8/XIbpxil0f03SiSq0tKfVvtXAXeXzXwY6b3VuzfhBfF
         gvsg==
X-Received: by 10.66.228.106 with SMTP id sh10mr7708755pac.108.1414555147562;
        Tue, 28 Oct 2014 20:59:07 -0700 (PDT)
Received: from localhost (b32.net. [192.81.132.72])
        by mx.google.com with ESMTPSA id kj9sm2946249pbc.37.2014.10.28.20.59.06
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Tue, 28 Oct 2014 20:59:07 -0700 (PDT)
From:   Kevin Cernekee <cernekee@gmail.com>
To:     f.fainelli@gmail.com, tglx@linutronix.de, jason@lakedaemon.net,
        ralf@linux-mips.org
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        mbizon@freebox.fr, jogo@openwrt.org, linux-mips@linux-mips.org
Subject: [PATCH 02/11] irqchip: brcmstb-l2: Eliminate dependency on ARM code
Date:   Tue, 28 Oct 2014 20:58:49 -0700
Message-Id: <1414555138-6500-2-git-send-email-cernekee@gmail.com>
X-Mailer: git-send-email 2.1.1
In-Reply-To: <1414555138-6500-1-git-send-email-cernekee@gmail.com>
References: <1414555138-6500-1-git-send-email-cernekee@gmail.com>
Return-Path: <cernekee@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 43672
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
