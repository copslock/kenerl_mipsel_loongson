Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 02 Feb 2004 21:20:02 +0000 (GMT)
Received: from gateway-1237.mvista.com ([IPv6:::ffff:12.44.186.158]:33776 "EHLO
	orion.mvista.com") by linux-mips.org with ESMTP id <S8225342AbUBBVUC>;
	Mon, 2 Feb 2004 21:20:02 +0000
Received: (from jsun@localhost)
	by orion.mvista.com (8.11.6/8.11.6) id i12LJoi19049;
	Mon, 2 Feb 2004 13:19:50 -0800
Date: Mon, 2 Feb 2004 13:19:50 -0800
From: Jun Sun <jsun@mvista.com>
To: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
Cc: macro@ds2.pg.gda.pl, linux-mips@linux-mips.org, jsun@mvista.com
Subject: Re: [PATCH 2.6] enable genrtc for MIPS
Message-ID: <20040202131950.I18155@mvista.com>
References: <20040130103913.E31937@mvista.com> <Pine.LNX.4.55.0401302012200.10311@jurand.ds.pg.gda.pl> <20040201.203005.74756858.anemo@mba.ocn.ne.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20040201.203005.74756858.anemo@mba.ocn.ne.jp>; from anemo@mba.ocn.ne.jp on Sun, Feb 01, 2004 at 08:30:05PM +0900
Return-Path: <jsun@mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 4242
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jsun@mvista.com
Precedence: bulk
X-list: linux-mips

On Sun, Feb 01, 2004 at 08:30:05PM +0900, Atsushi Nemoto wrote:
> 
> By the way, with this patch, individual board can not implement it's
> own genrtc routines.  How about making gen_rtc_time, etc. pointer to
> functions to allow overrides?
> 

Is this necessary?  How about letting us wait until there is a sensible
need?

> I think implementing rtc_get_time (mips specific) with get_rtc_time
> (genrtc) is more efficient than implementing get_rtc_time with
> rtc_get_time for most RTC chips.
> 

If I understand you correctly, you like to have board rtc read routines to 
return a rtc structure instead of the unsigned long integer.

There are actually boards which makes the current implementation more efficient.  
See vr4181.

In general, however, this is not a bad idea, just involving a lot more
board level changes.  I think it deserves another patch or even debate.

Jun
