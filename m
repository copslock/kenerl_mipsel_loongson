Return-Path: <SRS0=dr9w=P5=vger.kernel.org=linux-mips-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48BC2C2F3A0
	for <linux-mips@archiver.kernel.org>; Mon, 21 Jan 2019 14:06:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 18FC32089F
	for <linux-mips@archiver.kernel.org>; Mon, 21 Jan 2019 14:06:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548079614;
	bh=1h7VRctfXPD3uXjvnhmFQVdXYBhDa0cRPo+FG74tblg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=0kQ3eWqhp+o5sY87HWE6zgQ/K1CULFiSAIk0by4HThuBvJN4g2SgyPyQopOBmzrva
	 Pee+WkG+Y+bCOotOZgsM8v7iEgPdnUZR4GpQj2KPtkp7fBCilM/g8o8KA9mQYspvaM
	 G3CGB0yZrMRdd1rUdnul9B+sMnaF4/pK1PwhkMZ0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729944AbfAUOGs (ORCPT <rfc822;linux-mips@archiver.kernel.org>);
        Mon, 21 Jan 2019 09:06:48 -0500
Received: from mail.kernel.org ([198.145.29.99]:46610 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731872AbfAUOAM (ORCPT <rfc822;linux-mips@vger.kernel.org>);
        Mon, 21 Jan 2019 09:00:12 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B94212087F;
        Mon, 21 Jan 2019 14:00:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548079211;
        bh=1h7VRctfXPD3uXjvnhmFQVdXYBhDa0cRPo+FG74tblg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=A586MbHWISu1q0P6CVO489+Bco4R33erG0i/YMh3IPIa15kccCi6XAuXBov32xga5
         ZvXknWRnb8wM9elQU5siDZGWeCloX4UAQ307F7OQ8j2L6m2SG0bW5M3gz0RRcEcqmK
         39tjq8GR9gbtaYKiADiyB4nwhzh88gKK86ClVyG4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Hauke Mehrtens <hauke@hauke-m.de>,
        Paul Burton <paul.burton@mips.com>, jhogan@kernel.org,
        ralf@linux-mips.org, john@phrozen.org, linux-mips@linux-mips.org,
        linux-mips@vger.kernel.org, stable@kernel.org
Subject: [PATCH 4.19 47/99] MIPS: lantiq: Fix IPI interrupt handling
Date:   Mon, 21 Jan 2019 14:48:39 +0100
Message-Id: <20190121134915.762416972@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190121134913.924726465@linuxfoundation.org>
References: <20190121134913.924726465@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-mips-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mips.vger.kernel.org>
X-Mailing-List: linux-mips@vger.kernel.org

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Hauke Mehrtens <hauke@hauke-m.de>

commit 2b4dba55b04b212a7fd1f0395b41d79ee3a9801b upstream.

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

Fixes: 1eed40043579 ("MIPS: smp-mt: Use CPU interrupt controller IPI IRQ domain support")
Cc: stable@kernel.org # v4.12
Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
Signed-off-by: Paul Burton <paul.burton@mips.com>
Cc: jhogan@kernel.org
Cc: ralf@linux-mips.org
Cc: john@phrozen.org
Cc: linux-mips@linux-mips.org
Cc: linux-mips@vger.kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/mips/lantiq/irq.c |   68 +++----------------------------------------------
 1 file changed, 5 insertions(+), 63 deletions(-)

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
@@ -237,7 +239,8 @@ static void ltq_hw_irqdispatch(int modul
 	 * other bits might be bogus
 	 */
 	irq = __fls(irq);
-	do_IRQ((int)irq + MIPS_CPU_IRQ_CASCADE + (INT_NUM_IM_OFFSET * module));
+	hwirq = irq + MIPS_CPU_IRQ_CASCADE + (INT_NUM_IM_OFFSET * module);
+	generic_handle_irq(irq_linear_revmap(ltq_domain, hwirq));
 
 	/* if this is a EBU irq, we need to ack it or get a deadlock */
 	if ((irq == LTQ_ICU_EBU_IRQ) && (module == 0) && LTQ_EBU_PCC_ISTAT)
@@ -245,49 +248,6 @@ static void ltq_hw_irqdispatch(int modul
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
@@ -343,28 +303,10 @@ int __init icu_of_init(struct device_nod
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
 


