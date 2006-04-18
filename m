Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 18 Apr 2006 13:36:39 +0100 (BST)
Received: from ms-smtp-02.nyroc.rr.com ([24.24.2.56]:10898 "EHLO
	ms-smtp-02.nyroc.rr.com") by ftp.linux-mips.org with ESMTP
	id S8133480AbWDRMgX (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 18 Apr 2006 13:36:23 +0100
Received: from [192.168.23.10] (cpe-24-94-51-176.stny.res.rr.com [24.94.51.176])
	by ms-smtp-02.nyroc.rr.com (8.13.4/8.13.4) with ESMTP id k3IClv3e001514;
	Tue, 18 Apr 2006 08:47:57 -0400 (EDT)
Subject: Re: [PATCH 00/05] robust per_cpu allocation for modules
From:	Steven Rostedt <rostedt@goodmis.org>
To:	Nick Piggin <nickpiggin@yahoo.com.au>
Cc:	Ravikiran G Thirumalai <kiran@scalex86.org>,
	Christoph Lameter <clameter@sgi.com>,
	LKML <linux-kernel@vger.kernel.org>,
	Andrew Morton <akpm@osdl.org>,
	Linus Torvalds <torvalds@osdl.org>,
	Ingo Molnar <mingo@elte.hu>,
	Thomas Gleixner <tglx@linutronix.de>, Andi Kleen <ak@suse.de>,
	Martin Mares <mj@atrey.karlin.mff.cuni.cz>, bjornw@axis.com,
	schwidefsky@de.ibm.com, lethal@linux-sh.org,
	Chris Zankel <chris@zankel.net>,
	Marc Gauthier <marc@tensilica.com>,
	Joe Taylor <joe@tensilica.com>, rth@twiddle.net, spyro@f2s.com,
	starvik@axis.com, tony.luck@intel.com, linux-ia64@vger.kernel.org,
	ralf@linux-mips.org, linux-mips@linux-mips.org,
	grundler@parisc-linux.org, parisc-linux@parisc-linux.org,
	linuxppc-dev@ozlabs.org, paulus@samba.org, linux390@de.ibm.com,
	davem@davemloft.net
In-Reply-To: <44448A60.4040903@yahoo.com.au>
References: <1145049535.1336.128.camel@localhost.localdomain>
	 <4440855A.7040203@yahoo.com.au>
	 <Pine.LNX.4.64.0604170953390.29732@schroedinger.engr.sgi.com>
	 <20060417220238.GD3945@localhost.localdomain>
	 <Pine.LNX.4.58.0604171936040.24264@gandalf.stny.rr.com>
	 <44448A60.4040903@yahoo.com.au>
Content-Type: text/plain
Date:	Tue, 18 Apr 2006 08:47:57 -0400
Message-Id: <1145364477.17085.54.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.2.1 
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: Symantec AntiVirus Scan Engine
Return-Path: <rostedt@goodmis.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 11153
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: rostedt@goodmis.org
Precedence: bulk
X-list: linux-mips

[Removed from CC davidm@hpl.hp.com and benedict.gaster@superh.com
because I keep getting "unknown user" bounces from them]

On Tue, 2006-04-18 at 16:42 +1000, Nick Piggin wrote:
> Steven Rostedt wrote:
> 
> > Understood, but I'm going to start looking in the way Rusty and Arnd
> > suggested with the vmalloc approach. This would allow for saving of
> > memory and dynamic allocation of module memory making it more robust. And
> > all this without that evil extra indirection!
> 
> Remember that this approach could effectively just move the indirection to
> the TLB / page tables (well, I say "moves" because large kernel mappings
> are effectively free compared with 4K mappings).

Yeah, I thought about the paging latencies when it was first mentioned.
And this is something that's going to be very hard to know the impact,
because it will be different on every system.

> 
> So be careful about coding up a large amount of work before unleashing it:
> I doubt you'll be able to find a solution that doesn't involve tradeoffs
> somewhere (but wohoo if you can).
> 

OK, but as I mentioned that this is now more of a side project, so a
month of work is not really going to be a month of work ;)  I'll first
try to get something that just "works" and then post an RFC PATCH set,
to get more ideas.  Since obviously there's a lot of people out there
that know their systems much better than I do ;)

Thanks,

-- Steve
