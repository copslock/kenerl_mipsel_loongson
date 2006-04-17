Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 17 Apr 2006 11:24:28 +0100 (BST)
Received: from moutng.kundenserver.de ([212.227.126.183]:33791 "EHLO
	moutng.kundenserver.de") by ftp.linux-mips.org with ESMTP
	id S8133415AbWDQKYT convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Mon, 17 Apr 2006 11:24:19 +0100
Received: from [84.160.53.210] (helo=noname)
	by mrelayeu.kundenserver.de (node=mrelayeu7) with ESMTP (Nemesis),
	id 0ML2Dk-1FVJ8i0kPD-00038H; Mon, 17 Apr 2006 04:06:59 +0200
From:	Arnd Bergmann <arnd@arndb.de>
To:	Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH 00/05] robust per_cpu allocation for modules
Date:	Mon, 17 Apr 2006 04:07:23 +0200
User-Agent: KMail/1.9.1
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
	linux390@de.ibm.com, davem@davemloft.net, rusty@rustcorp.com.au
References: <1145049535.1336.128.camel@localhost.localdomain> <200604161734.20256.arnd@arndb.de> <1145234750.27828.8.camel@localhost.localdomain>
In-Reply-To: <1145234750.27828.8.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200604170407.26111.arnd@arndb.de>
X-Provags-ID: kundenserver.de abuse@kundenserver.de login:bf0b512fe2ff06b96d9695102898be39
Return-Path: <arnd@arndb.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 11128
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: arnd@arndb.de
Precedence: bulk
X-list: linux-mips

Am Monday 17 April 2006 02:45 schrieb Steven Rostedt:
> > - does not work in real mode, so percpu data can't be used
> >   inside exception handlers on some architectures.
>
> This is probably a big issue.  I believe interrupt context in hrtimers
> uses per_cpu variables.

If it's just about hrtimers, it should be harmless, since they
are run in softirq context. Even regular interrupt handlers are
always called with paging enabled, otherwise you could not
have them im modules.

> > - memory consumption is rather high when PAGE_SIZE is large
>
> That's also something that I'm trying to solve.  To use the least amount
> of memory and still have the performance.
>
> Now, I've also thought about allocating per_cpu and when a module is
> loaded, reallocate more memory and copy it again.  Use something like
> the kstopmachine to sync the system so that the CPUS don't update any
> per_cpu variables while this is happening, so that things can't get out
> of sync.

I guess this breaks if someone holds a pointer to a per-cpu variable
while a module gets loaded.

	Arnd <><
