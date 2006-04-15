Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 15 Apr 2006 21:07:18 +0100 (BST)
Received: from ms-smtp-04.nyroc.rr.com ([24.24.2.58]:63105 "EHLO
	ms-smtp-04.nyroc.rr.com") by ftp.linux-mips.org with ESMTP
	id S8133543AbWDOUGB (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Sat, 15 Apr 2006 21:06:01 +0100
Received: from [192.168.23.10] (cpe-24-94-51-176.stny.res.rr.com [24.94.51.176])
	by ms-smtp-04.nyroc.rr.com (8.13.4/8.13.4) with ESMTP id k3FKH17L021633;
	Sat, 15 Apr 2006 16:17:01 -0400 (EDT)
Date:	Sat, 15 Apr 2006 16:17:01 -0400 (EDT)
From:	Steven Rostedt <rostedt@goodmis.org>
X-X-Sender: rostedt@gandalf.stny.rr.com
To:	Nick Piggin <nickpiggin@yahoo.com.au>
cc:	LKML <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>,
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
	paulus@samba.org, linux390@de.ibm.com, davem@davemloft.net
Subject: Re: [PATCH 00/05] robust per_cpu allocation for modules
In-Reply-To: <4440855A.7040203@yahoo.com.au>
Message-ID: <Pine.LNX.4.58.0604151609340.11302@gandalf.stny.rr.com>
References: <1145049535.1336.128.camel@localhost.localdomain>
 <4440855A.7040203@yahoo.com.au>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Virus-Scanned: Symantec AntiVirus Scan Engine
Return-Path: <rostedt@goodmis.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 11110
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: rostedt@goodmis.org
Precedence: bulk
X-list: linux-mips


On Sat, 15 Apr 2006, Nick Piggin wrote:

> Steven Rostedt wrote:
>
> >  would now create a variable called per_cpu_offset__myint in
> > the .data.percpu_offset section.  This variable will point to the (if
> > defined in the kernel) __per_cpu_offset[] array.  If this was a module
> > variable, it would point to the module per_cpu_offset[] array which is
> > created when the modules is loaded.
>
> If I'm following you correctly, this adds another dependent load
> to a per-CPU data access, and from memory that isn't node-affine.
>
> If so, I think people with SMP and NUMA kernels would care more
> about performance and scalability than the few k of memory this
> saves.

It's not just about saving memory, but also to make it more robust. But
that's another story.

Since both the offset array, and the variables are mainly read only (only
written on boot up), added the fact that the added variables are in their
own section.  Couldn't something be done to help pre load this in a local
cache, or something similar?

I understand SMP issues pretty well, but NUMA is still somewhat foreign to
me.

-- Steve
