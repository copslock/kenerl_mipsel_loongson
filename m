Return-Path: <SRS0=CsrV=PO=vger.kernel.org=linux-mips-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73CE5C43612
	for <linux-mips@archiver.kernel.org>; Sun,  6 Jan 2019 18:44:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4AC6F213A2
	for <linux-mips@archiver.kernel.org>; Sun,  6 Jan 2019 18:44:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726014AbfAFSoe (ORCPT <rfc822;linux-mips@archiver.kernel.org>);
        Sun, 6 Jan 2019 13:44:34 -0500
Received: from mx1.mailbox.org ([80.241.60.212]:25690 "EHLO mx1.mailbox.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726034AbfAFSoe (ORCPT <rfc822;linux-mips@vger.kernel.org>);
        Sun, 6 Jan 2019 13:44:34 -0500
Received: from smtp1.mailbox.org (smtp1.mailbox.org [80.241.60.240])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by mx1.mailbox.org (Postfix) with ESMTPS id 144344BBDF;
        Sun,  6 Jan 2019 19:44:33 +0100 (CET)
X-Virus-Scanned: amavisd-new at heinlein-support.de
Received: from smtp1.mailbox.org ([80.241.60.240])
        by spamfilter04.heinlein-hosting.de (spamfilter04.heinlein-hosting.de [80.241.56.122]) (amavisd-new, port 10030)
        with ESMTP id zkAVtbGT6bFO; Sun,  6 Jan 2019 19:44:32 +0100 (CET)
From:   Hauke Mehrtens <hauke@hauke-m.de>
To:     paul.burton@mips.com
Cc:     jhogan@kernel.org, ralf@linux-mips.org, john@phrozen.org,
        linux-mips@linux-mips.org, linux-mips@vger.kernel.org,
        Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 2/2] MIPS: lantiq: Use CP0_LEGACY_COMPARE_IRQ
Date:   Sun,  6 Jan 2019 19:44:12 +0100
Message-Id: <20190106184412.18096-2-hauke@hauke-m.de>
In-Reply-To: <20190106184412.18096-1-hauke@hauke-m.de>
References: <20190106184412.18096-1-hauke@hauke-m.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-mips-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mips.vger.kernel.org>
X-Mailing-List: linux-mips@vger.kernel.org

Instead of using the lantiq specific MIPS_CPU_TIMER_IRQ use the generic
CP0_LEGACY_COMPARE_IRQ constant for the timer interrupt number.
MIPS_CPU_TIMER_IRQ was already defined to 7 for both supported SoC
families.

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 arch/mips/include/asm/mach-lantiq/falcon/falcon_irq.h | 2 --
 arch/mips/include/asm/mach-lantiq/xway/lantiq_irq.h   | 2 --
 arch/mips/lantiq/irq.c                                | 9 +--------
 3 files changed, 1 insertion(+), 12 deletions(-)

diff --git a/arch/mips/include/asm/mach-lantiq/falcon/falcon_irq.h b/arch/mips/include/asm/mach-lantiq/falcon/falcon_irq.h
index c6b63a409641..6dd8ad2409dc 100644
--- a/arch/mips/include/asm/mach-lantiq/falcon/falcon_irq.h
+++ b/arch/mips/include/asm/mach-lantiq/falcon/falcon_irq.h
@@ -18,8 +18,6 @@
 #define INT_NUM_EXTRA_START		(INT_NUM_IM4_IRL0 + 32)
 #define INT_NUM_IM_OFFSET		(INT_NUM_IM1_IRL0 - INT_NUM_IM0_IRL0)
 
-#define MIPS_CPU_TIMER_IRQ			7
-
 #define MAX_IM			5
 
 #endif /* _FALCON_IRQ__ */
diff --git a/arch/mips/include/asm/mach-lantiq/xway/lantiq_irq.h b/arch/mips/include/asm/mach-lantiq/xway/lantiq_irq.h
index 141076325307..0b424214a5e9 100644
--- a/arch/mips/include/asm/mach-lantiq/xway/lantiq_irq.h
+++ b/arch/mips/include/asm/mach-lantiq/xway/lantiq_irq.h
@@ -19,8 +19,6 @@
 
 #define LTQ_DMA_CH0_INT		(INT_NUM_IM2_IRL0)
 
-#define MIPS_CPU_TIMER_IRQ	7
-
 #define MAX_IM			5
 
 #endif
diff --git a/arch/mips/lantiq/irq.c b/arch/mips/lantiq/irq.c
index c4ef1c31e0c4..6549499eb202 100644
--- a/arch/mips/lantiq/irq.c
+++ b/arch/mips/lantiq/irq.c
@@ -310,13 +310,6 @@ int __init icu_of_init(struct device_node *node, struct device_node *parent)
 	/* tell oprofile which irq to use */
 	ltq_perfcount_irq = irq_create_mapping(ltq_domain, LTQ_PERF_IRQ);
 
-	/*
-	 * if the timer irq is not one of the mips irqs we need to
-	 * create a mapping
-	 */
-	if (MIPS_CPU_TIMER_IRQ != 7)
-		irq_create_mapping(ltq_domain, MIPS_CPU_TIMER_IRQ);
-
 	/* the external interrupts are optional and xway only */
 	eiu_node = of_find_compatible_node(NULL, NULL, "lantiq,eiu-xway");
 	if (eiu_node && !of_address_to_resource(eiu_node, 0, &res)) {
@@ -353,7 +346,7 @@ EXPORT_SYMBOL_GPL(get_c0_perfcount_int);
 
 unsigned int get_c0_compare_int(void)
 {
-	return MIPS_CPU_TIMER_IRQ;
+	return CP0_LEGACY_COMPARE_IRQ;
 }
 
 static struct of_device_id __initdata of_irq_ids[] = {
-- 
2.20.1

