Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f9UEE1422888
	for linux-mips-outgoing; Tue, 30 Oct 2001 06:14:01 -0800
Received: from dea.linux-mips.net (a1as06-p248.stg.tli.de [195.252.187.248])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f9UEDu022885
	for <linux-mips@oss.sgi.com>; Tue, 30 Oct 2001 06:13:56 -0800
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.11.1/8.11.1) id f9UED8624335;
	Tue, 30 Oct 2001 15:13:08 +0100
Date: Tue, 30 Oct 2001 15:13:08 +0100
From: Ralf Baechle <ralf@oss.sgi.com>
To: Carsten Langgaard <carstenl@mips.com>
Cc: Alice Hennessy <ahennessy@mvista.com>,
   Atsushi Nemoto <nemoto@toshiba-tops.co.jp>, ajob4me@21cn.com,
   linux-mips@oss.sgi.com
Subject: Re: Toshiba TX3927 board boot problem.
Message-ID: <20011030151308.B10165@dea.linux-mips.net>
References: <20011026095319.1C4BBB474@topsms.toshiba-tops.co.jp> <20011026.225806.63990588.nemoto@toshiba-tops.co.jp> <20011029.160225.59648095.nemoto@toshiba-tops.co.jp> <3BDD140E.432D795B@mips.com> <3BDDF193.B6405A7F@mvista.com> <20011030013223.B6614@dea.linux-mips.net> <3BDE0FAF.1E3556A9@mvista.com> <3BDE6671.7776CB4B@mips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3BDE6671.7776CB4B@mips.com>; from carstenl@mips.com on Tue, Oct 30, 2001 at 09:36:01AM +0100
X-Accept-Language: de,en,fr
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Tue, Oct 30, 2001 at 09:36:01AM +0100, Carsten Langgaard wrote:

> > So,  we should not set CU1 generically for FPU-less CPUs especially since a
> > known problem exists
> > for the tx3927?  Ie, qualify all setting of CU1 as follows:
> >
> > if (mips_cpu.options & MIPS_CPU_FPU)
> >                    set_cp0_status(ST0_CU1);
> 
> And while we are at it, could we handle the CP0 hazard of 4 nops, between
> setting the CU1 bit in the status register and executing
> the first floating point instruction, on CPU which got a FPU.

Which CPUs actually need four nops?

Just working on a patch; I found a bunch more place where we were playing
with the CU1 bit.

  Ralf
