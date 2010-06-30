Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 30 Jun 2010 19:48:37 +0200 (CEST)
Received: from sj-iport-4.cisco.com ([171.68.10.86]:56539 "EHLO
        sj-iport-4.cisco.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S1492317Ab0F3Rs3 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 30 Jun 2010 19:48:29 +0200
Authentication-Results: sj-iport-4.cisco.com; dkim=neutral (message not signed) header.i=none
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: AvsEAC8gK0yrR7Hu/2dsb2JhbACfUnGmXZozhSUEg2w
X-IronPort-AV: E=Sophos;i="4.53,514,1272844800"; 
   d="scan'208";a="152113219"
Received: from sj-core-5.cisco.com ([171.71.177.238])
  by sj-iport-4.cisco.com with ESMTP; 30 Jun 2010 17:48:19 +0000
Received: from dvomlehn-lnx2.corp.sa.net (dhcp-171-71-47-241.cisco.com [171.71.47.241])
        by sj-core-5.cisco.com (8.13.8/8.14.3) with ESMTP id o5UHmJqh011860;
        Wed, 30 Jun 2010 17:48:19 GMT
Date:   Wed, 30 Jun 2010 10:48:20 -0700
From:   David VomLehn <dvomlehn@cisco.com>
To:     Shinya Kuribayashi <skuribay@pobox.com>
Cc:     linux-mips@linux-mips.org
Subject: Re: [PATCH] MIPS: PowerTV: Use fls() carefully where static
        optimization is required
Message-ID: <20100630174819.GA20597@dvomlehn-lnx2.corp.sa.net>
References: <4C2755A3.3080600@pobox.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4C2755A3.3080600@pobox.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
X-archive-position: 27283
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dvomlehn@cisco.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                 
X-UID: 20427

On Sun, Jun 27, 2010 at 08:44:03AM -0500, Shinya Kuribayashi wrote:
> fls()/__fls() defined at <asm/bitops.h>, doesn't use CLZ unless it's
> explicitly requested via <cpu-features-overrides.h>.  In other words,
> as long as depending on cpu_data[0].isa_level, CLZ is nerver used for
> fls()/__fls().
> 
> Looking at leftover clz() in asic_int.c, PowerTV used to use Malta's
> clz() and irq_ffs() as-is, then for some reason made a decision not to
> use clz().
> 
> It's MIPS32 machine and luckily clz() is left there, then let's go back
> to the original shape.
> 
> Signed-off-by: Shinya Kuribayashi <skuribay@pobox.com>
> ---
> 
>  Compile checked, and now CLZ is back.
> 
>  arch/mips/powertv/asic/asic_int.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/arch/mips/powertv/asic/asic_int.c b/arch/mips/powertv/asic/asic_int.c
> index 529c44a..e3c08a2 100644
> --- a/arch/mips/powertv/asic/asic_int.c
> +++ b/arch/mips/powertv/asic/asic_int.c
> @@ -86,7 +86,7 @@ static inline int clz(unsigned long x)
>   */
>  static inline unsigned int irq_ffs(unsigned int pending)
>  {
> -	return fls(pending) - 1 + CAUSEB_IP;
> +	return -clz(pending) + 31 - CAUSEB_IP;
>  }
>  
>  /*

Thanks, I'll try this out.

-- 
David VL
