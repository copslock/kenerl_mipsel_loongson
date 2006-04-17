Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 17 Apr 2006 12:22:49 +0100 (BST)
Received: from ms-smtp-03.nyroc.rr.com ([24.24.2.57]:57321 "EHLO
	ms-smtp-03.nyroc.rr.com") by ftp.linux-mips.org with ESMTP
	id S8133403AbWDQLWh (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 17 Apr 2006 12:22:37 +0100
Received: from [192.168.23.10] (cpe-24-94-51-176.stny.res.rr.com [24.94.51.176])
	by ms-smtp-03.nyroc.rr.com (8.13.4/8.13.4) with ESMTP id k3HBXbAI001217;
	Mon, 17 Apr 2006 07:33:39 -0400 (EDT)
Subject: Re: [PATCH 00/05] robust per_cpu allocation for modules
From:	Steven Rostedt <rostedt@goodmis.org>
To:	Rusty Russell <rusty@rustcorp.com.au>
Cc:	Paul Mackerras <paulus@samba.org>,
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
	linux390@de.ibm.com, davem@davemloft.net,
	Arnd Bergmann <arnd@arndb.de>
In-Reply-To: <1145256445.28600.34.camel@localhost.localdomain>
References: <1145049535.1336.128.camel@localhost.localdomain>
	 <4440855A.7040203@yahoo.com.au>
	 <Pine.LNX.4.58.0604151609340.11302@gandalf.stny.rr.com>
	 <4441B02D.4000405@yahoo.com.au>
	 <Pine.LNX.4.58.0604152323560.16853@gandalf.stny.rr.com>
	 <17473.60411.690686.714791@cargo.ozlabs.ibm.com>
	 <1145194804.27407.103.camel@localhost.localdomain>
	 <1145256445.28600.34.camel@localhost.localdomain>
Content-Type: text/plain
Date:	Mon, 17 Apr 2006 07:33:36 -0400
Message-Id: <1145273616.27828.21.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.2.1 
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: Symantec AntiVirus Scan Engine
Return-Path: <rostedt@goodmis.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 11129
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: rostedt@goodmis.org
Precedence: bulk
X-list: linux-mips

On Mon, 2006-04-17 at 16:47 +1000, Rusty Russell wrote:

> 
> The arch would allocate a virtual memory hole for each CPU, and map
> pages as required (this is the simplest of several potential schemes).
> This gives the "same space between CPUs" property which is required for
> the ptr + per-cpu-offset scheme.  An arch would supply functions like:
> 
> 	/* Returns address of new memory chunk(s)
>          * (add __per_cpu_offset to get virtual addresses). */
> 	unsigned long alloc_percpu_memory(unsigned long *size);
> 
> 	/* Set by ia64 to reserve the first chunk for percpu vars
> 	 * in modules only.
> 	#define __MODULE_RESERVE_FIRST_CHUNK
> 
> And an allocator would work on top of these.
> 
> I'm glad someone is looking at this again!

Hi Rusty, thanks for the input.

Arnd Bergmann also suggested doing the same thing.  I've slept on this
thought last night and I'm starting to like it more and more.  At least
it seems to be a better solution than some of the things that I've come
up with.

I'll start playing around a little and see what I can do with it.  I
also need to start doing some other work too, so this might take a month
or two to get some results.  So hopefully, I'll have another patch set
in June or July that will be more acceptable.

I'd like to thank all those that responded with ideas and criticisms.
It's been very helpful.

-- Steve
