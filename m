Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 17 May 2012 18:19:59 +0200 (CEST)
Received: from mail3.caviumnetworks.com ([12.108.191.235]:16273 "EHLO
        mail3.caviumnetworks.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903636Ab2EQQTw (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 17 May 2012 18:19:52 +0200
Received: from caexch01.caveonetworks.com (Not Verified[192.168.16.9]) by mail3.caviumnetworks.com with MailMarshal (v6,7,2,8378)
        id <B4fb524330000>; Thu, 17 May 2012 09:15:52 -0700
Received: from caexch01.caveonetworks.com ([192.168.16.9]) by caexch01.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.4675);
         Thu, 17 May 2012 09:13:53 -0700
Received: from dd1.caveonetworks.com ([64.2.3.195]) by caexch01.caveonetworks.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.4675);
         Thu, 17 May 2012 09:13:53 -0700
Message-ID: <4FB523C1.4070902@cavium.com>
Date:   Thu, 17 May 2012 09:13:53 -0700
From:   David Daney <david.daney@cavium.com>
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.15) Gecko/20101027 Fedora/3.0.10-1.fc12 Thunderbird/3.0.10
MIME-Version: 1.0
To:     Yong Zhang <yong.zhang0@gmail.com>, ralf@linux-mips.org
CC:     linux-mips@linux-mips.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/8] patchset focus on MIPS SMP woes
References: <1337249410-7162-1-git-send-email-yong.zhang0@gmail.com>
In-Reply-To: <1337249410-7162-1-git-send-email-yong.zhang0@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 17 May 2012 16:13:53.0505 (UTC) FILETIME=[0DA88510:01CD3448]
X-archive-position: 33353
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: david.daney@cavium.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>

On 05/17/2012 03:10 AM, Yong Zhang wrote:
> From: Yong Zhang<yong.zhang@windriver.com>
>
> Since commit 5fbd036b [sched: Cleanup cpu_active madness] and
> commit 2baab4e9 [sched: Fix select_fallback_rq() vs cpu_active/cpu_online],
> it's more safe to put notify_cpu_starting() and set_cpu_online() with
> irq disabled, otherwise we will have a typical race condition which
> above two commits try to resolve:
>
>        CPU1                            CPU2
> __cpu_up();
>     mp_ops->boot_secondary();
>                                start_secondary();
>                                  ->init_secondary();
>                                    local_irq_enable();
>                                <IRQ>
>                                do something;
>                                      wake up softirqd;
>                                      try_to_wake_up();
>                                        select_fallback_rq();
>                                        /* select wrong cpu */
>     set_cpu_online();
>
>
> This patchset fix the above issue as well as set_cpu_online is
> called on the caller cpu.
>
> BTW, I'm only running it on Cavium board because of limited source,
> so if anyone is interested to test it on other board, that's great :)
>
> Signed-off-by: Yong Zhang<yong.zhang0@gmail.com>
>
> Yong Zhang (8):
>    MIPS: Octeon: delay enable irq to ->smp_finish()
>    MIPS: BMIPS: delay irq enable to ->smp_finish()
>    MIPS: SMTC: delay irq enable to ->smp_finish()
>    MIPS: Yosemite: delay irq enable to ->smp_finish()
>    MIPS: call ->smp_finish() a little late
>    MIPS: call set_cpu_online() on the uping cpu with irq disabled
>    MIPS: smp: Warn on too early irq enable
>    MIPS: sync-r4k: remove redundant irq operation
>

This entire patch set (modulo the change log grammar items noted by Sergei):

Acked-by: David Daney <david.daney@cavium.com>


>   arch/mips/cavium-octeon/smp.c       |    2 +-
>   arch/mips/kernel/smp-bmips.c        |   14 +++++++-------
>   arch/mips/kernel/smp.c              |   12 +++++++++---
>   arch/mips/kernel/smtc.c             |    3 ++-
>   arch/mips/kernel/sync-r4k.c         |    5 -----
>   arch/mips/pmc-sierra/yosemite/smp.c |    2 +-
>   6 files changed, 20 insertions(+), 18 deletions(-)
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>
