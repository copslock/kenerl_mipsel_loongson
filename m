Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 17 Apr 2006 09:42:10 +0100 (BST)
Received: from ozlabs.org ([203.10.76.45]:2456 "HELO ozlabs.org")
	by ftp.linux-mips.org with SMTP id S8127173AbWDQImA (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Mon, 17 Apr 2006 09:42:00 +0100
Received: from [192.168.1.68] (ppp62-226.lns1.cbr1.internode.on.net [59.167.62.226])
	(using SSLv3 with cipher RC4-MD5 (128/128 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id BE0C767B1A;
	Mon, 17 Apr 2006 16:47:43 +1000 (EST)
Subject: Re: [PATCH 00/05] robust per_cpu allocation for modules
From:	Rusty Russell <rusty@rustcorp.com.au>
To:	Steven Rostedt <rostedt@goodmis.org>
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
	linux390@de.ibm.com, davem@davemloft.net
In-Reply-To: <1145194804.27407.103.camel@localhost.localdomain>
References: <1145049535.1336.128.camel@localhost.localdomain>
	 <4440855A.7040203@yahoo.com.au>
	 <Pine.LNX.4.58.0604151609340.11302@gandalf.stny.rr.com>
	 <4441B02D.4000405@yahoo.com.au>
	 <Pine.LNX.4.58.0604152323560.16853@gandalf.stny.rr.com>
	 <17473.60411.690686.714791@cargo.ozlabs.ibm.com>
	 <1145194804.27407.103.camel@localhost.localdomain>
Content-Type: text/plain
Date:	Mon, 17 Apr 2006 16:47:24 +1000
Message-Id: <1145256445.28600.34.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 7bit
Return-Path: <rusty@rustcorp.com.au>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 11123
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: rusty@rustcorp.com.au
Precedence: bulk
X-list: linux-mips

On Sun, 2006-04-16 at 09:40 -0400, Steven Rostedt wrote:
> The reason that this is done, is that the per_cpu macro cant know
> whether or not the per_cpu variable was declared in a kernel or in a
> module.  So the __pre_cpu_offset[] array offset can't be used if the
> module allocation is in its own separate area. Remember that this offset
> array stores the difference from where the variable originally was and
> where it is now for each cpu.

Actually, the reason this is done is because the per_cpu_offset[] is
designed to be replaced by a register or an expression on archs which
care, and this is simple.  The main problem is that so many archs want
different things, it's a very UN task to build infrastructure.

I have always recommended using the same scheme to implement real
dynamic per-cpu allocation (which would then replace the mini-allocator
inside the module code).  In fact, I had such an implementation which I
reduced to the module case (dynamic per-cpu was too far-out at the
time).

The arch would allocate a virtual memory hole for each CPU, and map
pages as required (this is the simplest of several potential schemes).
This gives the "same space between CPUs" property which is required for
the ptr + per-cpu-offset scheme.  An arch would supply functions like:

	/* Returns address of new memory chunk(s)
         * (add __per_cpu_offset to get virtual addresses). */
	unsigned long alloc_percpu_memory(unsigned long *size);

	/* Set by ia64 to reserve the first chunk for percpu vars
	 * in modules only.
	#define __MODULE_RESERVE_FIRST_CHUNK

And an allocator would work on top of these.

I'm glad someone is looking at this again!
Rusty.
-- 
 ccontrol: http://ozlabs.org/~rusty/ccontrol
