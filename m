Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 20 Mar 2007 01:03:29 +0000 (GMT)
Received: from sccrmhc11.comcast.net ([204.127.200.81]:24449 "EHLO
	sccrmhc11.comcast.net") by ftp.linux-mips.org with ESMTP
	id S20022011AbXCTBD1 (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 20 Mar 2007 01:03:27 +0000
Received: from plexity.net (c-71-193-156-244.hsd1.or.comcast.net[71.193.156.244])
          by comcast.net (sccrmhc11) with ESMTP
          id <2007032001024401100al9d9e>; Tue, 20 Mar 2007 01:02:44 +0000
Received: by plexity.net (Postfix, from userid 1025)
	id 953CF54494A; Mon, 19 Mar 2007 17:03:00 -0700 (PDT)
Date:	Mon, 19 Mar 2007 17:03:00 -0700
From:	Deepak Saxena <dsaxena@plexity.net>
To:	mingo@elte.hu
Cc:	ralf@linux-mips.org, linux-mips@linux-mips.org,
	Manish Lachwani <mlachwani@mvista.com>
Subject: Re: [PATCH] Make MIPS udelay() preempt safe
Message-ID: <20070320000300.GA12123@plexity.net>
Reply-To: dsaxena@plexity.net
References: <20070319234945.GA11944@plexity.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20070319234945.GA11944@plexity.net>
Organization: Plexity Networks
User-Agent: Mutt/1.5.11
Return-Path: <dsaxena@plexity.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 14576
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dsaxena@plexity.net
Precedence: bulk
X-list: linux-mips


Nevermind on this one. I just noticed that the original patch is not
needed.

~Deepak

On Mar 19 2007, at 16:49, Deepak Saxena was caught saying:
> Fix MIPS udelay to make is preempt safe under DEBUG_PREEMPT
> 
> Signed-off-by: Manish Lachwani <mlachwani@mvista.com>
> Signed-off-by: Deepak Saxena <dsaxena@mvista.com>
> 
> ---
> 
> This needs to go into -rt patch set or directly into the MIPS tree.
> Applies cleanly to 2.6.21-rc4 and 2.6.21-rc3-rt0.
> 
>  include/asm-mips/delay.h |    2 +-
>  1 files changed, 1 insertion(+), 1 deletion(-)
> 
> Index: linux-2.6.18/include/asm-mips/delay.h
> ===================================================================
> --- linux-2.6.18.orig/include/asm-mips/delay.h
> +++ linux-2.6.18/include/asm-mips/delay.h
> @@ -79,7 +79,7 @@ static inline void __udelay(unsigned lon
>  	__delay(usecs);
>  }
>  
> -#define __udelay_val cpu_data[smp_processor_id()].udelay_val
> +#define __udelay_val cpu_data[raw_smp_processor_id()].udelay_val
>  
>  #define udelay(usecs) __udelay((usecs),__udelay_val)
>  
> 
> -- 
> Deepak Saxena - dsaxena@plexity.net - http://www.plexity.net
> 
> In the end, they will not say, "those were dark times,"  they will ask
> "why were their poets silent?" - Bertolt Brecht

-- 
Deepak Saxena - dsaxena@plexity.net - http://www.plexity.net

In the end, they will not say, "those were dark times,"  they will ask
"why were their poets silent?" - Bertolt Brecht
