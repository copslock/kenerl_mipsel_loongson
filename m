Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 23 Aug 2004 18:37:41 +0100 (BST)
Received: from gateway-1237.mvista.com ([IPv6:::ffff:12.44.186.158]:33787 "EHLO
	orion.mvista.com") by linux-mips.org with ESMTP id <S8225005AbUHWRhg>;
	Mon, 23 Aug 2004 18:37:36 +0100
Received: from orion.mvista.com (localhost.localdomain [127.0.0.1])
	by orion.mvista.com (8.12.8/8.12.8) with ESMTP id i7NHbX7T023185;
	Mon, 23 Aug 2004 10:37:33 -0700
Received: (from jsun@localhost)
	by orion.mvista.com (8.12.8/8.12.8/Submit) id i7NHbWBM023184;
	Mon, 23 Aug 2004 10:37:32 -0700
Date: Mon, 23 Aug 2004 10:37:31 -0700
From: Jun Sun <jsun@mvista.com>
To: Daniel Jacobowitz <dan@debian.org>
Cc: Dominic Sweetman <dom@mips.com>, linux-mips@linux-mips.org,
	jsun@mvista.com
Subject: Re: anybody tried NPTL?
Message-ID: <20040823173731.GC23004@mvista.com>
References: <20040804152936.D6269@mvista.com> <16676.46694.564448.344602@arsenal.mips.com> <20040819221646.GC8737@mvista.com> <16678.163.774841.111369@arsenal.mips.com> <20040823132853.GA31354@nevyn.them.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040823132853.GA31354@nevyn.them.org>
User-Agent: Mutt/1.4i
Return-Path: <jsun@mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 5724
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jsun@mvista.com
Precedence: bulk
X-list: linux-mips

On Mon, Aug 23, 2004 at 09:28:53AM -0400, Daniel Jacobowitz wrote:
> On Fri, Aug 20, 2004 at 02:46:11PM +0100, Dominic Sweetman wrote:
> > I guess our main message was that we felt it would be a mistake just
> > to add a thread register to o32 (which produces a substantially
> > incompatible new ABI anyway).
> 
> Completely agree...
> 
> > Until that all works, what we had in mind is that we'd do NPTL over
> > o32 by defining a system call to return a per-thread ID which is or
> > can be converted into a per-thread data pointer.  We suspected that
> > NPTL's per-thread-data model allows the use of cunning macros or
> > library functions to make that look OK.
> > 
> > Ought we to go further and see exactly how that can be done?
> 
> It shouldn't be at all hard.  The way NPTL's __thread support works,
> the only things that should have to know where the TLS base is are
> (A) GCC, so it can load it and (B) GDB, via some new ptrace op. 

Are you implying one can implement TLS support without changing O32
ABI?  Interesting...

I know Boris Hu has tried to implemented NPTL with another approach which
does not rely on TLS support (use "--without-tls").  According to him
this approach is getting harder these days.

Jun
