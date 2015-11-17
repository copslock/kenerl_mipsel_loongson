Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 18 Nov 2015 17:43:26 +0100 (CET)
Received: from smtpfb1-g21.free.fr ([212.27.42.9]:33771 "EHLO
        smtpfb1-g21.free.fr" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27005125AbbKRQnYYe0KI (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 18 Nov 2015 17:43:24 +0100
Received: from smtp3-g21.free.fr (smtp3-g21.free.fr [212.27.42.3])
        by smtpfb1-g21.free.fr (Postfix) with ESMTP id 1929B2E251;
        Tue, 17 Nov 2015 20:35:43 +0100 (CET)
Received: from localhost.localdomain (unknown [80.171.215.189])
        (Authenticated sender: albeu)
        by smtp3-g21.free.fr (Postfix) with ESMTPA id 4EA14A6236;
        Tue, 17 Nov 2015 20:35:26 +0100 (CET)
From:   Alban Bedel <albeu@free.fr>
To:     linux-mips@linux-mips.org
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Alexander Couzens <lynxis@fe80.eu>,
        Joel Porquet <joel@porquet.org>,
        Andrew Bresticker <abrestic@chromium.org>,
        linux-kernel@vger.kernel.org, Alban Bedel <albeu@free.fr>
Subject: [PATCH 2/6] MIPS: ath79: irq: Remove useless #ifdef CONFIG_IRQCHIP
Date:   Tue, 17 Nov 2015 20:34:52 +0100
Message-Id: <1447788896-15553-3-git-send-email-albeu@free.fr>
X-Mailer: git-send-email 2.0.0
In-Reply-To: <1447788896-15553-1-git-send-email-albeu@free.fr>
References: <1447788896-15553-1-git-send-email-albeu@free.fr>
Return-Path: <albeu@free.fr>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 49972
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: albeu@free.fr
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

IRQCHIP is always enabled, so the #ifdef can just be removed.

Signed-off-by: Alban Bedel <albeu@free.fr>
---
 arch/mips/ath79/irq.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/arch/mips/ath79/irq.c b/arch/mips/ath79/irq.c
index eeb3953..26f8d1b 100644
--- a/arch/mips/ath79/irq.c
+++ b/arch/mips/ath79/irq.c
@@ -256,7 +256,6 @@ asmlinkage void plat_irq_dispatch(void)
 	}
 }
 
-#ifdef CONFIG_IRQCHIP
 static int misc_map(struct irq_domain *d, unsigned int irq, irq_hw_number_t hw)
 {
 	irq_set_chip_and_handler(irq, &ath79_misc_irq_chip, handle_level_irq);
@@ -349,8 +348,6 @@ static int __init ar79_cpu_intc_of_init(
 IRQCHIP_DECLARE(ar79_cpu_intc, "qca,ar7100-cpu-intc",
 		ar79_cpu_intc_of_init);
 
-#endif
-
 void __init arch_init_irq(void)
 {
 	if (mips_machtype == ATH79_MACH_GENERIC_OF) {
-- 
2.0.0
