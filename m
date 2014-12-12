Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 12 Dec 2014 23:09:49 +0100 (CET)
Received: from mail-pa0-f54.google.com ([209.85.220.54]:57386 "EHLO
        mail-pa0-f54.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27008599AbaLLWI0j0V8T (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 12 Dec 2014 23:08:26 +0100
Received: by mail-pa0-f54.google.com with SMTP id fb1so8071589pad.13
        for <multiple recipients>; Fri, 12 Dec 2014 14:08:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=X9LBZPRKtSqt/8b8cmreX/QIqZmZPh1Uiu6tea6VsS0=;
        b=o/aq2sMYc0T1QNSbj9CHUBFeGATQwoVKcmiNeQjhp+KQ61AP1dh4szV0ZTs4do1aze
         6Sy9/Jol9Q5b1n/7gqvzd7/MnLHehfh6Qptw2drwWn9W+hBXHHPFUMqPPhi8Vvcrtan8
         VB1+tWXaEjlfdbPTlIuP4IqnbHnOo804WjYQiyLiSMRM98FOUZqyccdJjKBpYFERs2qf
         ITp3aB3l/j7McVh/hQ4dRmgL6+fQI6Znqu4EstFzqFLhcSZpRV1SKHw5BZxzJmk0oAxD
         x2dXnVqvuW6azWWgPnsaoas2nzs4as9mswwa541g22IUPPIjQm35boEeVRPmtX1yGhX7
         IGnQ==
X-Received: by 10.66.235.74 with SMTP id uk10mr30985837pac.16.1418422101052;
        Fri, 12 Dec 2014 14:08:21 -0800 (PST)
Received: from localhost (b32.net. [192.81.132.72])
        by mx.google.com with ESMTPSA id tm3sm2425841pac.12.2014.12.12.14.08.19
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Fri, 12 Dec 2014 14:08:20 -0800 (PST)
From:   Kevin Cernekee <cernekee@gmail.com>
To:     ralf@linux-mips.org
Cc:     f.fainelli@gmail.com, tglx@linutronix.de, jason@lakedaemon.net,
        jogo@openwrt.org, arnd@arndb.de, computersforpeace@gmail.com,
        linux-mips@linux-mips.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH V5 05/23] irqchip: brcmstb-l2: don't clear wakeable interrupts at init time
Date:   Fri, 12 Dec 2014 14:06:56 -0800
Message-Id: <1418422034-17099-6-git-send-email-cernekee@gmail.com>
X-Mailer: git-send-email 2.1.1
In-Reply-To: <1418422034-17099-1-git-send-email-cernekee@gmail.com>
References: <1418422034-17099-1-git-send-email-cernekee@gmail.com>
Return-Path: <cernekee@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 44643
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
