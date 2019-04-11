Return-Path: <SRS0=fNfu=SN=vger.kernel.org=linux-mips-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83A67C10F13
	for <linux-mips@archiver.kernel.org>; Thu, 11 Apr 2019 18:07:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6117920850
	for <linux-mips@archiver.kernel.org>; Thu, 11 Apr 2019 18:07:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726599AbfDKSHE (ORCPT <rfc822;linux-mips@archiver.kernel.org>);
        Thu, 11 Apr 2019 14:07:04 -0400
Received: from smtp-out.xnet.cz ([178.217.244.18]:58158 "EHLO smtp-out.xnet.cz"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726595AbfDKSHE (ORCPT <rfc822;linux-mips@vger.kernel.org>);
        Thu, 11 Apr 2019 14:07:04 -0400
Received: from meh.true.cz (meh.true.cz [108.61.167.218])
        (Authenticated sender: petr@true.cz)
        by smtp-out.xnet.cz (Postfix) with ESMTPSA id A734F3BE7;
        Thu, 11 Apr 2019 20:07:00 +0200 (CEST)
Received: by meh.true.cz (OpenSMTPD) with ESMTP id 496682da;
        Thu, 11 Apr 2019 20:06:58 +0200 (CEST)
From:   =?UTF-8?q?Petr=20=C5=A0tetiar?= <ynezz@true.cz>
To:     linux-mips@vger.kernel.org
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        James Hogan <jhogan@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <marc.zyngier@arm.com>,
        John Crispin <john@phrozen.org>,
        =?UTF-8?q?Petr=20=C5=A0tetiar?= <ynezz@true.cz>
Subject: [PATCH] MIPS: perf: ath79: Fix perfcount IRQ assignment
Date:   Thu, 11 Apr 2019 20:06:49 +0200
Message-Id: <1555006009-5764-1-git-send-email-ynezz@true.cz>
X-Mailer: git-send-email 1.9.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-mips-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mips.vger.kernel.org>
X-Mailing-List: linux-mips@vger.kernel.org

Currently it's not possible to use perf on ath79 due to genirq flags
mismatch happening on static IRQ 13 which is used for performance
counters interrupt.

On TP-Link Archer C7v5:

           CPU0
  2:          0      MIPS   2  ath9k
  4:        318      MIPS   4  19000000.eth
  7:      55034      MIPS   7  timer
  8:       1236      MISC   3  ttyS0
 12:          0      INTC   1  ehci_hcd:usb1
 13:          0  gpio-ath79   2  keys
 14:          0  gpio-ath79   5  keys
 15:         31  AR724X PCI    1  ath10k_pci

 $ perf top
 genirq: Flags mismatch irq 13. 00014c83 (mips_perf_pmu) vs. 00002003 (keys)

On TP-Link Archer C7v4:

         CPU0
  4:          0      MIPS   4  19000000.eth
  5:       7135      MIPS   5  1a000000.eth
  7:      98379      MIPS   7  timer
  8:         30      MISC   3  ttyS0
 12:      90028      INTC   0  ath9k
 13:       5520      INTC   1  ehci_hcd:usb1
 14:       4623      INTC   2  ehci_hcd:usb2
 15:      32844  AR724X PCI    1  ath10k_pci
 16:          0  gpio-ath79  16  keys
 23:          0  gpio-ath79  23  keys

 $ perf top
 genirq: Flags mismatch irq 13. 00014c80 (mips_perf_pmu) vs. 00000080 (ehci_hcd:usb1)

This problem is happening, because the statically assigned IRQ 13 for
performance counters is not claimed during the initialization of MIPS
PMU during the bootup, so the IRQ subsystem doesn't know, that this
interrupt isn't available for further use.

So this patch simply books IRQ 13 for MIPS PMU if the kernel is compiled
with performance counters functionality.

Tested-by: Kevin 'ldir' Darbyshire-Bryant <ldir@darbyshire-bryant.me.uk>
Signed-off-by: Petr Štetiar <ynezz@true.cz>
---
 arch/mips/ath79/setup.c          |  6 ------
 drivers/irqchip/irq-ath79-misc.c | 13 +++++++++++++
 2 files changed, 13 insertions(+), 6 deletions(-)

diff --git a/arch/mips/ath79/setup.c b/arch/mips/ath79/setup.c
index 4a70c5d..25a5789 100644
--- a/arch/mips/ath79/setup.c
+++ b/arch/mips/ath79/setup.c
@@ -210,12 +210,6 @@ const char *get_system_type(void)
 	return ath79_sys_type;
 }
 
-int get_c0_perfcount_int(void)
-{
-	return ATH79_MISC_IRQ(5);
-}
-EXPORT_SYMBOL_GPL(get_c0_perfcount_int);
-
 unsigned int get_c0_compare_int(void)
 {
 	return CP0_LEGACY_COMPARE_IRQ;
diff --git a/drivers/irqchip/irq-ath79-misc.c b/drivers/irqchip/irq-ath79-misc.c
index aa72907..77b3348 100644
--- a/drivers/irqchip/irq-ath79-misc.c
+++ b/drivers/irqchip/irq-ath79-misc.c
@@ -22,6 +22,15 @@
 #define AR71XX_RESET_REG_MISC_INT_ENABLE	4
 
 #define ATH79_MISC_IRQ_COUNT			32
+#define ATH79_MISC_PERF_IRQ			ATH79_MISC_IRQ(5)
+
+static int ath79_perfcount_irq;
+
+int get_c0_perfcount_int(void)
+{
+	return ath79_perfcount_irq;
+}
+EXPORT_SYMBOL_GPL(get_c0_perfcount_int);
 
 static void ath79_misc_irq_handler(struct irq_desc *desc)
 {
@@ -113,6 +122,10 @@ static void __init ath79_misc_intc_domain_init(
 {
 	void __iomem *base = domain->host_data;
 
+#ifdef CONFIG_PERF_EVENTS
+	ath79_perfcount_irq = irq_create_mapping(domain, ATH79_MISC_PERF_IRQ);
+#endif
+
 	/* Disable and clear all interrupts */
 	__raw_writel(0, base + AR71XX_RESET_REG_MISC_INT_ENABLE);
 	__raw_writel(0, base + AR71XX_RESET_REG_MISC_INT_STATUS);
-- 
1.9.1

