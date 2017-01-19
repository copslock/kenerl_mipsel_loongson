Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 19 Jan 2017 12:28:32 +0100 (CET)
Received: from nbd.name ([IPv6:2a01:4f8:131:30e2::2]:40314 "EHLO nbd.name"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23993014AbdASL2ZujkVB (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 19 Jan 2017 12:28:25 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name; s=20160729;
        h=Message-Id:Date:Subject:Cc:To:From; bh=Tri6NYnIB+XTgXiqg0fRt4AxKo2s1ZUoj+KLVuxLFsY=;
        b=RJAh5lIwvMQ2s7s9Hd+7YwJnR3kMWjjGxhumRkwW4kbYoyKq9tTAmNSuUW9HMUfsFBQjwhNe9fwnvVACYmKISy8xWbgUsKKfkrPQk9apqsaB2lxfHkjRDFsyeUWq8xzDew7jaLdey7YjHGpGTV76k+PDpX7k+mWLh08pm5tWryc=;
Received: by nf-4.local (Postfix, from userid 501)
        id 6F7EB185706E9; Thu, 19 Jan 2017 12:28:22 +0100 (CET)
From:   Felix Fietkau <nbd@nbd.name>
To:     linux-mips@linux-mips.org
Cc:     ralf@linux-mips.org, john@phrozen.org
Subject: [PATCH] MIPS: Lantiq: Fix cascaded IRQ setup
Date:   Thu, 19 Jan 2017 12:28:22 +0100
Message-Id: <20170119112822.59445-1-nbd@nbd.name>
X-Mailer: git-send-email 2.11.0
Return-Path: <nbd@nbd.name>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 56416
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: nbd@nbd.name
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

With the IRQ stack changes integrated, the XRX200 devices started
emitting a constant stream of kernel messages like this:

[  565.415310] Spurious IRQ: CAUSE=0x1100c300

This appears to be caused by IP0 firing for some reason without being
handled. Fix this by setting up IP2-6 as a proper chained IRQ handler and
calling do_IRQ for all MIPS CPU interrupts.

Cc: john@phrozen.org
Cc: stable@vger.kernel.org
Signed-off-by: Felix Fietkau <nbd@nbd.name>
---
 arch/mips/lantiq/irq.c | 38 +++++++++++++++++---------------------
 1 file changed, 17 insertions(+), 21 deletions(-)

diff --git a/arch/mips/lantiq/irq.c b/arch/mips/lantiq/irq.c
index 8ac0e5994ed2..0ddf3698b85d 100644
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
2.11.0
