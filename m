Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 16 Apr 2006 07:23:16 +0100 (BST)
Received: from ozlabs.org ([203.10.76.45]:36279 "HELO ozlabs.org")
	by ftp.linux-mips.org with SMTP id S8133465AbWDPGXI (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Sun, 16 Apr 2006 07:23:08 +0100
Received: by ozlabs.org (Postfix, from userid 1003)
	id B56AD67A60; Sun, 16 Apr 2006 16:35:15 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17473.58781.901412.135671@cargo.ozlabs.ibm.com>
Date:	Sun, 16 Apr 2006 16:35:09 +1000
From:	Paul Mackerras <paulus@samba.org>
To:	Steven Rostedt <rostedt@goodmis.org>
Cc:	LKML <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>,
	linux-mips@linux-mips.org,
	David Mosberger-Tang <davidm@hpl.hp.com>,
	linux-ia64@vger.kernel.org,
	Martin Mares <mj@atrey.karlin.mff.cuni.cz>, spyro@f2s.com,
	Joe Taylor <joe@tensilica.com>, linuxppc-dev@ozlabs.org,
	benedict.gaster@superh.com, bjornw@axis.com,
	Ingo Molnar <mingo@elte.hu>, grundler@parisc-linux.org,
	starvik@axis.com, Linus Torvalds <torvalds@osdl.org>,
	Thomas Gleixner <tglx@linutronix.de>, rth@twiddle.net,
	chris@zankel.net, tony.luck@intel.com, Andi Kleen <ak@suse.de>,
	ralf@linux-mips.org, Marc Gauthier <marc@tensilica.com>,
	lethal@linux-sh.org, schwidefsky@de.ibm.com, linux390@de.ibm.com,
	davem@davemloft.net, parisc-linux@parisc-linux.org
Subject: Re: [PATCH 00/05] robust per_cpu allocation for modules
In-Reply-To: <1145049535.1336.128.camel@localhost.localdomain>
References: <1145049535.1336.128.camel@localhost.localdomain>
X-Mailer: VM 7.19 under Emacs 21.4.1
Return-Path: <paulus@ozlabs.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 11114
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: paulus@samba.org
Precedence: bulk
X-list: linux-mips

Steven Rostedt writes:

> The data in .data.percpu_offset holds is referenced by the per_cpu
> variable name which points to the __per_cpu_offset array.  For modules,
> it will point to the per_cpu_offset array of the module.
> 
> Example:
> 
>  DEFINE_PER_CPU(int, myint);
> 
>  would now create a variable called per_cpu_offset__myint in
> the .data.percpu_offset section.  This variable will point to the (if
> defined in the kernel) __per_cpu_offset[] array.  If this was a module
> variable, it would point to the module per_cpu_offset[] array which is
> created when the modules is loaded.

This sounds like you have an extra memory reference each time a
per-cpu variable is accessed.  Have you tried to measure the
performance impact of that?  If so, how much performance does it lose?

Paul.
