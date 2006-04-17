Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 18 Apr 2006 00:33:35 +0100 (BST)
Received: from ms-smtp-02.nyroc.rr.com ([24.24.2.56]:27847 "EHLO
	ms-smtp-02.nyroc.rr.com") by ftp.linux-mips.org with ESMTP
	id S8133724AbWDQXd0 (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 18 Apr 2006 00:33:26 +0100
Received: from [192.168.23.10] (cpe-24-94-51-176.stny.res.rr.com [24.94.51.176])
	by ms-smtp-02.nyroc.rr.com (8.13.4/8.13.4) with ESMTP id k3HNiYUW011451;
	Mon, 17 Apr 2006 19:44:35 -0400 (EDT)
Date:	Mon, 17 Apr 2006 19:44:34 -0400 (EDT)
From:	Steven Rostedt <rostedt@goodmis.org>
X-X-Sender: rostedt@gandalf.stny.rr.com
To:	Ravikiran G Thirumalai <kiran@scalex86.org>
cc:	Christoph Lameter <clameter@sgi.com>,
	Nick Piggin <nickpiggin@yahoo.com.au>,
	LKML <linux-kernel@vger.kernel.org>,
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
	paulus@samba.org, linux390@de.ibm.com, davem@davemloft.net
Subject: Re: [PATCH 00/05] robust per_cpu allocation for modules
In-Reply-To: <20060417220238.GD3945@localhost.localdomain>
Message-ID: <Pine.LNX.4.58.0604171936040.24264@gandalf.stny.rr.com>
References: <1145049535.1336.128.camel@localhost.localdomain>
 <4440855A.7040203@yahoo.com.au> <Pine.LNX.4.64.0604170953390.29732@schroedinger.engr.sgi.com>
 <20060417220238.GD3945@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Virus-Scanned: Symantec AntiVirus Scan Engine
Return-Path: <rostedt@goodmis.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 11147
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: rostedt@goodmis.org
Precedence: bulk
X-list: linux-mips


On Mon, 17 Apr 2006, Ravikiran G Thirumalai wrote:

> On Mon, Apr 17, 2006 at 09:55:02AM -0700, Christoph Lameter wrote:
> > On Sat, 15 Apr 2006, Nick Piggin wrote:
> >
> > > If I'm following you correctly, this adds another dependent load
> > > to a per-CPU data access, and from memory that isn't node-affine.
> >
> > I am also concerned about that. Kiran has a patch to avoid allocpercpu
> > having to go through one level of indirection that I guess would no
> > longer work with this scheme.
>
> The alloc_percpu reimplementation would work regardless of changes to
> static per-cpu areas.  But, any extra indirection as was proposed initially
> is bad IMHO.
>

Don't worry, that idea has been shot down more than once ;-)

> >
> > > If so, I think people with SMP and NUMA kernels would care more
> > > about performance and scalability than the few k of memory this
> > > saves.
> >
> > Right.
>
> Me too :)
>

Understood, but I'm going to start looking in the way Rusty and Arnd
suggested with the vmalloc approach. This would allow for saving of
memory and dynamic allocation of module memory making it more robust. And
all this without that evil extra indirection!

So lets put my original patches where they belong, in the bit grave and
continue on. I lived, I learned and I've been shown the Way (thanks to
all BTW).

So now we can focus on a better solution.

Cheers,

-- Steve
