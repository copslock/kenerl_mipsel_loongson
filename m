Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id g1K5WXo03279
	for linux-mips-outgoing; Tue, 19 Feb 2002 21:32:33 -0800
Received: from nevyn.them.org (mail@NEVYN.RES.CMU.EDU [128.2.145.6])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id g1K5WT903276
	for <linux-mips@oss.sgi.com>; Tue, 19 Feb 2002 21:32:30 -0800
Received: from drow by nevyn.them.org with local (Exim 3.34 #1 (Debian))
	id 16dOQY-0005mZ-00; Tue, 19 Feb 2002 23:32:22 -0500
Date: Tue, 19 Feb 2002 23:32:22 -0500
From: Daniel Jacobowitz <dan@debian.org>
To: Jun Sun <jsun@mvista.com>
Cc: Greg Lindahl <lindahl@conservativecomputer.com>, linux-mips@oss.sgi.com
Subject: Re: FPU emulator unsafe for SMP?
Message-ID: <20020219233222.A22099@nevyn.them.org>
References: <3C6C6ACF.CAD2FFC@mvista.com> <20020215031118.B21011@dea.linux-mips.net> <20020214232030.A3601@mvista.com> <20020215003037.A3670@mvista.com> <002b01c1b607$6afbd5c0$10eca8c0@grendel> <20020219140514.C25739@mvista.com> <00af01c1b9a2$c0d6d5f0$10eca8c0@grendel> <20020219171238.E25739@mvista.com> <20020219222835.A4195@wumpus.skymv.com> <20020219202434.F25739@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020219202434.F25739@mvista.com>
User-Agent: Mutt/1.3.23i
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Tue, Feb 19, 2002 at 08:24:34PM -0800, Jun Sun wrote:
> On Tue, Feb 19, 2002 at 10:28:35PM -0500, Greg Lindahl wrote:
> > 
> > Alpha seems to always save the fpu state (the comments say that gcc
> > always generates code that uses it in every user process.)
> >
> 
> I think the comment might be an execuse. :-)  Never heard of gcc
> generating unnecessary floating point code.

I have :)  It may do memory moves in them, for instance.  Not sure if
that makes sense on Alpha.

> > I suspect that the optimization of not saving the fpu state for a
> > process that doesn't use the fpu is the most critical optimization.
> > And that you do already.
> 
> If you do use floating point, I think it is pretty common to have
> only process that uses fpu and runs for very long.  In that case,
> leaving FPU owned by the process also saves quite a bit.

Not true.  For instance, on a processor with hardware FPU, setjmp()
will save FPU registers.  That means most processes will actually end
up taking the FPU at least once.


The general approach in Linux is to disable lazy switching on SMP.  I'm
95% sure that PowerPC does that.

-- 
Daniel Jacobowitz                           Carnegie Mellon University
MontaVista Software                         Debian GNU/Linux Developer
