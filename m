Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 25 Oct 2011 07:37:39 +0200 (CEST)
Received: from dns1.mips.com ([12.201.5.69]:49231 "EHLO dns1.mips.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1491116Ab1JYFhb (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 25 Oct 2011 07:37:31 +0200
Received: from exchdb01.mips.com (exchhub01.mips.com [192.168.36.84])
        by dns1.mips.com (8.13.8/8.13.8) with ESMTP id p9P5awh9022960;
        Mon, 24 Oct 2011 22:36:58 -0700
Received: from [192.168.225.107] (192.168.225.107) by exchhub01.mips.com
 (192.168.36.84) with Microsoft SMTP Server id 14.1.270.1; Mon, 24 Oct 2011
 22:36:53 -0700
Message-ID: <4EA64AF3.8060307@mips.com>
Date:   Tue, 25 Oct 2011 13:36:51 +0800
From:   Deng-Cheng Zhu <dczhu@mips.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.9.2.18) Gecko/20110617 Lightning/1.0b2 Thunderbird/3.1.11
MIME-Version: 1.0
To:     Deng-Cheng Zhu <dczhu@mips.com>
CC:     <linux-mips@linux-mips.org>, <ralf@linux-mips.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Paul Mackerras <paulus@samba.org>, Ingo Molnar <mingo@elte.hu>,
        Arnaldo Carvalho de Melo <acme@ghostprotocols.net>,
        David Daney <david.daney@cavium.com>,
        David Ahern <dsahern@gmail.com>,
        Will Deacon <will.deacon@arm.com>
Subject: Re: [PATCH 3/4] MIPS/Perf-events: temporarily connect event to its
 pmu at event init
References: <1319453762-12962-1-git-send-email-dczhu@mips.com> <1319453762-12962-4-git-send-email-dczhu@mips.com>
In-Reply-To: <1319453762-12962-4-git-send-email-dczhu@mips.com>
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
X-EMS-Proccessed: 6LP3oGfGVdcdb8o1aBnt6w==
X-EMS-STAMP: dwR0t4ap5i4eA2QTfnDyAw==
X-archive-position: 31295
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dczhu@mips.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 17816

On 10/24/2011 06:56 PM, Deng-Cheng Zhu wrote:
> When arch level event init is called, the event is not yet connected to
> the PMU, thereby causing validate_group() to always do dummy work. On MIPS,
> this is due to the following lines in validate_event() called by
> validate_group():
>
> if (event->pmu !=&pmu || event->state<= PERF_EVENT_STATE_OFF)
>          return 1;
>
> This patch fixes it.
>
> Signed-off-by: Deng-Cheng Zhu<dczhu@mips.com>
> Cc: Peter Zijlstra<a.p.zijlstra@chello.nl>
> Cc: Paul Mackerras<paulus@samba.org>
> Cc: Ingo Molnar<mingo@elte.hu>
> Cc: Arnaldo Carvalho de Melo<acme@ghostprotocols.net>
> Cc: David Daney<david.daney@cavium.com>
> ---
>   arch/mips/kernel/perf_event_mipsxx.c |   17 +++++++++++++----
>   1 files changed, 13 insertions(+), 4 deletions(-)
>
> diff --git a/arch/mips/kernel/perf_event_mipsxx.c b/arch/mips/kernel/perf_event_mipsxx.c
> index 1f654ca..c804fdd 100644
> --- a/arch/mips/kernel/perf_event_mipsxx.c
> +++ b/arch/mips/kernel/perf_event_mipsxx.c
> @@ -548,6 +548,7 @@ static int __hw_perf_event_init(struct perf_event *event)
>   	struct perf_event_attr *attr =&event->attr;
>   	struct hw_perf_event *hwc =&event->hw;
>   	const struct mips_perf_event *pev;
> +	struct pmu *tmp;
>   	int err;
>
>   	/* Returning MIPS event descriptor for generic perf event. */
> @@ -611,11 +612,19 @@ static int __hw_perf_event_init(struct perf_event *event)
>   	}
>
>   	err = 0;
> -	if (event->group_leader != event) {
> +
> +	/*
> +	 * we temporarily connect event to its pmu such that
> +	 * validate_event() in validate_group() can classify
> +	 * it as a MIPS event by passing (event->pmu ==&pmu).
> +	 */
> +	tmp = event->pmu;
> +	event->pmu =&pmu;
> +
> +	if (event->group_leader != event)
>   		err = validate_group(event);
> -		if (err)
> -			return -EINVAL;
> -	}
> +
> +	event->pmu = tmp;
>
>   	event->destroy = hw_perf_event_destroy;
>

After looking at David Ahern's reply to my another patch (link
provided below), I started to think whether the PMU and event state
checks are redundant in validate_event() on MIPS (ARM may also have
the same consideration).

The related patch link:
http://www.spinics.net/lists/kernel/msg1252452.html

_If_ the state fix goes to group checks instead of to the perf tool,
then the following line in validate_event() on MIPS seems redundant:

if (event->pmu !=&pmu || event->state <= PERF_EVENT_STATE_OFF)
         return 1;

This is because validate_event() is only called by validate_group()
which is called only by __hw_perf_event_init(), and the issue of the
pmu check is already addressed in this patch, and we don't want the
grouped events which are in PERF_EVENT_STATE_OFF (by "attr->disabled =
1") to be filtered out here.

Also, _if_ the state fix goes to group checks instead of to the perf
tool, then X86 may need a patch to allow collect_events() to do real
work in validate_group().

Any comments?


Deng-Cheng
