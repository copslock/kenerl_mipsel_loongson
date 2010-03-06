Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 06 Mar 2010 15:26:20 +0100 (CET)
Received: from www.linuxtv.org ([130.149.80.248]:41990 "EHLO www.linuxtv.org"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1492151Ab0CFO0P (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Sat, 6 Mar 2010 15:26:15 +0100
Received: from mchehab by www.linuxtv.org with local (Exim 4.69)
        (envelope-from <mchehab@linuxtv.org>)
        id 1NnuxI-0000ir-3G; Sat, 06 Mar 2010 15:26:12 +0100
Subject: [git:v4l-dvb/master] MIPS: Fixup of the r4k timer
From:   Patch from Wu Zhangjin <linuxtv-commits-bounces@linuxtv.org>
To:     linuxtv-commits@linuxtv.org
Data:   Mon, 1 Feb 2010 17:10:55 +0800
Cc:     Wu Zhangjin <wuzhangjin@gmail.com>,
        Shane McDonald <mcdonald.shane@gmail.com>, mbizon@freebox.fr,
        linux-mips@linux-mips.org, David VomLehn <dvomlehn@cisco.com>,
        Ralf Baechle <ralf@linux-mips.org>
Mail-followup-to: linux-media@vger.kernel.org
Forward-to: linux-media@vger.kernel.org
Reply-to: linux-media@vger.kernel.org
Message-Id: <E1NnuxI-0000ir-3G@www.linuxtv.org>
Date:   Sat, 06 Mar 2010 15:26:12 +0100
Return-Path: <mchehab@linuxtv.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 26136
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: linuxtv-commits-bounces@linuxtv.org
Precedence: bulk
X-list: linux-mips

From: Wu Zhangjin <wuzhangjin@gmail.com>

As reported by Maxime Bizon, the commit "MIPS: PowerTV: Fix support for
timer interrupts with > 64 external IRQs" have broken the r4k timer
since it didn't initialize the cp0_compare_irq_shift variable used in
c0_compare_int_pending() on the architectures whose cpu_has_mips_r2 is
false.

This patch fixes it via initializing the cp0_compare_irq_shift as the
cp0_compare_irq used in the old c0_compare_int_pending().

Reported-by: Maxime Bizon <mbizon@freebox.fr>
Signed-off-by: Wu Zhangjin <wuzhangjin@gmail.com>
Cc: David VomLehn <dvomlehn@cisco.com>
Cc: mbizon@freebox.fr
Cc: linux-mips@linux-mips.org
Patchwork: http://patchwork.linux-mips.org/patch/922/
Tested-by: Shane McDonald <mcdonald.shane@gmail.com>
Signed-off-by: Ralf Baechle <ralf@linux-mips.org>

 arch/mips/kernel/traps.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

---

http://git.linuxtv.org/v4l-dvb.git?a=commitdiff;h=f4fc580bec5fb76560329c8c537b9b71d8d032b6

diff --git a/arch/mips/kernel/traps.c b/arch/mips/kernel/traps.c
index 338dfe8..31b204b 100644
--- a/arch/mips/kernel/traps.c
+++ b/arch/mips/kernel/traps.c
@@ -1501,6 +1501,7 @@ void __cpuinit per_cpu_trap_init(void)
 			cp0_perfcount_irq = -1;
 	} else {
 		cp0_compare_irq = CP0_LEGACY_COMPARE_IRQ;
+		cp0_compare_irq_shift = cp0_compare_irq;
 		cp0_perfcount_irq = -1;
 	}
 
