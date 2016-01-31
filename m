Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 31 Jan 2016 21:29:43 +0100 (CET)
Received: from mail-pa0-f41.google.com ([209.85.220.41]:34964 "EHLO
        mail-pa0-f41.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27011382AbcAaU3jrfuT7 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 31 Jan 2016 21:29:39 +0100
Received: by mail-pa0-f41.google.com with SMTP id ho8so69749156pac.2;
        Sun, 31 Jan 2016 12:29:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=JTFmwrCvLTCfE2Oikft0nI1ODRbF2diyJVsjvYkRlwQ=;
        b=z0EAYdJFnBtc/bvfCNwqXrPw9Ayo9y6XUS/Kr/JC7MBZewWALhDxrpzt+LVJ9ACivb
         32rOBUM/Uhkk0iXsHcyADajjm9MioZwVunSaHv2ue0zYtbVLq12oGc2+ZGcyAFWyi45T
         C5U5Yp16zJ64RjOm7OtrP0pJ1qCVipKuQ/oljZo+/RwRtyzAuna/y4Vlx/QFkeazUaSb
         BSlS7oFK9Tv+g2tJlLqpci1TJea3MOVsOGSaetRB2feexQGRGX3PisrhLrgbq41r3kFv
         vXA8LpsaPIf1oEnBFmfihJaWhIPBZwkuXxyH2i4oDZ5R/+BOTcasseKdWHLrIMIOIz8t
         Pn9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=JTFmwrCvLTCfE2Oikft0nI1ODRbF2diyJVsjvYkRlwQ=;
        b=aPHwOC1eFAA9HV56s9F2lcGSFP7s2Eh013Z47O9QFzVePxMIsVjmt6Y6LsiXnyQXNm
         +ZmLkrMeRtqibZrmGMfj8xMxIqHfJoEbqS3SFvoE5d2Q3gWCtcz9/XYDh9dABnoFzKo6
         EXt5uz5h21elsuGXU0WDeBi5up+NYmrddXpgDt6fy/8oVqjykcOQbarRu8P6QKiRS0gs
         Rl3bhqjUejkpolmLVPh4om58fvFZiNn26Gahs/Fwuk7QosAb6hCA/jutSrQOAWSuEwRb
         0QRHOFzjih+j6falr/v8hOcwh2fXl+bhSyMOVcGTY/Z+/uNKBDhbYmSRt9FH0G6TDfo0
         LRTA==
X-Gm-Message-State: AG10YOQCjiNtPNxUwmbxZnqYIHuyyVGCQq7Vk89Op19KLDsYdWjxTKHeD4zjxnO7El90tw==
X-Received: by 10.66.158.37 with SMTP id wr5mr32604440pab.48.1454272173733;
        Sun, 31 Jan 2016 12:29:33 -0800 (PST)
Received: from localhost.localdomain (5520-maca-inet1-outside.broadcom.com. [216.31.211.11])
        by smtp.gmail.com with ESMTPSA id ya4sm37806112pab.22.2016.01.31.12.29.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 31 Jan 2016 12:29:32 -0800 (PST)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     linux-mips@linux-mips.org
Cc:     ralf@linux-mips.org, cernekee@gmail.com, arnd@arndb.de,
        jaedon.shin@gmail.com, pgynther@google.com,
        Florian Fainelli <f.fainelli@gmail.com>
Subject: [PATCH] bus: brcmstb_gisb: Hook to MIPS board_be_handler
Date:   Sun, 31 Jan 2016 12:29:27 -0800
Message-Id: <1454272167-565-1-git-send-email-f.fainelli@gmail.com>
X-Mailer: git-send-email 1.7.1
Return-Path: <f.fainelli@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 51555
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

MIPS kernels allow platforms to invoke a custom Bus Error handler, add the
necessary code to do this for Broadcom SoCs where the GISB bus error handler can be used.

We may get a bus error from an address decoded outside of the GISB bus space,
so we need to check the validity of such a capture before printing anything.

Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
Ralf, Arnd,

We first introduced this driver through an arm-soc drivers pull request, but since then
there has not been many changes to this driver, at least, nothing in flight that would
cause merge conflicts.

I am okay to take this in an upcoming arm-soc drivers pull request, of directly via the
MIPS tree, whatever works best for you.

Thank you!

 drivers/bus/brcmstb_gisb.c |   30 ++++++++++++++++++++++++++++++
 1 files changed, 30 insertions(+), 0 deletions(-)

diff --git a/drivers/bus/brcmstb_gisb.c b/drivers/bus/brcmstb_gisb.c
index f364fa4..72fe0a5 100644
--- a/drivers/bus/brcmstb_gisb.c
+++ b/drivers/bus/brcmstb_gisb.c
@@ -30,6 +30,10 @@
 #include <asm/signal.h>
 #endif
 
+#ifdef CONFIG_MIPS
+#include <asm/traps.h>
+#endif
+
 #define  ARB_ERR_CAP_CLEAR		(1 << 0)
 #define  ARB_ERR_CAP_STATUS_TIMEOUT	(1 << 12)
 #define  ARB_ERR_CAP_STATUS_TEA		(1 << 11)
@@ -238,6 +242,29 @@ static int brcmstb_bus_error_handler(unsigned long addr, unsigned int fsr,
 }
 #endif
 
+#ifdef CONFIG_MIPS
+static int brcmstb_bus_error_handler(struct pt_regs *regs, int is_fixup)
+{
+	int ret = 0;
+	struct brcmstb_gisb_arb_device *gdev;
+	u32 cap_status;
+
+	list_for_each_entry(gdev, &brcmstb_gisb_arb_device_list, next) {
+		cap_status = gisb_read(gdev, ARB_ERR_CAP_STATUS);
+
+		/* Invalid captured address, bail out */
+		if (!(cap_status & ARB_ERR_CAP_STATUS_VALID)) {
+			is_fixup = 1;
+			goto out;
+		}
+
+		ret |= brcmstb_gisb_arb_decode_addr(gdev, "bus error");
+	}
+out:
+	return is_fixup ? MIPS_BE_FIXUP : MIPS_BE_FATAL;
+}
+#endif
+
 static irqreturn_t brcmstb_gisb_timeout_handler(int irq, void *dev_id)
 {
 	brcmstb_gisb_arb_decode_addr(dev_id, "timeout");
@@ -355,6 +382,9 @@ static int __init brcmstb_gisb_arb_probe(struct platform_device *pdev)
 	hook_fault_code(22, brcmstb_bus_error_handler, SIGBUS, 0,
 			"imprecise external abort");
 #endif
+#ifdef CONFIG_MIPS
+	board_be_handler = brcmstb_bus_error_handler;
+#endif
 
 	dev_info(&pdev->dev, "registered mem: %p, irqs: %d, %d\n",
 			gdev->base, timeout_irq, tea_irq);
-- 
1.7.1
