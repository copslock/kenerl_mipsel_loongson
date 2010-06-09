Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 09 Jun 2010 13:21:23 +0200 (CEST)
Received: from faui40.informatik.uni-erlangen.de ([131.188.34.40]:37174 "EHLO
        faui40.informatik.uni-erlangen.de" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S2097165Ab0FILVJ (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 9 Jun 2010 13:21:09 +0200
Received: from faui49h (faui49h.informatik.uni-erlangen.de [131.188.42.58])
        by faui40.informatik.uni-erlangen.de (Postfix) with SMTP id 1A3805F26E;
        Wed,  9 Jun 2010 13:21:08 +0200 (MEST)
Received: by faui49h (sSMTP sendmail emulation); Wed, 09 Jun 2010 13:21:08 +0200
Date:   Wed, 9 Jun 2010 13:21:08 +0200
From:   Christoph Egger <siccegge@cs.fau.de>
To:     Ralf Baechle <ralf@linux-mips.org>,
        Gilles Espinasse <g.esp@free.fr>, Tejun Heo <tj@kernel.org>,
        Jiri Kosina <jkosina@suse.cz>, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org
Cc:     vamos@i4.informatik.uni-erlangen.de
Subject: [PATCH 3/9] Removing dead CONFIG_SIBYTE_BCM1480_PROF
Message-ID: <c217f4530c057f4b8030bd14459a0cb2856decde.1275925108.git.siccegge@cs.fau.de>
References: <cover.1275925108.git.siccegge@cs.fau.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1275925108.git.siccegge@cs.fau.de>
User-Agent: Mutt/1.5.20 (2009-06-14)
X-archive-position: 27103
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: siccegge@cs.fau.de
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                 
X-UID: 6335

CONFIG_SIBYTE_BCM1480_PROF doesn't exist in Kconfig, therefore removing all
references for it from the source code.

Signed-off-by: Christoph Egger <siccegge@cs.fau.de>
---
 arch/mips/sibyte/bcm1480/irq.c |   11 -----------
 1 files changed, 0 insertions(+), 11 deletions(-)

diff --git a/arch/mips/sibyte/bcm1480/irq.c b/arch/mips/sibyte/bcm1480/irq.c
index 044bbe4..919d2d5 100644
--- a/arch/mips/sibyte/bcm1480/irq.c
+++ b/arch/mips/sibyte/bcm1480/irq.c
@@ -362,19 +362,8 @@ asmlinkage void plat_irq_dispatch(void)
 	unsigned int cpu = smp_processor_id();
 	unsigned int pending;
 
-#ifdef CONFIG_SIBYTE_BCM1480_PROF
-	/* Set compare to count to silence count/compare timer interrupts */
-	write_c0_compare(read_c0_count());
-#endif
-
 	pending = read_c0_cause() & read_c0_status();
 
-#ifdef CONFIG_SIBYTE_BCM1480_PROF
-	if (pending & CAUSEF_IP7)	/* Cpu performance counter interrupt */
-		sbprof_cpu_intr();
-	else
-#endif
-
 	if (pending & CAUSEF_IP4)
 		do_IRQ(K_BCM1480_INT_TIMER_0 + cpu);
 #ifdef CONFIG_SMP
-- 
1.6.3.3
