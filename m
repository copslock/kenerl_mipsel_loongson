Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 28 Jul 2017 00:38:42 +0200 (CEST)
Received: from mail-qk0-x243.google.com ([IPv6:2607:f8b0:400d:c09::243]:35303
        "EHLO mail-qk0-x243.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23993961AbdG0WifsYC5D (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 28 Jul 2017 00:38:35 +0200
Received: by mail-qk0-x243.google.com with SMTP id a77so2298268qkb.2
        for <linux-mips@linux-mips.org>; Thu, 27 Jul 2017 15:38:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=2Jzk271X1msY18Ii8Ign3KT9bJ2e5zPC2r/uXDaAyn0=;
        b=SkuTEpXyCPETPHcObmiJ/9UfEEwdxa2tggEWZzUS3YTpe9OZEhw5yNisTFqPIbC3sW
         7aG8BMOABy9xq+PYvYxWa3ednMZFcuoeAU+FG5Qj1SBYekGq6q8mGLctwHB4+KDDOIkQ
         YztRk8/7Gl+DWx15VBiL8lqSddpKm7kIDZXZLD7nNx/HlYYGbE/CyGLAT2pUMnbKa1EN
         t/iZIgFe8eDFT6OsOsInV2oZPOyhxJK4x8TAoGM/g+79nOtEGDqjh+ubIBSFouaKGDlQ
         LgmHkWlI3TmRh7aa29KkbSi3JnRU3GH4nx9zSsHfStEZT80+ZCbZ30D7c/zSyf6G5dBL
         P9Wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=2Jzk271X1msY18Ii8Ign3KT9bJ2e5zPC2r/uXDaAyn0=;
        b=au2xvEIWno4yM2IyforcxlugdqI2sIr/14XZvxfyJckTHfFiuEfxjuVbCCeRCZcXNQ
         LsvNnT/o/vo90yRlFGNLO501k7UzBrizqME8NBw9fhrepn+dposQBNgb4BWM8jK+2Z7y
         lxDq2gF6c/MREgaP7veL8fT8kEBLB43PnSG2295x6dOBtol8NqGpsPeEwKP/7VV0GTy/
         OHA8JR58twKC2IRCfzN8tiMSiySXmC5bC2mnQc/UBeC23OY1mROgUmkZ4ew2yZUdz2Et
         DhGv4D7ps9r3OcmTEHwAtUCYcANCgw8HV3wuUAsivnDJghwuvK7xBrPDdQeU4CrqYk3c
         wwuA==
X-Gm-Message-State: AIVw110JATi13oQuGRLlj5UT/Ra2X8EuVNspi5FP0w6CDBnlTovv7IoR
        3ozawPV/Jk1clA==
X-Received: by 10.55.26.161 with SMTP id l33mr8252195qkh.315.1501195110089;
        Thu, 27 Jul 2017 15:38:30 -0700 (PDT)
Received: from fainelli-desktop.broadcom.com ([192.19.255.250])
        by smtp.gmail.com with ESMTPSA id i79sm13895881qke.3.2017.07.27.15.38.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 27 Jul 2017 15:38:29 -0700 (PDT)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     opendmb@gmail.com, Florian Fainelli <f.fainelli@gmail.com>,
        Kevin Cernekee <cernekee@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Brian Norris <computersforpeace@gmail.com>,
        Gregory Fong <gregory.0xf0@gmail.com>,
        bcm-kernel-feedback-list@broadcom.com (maintainer:BROADCOM BCM7XXX ARM
        ARCHITECTURE),
        linux-mips@linux-mips.org (open list:BROADCOM BMIPS MIPS ARCHITECTURE),
        linux-kernel@vger.kernel.org (open list:IRQCHIP DRIVERS)
Subject: [PATCH] irqchip: brcmstb-l2: Define an irq_pm_shutdown function
Date:   Thu, 27 Jul 2017 15:38:17 -0700
Message-Id: <20170727223817.7494-1-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.9.3
Return-Path: <f.fainelli@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 59301
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: f.fainelli@gmail.com
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

The Broadcom STB platforms support S5 and we allow specific hardware
wake-up events to take us out of this state. Because we were not
defining an irq_pm_shutdown() function pointer, we would not be
correctly masking non-wakeup events, which would result in spurious
wake-ups from sources that were not explicitly configured for wake-up.

Fixes: 7f646e92766e ("irqchip: brcmstb-l2: Add Broadcom Set Top Box Level-2 interrupt controller")
Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 drivers/irqchip/irq-brcmstb-l2.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/irqchip/irq-brcmstb-l2.c b/drivers/irqchip/irq-brcmstb-l2.c
index bddf169c4b37..b009b916a292 100644
--- a/drivers/irqchip/irq-brcmstb-l2.c
+++ b/drivers/irqchip/irq-brcmstb-l2.c
@@ -189,6 +189,7 @@ static int __init brcmstb_l2_intc_of_init(struct device_node *np,
 
 	ct->chip.irq_suspend = brcmstb_l2_intc_suspend;
 	ct->chip.irq_resume = brcmstb_l2_intc_resume;
+	ct->chip.irq_pm_shutdown = brcmstb_l2_intc_suspend;
 
 	if (data->can_wake) {
 		/* This IRQ chip can wake the system, set all child interrupts
-- 
2.9.3
