Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 28 Nov 2014 05:33:45 +0100 (CET)
Received: from mail-pd0-f172.google.com ([209.85.192.172]:59850 "EHLO
        mail-pd0-f172.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27007429AbaK1EdOHlTdi (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 28 Nov 2014 05:33:14 +0100
Received: by mail-pd0-f172.google.com with SMTP id y13so6008756pdi.3
        for <multiple recipients>; Thu, 27 Nov 2014 20:33:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ivL+n1ssKBwNTWwU2dniqJPZJYF+kKPilbC1eLUu8Pk=;
        b=c2AzfLl5LAjf0/4tUTh0/GIzv2NUKzxIwjFzHVkCgf3dFNjD7i40QQtc3vvymk58E+
         uUt5LGsFi8H/+qPMh6tqzpt6x2ypGLMf2Zt88t5Be2FyiuxIEf7/XNYNUgx0oLMGmExM
         KlMcuet8nmIkHGpggya2OfrSUXqmBmbk0fKp6JPJVvUeoPbvwrXh5rNc0maTPDs/meOG
         bIiQDJD/5Yr8+m2rhUyAu0EBUygMmFd3g5trI+ADlCUojF+r033sr72TAnqd51iDKQJs
         xRjYqXkOYWx+5Z2CbQbSBXO2Uz43ohyW8LTaAwREsBcsWMRU4B5CZ0InSrGXwoEprBNh
         Z51A==
X-Received: by 10.68.246.229 with SMTP id xz5mr69153343pbc.131.1417149187938;
        Thu, 27 Nov 2014 20:33:07 -0800 (PST)
Received: from localhost (b32.net. [192.81.132.72])
        by mx.google.com with ESMTPSA id u5sm8482887pdc.79.2014.11.27.20.33.06
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Thu, 27 Nov 2014 20:33:07 -0800 (PST)
From:   Kevin Cernekee <cernekee@gmail.com>
To:     ralf@linux-mips.org
Cc:     f.fainelli@gmail.com, jfraser@broadcom.com, dtor@chromium.org,
        tglx@linutronix.de, jason@lakedaemon.net, jogo@openwrt.org,
        arnd@arndb.de, computersforpeace@gmail.com,
        linux-mips@linux-mips.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH V4 02/16] irqchip: brcmstb-l2: don't clear wakeable interrupts at init time
Date:   Thu, 27 Nov 2014 20:32:08 -0800
Message-Id: <1417149142-3756-3-git-send-email-cernekee@gmail.com>
X-Mailer: git-send-email 2.1.1
In-Reply-To: <1417149142-3756-1-git-send-email-cernekee@gmail.com>
References: <1417149142-3756-1-git-send-email-cernekee@gmail.com>
Return-Path: <cernekee@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 44493
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

From: Brian Norris <computersforpeace@gmail.com>

Wakeable interrupts might be pending at boot/init time, because wakeup
interrupts might have triggered a resume from S5. So don't clear such
wakeups.

This means that any driver which requests a wakeable interrupt bit
should be prepared to handle an interrupt as soon as they call
request_irq(). (This is technically already the correct development
practice, but some drivers probably expect not to receive interrupts
until they have performed some I/O.)

Signed-off-by: Brian Norris <computersforpeace@gmail.com>
Signed-off-by: Kevin Cernekee <cernekee@gmail.com>
---
 drivers/irqchip/irq-brcmstb-l2.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/irqchip/irq-brcmstb-l2.c b/drivers/irqchip/irq-brcmstb-l2.c
index 4aa653a0ac72..4edd27c486c4 100644
--- a/drivers/irqchip/irq-brcmstb-l2.c
+++ b/drivers/irqchip/irq-brcmstb-l2.c
@@ -136,7 +136,11 @@ int __init brcmstb_l2_intc_of_init(struct device_node *np,
 
 	/* Disable all interrupts by default */
 	writel(0xffffffff, data->base + CPU_MASK_SET);
-	writel(0xffffffff, data->base + CPU_CLEAR);
+
+	/* Wakeup interrupts may be retained from S5 (cold boot) */
+	data->can_wake = of_property_read_bool(np, "brcm,irq-can-wake");
+	if (!data->can_wake)
+		writel(0xffffffff, data->base + CPU_CLEAR);
 
 	data->parent_irq = irq_of_parse_and_map(np, 0);
 	if (data->parent_irq < 0) {
@@ -188,8 +192,7 @@ int __init brcmstb_l2_intc_of_init(struct device_node *np,
 	ct->chip.irq_suspend = brcmstb_l2_intc_suspend;
 	ct->chip.irq_resume = brcmstb_l2_intc_resume;
 
-	if (of_property_read_bool(np, "brcm,irq-can-wake")) {
-		data->can_wake = true;
+	if (data->can_wake) {
 		/* This IRQ chip can wake the system, set all child interrupts
 		 * in wake_enabled mask
 		 */
-- 
2.1.0
