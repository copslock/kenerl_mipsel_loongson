Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 17 May 2006 17:20:49 +0200 (CEST)
Received: from ms-smtp-02.nyroc.rr.com ([24.24.2.56]:10971 "EHLO
	ms-smtp-02.nyroc.rr.com") by ftp.linux-mips.org with ESMTP
	id S8133389AbWEQPUk (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 17 May 2006 17:20:40 +0200
Received: from [192.168.23.10] (cpe-24-94-51-176.stny.res.rr.com [24.94.51.176])
	by ms-smtp-02.nyroc.rr.com (8.13.6/8.13.6) with ESMTP id k4HFIDKg020031;
	Wed, 17 May 2006 11:18:17 -0400 (EDT)
Date:	Wed, 17 May 2006 11:18:13 -0400 (EDT)
From:	Steven Rostedt <rostedt@goodmis.org>
X-X-Sender: rostedt@gandalf.stny.rr.com
To:	Christoph Lameter <clameter@sgi.com>
cc:	LKML <linux-kernel@vger.kernel.org>,
	Rusty Russell <rusty@rustcorp.com.au>,
	Paul Mackerras <paulus@samba.org>,
	Nick Piggin <nickpiggin@yahoo.com.au>,
	Andrew Morton <akpm@osdl.org>,
	Linus Torvalds <torvalds@osdl.org>,
	Ingo Molnar <mingo@elte.hu>,
	Thomas Gleixner <tglx@linutronix.de>, Andi Kleen <ak@suse.de>,
	Martin Mares <mj@atrey.karlin.mff.cuni.cz>, bjornw@axis.com,
	schwidefsky@de.ibm.com, benedict.gaster@superh.com,
	lethal@linux-sh.org, Chris Zankel <chris@zankel.net>,
	Marc Gauthier <marc@tensilica.com>,
	Joe Taylor <joe@tensilica.com>,
	David Mosberger-Tang <davidm@hpl.hp.com>, rth@twiddle.net,
	spyro@f2s.com, starvik@axis.com, tony.luck@intel.com,
	linux-ia64@vger.kernel.org, ralf@linux-mips.org,
	linux-mips@linux-mips.org, grundler@parisc-linux.org,
	parisc-linux@parisc-linux.org, linuxppc-dev@ozlabs.org,
	linux390@de.ibm.com, davem@davemloft.net, arnd@arndb.de,
	kenneth.w.chen@intel.com, sam@ravnborg.org, kiran@scalex86.org
Subject: Re: [RFC PATCH 00/09] robust VM per_cpu variables
In-Reply-To: <Pine.LNX.4.64.0605170744360.13021@schroedinger.engr.sgi.com>
Message-ID: <Pine.LNX.4.58.0605171104100.13160@gandalf.stny.rr.com>
References: <Pine.LNX.4.58.0605170547490.8408@gandalf.stny.rr.com>
 <Pine.LNX.4.64.0605170744360.13021@schroedinger.engr.sgi.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Virus-Scanned: Symantec AntiVirus Scan Engine
Return-Path: <rostedt@goodmis.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 11475
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: rostedt@goodmis.org
Precedence: bulk
X-list: linux-mips


Hi Christoph,

Thanks for replying!

On Wed, 17 May 2006, Christoph Lameter wrote:

> On Wed, 17 May 2006, Steven Rostedt wrote:
>
> > My first attempt to fix this introduced another dereference, to allow
> > for modules to allocate their own memory.  This was quickly shot down,
> > and for good reason, because dereferences kill performance, and don't
> > play nice with large SMP systems that depend on per_cpu being fast.
>
> > I now place the per_cpu variables into VM, such that the pages are
> > only allocated when needed. All the architecture needs to do is
> > supply a VM address range, size for each CPU to use (note this
> > implementation expects all the VM CPU areas to be together), and
> > three functions to allow for allocating page tables at bootup.
>
> So now instead of an explicit indirection we use an implicit one
> through the page tables for this. This happens during early boot which
> requires additional page table functions? And it requires the use of an
> additional TLB entry? I guess that the additional TLB pressure alone will
> result in a performance drop of 3%?

Ouch!

>
> See http://www.gelato.unsw.edu.au/archives/linux-ia64/0602/17311.html

Thanks for the link.

Hmm, my main goal is still to make the per_cpu more robust, so that the
generic code is truely that, and the hacks are better managed.  Would the
TLB pressure on a normal desktop also cause the drop in performance?  I
haven't tried any benchmarks.  Have any tests I can run on two kernels?
I'm currently running my machine with the patches and I haven't noticed
a difference.  Although I'm not doing database work, I'm still compiling
kernels.

Reason I'm asking, is that I wonder if the whole VM idea is a waste, or is
it only a problem on certain archs?

Perhaps move the whole of percpu_boot_alloc into the arch, and let it do
the allocation as is.  Could perhaps use some arch specific register to
calculate the entries.

OK, now I'm just rambling. I don't know,  have any other ideas on making
this more robust?  Or is this all in vain, and I should spend my evenings
walking around this beautiful town of Karlsruhe ;)

-- Steve
