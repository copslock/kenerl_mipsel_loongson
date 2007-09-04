Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 04 Sep 2007 09:49:56 +0100 (BST)
Received: from mail.windriver.com ([147.11.1.11]:64671 "EHLO mail.wrs.com")
	by ftp.linux-mips.org with ESMTP id S20024634AbXIDItq (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 4 Sep 2007 09:49:46 +0100
Received: from ALA-MAIL03.corp.ad.wrs.com (ala-mail03 [147.11.57.144])
	by mail.wrs.com (8.13.6/8.13.6) with ESMTP id l848neBG009582
	for <linux-mips@linux-mips.org>; Tue, 4 Sep 2007 01:49:40 -0700 (PDT)
Received: from ala-mail06.corp.ad.wrs.com ([147.11.57.147]) by ALA-MAIL03.corp.ad.wrs.com with Microsoft SMTPSVC(6.0.3790.1830);
	 Tue, 4 Sep 2007 01:49:40 -0700
Received: from [128.224.162.180] ([128.224.162.180]) by ala-mail06.corp.ad.wrs.com with Microsoft SMTPSVC(6.0.3790.1830);
	 Tue, 4 Sep 2007 01:49:40 -0700
Message-ID: <46DD1CD1.5040306@windriver.com>
Date:	Tue, 04 Sep 2007 16:52:33 +0800
From:	yshi <yang.shi@windriver.com>
User-Agent: Thunderbird 2.0.0.6 (X11/20070728)
MIME-Version: 1.0
To:	linux-mips@linux-mips.org
Subject: [PATCH] malta4kec hang in calibrate_delay fix
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 04 Sep 2007 08:49:40.0448 (UTC) FILETIME=[87EE0600:01C7EED0]
Return-Path: <Yang.Shi@windriver.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 16365
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: yang.shi@windriver.com
Precedence: bulk
X-list: linux-mips

perfmon2 patch changed timer interrupt handler of malta board.
When kernel handles timer interrupt, interrupt handler will read 30 bit
of cause register. If this bit is zero, timer interrupt handler will
exit, won't really handle interrupt. Because Malta 4kec board's core
revision is CoreFPGA-3, this core's cause register doesn't implement 30
bit, so kernel always read zero from this bit. This will cause kernel
hang in calibrate_delay.

Signed-off-by: Yang Shi <yang.shi@windriver.com>
---
b/arch/mips/mips-boards/generic/time.c |   17 ++++++++++++-----
1 file changed, 12 insertions(+), 5 deletions(-)
---

--- a/arch/mips/mips-boards/generic/time.c
+++ b/arch/mips/mips-boards/generic/time.c
@@ -136,11 +136,13 @@ irqreturn_t mips_timer_interrupt(int irq
#else /* CONFIG_MIPS_MT_SMTC */
      int r2 = cpu_has_mips_r2;

-       if (handle_perf_irq(r2))
-               goto out;
+       if (mips_revision_corid != MIPS_REVISION_CORID_CORE_FPGA3) {
+               if (handle_perf_irq(r2))
+                       goto out;

-       if (r2 && ((read_c0_cause() & (1 << 30)) == 0))
-               goto out;
+               if (r2 && ((read_c0_cause() & (1 << 30)) == 0))
+                       goto out;
+       }

      if (cpu == 0) {
              /*
@@ -294,7 +296,12 @@ void __init plat_timer_setup(struct irqa
      {
              if (cpu_has_vint)
                      set_vi_handler(cp0_compare_irq, mips_timer_dispatch);
-               mips_cpu_timer_irq = MIPS_CPU_IRQ_BASE + cp0_compare_irq;
+
+               if (mips_revision_corid != MIPS_REVISION_CORID_CORE_FPGA3)
+                       mips_cpu_timer_irq = MIPS_CPU_IRQ_BASE + 
cp0_compare_irq;
+               else
+                       mips_cpu_timer_irq = MIPS_CPU_IRQ_BASE +
+                                            CP0_LEGACY_COMPARE_IRQ;
      }

      /* we are using the cpu counter for timer interrupts */
