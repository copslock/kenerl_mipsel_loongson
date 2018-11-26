Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 26 Nov 2018 15:12:11 +0100 (CET)
Received: from foss.arm.com ([217.140.101.70]:55686 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23991923AbeKZOKcED0F1 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 26 Nov 2018 15:10:32 +0100
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 08D4222C7;
        Mon, 26 Nov 2018 06:10:30 -0800 (PST)
Received: from [10.1.196.75] (e110467-lin.cambridge.arm.com [10.1.196.75])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id F24DD3F5A0;
        Mon, 26 Nov 2018 06:10:25 -0800 (PST)
Subject: Re: [PATCH v2 03/20] perf/core: add PERF_PMU_CAP_EXCLUDE for
 exclusion capable PMUs
To:     Andrew Murray <andrew.murray@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Will Deacon <will.deacon@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>, x86@kernel.org,
        Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        James Hogan <jhogan@kernel.org>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        "David S . Miller" <davem@davemloft.net>,
        sparclinux@vger.kernel.org, Michael Ellerman <mpe@ellerman.id.au>
Cc:     linux-s390@vger.kernel.org, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org, linux-alpha@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org
References: <1543230756-15319-1-git-send-email-andrew.murray@arm.com>
 <1543230756-15319-4-git-send-email-andrew.murray@arm.com>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <8c9003c3-ccbf-c342-024f-772d697a911b@arm.com>
Date:   Mon, 26 Nov 2018 14:10:24 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <1543230756-15319-4-git-send-email-andrew.murray@arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Return-Path: <robin.murphy@arm.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 67509
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: robin.murphy@arm.com
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

Hi Andrew,

On 26/11/2018 11:12, Andrew Murray wrote:
> Many PMU drivers do not have the capability to exclude counting events
> that occur in specific contexts such as idle, kernel, guest, etc. These
> drivers indicate this by returning an error in their event_init upon
> testing the events attribute flags. This approach is error prone and
> often inconsistent.
> 
> Let's instead allow PMU drivers to advertise their ability to exclude
> based on context via a new capability: PERF_PMU_CAP_EXCLUDE. This
> allows the perf core to reject requests for exclusion events where
> there is no support in the PMU.
> 
> Signed-off-by: Andrew Murray <andrew.murray@arm.com>
> ---
>   include/linux/perf_event.h | 1 +
>   kernel/events/core.c       | 9 +++++++++
>   2 files changed, 10 insertions(+)
> 
> diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
> index b2e806f..69b3d65 100644
> --- a/include/linux/perf_event.h
> +++ b/include/linux/perf_event.h
> @@ -244,6 +244,7 @@ struct perf_event;
>   #define PERF_PMU_CAP_EXCLUSIVE			0x10
>   #define PERF_PMU_CAP_ITRACE			0x20
>   #define PERF_PMU_CAP_HETEROGENEOUS_CPUS		0x40
> +#define PERF_PMU_CAP_EXCLUDE			0x80
>   
>   /**
>    * struct pmu - generic performance monitoring unit
> diff --git a/kernel/events/core.c b/kernel/events/core.c
> index 5a97f34..9afb33c 100644
> --- a/kernel/events/core.c
> +++ b/kernel/events/core.c
> @@ -9743,6 +9743,15 @@ static int perf_try_init_event(struct pmu *pmu, struct perf_event *event)
>   	if (ctx)
>   		perf_event_ctx_unlock(event->group_leader, ctx);
>   
> +	if (!ret) {
> +		if (!(pmu->capabilities & PERF_PMU_CAP_EXCLUDE) &&
> +				event_has_any_exclude_flag(event)) {

Technically this is a bisection-breaker, since no driver has this 
capability yet - ideally, this patch should come after all the ones 
introducing it to the relevant drivers (with the removal of the 
now-redundant code from the other drivers at the end).

Alternatively, since we already have several other negative 
capabilities, unless there's a strong feeling against adding any more 
then it might work out simpler to flip it to PERF_PMU_CAP_NO_EXCLUDE, 
such that we only need to introduce the core check then directly replace 
the open-coded event checks with the capability in the appropriate 
drivers, and need not touch the exclusion-supporting ones at all.

Robin.

> +			if (event->destroy)
> +				event->destroy(event);
> +			ret = -EINVAL;
> +		}
> +	}
> +
>   	if (ret)
>   		module_put(pmu->module);
>   
> 
