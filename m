Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 24 Nov 2003 18:31:18 +0000 (GMT)
Received: from gateway-1237.mvista.com ([IPv6:::ffff:12.44.186.158]:29943 "EHLO
	orion.mvista.com") by linux-mips.org with ESMTP id <S8225370AbTKXSbG>;
	Mon, 24 Nov 2003 18:31:06 +0000
Received: (from jsun@localhost)
	by orion.mvista.com (8.11.6/8.11.6) id hAOIV1923470;
	Mon, 24 Nov 2003 10:31:01 -0800
Date: Mon, 24 Nov 2003 10:31:01 -0800
From: Jun Sun <jsun@mvista.com>
To: "Steven J. Hill" <sjhill@realitydiluted.com>
Cc: linux-mips@linux-mips.org, jsun@mvista.com
Subject: Re: Kernel interface for MIPS timers....
Message-ID: <20031124103101.I14650@mvista.com>
References: <3FC200DF.8000804@realitydiluted.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3FC200DF.8000804@realitydiluted.com>; from sjhill@realitydiluted.com on Mon, Nov 24, 2003 at 08:00:15AM -0500
Return-Path: <jsun@mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 3661
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jsun@mvista.com
Precedence: bulk
X-list: linux-mips

On Mon, Nov 24, 2003 at 08:00:15AM -0500, Steven J. Hill wrote:
> Hello.
> 
> This could be an embarassing question, but I seem to be good at
> asking those anyway. A lot more MIPS processors lately seem to
> come with multiple timers. In addition to the main HPT timer on
> R4K variants and above, usually there are 2 or 3 additional 16
> or 32-bit timers with prescalars and other features. Some drivers
> may decide to use one of these timers exclusively and I am sure
> there are many other uses as well. There does not seem to be any
> type of API or reservation system to cleanly utilize the timers
> present in the system. Actually, on a lot of my boards the added
> timers do not get any usage, but perhaps that could change. Has
> anyone given thought to this, or does it just seem pointless?

I afraid it might be later. :)

Kernel needs one timer, i.e., the system or jiffy timer.  All
other time or timer services are provided based on it.

Individual drivers or application may use the other timers, but
that does not mean kernel needs to explicitly manage them.

Given that said, Monta Vista recently has implemented high resolution
posix timer, in which case we do abstract out two system timers,
one for jiffy, and other is for high resolution stuff.  (Individual
board, however, is free to multiplex the same hw timer for both 
purposes in its implementation)

Personally I don't think this approach is perfect.  The ultimate right 
solution is to have a single high resolution timer interface native to
the kernel, and we emulate jiffy timer on top to provide continuing support
for existing (or legacy) jiffy timer services.

This is something which should be interesting for 2.7.

Jun
