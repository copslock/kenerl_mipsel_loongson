Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id g1KLrcA27120
	for linux-mips-outgoing; Wed, 20 Feb 2002 13:53:38 -0800
Received: from nixon.xkey.com (nixon.xkey.com [209.245.148.124])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id g1KLrZ927117
	for <linux-mips@oss.sgi.com>; Wed, 20 Feb 2002 13:53:35 -0800
Received: (qmail 19733 invoked from network); 20 Feb 2002 20:53:34 -0000
Received: from localhost (HELO localhost.conservativecomputer.com) (127.0.0.1)
  by localhost with SMTP; 20 Feb 2002 20:53:34 -0000
Received: (from lindahl@localhost)
	by localhost.conservativecomputer.com (8.11.6/8.11.0) id g1KKrWr02843
	for linux-mips@oss.sgi.com; Wed, 20 Feb 2002 15:53:32 -0500
X-Authentication-Warning: localhost.hpti.com: lindahl set sender to lindahl@conservativecomputer.com using -f
Date: Wed, 20 Feb 2002 15:53:32 -0500
From: Greg Lindahl <lindahl@conservativecomputer.com>
To: linux-mips@oss.sgi.com
Subject: Re: FPU emulator unsafe for SMP?
Message-ID: <20020220155332.A2766@wumpus.skymv.com>
Mail-Followup-To: linux-mips@oss.sgi.com
References: <20020215003037.A3670@mvista.com> <002b01c1b607$6afbd5c0$10eca8c0@grendel> <20020219140514.C25739@mvista.com> <00af01c1b9a2$c0d6d5f0$10eca8c0@grendel> <20020219171238.E25739@mvista.com> <20020219222835.A4195@wumpus.skymv.com> <20020219202434.F25739@mvista.com> <20020219233222.A22099@nevyn.them.org> <006001c1b9f7$7da1c920$0deca8c0@Ulysses> <20020220145023.G15588@dea.linux-mips.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20020220145023.G15588@dea.linux-mips.net>; from ralf@oss.sgi.com on Wed, Feb 20, 2002 at 02:50:23PM +0100
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Wed, Feb 20, 2002 at 02:50:23PM +0100, Ralf Baechle wrote:

> These days I assume the difference to be greater for cache reasons.  Our
> stored fp registers take 256 bytes and also tend to be located at a constant
> offset from start of the 8kB (64-bit: 16kB) aligned task_struct.  Combined
> with the usually low degree of cache associativity on MIPS that means
> we'll frequently miss L1.

Ouch. That cache miss is much more expensive than saving the FPU state.

Can we un-align task_struct? I see it is allocated as a whole page,
but it's apparently much smaller. We could add an offset to its start
(hm, should be a multiple of the cache line size), and that ought to
give much nicer L1 usage.

Any other struct which is allocated as a whole page but is much
smaller could be a candidate for this, too. But we should experiment
once to see if it's a win before getting that excited.

greg
