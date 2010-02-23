Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 23 Feb 2010 06:42:57 +0100 (CET)
Received: from TYO201.gate.nec.co.jp ([202.32.8.193]:56016 "EHLO
        tyo201.gate.nec.co.jp" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491039Ab0BWFmt (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 23 Feb 2010 06:42:49 +0100
Received: from relay21.aps.necel.com ([10.29.19.50])
        by tyo201.gate.nec.co.jp (8.13.8/8.13.4) with ESMTP id o1N5gJlM008652;
        Tue, 23 Feb 2010 14:42:42 +0900 (JST)
Received: from realmbox31.aps.necel.com ([10.29.19.36] [10.29.19.36]) by relay21.aps.necel.com with ESMTP; Tue, 23 Feb 2010 14:42:42 +0900
Received: from [10.114.181.193] ([10.114.181.193] [10.114.181.193]) by mbox02.aps.necel.com with ESMTP; Tue, 23 Feb 2010 14:42:42 +0900
Message-ID: <4B836AD2.20602@necel.com>
Date:   Tue, 23 Feb 2010 14:42:42 +0900
From:   Shinya Kuribayashi <shinya.kuribayashi@necel.com>
User-Agent: Thunderbird 2.0.0.23 (Windows/20090812)
MIME-Version: 1.0
To:     "Kevin D. Kissell" <kevink@paralogos.com>
CC:     Linux MIPS Org <linux-mips@linux-mips.org>
Subject: compare_change_hazard (was Re: SMTC Patches [3 of 3])
References: <48C6DD4D.9090600@paralogos.com>
In-Reply-To: <48C6DD4D.9090600@paralogos.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <shinya.kuribayashi@necel.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 25994
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: shinya.kuribayashi@necel.com
Precedence: bulk
X-list: linux-mips

Hi Kevin and folks,

Recently I have encountered an awkward timer interrupt behavior
on a MIPS32r2 core running at 500+MHz, and find a useful comment
left in the kernel.

Here I have some question about compare_change_hazard(), which was
introduced by the commit.  See below: 

Kevin D. Kissell wrote:
>From ac801c3b5c31eb0d53bf08538965f82f59f5f39d Mon Sep 17 00:00:00 2001
>From: Kevin D. Kissell <kevink@paralogos.com>
>Date: Tue, 9 Sep 2008 21:48:52 +0200
>Subject: [PATCH] Rework of SMTC support to make it work with the new clock event
> system, allowing "tickless" operation, and to make it compatible
> with the use of the "wait_irqoff" idle loop.  The new clocking
> scheme means that the previously optional IPI instant replay
> mechanism is now required, and has been made more robust.
> Signed-off-by: Kevin D. Kissell <kevink@paralogos.com>
>
>---
> arch/mips/Kconfig                        |   26 +--
> arch/mips/kernel/Makefile                |    1 +
> arch/mips/kernel/cevt-r4k.c              |  173 +++++------------
> arch/mips/kernel/cevt-smtc.c             |  321 ++++++++++++++++++++++++++++++
> arch/mips/kernel/cpu-probe.c             |   10 +-
> arch/mips/kernel/genex.S                 |    4 +-
> arch/mips/kernel/smtc.c                  |  254 +++++++++++++-----------
> arch/mips/mips-boards/malta/malta_smtc.c |    9 +-
> include/asm-mips/cevt-r4k.h              |   46 +++++
> include/asm-mips/irqflags.h              |   26 ++-
> include/asm-mips/smtc.h                  |    8 +-
> 11 files changed, 598 insertions(+), 280 deletions(-)
> create mode 100644 arch/mips/kernel/cevt-smtc.c
> create mode 100644 include/asm-mips/cevt-r4k.h
[snip]
>diff --git a/arch/mips/kernel/cevt-r4k.c b/arch/mips/kernel/cevt-r4k.c
>index 24a2d90..4a4c59f 100644
>--- a/arch/mips/kernel/cevt-r4k.c
>+++ b/arch/mips/kernel/cevt-r4k.c
[snip]
>@@ -177,7 +99,23 @@ static int c0_compare_int_pending(void)
> 	return (read_c0_cause() >> cp0_compare_irq) & 0x100;
> }
> 
>-static int c0_compare_int_usable(void)
>+/*
>+ * Compare interrupt can be routed and latched outside the core,
>+ * so a single execution hazard barrier may not be enough to give
>+ * it time to clear as seen in the Cause register.  4 time the
>+ * pipeline depth seems reasonably conservative, and empirically
>+ * works better in configurations with high CPU/bus clock ratios.
>+ */
>+
>+#define compare_change_hazard() \
>+	do { \
>+		irq_disable_hazard(); \
>+		irq_disable_hazard(); \
>+		irq_disable_hazard(); \
>+		irq_disable_hazard(); \
>+	} while (0)
>+
>+int c0_compare_int_usable(void)
> {
> 	unsigned int delta;
> 	unsigned int cnt;

Above commets reasonably make sense and do help me, thanks :-)
On the other hand, the implementation of compare_change_hazard()
makes me wonder how this hazard works internally.

For MIPS32r2 cores (except for Octeon), irq_disable_hazard() will
be translated into "ehb" instruction, so the resulting compare_
change_hazard() is going to be

compare_change_hazard:
        ehb
        ehb
        ehb
        ehb

And I wonder how these instructions work.  I think the first ehb
instruction will clear all execution hazards created by preceding
instruction(s) at that moment, this is fine.  But I wonder,

* HOW do subsequent three "ehb" instructions work in the pipeline?
  Do they make any "real" effect, or just work as "nop"?

* Kevin noted that "4 time the pipeline depth seems reasonably
  convervative."  Is current form of compare_change_hazard()
  implemented in accordance with his comments?

* How many pipline clokcs are consumed for subsequent "ehb"
  instruction?

and so on.  I'd like to ask hardware people later, separately, but
any comments are appreciated.

Thanks in adavance.

  Shinya


>@@ -187,7 +125,7 @@ static int c0_compare_int_usable(void)
> 	 */
> 	if (c0_compare_int_pending()) {
> 		write_c0_compare(read_c0_count());
>-		irq_disable_hazard();
>+		compare_change_hazard();
> 		if (c0_compare_int_pending())
> 			return 0;
> 	}
>@@ -196,7 +134,7 @@ static int c0_compare_int_usable(void)
> 		cnt = read_c0_count();
> 		cnt += delta;
> 		write_c0_compare(cnt);
>-		irq_disable_hazard();
>+		compare_change_hazard();
> 		if ((int)(read_c0_count() - cnt) < 0)
> 		    break;
> 		/* increase delta if the timer was already expired */
>@@ -205,11 +143,12 @@ static int c0_compare_int_usable(void)
> 	while ((int)(read_c0_count() - cnt) <= 0)
> 		;	/* Wait for expiry  */
> 
>+	compare_change_hazard();
> 	if (!c0_compare_int_pending())
> 		return 0;
> 
> 	write_c0_compare(read_c0_count());
>-	irq_disable_hazard();
>+	compare_change_hazard();
> 	if (c0_compare_int_pending())
> 		return 0;
> 

-- 
Shinya Kuribayashi
NEC Electronics
