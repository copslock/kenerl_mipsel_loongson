Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id g1KF03D13368
	for linux-mips-outgoing; Wed, 20 Feb 2002 07:00:03 -0800
Received: from dea.linux-mips.net (a1as06-p249.stg.tli.de [195.252.187.249])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id g1KExm913344
	for <linux-mips@oss.sgi.com>; Wed, 20 Feb 2002 06:59:51 -0800
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.11.6/8.11.1) id g1KDIfO16279;
	Wed, 20 Feb 2002 14:18:41 +0100
Date: Wed, 20 Feb 2002 14:18:41 +0100
From: Ralf Baechle <ralf@oss.sgi.com>
To: Jun Sun <jsun@mvista.com>
Cc: Greg Lindahl <lindahl@conservativecomputer.com>, linux-mips@oss.sgi.com
Subject: Re: FPU emulator unsafe for SMP?
Message-ID: <20020220141841.E15588@dea.linux-mips.net>
References: <3C6C6ACF.CAD2FFC@mvista.com> <20020215031118.B21011@dea.linux-mips.net> <20020214232030.A3601@mvista.com> <20020215003037.A3670@mvista.com> <002b01c1b607$6afbd5c0$10eca8c0@grendel> <20020219140514.C25739@mvista.com> <00af01c1b9a2$c0d6d5f0$10eca8c0@grendel> <20020219171238.E25739@mvista.com> <20020219222835.A4195@wumpus.skymv.com> <20020219202434.F25739@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20020219202434.F25739@mvista.com>; from jsun@mvista.com on Tue, Feb 19, 2002 at 08:24:34PM -0800
X-Accept-Language: de,en,fr
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Tue, Feb 19, 2002 at 08:24:34PM -0800, Jun Sun wrote:

> > What you propose, locking the fpu owner to the current cpu, will not
> > result in a fair solution. Imagine a 2 cpu machine with 2 processes
> > using integer math and 1 using floating point... how much cpu time
> > will each process get? 
> 
> In this case, proc that uses fpu gets about 50% of one cpu, i.e., 25% of
> total load, while the other two integer math proces split the rest 75%,
> which gives 37.5% each.  Not too bad in my opinion.

Certainly not good either.  Still not having checked the x86 solution
I currently favor the approach of only always storing the fp context
but lazily restoring it.

  Ralf
