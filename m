Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 07 Oct 2002 20:43:54 +0200 (CEST)
Received: from buserror-extern.convergence.de ([212.84.236.66]:22020 "EHLO
	hell") by linux-mips.org with ESMTP id <S1123396AbSJGSnx>;
	Mon, 7 Oct 2002 20:43:53 +0200
Received: from js by hell with local (Exim 3.35 #1 (Debian))
	id 17ycr2-0004ad-00; Mon, 07 Oct 2002 20:43:44 +0200
Date: Mon, 7 Oct 2002 20:43:44 +0200
From: Johannes Stezenbach <js@convergence.de>
To: "Kevin D. Kissell" <kevink@mips.com>
Cc: linux-mips@linux-mips.org
Subject: Re: Once again: test_and_set for CPUs w/o LL/SC
Message-ID: <20021007184344.GA17548@convergence.de>
Mail-Followup-To: Johannes Stezenbach <js@convergence.de>,
	"Kevin D. Kissell" <kevink@mips.com>, linux-mips@linux-mips.org
References: <20020916164034.GA12489@convergence.de> <20021007144749.GB16641@convergence.de> <01fd01c26e1d$add77240$10eca8c0@grendel>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <01fd01c26e1d$add77240$10eca8c0@grendel>
User-Agent: Mutt/1.4i
Return-Path: <js@convergence.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 392
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: js@convergence.de
Precedence: bulk
X-list: linux-mips

On Mon, Oct 07, 2002 at 06:21:52PM +0200, Kevin D. Kissell wrote:
>
> When I first proposed the branch-likely hack last winter,
> I thought it might be worth while to do a through code
> inspection to determine what set of values could never
> be returned in k1 (or k0 for all I care) if an exception
> was taken, such that there would be no mods to the
> kernel required whatsoever.  I spent a little time going 
> down that path, and it does look at first glance as if one 
> could guarantee that one will never come out of an exception 
> with k1 equal to 0xffdadaff in current oss/linux-mips cvs
> sources, but the guys at Sony, who have a big interest in 
> this technique, given that the PS2 has no LL/SC,
> prefered a more conservative approach which explicitly
> clobbered the selective register on all exceptions,
> even if it meant some small performance impact.
> That's probably going to be a more reliable design,
> though I would still consider leaving the TLB refill handler
> untouched and counting on the fact that k1 must contain
> a non-lethal EntryLo value on return from the exception.

In my original posting from Mon, Sep 16, 2002 (maybe I should
have reposted it in full?), a had appended a patch which
leaves the TLB handlers alone (k1 always ends up with an EntryLo value,
thus bit 31 is guaranteed to be 0), but explicitly sets k1 to zero in
RESTORE_SP_AND_RET.

> As for glibc, the possibilities are numerous and I'm not
> the guy who'd have to make it work.

The question is how the glibc can detect if
a) the CPU does not have LL/SC
b) the kernel guarantees k1 != MAGIC

I think the kernel should announce this explicitly.
In my patch from Sep 16 I used a sysctl, but that's
probably bad because glibc would rely on a real new
include/linux/sysctl.h.

I need some advice on this (maybe add a line to /proc/cpuinfo,
or create a new /proc entry? or add a sysmips call to get
this info?).

I also want to know if there's public interest to get such
a change in the kernel. If yes, I will try to get a matching
patch into glibc. If no, I will just post the current patch I
use to the list for the hackers to pick up.


Regards,
Johannes
