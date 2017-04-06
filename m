Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 06 Apr 2017 11:16:19 +0200 (CEST)
Received: from bombadil.infradead.org ([65.50.211.133]:54177 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23991976AbdDFJQJqgV8K (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 6 Apr 2017 11:16:09 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=QdOqia+P2JHaHhydlWsNOGWNxo7LGJnXt+VI5y9ocU0=; b=ivM5xL4OhvKheBTmT9mj1LFIv
        zPtScqZTl//Wo9CUk+Ut/CpeipGFWAz0mF3yTGoXH1J1H6cjPxc05oWFGab1Rq+8A8NOlbfSTJ5F4
        Grth/izR3YndFpu5pUE4ewWcj6aRmkbisbSPmgszpIY+W7OCr8mxxcJKPAep5+S+pv24tmkHdvhxl
        W+wtxhWRSKK+VgE1rfNn7Ee7Gxj8l9eEV9+kO8ZLmAOD2zDW6yodu20FELmy2OZ1LpwHTN2dlcYZo
        AopUysAi23SBA6WbBWLS5Nel9H+9pBH/gVoZEM/R1SAKTC+YSxju+Pe9ueusOVezavrPQORm7U52n
        T3rLgKDwA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.87 #1 (Red Hat Linux))
        id 1cw3WR-0007uY-0S; Thu, 06 Apr 2017 09:16:07 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 54609205B0082; Thu,  6 Apr 2017 11:16:04 +0200 (CEST)
Date:   Thu, 6 Apr 2017 11:16:04 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Rabin Vincent <rabin.vincent@axis.com>
Cc:     ralf@linux-mips.org, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org, mingo@redhat.com, acme@kernel.org,
        alexander.shishkin@linux.intel.com, Rabin Vincent <rabinv@axis.com>
Subject: Re: [PATCH] MIPS: perf: fix deadlock
Message-ID: <20170406091604.37poma56ptmcn7de@hirez.programming.kicks-ass.net>
References: <1491398048-20083-1-git-send-email-rabin.vincent@axis.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1491398048-20083-1-git-send-email-rabin.vincent@axis.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Return-Path: <peterz@infradead.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 57579
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: peterz@infradead.org
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

On Wed, Apr 05, 2017 at 03:14:08PM +0200, Rabin Vincent wrote:

That lock is disgusting... but yes patch looks about right.

I'll leave it to the MIPS people though.

> ---
>  arch/mips/kernel/perf_event_mipsxx.c | 9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/mips/kernel/perf_event_mipsxx.c b/arch/mips/kernel/perf_event_mipsxx.c
> index 8c35b31..9452b02 100644
> --- a/arch/mips/kernel/perf_event_mipsxx.c
> +++ b/arch/mips/kernel/perf_event_mipsxx.c
> @@ -1446,6 +1446,11 @@ static int mipsxx_pmu_handle_shared_irq(void)
>  	HANDLE_COUNTER(0)
>  	}
>  
> +#ifdef CONFIG_MIPS_PERF_SHARED_TC_COUNTERS
> +	read_unlock(&pmuint_rwlock);
> +#endif
> +	resume_local_counters();
> +
>  	/*
>  	 * Do all the work for the pending perf events. We can do this
>  	 * in here because the performance counter interrupt is a regular
> @@ -1454,10 +1459,6 @@ static int mipsxx_pmu_handle_shared_irq(void)
>  	if (handled == IRQ_HANDLED)
>  		irq_work_run();
>  
> -#ifdef CONFIG_MIPS_PERF_SHARED_TC_COUNTERS
> -	read_unlock(&pmuint_rwlock);
> -#endif
> -	resume_local_counters();
>  	return handled;
>  }
>  
> -- 
> 2.7.0
> 
