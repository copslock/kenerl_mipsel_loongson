Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id g1KAn0i08344
	for linux-mips-outgoing; Wed, 20 Feb 2002 02:49:00 -0800
Received: from orion.mvista.com (gateway-1237.mvista.com [12.44.186.158])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id g1KAmv908341
	for <linux-mips@oss.sgi.com>; Wed, 20 Feb 2002 02:48:57 -0800
Received: (from jsun@localhost)
	by orion.mvista.com (8.9.3/8.9.3) id BAA03695;
	Wed, 20 Feb 2002 01:48:22 -0800
Date: Wed, 20 Feb 2002 01:48:21 -0800
From: Jun Sun <jsun@mvista.com>
To: Daniel Jacobowitz <dan@debian.org>
Cc: Greg Lindahl <lindahl@conservativecomputer.com>, linux-mips@oss.sgi.com
Subject: Re: FPU emulator unsafe for SMP?
Message-ID: <20020220014821.H25739@mvista.com>
References: <20020215031118.B21011@dea.linux-mips.net> <20020214232030.A3601@mvista.com> <20020215003037.A3670@mvista.com> <002b01c1b607$6afbd5c0$10eca8c0@grendel> <20020219140514.C25739@mvista.com> <00af01c1b9a2$c0d6d5f0$10eca8c0@grendel> <20020219171238.E25739@mvista.com> <20020219222835.A4195@wumpus.skymv.com> <20020219202434.F25739@mvista.com> <20020219233222.A22099@nevyn.them.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20020219233222.A22099@nevyn.them.org>; from dan@debian.org on Tue, Feb 19, 2002 at 11:32:22PM -0500
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Tue, Feb 19, 2002 at 11:32:22PM -0500, Daniel Jacobowitz wrote:
> > If you do use floating point, I think it is pretty common to have
> > only process that uses fpu and runs for very long.  In that case,
> > leaving FPU owned by the process also saves quite a bit.
> 
> Not true.  For instance, on a processor with hardware FPU, setjmp()
> will save FPU registers.  That means most processes will actually end
> up taking the FPU at least once.
> 

It is true that almost all process will take FPU once, but that 
does not affect my statement unless you have a lot of programs come in
and go away.

On other hand, I do agree with Greg that hand-waving does not mean
much here.  It would be nice to have some performance data on
a benchmark apps.  Any good candidate?  It should be easy to
do a comparison.

BTW, I just found out that almost all processes have their used_math
bit set - this is because init uses math at the beginning and
later all forked processes inherit that bit.  Interesting - that
also hides a couple of bugs related to if (!current->used) branch
in do_cpu(). 

Jun
