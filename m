Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 10 Mar 2003 17:59:39 +0000 (GMT)
Received: from gateway-1237.mvista.com ([IPv6:::ffff:12.44.186.158]:15100 "EHLO
	orion.mvista.com") by linux-mips.org with ESMTP id <S8225211AbTCJR7j>;
	Mon, 10 Mar 2003 17:59:39 +0000
Received: (from jsun@localhost)
	by orion.mvista.com (8.11.6/8.11.6) id h2AHx7P10368;
	Mon, 10 Mar 2003 09:59:07 -0800
Date: Mon, 10 Mar 2003 09:59:07 -0800
From: Jun Sun <jsun@mvista.com>
To: Ralf Baechle <ralf@linux-mips.org>
Cc: Kip Walker <kwalker@broadcom.com>, linux-mips@linux-mips.org,
	jsun@mvista.com
Subject: Re: [pathch] kernel/sched.c bogon?
Message-ID: <20030310095907.U26071@mvista.com>
References: <3E67EF64.152CFC6C@broadcom.com> <20030306174001.K26071@mvista.com> <20030310135531.B2206@linux-mips.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20030310135531.B2206@linux-mips.org>; from ralf@linux-mips.org on Mon, Mar 10, 2003 at 01:55:31PM +0100
Return-Path: <jsun@mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 1683
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jsun@mvista.com
Precedence: bulk
X-list: linux-mips

On Mon, Mar 10, 2003 at 01:55:31PM +0100, Ralf Baechle wrote:
> On Thu, Mar 06, 2003 at 05:40:01PM -0800, Jun Sun wrote:
> 
> > I reported this bug last May.  Apparently it is still not
> > taken up-stream.   Ralf, why don't we fix it here and push
> > it up from you?
> > 
> > BTW, this bug actually has effect on real-time performance under
> > preemptible kernel.
> 
> < = 2.4.x preemptible kernel is OPP.
> 
> >  It can delay the execution of the highest
> > priority real-time process from execution up to 1 jiffy.
> 
> Quite a number of users get_cycles() in the kernel assume it to return a
> 64-bit number.  I guess we'll have to fake a 64-bit counter in software ...
>

Whether we fake 64-bit or not, oldest_idle is declared as cycles_t.  
So comparing it with (cycles_t)-1 should be always be correct.  And it
actually makes a correct C program. :-)

I don't see any possible reason for rejecting the change.  My previous
report is probably just lost in the noise.

Jun
