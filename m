Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 09 Jul 2015 10:51:55 +0200 (CEST)
Received: from smtp3-g21.free.fr ([212.27.42.3]:30211 "EHLO smtp3-g21.free.fr"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27008545AbbGIIvye3FtL (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 9 Jul 2015 10:51:54 +0200
Received: from localhost.localdomain (unknown [176.4.113.222])
        (Authenticated sender: albeu)
        by smtp3-g21.free.fr (Postfix) with ESMTPA id E82D2A6325;
        Thu,  9 Jul 2015 10:51:46 +0200 (CEST)
From:   Alban Bedel <albeu@free.fr>
To:     linux-mips@linux-mips.org
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ralf Baechle <ralf@linux-mips.org>,
        Andrew Bresticker <abrestic@chromium.org>,
        Qais Yousef <qais.yousef@imgtec.com>,
        linux-kernel@vger.kernel.org, Alban Bedel <albeu@free.fr>
Subject: [PATCH] MIPS: ath79: irq: IRQCHIP_DECLARE moved to linux/irqchip.h
Date:   Thu,  9 Jul 2015 10:51:36 +0200
Message-Id: <1436431896-21010-1-git-send-email-albeu@free.fr>
X-Mailer: git-send-email 2.0.0
Return-Path: <albeu@free.fr>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 48134
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

Remove the ugly cross tree include now that IRQCHIP_DECLARE moved to
linux/irqchip.h.

Signed-off-by: Alban Bedel <albeu@free.fr>
---
 arch/mips/ath79/irq.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/mips/ath79/irq.c b/arch/mips/ath79/irq.c
index afb0096..2021be2 100644
--- a/arch/mips/ath79/irq.c
+++ b/arch/mips/ath79/irq.c
@@ -17,7 +17,6 @@
 #include <linux/interrupt.h>
 #include <linux/irqchip.h>
 #include <linux/of_irq.h>
-#include "../../../drivers/irqchip/irqchip.h"
 
 #include <asm/irq_cpu.h>
 #include <asm/mipsregs.h>
-- 
2.0.0
