Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f9O0i0Z20365
	for linux-mips-outgoing; Tue, 23 Oct 2001 17:44:00 -0700
Received: from dea.linux-mips.net (a1as04-p137.stg.tli.de [195.252.186.137])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f9O0huD20358
	for <linux-mips@oss.sgi.com>; Tue, 23 Oct 2001 17:43:57 -0700
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.11.1/8.11.1) id f9O0h9421492;
	Wed, 24 Oct 2001 02:43:09 +0200
Date: Wed, 24 Oct 2001 02:43:08 +0200
From: Ralf Baechle <ralf@oss.sgi.com>
To: Petko Manolov <pmanolov@Lnxw.COM>
Cc: linux-mips@oss.sgi.com
Subject: Re: Malta probs
Message-ID: <20011024024308.A21460@dea.linux-mips.net>
References: <200110230102.f9N12kb20443@oss.sgi.com> <3BD5D236.8D0CE33C@lnxw.com> <20011023224718.A6283@dea.linux-mips.net> <3BD5E193.BB41A907@lnxw.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3BD5E193.BB41A907@lnxw.com>; from pmanolov@Lnxw.COM on Tue, Oct 23, 2001 at 02:30:59PM -0700
X-Accept-Language: de,en,fr
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Tue, Oct 23, 2001 at 02:30:59PM -0700, Petko Manolov wrote:

> > What CPU are you using; can you send me your .config file?
> 
> I am using R4Kc core on Malta board; here is the .config file.
> 
> BTW the kernel silently hang after executing execve("/sbin/init")
> in init/main.c file. I suspect some of the tlb handling code
> which was recently changed is causing the crash. Not having any
> register dump also increase the entropy :-)

It wasn't really changed, the whole lump of arch/mips/mm/ was just
restructured in a way that allows adding of new CPU types and - even
more important - get the code maintainable again.  As it is right now
we had a bunch of almost identical copies of the TLB flushing code,
some even buggy.  Now way I'd continue to deal with that.  So now let's
fix the breakage asap.  As there were no functional changes any bugs
are of rather trivial nature.

  Ralf
