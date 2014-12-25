Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 25 Dec 2014 18:59:10 +0100 (CET)
Received: from mail-pd0-f171.google.com ([209.85.192.171]:48639 "EHLO
        mail-pd0-f171.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27009773AbaLYR5QAr7Sr (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 25 Dec 2014 18:57:16 +0100
Received: by mail-pd0-f171.google.com with SMTP id y13so11905126pdi.30;
        Thu, 25 Dec 2014 09:57:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=X9LBZPRKtSqt/8b8cmreX/QIqZmZPh1Uiu6tea6VsS0=;
        b=GEQipS8Zjc6H4T5JNgVe5bXZYFWxaSFnCkds3kEP2IBZh+ZgF6O998YuBkscWSMx6M
         1vt/6pC1mTOt2sSG2bbp/5F5ZWKlmNBHhDcPtAu17yuiTlWVJy4fXgXuKDRLzw+Dx9bC
         8W6S5yrixqx/oyYwZQiCUXc12boOa9cTljbvTamyNbqB7tHZi0mRfHT7kViqlBhKg34a
         tLwo9D9oKb181BUTkUqBn4gYwqsKZXfH8FSE0WrxW9mtyecTa3XhUe407iHwQSY0em3M
         x8lsmnp6JahULkoD6FKu9D2guFg1seT8tLA9mR5xnxrk5O+ndfEfGMwha8/R99mQ/vea
         fzJg==
X-Received: by 10.68.162.130 with SMTP id ya2mr52329825pbb.113.1419530230381;
        Thu, 25 Dec 2014 09:57:10 -0800 (PST)
Received: from localhost (b32.net. [192.81.132.72])
        by mx.google.com with ESMTPSA id e9sm25964046pdp.59.2014.12.25.09.57.08
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Thu, 25 Dec 2014 09:57:09 -0800 (PST)
From:   Kevin Cernekee <cernekee@gmail.com>
To:     ralf@linux-mips.org
Cc:     f.fainelli@gmail.com, jaedon.shin@gmail.com, abrestic@chromium.org,
        tglx@linutronix.de, jason@lakedaemon.net, jogo@openwrt.org,
        arnd@arndb.de, computersforpeace@gmail.com,
        linux-mips@linux-mips.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH V6 07/25] irqchip: brcmstb-l2: don't clear wakeable interrupts at init time
Date:   Thu, 25 Dec 2014 09:49:02 -0800
Message-Id: <1419529760-9520-8-git-send-email-cernekee@gmail.com>
X-Mailer: git-send-email 2.1.1
In-Reply-To: <1419529760-9520-1-git-send-email-cernekee@gmail.com>
References: <1419529760-9520-1-git-send-email-cernekee@gmail.com>
Return-Path: <cernekee@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 44917
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
index 313c2c6..d6bcc6b 100644
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
 	if (!data->parent_irq) {
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
