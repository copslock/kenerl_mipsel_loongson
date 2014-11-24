Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 24 Nov 2014 03:41:33 +0100 (CET)
Received: from mail-pa0-f51.google.com ([209.85.220.51]:51536 "EHLO
        mail-pa0-f51.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27006771AbaKXCk6rB0u1 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 24 Nov 2014 03:40:58 +0100
Received: by mail-pa0-f51.google.com with SMTP id ey11so8668756pad.10
        for <multiple recipients>; Sun, 23 Nov 2014 18:40:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=J0ps19CrX6OJS2+H6r/U+xecpt7o9AVIExY4F+KMNZM=;
        b=SuclGVNJ8lUhDdLbD65aIAuNnsRo0VU2tbkTXEe2FEolottUzzijvZlAyYt8ba+kH9
         DczmRTgXJa4vDj/IgMTc2eFiTlkXw2Vxit26WU29iFoFl4NQkCKCKCG+tODaIb+XtQW/
         jZGi4ZCpASEvOisUP66dvE0WtiwuvmcwmgAGbTy362Wz0XHA9j72g6i0k+HkWawR7gPP
         PepYVMVhgFFXDCMNRfisIC/BtSS8luLEGbWu5MXIXmcL9k3Dn76OuQU+3EPs56XMe0Xc
         5SUolUAmOqNq+qwqCBEdEID04hKqAjbJTV4SkmfYkz/XC0BTTVj8XyljjzO5dVuQfkiS
         FowA==
X-Received: by 10.68.65.2 with SMTP id t2mr28691537pbs.39.1416796852791;
        Sun, 23 Nov 2014 18:40:52 -0800 (PST)
Received: from localhost (b32.net. [192.81.132.72])
        by mx.google.com with ESMTPSA id ml5sm10930673pab.32.2014.11.23.18.40.51
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sun, 23 Nov 2014 18:40:52 -0800 (PST)
From:   Kevin Cernekee <cernekee@gmail.com>
To:     ralf@linux-mips.org
Cc:     f.fainelli@gmail.com, jfraser@broadcom.com, dtor@chromium.org,
        tglx@linutronix.de, jason@lakedaemon.net, jogo@openwrt.org,
        arnd@arndb.de, computersforpeace@gmail.com,
        linux-mips@linux-mips.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH V3 02/11] irqchip: brcmstb-l2: don't clear wakeable interrupts at init time
Date:   Sun, 23 Nov 2014 18:40:37 -0800
Message-Id: <1416796846-28149-3-git-send-email-cernekee@gmail.com>
X-Mailer: git-send-email 2.1.1
In-Reply-To: <1416796846-28149-1-git-send-email-cernekee@gmail.com>
References: <1416796846-28149-1-git-send-email-cernekee@gmail.com>
Return-Path: <cernekee@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 44355
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
2.1.1
