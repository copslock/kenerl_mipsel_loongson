Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 19 Oct 2014 20:04:33 +0200 (CEST)
Received: from faui40.informatik.uni-erlangen.de ([131.188.34.40]:38259 "EHLO
        faui40.informatik.uni-erlangen.de" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27011799AbaJSSEcPP6h9 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 19 Oct 2014 20:04:32 +0200
Received: from faui48e.informatik.uni-erlangen.de (faui48e.informatik.uni-erlangen.de [131.188.34.51])
        by faui40.informatik.uni-erlangen.de (Postfix) with ESMTP id 0BDB058C4C1;
        Sun, 19 Oct 2014 20:04:32 +0200 (CEST)
Received: by faui48e.informatik.uni-erlangen.de (Postfix, from userid 31112)
        id F00254E0CD8; Sun, 19 Oct 2014 20:04:31 +0200 (CEST)
From:   Stefan Hengelein <stefan.hengelein@fau.de>
To:     linux-mips@linux-mips.org
Cc:     linux-kernel@vger.kernel.org, ralf@linux-mips.org,
        Stefan Hengelein <stefan.hengelein@fau.de>
Subject: [PATCH] MIPS: MSP71xx: remove compilation error
Date:   Sun, 19 Oct 2014 20:04:26 +0200
Message-Id: <1413741866-48496-1-git-send-email-stefan.hengelein@fau.de>
X-Mailer: git-send-email 1.9.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-Path: <sistheng@faui48e.informatik.uni-erlangen.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 43337
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: stefan.hengelein@fau.de
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

When CONFIG_MIPS_MT_SMP is enabled, the following compilation error
occurs:

arch/mips/pmcs-msp71xx/msp_irq_cic.c:134: error: ‘irq’ undeclared

This code clearly never saw a compiler.
The surrounding code suggests, that 'd->irq' was intended, not
'irq'.

This error was found with vampyr.

Signed-off-by: Stefan Hengelein <stefan.hengelein@fau.de>
---
 arch/mips/pmcs-msp71xx/msp_irq_cic.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/mips/pmcs-msp71xx/msp_irq_cic.c b/arch/mips/pmcs-msp71xx/msp_irq_cic.c
index b8df2f7..1207ec4 100644
--- a/arch/mips/pmcs-msp71xx/msp_irq_cic.c
+++ b/arch/mips/pmcs-msp71xx/msp_irq_cic.c
@@ -131,11 +131,11 @@ static int msp_cic_irq_set_affinity(struct irq_data *d,
 	int cpu;
 	unsigned long flags;
 	unsigned int  mtflags;
-	unsigned long imask = (1 << (irq - MSP_CIC_INTBASE));
+	unsigned long imask = (1 << (d->irq - MSP_CIC_INTBASE));
 	volatile u32 *cic_mask = (volatile u32 *)CIC_VPE0_MSK_REG;
 
 	/* timer balancing should be disabled in kernel code */
-	BUG_ON(irq == MSP_INT_VPE0_TIMER || irq == MSP_INT_VPE1_TIMER);
+	BUG_ON(d->irq == MSP_INT_VPE0_TIMER || d->irq == MSP_INT_VPE1_TIMER);
 
 	LOCK_CORE(flags, mtflags);
 	/* enable if any of each VPE's TCs require this IRQ */
-- 
1.9.1
