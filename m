Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 02 Jul 2007 09:24:36 +0100 (BST)
Received: from marmite.frogfoot.net ([196.1.58.49]:53178 "EHLO
	marmite.frogfoot.net") by ftp.linux-mips.org with ESMTP
	id S20022463AbXGBIYe (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 2 Jul 2007 09:24:34 +0100
Received: from michael by marmite.frogfoot.net with local (Exim 4.63)
	(envelope-from <michael@frogfoot.com>)
	id 1I5HCo-0004kk-8s; Mon, 02 Jul 2007 10:24:22 +0200
Date:	Mon, 2 Jul 2007 10:24:21 +0200
To:	Florian Fainelli <florian.fainelli@telecomint.eu>
Cc:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>, linux-mips@linux-mips.org
Subject: Re: Unhandled kernel unaligned access debugging
Message-ID: <20070702082420.GI5929@marmite.frogfoot.net>
References: <20070629163951.GG5929@marmite.frogfoot.net> <20070701.014454.126142904.anemo@mba.ocn.ne.jp> <200706301854.01564.florian.fainelli@telecomint.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200706301854.01564.florian.fainelli@telecomint.eu>
User-Agent: Mutt/1.5.13 (2006-08-11)
From:	Michael Wood <michael@frogfoot.com>
Return-Path: <michael@frogfoot.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 15591
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: michael@frogfoot.com
Precedence: bulk
X-list: linux-mips

On Sat, Jun 30, 2007 at 06:53:59PM +0200, Florian Fainelli wrote:
> Hello Michael,
> 
> The OpenWrt kernel is based on the mainline kernel plus some other patches we 
> maintain for memory footprint or features. 
> 
> I suggets you disable mini_fo in the kernel configuration because it was 
> responsible for some memory corruption.

Thanks for the suggestion.

> You could also have reported the bug to our bug tracking system at 
> https://dev.openwrt.org. You will see that there a lot of other people trying 
> to get AR7 work (better ?).

I am suitably chastised ;)

I was really looking for details on what I could do to track it down,
instead of just reporting it and sitting back while someone else fixes
it, but I'll open a new ticket.

Thanks.

-- 
Michael Wood <michael@frogfoot.com>
