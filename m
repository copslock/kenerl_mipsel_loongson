Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 10 Apr 2010 12:55:21 +0200 (CEST)
Received: from rs1.rw-gmbh.net ([213.239.201.58]:38637 "EHLO rs1.rw-gmbh.net"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1491800Ab0DJKzS (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Sat, 10 Apr 2010 12:55:18 +0200
Received: from pd95181a7.dip0.t-ipconnect.de ([217.81.129.167] helo=[192.168.178.24])
        by rs1.rw-gmbh.net with esmtpsa (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
        (Exim 4.71)
        (envelope-from <ralf.roesch@rw-gmbh.de>)
        id 1O0YLG-0003SR-HI; Sat, 10 Apr 2010 12:55:15 +0200
Message-ID: <4BC0590D.5080305@rw-gmbh.de>
Date:   Sat, 10 Apr 2010 12:55:09 +0200
From:   Ralf Roesch <ralf.roesch@rw-gmbh.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; de; rv:1.9.1.9) Gecko/20100405 Lightning/1.0b1 Icedove/3.0.4
MIME-Version: 1.0
To:     Wu Zhangjin <wuzhangjin@gmail.com>
CC:     Ralf Baechle <ralf@linux-mips.org>,
        David Daney <ddaney@caviumnetworks.com>,
        linux-mips@linux-mips.org
Subject: Re: [PATCH v3 0/3] add high resolution sched_clock() for MIPS
References: <cover.1270881177.git.wuzhangjin@gmail.com>
In-Reply-To: <cover.1270881177.git.wuzhangjin@gmail.com>
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 8bit
Return-Path: <ralf.roesch@rw-gmbh.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 26382
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf.roesch@rw-gmbh.de
Precedence: bulk
X-list: linux-mips

I applied your patch set against tip/rt/2.6.33 (kernel.org) and it works 
fine on our TX4938 based Fieldbuscontroller which uses the r4k-based 
timer clocksource. Thanks!

(32bit version)
tested-by: Ralf Roesch <ralf.roesch@rw-gmbh.de>


On Sat Apr 10 2010 08:49:56 GMT+0200 (CET), Wu Zhangjin 
<wuzhangjin@gmail.com>  wrote:
> From: Wu Zhangjin<wuzhangjin@gmail.com>
>
> Hi, Ralf, hi David.
>
> I have tested it again in the 32bit and 64bit kernel on a Yeeloong netbook,
> both of them work well. so, it should be applicable now.
>
> BTW:
>
> to David, if the first two patches are ok for you, could you give a
> "Acked-by:"?  thanks!
>
> to Ralf Rösch, does this 32bit version work for you? If yes, welcome your
> tested-by:, thanks ;)
>
> ----------------
>
> Changes:
>
> v2 ->  v3:
>
>    o remove the 'easy way' of 128bit arithmatic of mips_cyc2ns().
>    o use 32bit type instead of 64bit for the input arguments(mult and shift) as
>    the 'struct clocksource' does.
>    o use a smaller scaling factor: 8, with this factor, if the clock frequency
>    is 400MHz, it will overflow after about 521 days.
>
> v1 ->  v2:
>
>    o Adds 32bit support, using a smaller scaling factor(shift) to avoid 128bit
>    arithmatic, of course, it loses some precision.
>
>    o Adds the testing results of the overhead of sched_clock() in 64bit kernel
>
>    Clock func/overhead(ns) Min Avg Max Jitter Std.Dev.
>    ----------------------------------------------
>    sched_clock(cnt32_to_63) 105 116.2 236 131 9.5
>    getnstimeofday()      160 167.1 437 277 15
>    ----------------------------------------------
>
>    As we can see, the cnt32_to_63() based sched_clock() have lower overhead.
>
> ----------------
>
> This patchset adds a high resolution version of sched_clock() for the r4k MIPS.
>
> The generic sched_clock() is jiffies based and has very bad resolution(1ms with
> HZ set as 1000), this one is based on the r4k c0 count, the resolution reaches
> about several ns(2.5ns with 400M clock frequency).
>
> To cope with the overflow problem of the 32bit c0 count, based on the
> cnt32_to_63() method in include/linux/cnt32_to_63.h. we have converted the
> 32bit counter to a virtual 63bit counter.
>
> And to fix the overflow problem of the 64bit arithmatic(cycles * mult) in 64bit
> kernel, we use the 128bit arithmatic contributed by David, but for 32bit
> kernel, to balance the overhead of 128bit arithmatic and the precision lost, we
> choose the method used in X86(arch/x86/kernel/tsc.c) and
> ARM(arch/arm/plat-orion/time.c): just use a smaller scaling factor and do 64bit
> arithmatic, of course, it will also overflow but not that quickly.
>
> Regards,
>          Wu Zhangjin
>
> Wu Zhangjin (3):
>    MIPS: add a common mips_cyc2ns()
>    MIPS: cavium-octeon: rewrite the sched_clock() based on mips_cyc2ns()
>    MIPS: r4k: Add a high resolution sched_clock()
>
>   arch/mips/Kconfig                     |   12 +++++
>   arch/mips/cavium-octeon/csrc-octeon.c |   29 +------------
>   arch/mips/include/asm/time.h          |   34 +++++++++++++++
>   arch/mips/kernel/csrc-r4k.c           |   76 +++++++++++++++++++++++++++++++++
>   arch/mips/kernel/time.c               |    5 ++
>   5 files changed, 129 insertions(+), 27 deletions(-)
>
>    
