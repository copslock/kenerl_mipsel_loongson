Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 03 Mar 2010 13:58:57 +0100 (CET)
Received: from kuber.nabble.com ([216.139.236.158]:40801 "EHLO
        kuber.nabble.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S1491065Ab0CCM6w (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 3 Mar 2010 13:58:52 +0100
Received: from isper.nabble.com ([192.168.236.156])
        by kuber.nabble.com with esmtp (Exim 4.63)
        (envelope-from <lists@nabble.com>)
        id 1NmoA4-0003yM-G9
        for linux-mips@linux-mips.org; Wed, 03 Mar 2010 04:58:48 -0800
Message-ID: <27767861.post@talk.nabble.com>
Date:   Wed, 3 Mar 2010 04:58:48 -0800 (PST)
From:   Dea_RU <dryukovz@mail.ru>
To:     linux-mips@linux-mips.org
Subject: Re: TI AR7 7200 - no boot
In-Reply-To: <27766728.post@talk.nabble.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Nabble-From: dryukovz@mail.ru
References: <27766331.post@talk.nabble.com> <201003031124.46336.florian@openwrt.org> <27766728.post@talk.nabble.com>
Return-Path: <lists@nabble.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 26106
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dryukovz@mail.ru
Precedence: bulk
X-list: linux-mips


i adder printk(...) before all function in kernel init funktion /init/main.c

log show last message before called fundtion  local_irq_enable().

If delete my debug printk-s kernel stop after first console output
"Calibrating delay loop... "

I do not MIPS arch interput specific ..... Can be MIPS need init internel
timer and link overflow flag to interput ??


------ log with added printk ----
......
Memory: 13172k/16384k available (1314k kernel code, 3212k reserved, 411k
data, 120k init, 0k highmem)
early_irq_init
NR_IRQS:256 <- kernel
init_IRQ
prio_tree_init
init_timers
hrtimers_init
softirq_init
timerkepping_init
time init
profile_init
early_boot_irqs_on
local_irq_enable <- last my debug printk message before call to
local_irq_enable()
-------------------------------
-- 
View this message in context: http://old.nabble.com/TI-AR7-7200---no-boot-tp27766331p27767861.html
Sent from the linux-mips main mailing list archive at Nabble.com.
