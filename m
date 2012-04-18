Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 18 Apr 2012 14:55:56 +0200 (CEST)
Received: from mail-pz0-f49.google.com ([209.85.210.49]:60168 "EHLO
        mail-pz0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903691Ab2DRMzj (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 18 Apr 2012 14:55:39 +0200
Received: by dadq36 with SMTP id q36so8020538dad.36
        for <multiple recipients>; Wed, 18 Apr 2012 05:55:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:reply-to:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=yAPmUgXfiumLfjVfiBfSM5FKNZG1ksrg7pa14NT5aJg=;
        b=AxGhrOoylE+n8qgoDulIGzaaFoG8AbF5eTcXciWi5MDg0btaJB/TQjZJCyChQlxHCQ
         goAaz0FzJ8As6YrAiKh92ndfvq8M8RqCKOy3AU1Ff96usXFPXQY8feuxaf4chn6pLURl
         ZejTkv18klCNAjEO7yJYLHQJtNdRsYkU8mj4CUuUjHBk7BFyRLKmDp9GJGGphubQ0OvT
         OkHWoCb/7mx2Y/ztz/l8b8boq9Kc423NIAjKz1ym/PyG2qBPdVhq/JVm1/9VWJoUnxg3
         xbGKrxg3ORit5zdvjwrxzLBWzIwD8/HNwfzAwF7KA2eQxY9vTiwMzc4TP7zoZNYRNsot
         ZPcw==
Received: by 10.68.201.98 with SMTP id jz2mr6195684pbc.97.1334753732253;
        Wed, 18 Apr 2012 05:55:32 -0700 (PDT)
Received: from localhost ([221.223.127.7])
        by mx.google.com with ESMTPS id ox2sm2309950pbc.55.2012.04.18.05.55.25
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 18 Apr 2012 05:55:30 -0700 (PDT)
Date:   Wed, 18 Apr 2012 20:55:16 +0800
From:   Yong Zhang <yong.zhang0@gmail.com>
To:     David Daney <ddaney.cavm@gmail.com>
Cc:     Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
        David Daney <ddaney@caviumnetworks.com>
Subject: Re: [PATCH] MIPS: cavium: Don't enable irq in ->init__secondary()
Message-ID: <20120418125516.GA4007@zhy>
Reply-To: Yong Zhang <yong.zhang0@gmail.com>
References: <1334561133-19139-1-git-send-email-yong.zhang0@gmail.com>
 <4F8C4D4E.4060900@gmail.com>
 <20120417030848.GA6377@zhy>
 <4F8DD67E.3000600@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <4F8DD67E.3000600@gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
X-archive-position: 32960
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: yong.zhang0@gmail.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>

On Tue, Apr 17, 2012 at 01:45:50PM -0700, David Daney wrote:
> On 04/16/2012 08:08 PM, Yong Zhang wrote:
> >On Mon, Apr 16, 2012 at 09:48:14AM -0700, David Daney wrote:
> >>On 04/16/2012 12:25 AM, Yong Zhang wrote:
> >>>From: Yong Zhang<yong.zhang@windriver.com>
> >>>
> >>>Too early to enable irq will break some following action,
> >>>such as notify_cpu_starting().
> >>
> >>Can you be more specific about what breaks?
> >
> >For example:
> >
> >	CPU1				CPU2
> >__cpu_up();
> >   mp_ops->boot_secondary();
> >     				start_secondary();
> >				  octeon_init_secondary();
> >				    raw_local_irq_enable();
> >				<IRQ>
> >				do something;
> >				      wake up softirqd;
> >				      try_to_wake_up();
> >				        select_fallback_rq();
> >					/* select wrong cpu */
> >     set_cpu_online();
> >
> 
> Yeah, that looks broken to me too.
> 
> >>
> >>>
> >>>I don't get side effect with this patch.
> >>
> >>Without this, where do irqs get enabled on the secondary CPUs?
> >
> >cpu_idle() will handle it. But in fact we should not depend on
> >cpu_idle().
> 
> It is not done in cpu_idle() itself.  If irqs are disabled upon
> entry to cpu_idle() *and* need_resched(), then we call into
> schedule().  The irqs are then enabled by the
> raw_spin_unlock_irq(&rq->lock) at the end of kernel/sched/core.c:
> __schedule().
> 
> >
> >But it seems there is not suitable place to put local_irq_enable(),
> >though ->smp_finish() looks like a more suitable place.
> 
> It would be better, but it seems like really it should be done in
> cpu_idle() immediately after rcu_idle_enter().

Hmm... seems we should put it before enter while (1) in cpu_idle(),
otherwise tick_nohz_idle_enter() will be unhappy if NO_HZ enabled.

But anyway, we still cann't survive from set_cpu_online() called on
other cpu. I'll recheck smp support for MIPS to see if things could
be improved ;-)

Thanks,
Yong
> 
> >
> >When looking more at smp support on MIPS, there is more things I find.
> >Such as set_cpu_online() is called on CPU1, so there will be another race
> >window like above scenario. Please take a look at what commit 2baab4e9
> >intend to resolve.
> >
> >Thanks,
> >Yong
> >
> >
> >
> >
> >>
> >>>
> >>>Signed-off-by: Yong Zhang<yong.zhang0@gmail.com>
> >>>Cc: David Daney<ddaney@caviumnetworks.com>
> >>>Cc: Ralf Baechle<ralf@linux-mips.org>
> >>>---
> >>>  arch/mips/cavium-octeon/smp.c |    1 -
> >>>  1 files changed, 0 insertions(+), 1 deletions(-)
> >>>
> >>>diff --git a/arch/mips/cavium-octeon/smp.c b/arch/mips/cavium-octeon/smp.c
> >>>index 97e7ce9..7e65c88 100644
> >>>--- a/arch/mips/cavium-octeon/smp.c
> >>>+++ b/arch/mips/cavium-octeon/smp.c
> >>>@@ -185,7 +185,6 @@ static void __cpuinit octeon_init_secondary(void)
> >>>  	octeon_init_cvmcount();
> >>>
> >>>  	octeon_irq_setup_secondary();
> >>>-	raw_local_irq_enable();
> >>>  }
> >>>
> >>>  /**
> >
