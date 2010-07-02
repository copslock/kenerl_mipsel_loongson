Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 02 Jul 2010 23:32:36 +0200 (CEST)
Received: from sj-iport-1.cisco.com ([171.71.176.70]:46539 "EHLO
        sj-iport-1.cisco.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S1492042Ab0GBVca (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 2 Jul 2010 23:32:30 +0200
Authentication-Results: sj-iport-1.cisco.com; dkim=neutral (message not signed) header.i=none
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: AvsEAHP3LUyrR7Ht/2dsb2JhbACfZXGlFpo7hSQEg3Q
X-IronPort-AV: E=Sophos;i="4.53,528,1272844800"; 
   d="scan'208";a="340773696"
Received: from sj-core-1.cisco.com ([171.71.177.237])
  by sj-iport-1.cisco.com with ESMTP; 02 Jul 2010 21:32:19 +0000
Received: from dvomlehn-lnx2.corp.sa.net (dhcp-171-71-47-241.cisco.com [171.71.47.241])
        by sj-core-1.cisco.com (8.13.8/8.14.3) with ESMTP id o62LWJFH022473;
        Fri, 2 Jul 2010 21:32:19 GMT
Date:   Fri, 2 Jul 2010 14:32:19 -0700
From:   David VomLehn <dvomlehn@cisco.com>
To:     Shinya Kuribayashi <skuribay@pobox.com>
Cc:     linux-mips@linux-mips.org
Subject: Re: [PATCH] MIPS: PowerTV: Use fls() carefully where static
        optimization is required
Message-ID: <20100702213219.GA390@dvomlehn-lnx2.corp.sa.net>
References: <4C2755A3.3080600@pobox.com> <20100630220124.GA576@dvomlehn-lnx2.corp.sa.net> <4C2DF427.7080508@pobox.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4C2DF427.7080508@pobox.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
Return-Path: <dvomlehn@cisco.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 27300
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dvomlehn@cisco.com
Precedence: bulk
X-list: linux-mips

On Fri, Jul 02, 2010 at 09:13:59AM -0500, Shinya Kuribayashi wrote:
> Hi,
> 
> On 07/01/2010 07:01 AM, David VomLehn wrote:
> > Thanks!  You are correct in your analysis and make a good point that
> > clz should be used in interrupt handling. I think, though, that it's
> > better to go ahead and supply a full-blown cpu-features-override.h 
> > rather than focusing on this one case. This way fls() will be optimized
> > to use clz everywhere and any other optimizations that depend on constant
> > cpu_has_* values will also be used.
> 
> Your choice, either one will be fine :-)

I think the cpu-features-override is a a better solution because it allows
better code throughout the kernel.

> By the way, Malta's clz() and irq_ffs() are very nice, and there are
> two followers; MIPSSim and PowerTV.  And now I'm going to make use of
> them for emma2rh, too.
> 
> I've prepared a consolidation patch like this, but have two concerns:
> 
> 1) irq_ffs() is used to dispatch IRQs, so we'd like to give preference
>    to CONFIG_CPU_xxx over cpu_has_clo_clz, to optimize with CLZ.  It's
>    somewhat different for usual fls() and ffs() cases.  Or, 
> 
> 2) would it be better to check __builtin_constant_p(cpu_has_clo_clz)?
> 
> Or, any other good alternatives?

Usually it's better to control things on a feature-by-feature basis rather
than rely on things like CPU model. This allows you to easily handle case
where, for example, you have a different CPU that normally doesn't have
a feature but a particular variant does have it. IIRC, the MIPS family has
examples of this. So, I think it's better to go with the:
	__builtin_constant_p(cpu_has_clo_clz) && cpu_has_clo_clz
used in fls().
-- 
David VL
