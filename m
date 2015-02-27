Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 27 Feb 2015 13:14:37 +0100 (CET)
Received: from osiris.lip6.fr ([132.227.60.30]:57974 "EHLO osiris.lip6.fr"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27007566AbbB0MOfdVwHv (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 27 Feb 2015 13:14:35 +0100
Received: from poleia.lip6.fr (poleia.lip6.fr [132.227.201.8])
          by osiris.lip6.fr (8.15.1/lip6) with ESMTP id t1RCEQQV010540
          ; Fri, 27 Feb 2015 13:14:28 +0100 (CET)
X-pt:   osiris.lip6.fr
Received: from r2d2.rsr.lip6.fr (hp-valentin.rsr.lip6.fr [132.227.64.74])
        by poleia.lip6.fr (Postfix) with ESMTPSA id 64B98665350;
        Fri, 27 Feb 2015 13:14:26 +0100 (CET)
From:   Valentin Rothberg <Valentin.Rothberg@lip6.fr>
To:     ralf@linux-mips.org, taohl@lemote.com, chenhc@lemote.com,
        linux-mips@linux-mips.org, linux-kernel@vger.kernel.org
Cc:     Valentin Rothberg <Valentin.Rothberg@lip6.fr>
Subject: [PATCH] loongson-3/hpet.c: remove IRQF_DISABLED flag
Date:   Fri, 27 Feb 2015 13:14:22 +0100
Message-Id: <1425039262-20003-1-git-send-email-Valentin.Rothberg@lip6.fr>
X-Mailer: git-send-email 1.9.1
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.4.3 (osiris.lip6.fr [132.227.60.30]); Fri, 27 Feb 2015 13:14:28 +0100 (CET)
X-Scanned-By: MIMEDefang 2.75 on 132.227.60.30
Return-Path: <Valentin.Rothberg@lip6.fr>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 46043
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: Valentin.Rothberg@lip6.fr
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

The IRQF_DISABLED is a NOOP and scheduled to be removed.  According to Ingo
Molnar (e58aa3d2d0cc01ad8d6f7f640a0670433f794922) running IRQ handlers with
interrupts enabled can cause stack overflows when the interrupt line of the
issuing device is still active.

Signed-off-by: Valentin Rothberg <Valentin.Rothberg@lip6.fr>
---
 arch/mips/loongson/loongson-3/hpet.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/mips/loongson/loongson-3/hpet.c b/arch/mips/loongson/loongson-3/hpet.c
index e898d68..5c21cd3 100644
--- a/arch/mips/loongson/loongson-3/hpet.c
+++ b/arch/mips/loongson/loongson-3/hpet.c
@@ -162,7 +162,7 @@ static irqreturn_t hpet_irq_handler(int irq, void *data)
 
 static struct irqaction hpet_irq = {
 	.handler = hpet_irq_handler,
-	.flags = IRQF_DISABLED | IRQF_NOBALANCING | IRQF_TIMER,
+	.flags = IRQF_NOBALANCING | IRQF_TIMER,
 	.name = "hpet",
 };
 
-- 
1.9.1
