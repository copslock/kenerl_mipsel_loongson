Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 06 Jan 2011 08:40:56 +0100 (CET)
Received: from [69.28.251.93] ([69.28.251.93]:37732 "EHLO b32.net"
        rhost-flags-FAIL-FAIL-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1490997Ab1AFHjW (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 6 Jan 2011 08:39:22 +0100
Received: (qmail 3801 invoked from network); 6 Jan 2011 07:39:19 -0000
Received: from unknown (HELO vps-1001064-677.cp.jvds.com) (127.0.0.1)
  by 127.0.0.1 with (DHE-RSA-AES128-SHA encrypted) SMTP; 6 Jan 2011 07:39:19 -0000
Received: by vps-1001064-677.cp.jvds.com (sSMTP sendmail emulation); Wed, 05 Jan 2011 23:39:19 -0800
From:   Kevin Cernekee <cernekee@gmail.com>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     <linux-mips@linux-mips.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH RESEND 5/6] MIPS: Install handlers for BMIPS software IRQs
Date:   Wed, 05 Jan 2011 23:31:29 -0800
Message-Id: <15216cd202530798c9d4c5beeb45c6ba@localhost>
In-Reply-To: <8eec0c63f92528c501c0e6a0c8396359@localhost>
References: <8eec0c63f92528c501c0e6a0c8396359@localhost>
User-Agent: vim 7.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Return-Path: <cernekee@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 28862
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: cernekee@gmail.com
Precedence: bulk
X-list: linux-mips

BMIPS4350/4380/5000 CMT/SMT all use SW INT0/INT1 for inter-thread
signaling.

Signed-off-by: Kevin Cernekee <cernekee@gmail.com>
---
 arch/mips/kernel/irq_cpu.c |   14 ++++++--------
 1 files changed, 6 insertions(+), 8 deletions(-)

diff --git a/arch/mips/kernel/irq_cpu.c b/arch/mips/kernel/irq_cpu.c
index 0262abe..70d4736 100644
--- a/arch/mips/kernel/irq_cpu.c
+++ b/arch/mips/kernel/irq_cpu.c
@@ -107,14 +107,12 @@ void __init mips_cpu_irq_init(void)
 	clear_c0_status(ST0_IM);
 	clear_c0_cause(CAUSEF_IP);
 
-	/*
-	 * Only MT is using the software interrupts currently, so we just
-	 * leave them uninitialized for other processors.
-	 */
-	if (cpu_has_mipsmt)
-		for (i = irq_base; i < irq_base + 2; i++)
-			set_irq_chip_and_handler(i, &mips_mt_cpu_irq_controller,
-						 handle_percpu_irq);
+	/* Software interrupts are used for MT/CMT IPI */
+	for (i = irq_base; i < irq_base + 2; i++)
+		set_irq_chip_and_handler(i, cpu_has_mipsmt ?
+					 &mips_mt_cpu_irq_controller :
+					 &mips_cpu_irq_controller,
+					 handle_percpu_irq);
 
 	for (i = irq_base + 2; i < irq_base + 8; i++)
 		set_irq_chip_and_handler(i, &mips_cpu_irq_controller,
-- 
1.7.0.4
