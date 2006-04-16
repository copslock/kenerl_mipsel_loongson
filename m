Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 16 Apr 2006 07:50:22 +0100 (BST)
Received: from ozlabs.org ([203.10.76.45]:2236 "HELO ozlabs.org")
	by ftp.linux-mips.org with SMTP id S8133423AbWDPGuN (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Sun, 16 Apr 2006 07:50:13 +0100
Received: by ozlabs.org (Postfix, from userid 1003)
	id 2A1FB67A76; Sun, 16 Apr 2006 17:02:24 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17473.60411.690686.714791@cargo.ozlabs.ibm.com>
Date:	Sun, 16 Apr 2006 17:02:19 +1000
From:	Paul Mackerras <paulus@samba.org>
To:	Steven Rostedt <rostedt@goodmis.org>
Cc:	Nick Piggin <nickpiggin@yahoo.com.au>,
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
	linux390@de.ibm.com, davem@davemloft.net, rusty@rustcorp.com.au
Subject: Re: [PATCH 00/05] robust per_cpu allocation for modules
In-Reply-To: <Pine.LNX.4.58.0604152323560.16853@gandalf.stny.rr.com>
References: <1145049535.1336.128.camel@localhost.localdomain>
	<4440855A.7040203@yahoo.com.au>
	<Pine.LNX.4.58.0604151609340.11302@gandalf.stny.rr.com>
	<4441B02D.4000405@yahoo.com.au>
	<Pine.LNX.4.58.0604152323560.16853@gandalf.stny.rr.com>
X-Mailer: VM 7.19 under Emacs 21.4.1
Return-Path: <paulus@ozlabs.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 11115
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: paulus@samba.org
Precedence: bulk
X-list: linux-mips

Steven Rostedt writes:

> So now I'm asking for advice on some ideas that can be a work around to
> keep the robustness and speed.

Ideally, what I'd like to do on powerpc is to dedicate one register to
storing a per-cpu base address or offset, and be able to resolve the
offset at link time, so that per-cpu variable accesses just become a
register + offset memory access.  (For modules, "link time" would be
module load time.)

We *might* be able to use some of the infrastructure that was put into
gcc and binutils to support TLS (thread local storage) to achieve
this.  (See http://people.redhat.com/drepper/tls.pdf for some of the
details of that.)

Also, I've added Rusty Russell to the cc list, since he designed the
per-cpu variable stuff in the first place, and would be able to
explain the trade-offs that led to the PERCPU_ENOUGH_ROOM thing.  (I
think you're discovering them as you go, though. :)

Paul.
