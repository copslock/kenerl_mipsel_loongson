Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 04 Apr 2017 08:17:18 +0200 (CEST)
Received: from mail-pg0-x233.google.com ([IPv6:2607:f8b0:400e:c05::233]:36600
        "EHLO mail-pg0-x233.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990509AbdDDGRJLryeU (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 4 Apr 2017 08:17:09 +0200
Received: by mail-pg0-x233.google.com with SMTP id g2so140783858pge.3
        for <linux-mips@linux-mips.org>; Mon, 03 Apr 2017 23:17:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=bty6R6DYul67AKn+issoCh5QE2qoeZmvASm1stWPxWQ=;
        b=d01WXXFal1MfKSYlfe1VQzteZiKn9NAaIchn2t3AfRXDNcgZAzESaMwgT1yqlC1mUW
         AzYklgMnA/5/bhuDsx6WjWUMPRhHdn2/nYG941bM9/AGPTy1YroyisxBQUg9ux0KneeH
         e0v6b/pGnw1IulDjmXA28bL6ES/ewMD6frDUg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=bty6R6DYul67AKn+issoCh5QE2qoeZmvASm1stWPxWQ=;
        b=b9Dx1Jf/NAG6yzCx5uU8OicWpP09BrfzPYslbRAhiC/jnhD2CoNNfF0pRhwMe/WYeR
         sk2azvLMP12RiGlgEBwixeZQerzfj3pqipgAD8S+cdl01XBW5bR15Zhmyx/pWeP5D16c
         QAzJ1FHnFwWSf7FGmWRJrmjmSN8Djl1qYs4MQNPXePtIIeO+n1oaAmLxamyFH/PuKuGH
         BjJKkRmPdffOTsh08et36ZZZaVy7J3ZN7RtEZpM/liWfyLx7qRw5kFUp00QsHmbIJj2M
         fLRIs7bRTsCLtjtbUljSxJweQutoq7vxm2E8k6RAs6lBiNLH7jTIJV4MAEyJBJL9xva5
         E0UQ==
X-Gm-Message-State: AFeK/H0D0xpYqAwcpvi2MIIK6ICh8mvSG44qjIAmqi8XDicLT+rw3o/+zB/rNG9fcG5v5/Fm
X-Received: by 10.98.138.80 with SMTP id y77mr292303pfd.183.1491286623035;
        Mon, 03 Apr 2017 23:17:03 -0700 (PDT)
Received: from localhost.localdomain ([106.51.240.246])
        by smtp.gmail.com with ESMTPSA id f81sm29247068pfe.61.2017.04.03.23.17.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 03 Apr 2017 23:17:02 -0700 (PDT)
From:   Amit Pundir <amit.pundir@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     stable@vger.kernel.org, Felix Fietkau <nbd@nbd.name>,
        linux-mips@linux-mips.org, James Hogan <james.hogan@imgtec.com>
Subject: [PATCH 05/33] MIPS: Lantiq: Fix cascaded IRQ setup
Date:   Tue,  4 Apr 2017 11:46:53 +0530
Message-Id: <1491286617-31131-2-git-send-email-amit.pundir@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1491286617-31131-1-git-send-email-amit.pundir@linaro.org>
References: <1491286617-31131-1-git-send-email-amit.pundir@linaro.org>
Return-Path: <amit.pundir@linaro.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 57552
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
index 8ac0e59..0ddf369 100644
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
