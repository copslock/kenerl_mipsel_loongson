Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 06 Apr 2017 14:52:05 +0200 (CEST)
Received: from mail-pg0-x230.google.com ([IPv6:2607:f8b0:400e:c05::230]:35017
        "EHLO mail-pg0-x230.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992136AbdDFMtfnGiVi (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 6 Apr 2017 14:49:35 +0200
Received: by mail-pg0-x230.google.com with SMTP id 81so35574198pgh.2
        for <linux-mips@linux-mips.org>; Thu, 06 Apr 2017 05:49:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=SgcbcNIVf6PVs7VkdNYhv13Y71rJlBahQc+9Wap4k2A=;
        b=j7hQQXh0NBncW3bfJ1d7vjzathp91X6bwwDEWIlCSDVH+QyWXQBPkDYmxdP6F3qWaH
         8g77lZS4f0dVofToMTSxXdP49wy8gesHD5NxVAko/Ov4vNE+OupPqBokidjqJtqf7hRS
         DBCg3rMuPf9LZQBpseA+2BjqlezKZZ6Ve/KHc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=SgcbcNIVf6PVs7VkdNYhv13Y71rJlBahQc+9Wap4k2A=;
        b=mjjr3QhJ3tXm5v7cf//vJ/QK+UxFwR4LanHsYchsiY3ri6XdAxsmVsAHj4IZYJxn6J
         JzHuH404Z36afGozlnbyG9Ex2Z4kk9wPJxFm2dsB2mr6NQiKDT1G1viFtAfX9XF8gts9
         mYKQr9Fb1Lo42pFeLMFCwcNSkkKFrocUXmSNuN3D3ijkKc1I2g0xrVObBGX6JgVPL2KR
         //d7pDrIIY+7m+lhOkmetlMLsTlyXDsTgX70ExnrbmVKCgld4+xdiHbdjhL/4r7qVWjE
         gs9/od6LbdulGGeKq5pSrd3jN8RtEec0KAjrrzhhg6w8UuUelwPvjdVl0JS1dTrXrphe
         nf7g==
X-Gm-Message-State: AFeK/H2eKTU+SZFjZfzXQfBdd9twPeDldY8tcmFt8t4x9TsG33VHaGGZBuNaqgkhKlqls+Sc
X-Received: by 10.98.71.149 with SMTP id p21mr35780219pfi.94.1491482969863;
        Thu, 06 Apr 2017 05:49:29 -0700 (PDT)
Received: from localhost.localdomain ([106.51.240.246])
        by smtp.gmail.com with ESMTPSA id n7sm3892564pfn.0.2017.04.06.05.49.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 06 Apr 2017 05:49:29 -0700 (PDT)
From:   Amit Pundir <amit.pundir@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     stable@vger.kernel.org, james.hogan@imgtec.com,
        Felix Fietkau <nbd@nbd.name>, linux-mips@linux-mips.org
Subject: [PATCH for-4.4 7/7] MIPS: Lantiq: Fix cascaded IRQ setup
Date:   Thu,  6 Apr 2017 18:19:00 +0530
Message-Id: <1491482940-1163-8-git-send-email-amit.pundir@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1491482940-1163-1-git-send-email-amit.pundir@linaro.org>
References: <1491482940-1163-1-git-send-email-amit.pundir@linaro.org>
Return-Path: <amit.pundir@linaro.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 57591
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: amit.pundir@linaro.org
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

From: Felix Fietkau <nbd@nbd.name>

With the IRQ stack changes integrated, the XRX200 devices started
emitting a constant stream of kernel messages like this:

[  565.415310] Spurious IRQ: CAUSE=0x1100c300

This is caused by IP0 getting handled by plat_irq_dispatch() rather than
its vectored interrupt handler, which is fixed by commit de856416e714
("MIPS: IRQ Stack: Fix erroneous jal to plat_irq_dispatch").

Fix plat_irq_dispatch() to handle non-vectored IPI interrupts correctly
by setting up IP2-6 as proper chained IRQ handlers and calling do_IRQ
for all MIPS CPU interrupts.

Signed-off-by: Felix Fietkau <nbd@nbd.name>
Acked-by: John Crispin <john@phrozen.org>
Cc: linux-mips@linux-mips.org
Patchwork: https://patchwork.linux-mips.org/patch/15077/
[james.hogan@imgtec.com: tweaked commit message]
Signed-off-by: James Hogan <james.hogan@imgtec.com>

(cherry picked from commit 6c356eda225e3ee134ed4176b9ae3a76f793f4dd)
Signed-off-by: Amit Pundir <amit.pundir@linaro.org>
---
 arch/mips/lantiq/irq.c | 38 +++++++++++++++++---------------------
 1 file changed, 17 insertions(+), 21 deletions(-)

diff --git a/arch/mips/lantiq/irq.c b/arch/mips/lantiq/irq.c
index 2e7f60c..51cdc46 100644
--- a/arch/mips/lantiq/irq.c
+++ b/arch/mips/lantiq/irq.c
@@ -269,6 +269,11 @@ static void ltq_hw5_irqdispatch(void)
 DEFINE_HWx_IRQDISPATCH(5)
 #endif
 
+static void ltq_hw_irq_handler(struct irq_desc *desc)
+{
+	ltq_hw_irqdispatch(irq_desc_get_irq(desc) - 2);
+}
+
 #ifdef CONFIG_MIPS_MT_SMP
 void __init arch_init_ipiirq(int irq, struct irqaction *action)
 {
@@ -313,23 +318,19 @@ static struct irqaction irq_call = {
 asmlinkage void plat_irq_dispatch(void)
 {
 	unsigned int pending = read_c0_status() & read_c0_cause() & ST0_IM;
-	unsigned int i;
-
-	if ((MIPS_CPU_TIMER_IRQ == 7) && (pending & CAUSEF_IP7)) {
-		do_IRQ(MIPS_CPU_TIMER_IRQ);
-		goto out;
-	} else {
-		for (i = 0; i < MAX_IM; i++) {
-			if (pending & (CAUSEF_IP2 << i)) {
-				ltq_hw_irqdispatch(i);
-				goto out;
-			}
-		}
+	int irq;
+
+	if (!pending) {
+		spurious_interrupt();
+		return;
 	}
-	pr_alert("Spurious IRQ: CAUSE=0x%08x\n", read_c0_status());
 
-out:
-	return;
+	pending >>= CAUSEB_IP;
+	while (pending) {
+		irq = fls(pending) - 1;
+		do_IRQ(MIPS_CPU_IRQ_BASE + irq);
+		pending &= ~BIT(irq);
+	}
 }
 
 static int icu_map(struct irq_domain *d, unsigned int irq, irq_hw_number_t hw)
@@ -354,11 +355,6 @@ static const struct irq_domain_ops irq_domain_ops = {
 	.map = icu_map,
 };
 
-static struct irqaction cascade = {
-	.handler = no_action,
-	.name = "cascade",
-};
-
 int __init icu_of_init(struct device_node *node, struct device_node *parent)
 {
 	struct device_node *eiu_node;
@@ -390,7 +386,7 @@ int __init icu_of_init(struct device_node *node, struct device_node *parent)
 	mips_cpu_irq_init();
 
 	for (i = 0; i < MAX_IM; i++)
-		setup_irq(i + 2, &cascade);
+		irq_set_chained_handler(i + 2, ltq_hw_irq_handler);
 
 	if (cpu_has_vint) {
 		pr_info("Setting up vectored interrupts\n");
-- 
2.7.4
