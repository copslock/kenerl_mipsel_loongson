Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id g1KF0Md13435
	for linux-mips-outgoing; Wed, 20 Feb 2002 07:00:22 -0800
Received: from dea.linux-mips.net (a1as06-p249.stg.tli.de [195.252.187.249])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id g1KF0F913425
	for <linux-mips@oss.sgi.com>; Wed, 20 Feb 2002 07:00:18 -0800
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.11.6/8.11.1) id g1KDOGd16319;
	Wed, 20 Feb 2002 14:24:16 +0100
Date: Wed, 20 Feb 2002 14:24:16 +0100
From: Ralf Baechle <ralf@oss.sgi.com>
To: Daniel Jacobowitz <dan@debian.org>
Cc: Jun Sun <jsun@mvista.com>, Greg Lindahl <lindahl@conservativecomputer.com>,
   linux-mips@oss.sgi.com
Subject: Re: FPU emulator unsafe for SMP?
Message-ID: <20020220142416.F15588@dea.linux-mips.net>
References: <20020215031118.B21011@dea.linux-mips.net> <20020214232030.A3601@mvista.com> <20020215003037.A3670@mvista.com> <002b01c1b607$6afbd5c0$10eca8c0@grendel> <20020219140514.C25739@mvista.com> <00af01c1b9a2$c0d6d5f0$10eca8c0@grendel> <20020219171238.E25739@mvista.com> <20020219222835.A4195@wumpus.skymv.com> <20020219202434.F25739@mvista.com> <20020219233222.A22099@nevyn.them.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20020219233222.A22099@nevyn.them.org>; from dan@debian.org on Tue, Feb 19, 2002 at 11:32:22PM -0500
X-Accept-Language: de,en,fr
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

The cleassic reason to take the FPU is the ctc1 $0, $31 instruction used
to initalize the FPU control register rsp. it's equivalent on other
architectures.  This should be fixed in glibc since a few years.

   Ralf
