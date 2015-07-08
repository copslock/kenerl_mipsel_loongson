Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 08 Jul 2015 20:11:29 +0200 (CEST)
Received: from smtp4-g21.free.fr ([212.27.42.4]:4339 "EHLO smtp4-g21.free.fr"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27010837AbbGHSL1lLXcT (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 8 Jul 2015 20:11:27 +0200
Received: from localhost.localdomain (unknown [176.0.10.208])
        (Authenticated sender: albeu)
        by smtp4-g21.free.fr (Postfix) with ESMTPA id 8909D4C80AF;
        Wed,  8 Jul 2015 20:11:19 +0200 (CEST)
From:   Alban Bedel <albeu@free.fr>
To:     linux-mips@linux-mips.org
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ralf Baechle <ralf@linux-mips.org>,
        Andrew Bresticker <abrestic@chromium.org>,
        Qais Yousef <qais.yousef@imgtec.com>,
        linux-kernel@vger.kernel.org, Alban Bedel <albeu@free.fr>
Subject: [PATCH] MIPS: ath79: irq: Remove the include of drivers/irqchip/irqchip.h
Date:   Wed,  8 Jul 2015 20:11:11 +0200
Message-Id: <1436379071-31574-1-git-send-email-albeu@free.fr>
X-Mailer: git-send-email 2.0.0
Return-Path: <albeu@free.fr>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 48127
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

We shouldn't include irqchip.h from outside of the drivers/irqchip
directory. The irq driver should idealy be there, however this not
trivial at the moment. We still need to support platforms without DT
support and the interface to the DDR controller still use a custom
arch specific API.

For now just redefine the IRQCHIP_DECLARE macro to avoid the cross
tree include.

Signed-off-by: Alban Bedel <albeu@free.fr>
---
 arch/mips/ath79/irq.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/arch/mips/ath79/irq.c b/arch/mips/ath79/irq.c
index afb0096..c5ad737 100644
--- a/arch/mips/ath79/irq.c
+++ b/arch/mips/ath79/irq.c
@@ -17,7 +17,6 @@
 #include <linux/interrupt.h>
 #include <linux/irqchip.h>
 #include <linux/of_irq.h>
-#include "../../../drivers/irqchip/irqchip.h"
 
 #include <asm/irq_cpu.h>
 #include <asm/mipsregs.h>
@@ -272,6 +271,13 @@ asmlinkage void plat_irq_dispatch(void)
 }
 
 #ifdef CONFIG_IRQCHIP
+/*
+ * We cannot use the IRQCHIP_DECLARE macro that lives in
+ * drivers/irqchip, so we're forced to roll our own. Not very nice,
+ * but should do until this code is moved to drivers/irqchip.
+ */
+#define IRQCHIP_DECLARE(name, compat, fn) OF_DECLARE_2(irqchip, name, compat, fn)
+
 static int misc_map(struct irq_domain *d, unsigned int irq, irq_hw_number_t hw)
 {
 	irq_set_chip_and_handler(irq, &ath79_misc_irq_chip, handle_level_irq);
-- 
2.0.0
