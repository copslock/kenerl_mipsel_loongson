Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 22 May 2014 11:24:44 +0200 (CEST)
Received: from cpsmtpb-ews03.kpnxchange.com ([213.75.39.6]:54975 "EHLO
        cpsmtpb-ews03.kpnxchange.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6815784AbaEVJYZMNmz0 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 22 May 2014 11:24:25 +0200
Received: from cpsps-ews30.kpnxchange.com ([10.94.84.196]) by cpsmtpb-ews03.kpnxchange.com with Microsoft SMTPSVC(7.5.7601.17514);
         Thu, 22 May 2014 11:24:19 +0200
Received: from CPSMTPM-TLF101.kpnxchange.com ([195.121.3.4]) by cpsps-ews30.kpnxchange.com with Microsoft SMTPSVC(7.5.7601.17514);
         Thu, 22 May 2014 11:24:19 +0200
Received: from [192.168.10.106] ([195.240.213.44]) by CPSMTPM-TLF101.kpnxchange.com with Microsoft SMTPSVC(7.5.7601.17514);
         Thu, 22 May 2014 11:24:19 +0200
Message-ID: <1400750659.16832.24.camel@x220>
Subject: [PATCH] MIPS: BCM1480: remove checks for CONFIG_SIBYTE_BCM1480_PROF
From:   Paul Bolle <pebolle@tiscali.nl>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     linux-mips@linux-mips.org, linux-kernel@vger.kernel.org
Date:   Thu, 22 May 2014 11:24:19 +0200
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4 (3.10.4-2.fc20) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 22 May 2014 09:24:19.0318 (UTC) FILETIME=[9BEB6960:01CF759F]
X-RcptDomain: linux-mips.org
Return-Path: <pebolle@tiscali.nl>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 40234
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: pebolle@tiscali.nl
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

There are two checks for CONFIG_SIBYTE_BCM1480_PROF in the tree since
v2.6.15. The related Kconfig symbol has never been added to the tree. So
these checks have always evaluated to false. Besides, one of these
checks guards a call of sbprof_cpu_intr(). But that function is not
defined. Remove all this.

Signed-off-by: Paul Bolle <pebolle@tiscali.nl>
---
Untested.

Until v2.6.23 there also were checks for CONFIG_SIBYTE_SB1250_PROF in
the tree. There also was a Kconfig symbol SIBYTE_SB1250_PROF so it was
possible to make these checks evaluate to true. But, since one of these
checks also guarded a call of sbprof_cpu_intr(), that should have made
the build fail with an error.

 arch/mips/sibyte/bcm1480/irq.c | 11 -----------
 1 file changed, 11 deletions(-)

diff --git a/arch/mips/sibyte/bcm1480/irq.c b/arch/mips/sibyte/bcm1480/irq.c
index 59cfe2659771..373fbbc8425c 100644
--- a/arch/mips/sibyte/bcm1480/irq.c
+++ b/arch/mips/sibyte/bcm1480/irq.c
@@ -347,19 +347,8 @@ asmlinkage void plat_irq_dispatch(void)
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
1.9.0
