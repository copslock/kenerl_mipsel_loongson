Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 26 Mar 2004 18:44:30 +0000 (GMT)
Received: from purplechoc.demon.co.uk ([IPv6:::ffff:80.176.224.106]:8064 "EHLO
	skeleton-jack.localnet") by linux-mips.org with ESMTP
	id <S8225255AbUCZSo3>; Fri, 26 Mar 2004 18:44:29 +0000
Received: from pdh by skeleton-jack.localnet with local (Exim 3.35 #1 (Debian))
	id 1B6wIX-0000zx-00; Fri, 26 Mar 2004 18:43:17 +0000
Date: Fri, 26 Mar 2004 18:43:17 +0000
To: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
Cc: phorton@bitbox.co.uk, linux-mips@linux-mips.org
Subject: Re: missing flush_dcache_page call in 2.4 kernel
Message-ID: <20040326184317.GA3661@skeleton-jack>
References: <20040325.224229.112629304.nemoto@toshiba-tops.co.jp> <20040325143319.GA873@linux-mips.org> <4062F1A1.9070005@bitbox.co.uk> <20040326.122258.41628012.nemoto@toshiba-tops.co.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040326.122258.41628012.nemoto@toshiba-tops.co.jp>
User-Agent: Mutt/1.3.28i
From: Peter Horton <pdh@colonel-panic.org>
Return-Path: <pdh@colonel-panic.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 4664
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: pdh@colonel-panic.org
Precedence: bulk
X-list: linux-mips

On Fri, Mar 26, 2004 at 12:22:58PM +0900, Atsushi Nemoto wrote:
>
> phorton> Looks like it.
> 
> phorton> The fix we're using on Cobalt's at the moment is below
> phorton> (required for 2.4.x and 2.6.x).
> 
> phorton> Fixing it this way fixes the problem with both page cache
> phorton> pages and swap pages.
> 
> phorton> For more details see the threads "Kernel 2.4.23 on Cobalt
> phorton> Qube2 - area of problem" and "Instability / caching problems
> phorton> on Qube 2 - solved ?"  from December last year.
> 
> Thanks, I agree (maybe I should read ML messages more carefully ...)
> 
> This patch fixes my problem also, thanks, but ... I do not think
> r4k_flush_icache_page is a best place to fix since my test program is
> not related I-cache at all.
> 

Agreed. The fix went here because this is arch specific code and it's
called in exactly the two places where there is a problem.

> I'm quite sure that it's a kernel bug and may cause problems if any
> PIO block device (PIO ide, ide-cs, mtdblock, etc.) are used on CPUs
> which have d-cache aliases (not only MIPS).  We need a correct fix ...
> 

True. A proper fix would flush the relevant page after PIO transfers
into the page cache / swap pages. Unfortunately this would require a
hook in the generic kernel.

P.
