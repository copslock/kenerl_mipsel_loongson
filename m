Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 25 Mar 2005 22:53:16 +0000 (GMT)
Received: from nevyn.them.org ([IPv6:::ffff:66.93.172.17]:41425 "EHLO
	nevyn.them.org") by linux-mips.org with ESMTP id <S8229678AbVCYWxB>;
	Fri, 25 Mar 2005 22:53:01 +0000
Received: from drow by nevyn.them.org with local (Exim 4.50 #1 (Debian))
	id 1DExgN-0003Jv-Hf; Fri, 25 Mar 2005 17:53:35 -0500
Date:	Fri, 25 Mar 2005 17:53:35 -0500
From:	Daniel Jacobowitz <dan@debian.org>
To:	Ed Martini <martini@c2micro.com>
Cc:	linux-mips@linux-mips.org
Subject: Re: Observations on LLSC and SMP
Message-ID: <20050325225335.GA12669@nevyn.them.org>
References: <4230DB4C.7090103@c2micro.com> <20050314110101.GF7759@linux-mips.org> <423763B9.2000907@c2micro.com> <20050316120647.GB8563@linux-mips.org> <42446555.6090005@c2micro.com> <20050325193759.GA23046@nevyn.them.org> <424494AC.7020407@c2micro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <424494AC.7020407@c2micro.com>
User-Agent: Mutt/1.5.6+20040907i
Return-Path: <drow@nevyn.them.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 7529
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dan@debian.org
Precedence: bulk
X-list: linux-mips

On Fri, Mar 25, 2005 at 02:46:04PM -0800, Ed Martini wrote:
> Daniel Jacobowitz wrote:
> 
> >On Fri, Mar 25, 2005 at 11:24:05AM -0800, Ed Martini wrote:
> > 
> >
> >>1. If the first part of the if were an ifdef instead it would result in 
> >>a code size reduction as well as a runtime performance gain.
> >>   
> >>
> >
> >You should spend a little time playing with an optimizing compiler. 
> >They're capable of working out when a condition will always be false.
> > 
> >
> Yes, but in the case where R10000_LLSC_WAR is true, but cpu_has_llsc 
> returns false there are still two wasted tests, and two blocks of code 
> that the compiler can't optimize out.

Not only is cpu_has_llsc often a constant, R10000_LLSC_WAR will never
be true if the CPU does not have LL/SC.

-- 
Daniel Jacobowitz
CodeSourcery, LLC
