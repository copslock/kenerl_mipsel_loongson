Return-Path: <SRS0=CsrV=PO=vger.kernel.org=linux-mips-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58E3BC43387
	for <linux-mips@archiver.kernel.org>; Sun,  6 Jan 2019 18:44:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 283E62087F
	for <linux-mips@archiver.kernel.org>; Sun,  6 Jan 2019 18:44:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726036AbfAFSoe (ORCPT <rfc822;linux-mips@archiver.kernel.org>);
        Sun, 6 Jan 2019 13:44:34 -0500
Received: from mx1.mailbox.org ([80.241.60.212]:25636 "EHLO mx1.mailbox.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726014AbfAFSoe (ORCPT <rfc822;linux-mips@vger.kernel.org>);
        Sun, 6 Jan 2019 13:44:34 -0500
Received: from smtp1.mailbox.org (smtp1.mailbox.org [IPv6:2001:67c:2050:105:465:1:1:0])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by mx1.mailbox.org (Postfix) with ESMTPS id CC0BE4BBC5;
        Sun,  6 Jan 2019 19:44:31 +0100 (CET)
X-Virus-Scanned: amavisd-new at heinlein-support.de
Received: from smtp1.mailbox.org ([80.241.60.240])
        by spamfilter03.heinlein-hosting.de (spamfilter03.heinlein-hosting.de [80.241.56.117]) (amavisd-new, port 10030)
        with ESMTP id gS8fToNvPCi1; Sun,  6 Jan 2019 19:44:30 +0100 (CET)
From:   Hauke Mehrtens <hauke@hauke-m.de>
To:     paul.burton@mips.com
Cc:     jhogan@kernel.org, ralf@linux-mips.org, john@phrozen.org,
        linux-mips@linux-mips.org, linux-mips@vger.kernel.org,
        Hauke Mehrtens <hauke@hauke-m.de>, stable@kernel.org
Subject: [PATCH 1/2] MIPS: lantiq: Fix IPI interrupt handling
Date:   Sun,  6 Jan 2019 19:44:11 +0100
Message-Id: <20190106184412.18096-1-hauke@hauke-m.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-mips-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mips.vger.kernel.org>
X-Mailing-List: linux-mips@vger.kernel.org

This makes SMP on the vrx200 work again, by removing all the MIPS CPU
interrupt specific code and making it fully use the generic MIPS CPU
interrupt controller.

The mti,cpu-interrupt-controller from irq-mips-cpu.c now handles the CPU
interrupts and also the IPI interrupts which are used to communication
between the CPUs in a SMP system. The generic interrupt code was
already used before but the interrupt vectors were overwritten again
when we called set_vi_handler() in the lantiq interrupt driver and we
also provided our own plat_irq_dispatch() function which overwrote the
weak generic implementation. Now the code uses the generic handler for
the MIPS CPU interrupts including the IPI interrupts and registers a
handler for the CPU interrupts which are handled by the lantiq ICU with
irq_set_chained_handler() which was already called before.

Calling the set_c0_status() function is also not needed any more because
the generic MIPS CPU interrupt already activates the needed bits.

Fixes 1eed40043579 ("MIPS: smp-mt: Use CPU interrupt controller IPI IRQ domain support")
Cc: stable@kernel.org # v4.12
Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 arch/mips/lantiq/irq.c | 68 ++++--------------------------------------
 1 file changed, 5 insertions(+), 63 deletions(-)

diff --git a/arch/mips/lantiq/irq.c b/arch/mips/lantiq/irq.c
index f0bc3312ed11..c4ef1c31e0c4 100644
--- a/arch/mips/lantiq/irq.c
+++ b/arch/mips/lantiq/irq.c
@@ -224,9 +224,11 @@ static struct irq_chip ltq_eiu_type = {
 	.irq_set_type = ltq_eiu_settype,
 };
 
-static void ltq_hw_irqdispatch(int module)
+static void ltq_hw_irq_handler(struct irq_desc *desc)
 {
+	int module = irq_desc_get_irq(desc) - 2;
 	u32 irq;
+	int hwirq;
 
 	irq = ltq_icu_r32(module, LTQ_ICU_IM0_IOSR);
 	if (irq == 0)
@@ -237,7 +239,8 @@ static void ltq_hw_irqdispatch(int module)
 	 * other bits might be bogus
 	 */
 	irq = __fls(irq);
-	do_IRQ((int)irq + MIPS_CPU_IRQ_CASCADE + (INT_NUM_IM_OFFSET * module));
+	hwirq = irq + MIPS_CPU_IRQ_CASCADE + (INT_NUM_IM_OFFSET * module);
+	generic_handle_irq(irq_linear_revmap(ltq_domain, hwirq));
 
 	/* if this is a EBU irq, we need to ack it or get a deadlock */
 	if ((irq == LTQ_ICU_EBU_IRQ) && (module == 0) && LTQ_EBU_PCC_ISTAT)
@@ -245,49 +248,6 @@ static void ltq_hw_irqdispatch(int module)
 			LTQ_EBU_PCC_ISTAT);
 }
 
-#define DEFINE_HWx_IRQDISPATCH(x)					\
-	static void ltq_hw ## x ## _irqdispatch(void)			\
-	{								\
-		ltq_hw_irqdispatch(x);					\
-	}
-DEFINE_HWx_IRQDISPATCH(0)
-DEFINE_HWx_IRQDISPATCH(1)
-DEFINE_HWx_IRQDISPATCH(2)
-DEFINE_HWx_IRQDISPATCH(3)
-DEFINE_HWx_IRQDISPATCH(4)
-
-#if MIPS_CPU_TIMER_IRQ == 7
-static void ltq_hw5_irqdispatch(void)
-{
-	do_IRQ(MIPS_CPU_TIMER_IRQ);
-}
-#else
-DEFINE_HWx_IRQDISPATCH(5)
-#endif
-
-static void ltq_hw_irq_handler(struct irq_desc *desc)
-{
-	ltq_hw_irqdispatch(irq_desc_get_irq(desc) - 2);
-}
-
-asmlinkage void plat_irq_dispatch(void)
-{
-	unsigned int pending = read_c0_status() & read_c0_cause() & ST0_IM;
-	int irq;
-
-	if (!pending) {
-		spurious_interrupt();
-		return;
-	}
-
-	pending >>= CAUSEB_IP;
-	while (pending) {
-		irq = fls(pending) - 1;
-		do_IRQ(MIPS_CPU_IRQ_BASE + irq);
-		pending &= ~BIT(irq);
-	}
-}
-
 static int icu_map(struct irq_domain *d, unsigned int irq, irq_hw_number_t hw)
 {
 	struct irq_chip *chip = &ltq_irq_type;
@@ -343,28 +303,10 @@ int __init icu_of_init(struct device_node *node, struct device_node *parent)
 	for (i = 0; i < MAX_IM; i++)
 		irq_set_chained_handler(i + 2, ltq_hw_irq_handler);
 
-	if (cpu_has_vint) {
-		pr_info("Setting up vectored interrupts\n");
-		set_vi_handler(2, ltq_hw0_irqdispatch);
-		set_vi_handler(3, ltq_hw1_irqdispatch);
-		set_vi_handler(4, ltq_hw2_irqdispatch);
-		set_vi_handler(5, ltq_hw3_irqdispatch);
-		set_vi_handler(6, ltq_hw4_irqdispatch);
-		set_vi_handler(7, ltq_hw5_irqdispatch);
-	}
-
 	ltq_domain = irq_domain_add_linear(node,
 		(MAX_IM * INT_NUM_IM_OFFSET) + MIPS_CPU_IRQ_CASCADE,
 		&irq_domain_ops, 0);
 
-#ifndef CONFIG_MIPS_MT_SMP
-	set_c0_status(IE_IRQ0 | IE_IRQ1 | IE_IRQ2 |
-		IE_IRQ3 | IE_IRQ4 | IE_IRQ5);
-#else
-	set_c0_status(IE_SW0 | IE_SW1 | IE_IRQ0 | IE_IRQ1 |
-		IE_IRQ2 | IE_IRQ3 | IE_IRQ4 | IE_IRQ5);
-#endif
-
 	/* tell oprofile which irq to use */
 	ltq_perfcount_irq = irq_create_mapping(ltq_domain, LTQ_PERF_IRQ);
 
-- 
2.20.1

