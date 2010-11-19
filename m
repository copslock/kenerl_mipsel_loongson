Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 19 Nov 2010 10:43:59 +0100 (CET)
Received: from cam-admin0.cambridge.arm.com ([217.140.96.50]:56299 "EHLO
        cam-admin0.cambridge.arm.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491181Ab0KSJnz (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 19 Nov 2010 10:43:55 +0100
Received: from cam-owa1.Emea.Arm.com (cam-owa1.emea.arm.com [10.1.255.62])
        by cam-admin0.cambridge.arm.com (8.12.6/8.12.6) with ESMTP id oAJ9biF9003366;
        Fri, 19 Nov 2010 09:37:44 GMT
Received: from [10.1.68.185] ([10.1.255.212]) by cam-owa1.Emea.Arm.com with Microsoft SMTPSVC(6.0.3790.0);
         Fri, 19 Nov 2010 09:43:30 +0000
Subject: Re: [PATCH 3/5] MIPS/Perf-events: Check event state in
 validate_event()
From:   Will Deacon <will.deacon@arm.com>
To:     Deng-Cheng Zhu <dengcheng.zhu@gmail.com>
Cc:     ralf@linux-mips.org, a.p.zijlstra@chello.nl, fweisbec@gmail.com,
        linux-mips@linux-mips.org, linux-kernel@vger.kernel.org,
        wuzhangjin@gmail.com, paulus@samba.org, mingo@elte.hu,
        acme@redhat.com
In-Reply-To: <1290063401-25440-4-git-send-email-dengcheng.zhu@gmail.com>
References: <1290063401-25440-1-git-send-email-dengcheng.zhu@gmail.com>
         <1290063401-25440-4-git-send-email-dengcheng.zhu@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Date:   Fri, 19 Nov 2010 09:43:26 +0000
Message-ID: <1290159806.9342.7.camel@e102144-lin.cambridge.arm.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.28.1 
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 19 Nov 2010 09:43:30.0259 (UTC) FILETIME=[392F1230:01CB87CE]
Return-Path: <Will.Deacon@arm.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 28425
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: will.deacon@arm.com
Precedence: bulk
X-list: linux-mips

Hi Deng-Cheng,

On Thu, 2010-11-18 at 06:56 +0000, Deng-Cheng Zhu wrote:
> Ignore events that are not for this PMU or are in off/error state.
> 
Sorry I didn't see this before, thanks for pointing out that you
had included it for MIPS.

> Signed-off-by: Deng-Cheng Zhu <dengcheng.zhu@gmail.com>
> ---
>  arch/mips/kernel/perf_event.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/arch/mips/kernel/perf_event.c b/arch/mips/kernel/perf_event.c
> index 1ee44a3..9c6442a 100644
> --- a/arch/mips/kernel/perf_event.c
> +++ b/arch/mips/kernel/perf_event.c
> @@ -486,7 +486,7 @@ static int validate_event(struct cpu_hw_events *cpuc,
>  {
>         struct hw_perf_event fake_hwc = event->hw;
> 
> -       if (event->pmu && event->pmu != &pmu)
> +       if (event->pmu != &pmu || event->state <= PERF_EVENT_STATE_OFF)
>                 return 0;
> 
>         return mipspmu->alloc_counter(cpuc, &fake_hwc) >= 0;

So this is the opposite of what we're doing on ARM. Our
approach is to ignore events that are OFF (or in the ERROR
state) or that belong to a different PMU. We do this by
allowing them to *pass* validation (i.e. by returning 1 above).
This means that we won't unconditionally fail a mixed event group.

x86 does something similar in the collect_events function.

Will
