Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.3/8.11.3) id f2GI2YD11051
	for linux-mips-outgoing; Fri, 16 Mar 2001 10:02:34 -0800
Received: from nevyn.them.org (mail@NEVYN.RES.CMU.EDU [128.2.145.225])
	by oss.sgi.com (8.11.3/8.11.3) with ESMTP id f2GI2PM11043;
	Fri, 16 Mar 2001 10:02:26 -0800
Received: from drow by nevyn.them.org with local (Exim 3.22 #1 (Debian))
	id 14dyYC-0001rC-00; Fri, 16 Mar 2001 13:02:08 -0500
Date: Fri, 16 Mar 2001 13:02:08 -0500
From: Daniel Jacobowitz <dan@debian.org>
To: Ralf Baechle <ralf@oss.sgi.com>
Cc: linux-mips@oss.sgi.com
Subject: Re: Can't build a CONFIG_CPU_NEVADA kernel
Message-ID: <20010316130208.A6803@nevyn.them.org>
References: <20010314084633.A25674@nevyn.them.org> <20010314195919.A1911@bacchus.dhis.org> <20010314140529.A29525@nevyn.them.org> <20010314202058.B1911@bacchus.dhis.org> <00fc01c0acd3$c881ca80$0deca8c0@Ulysses> <20010316150423.A3529@bacchus.dhis.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.16i
In-Reply-To: <20010316150423.A3529@bacchus.dhis.org>; from ralf@oss.sgi.com on Fri, Mar 16, 2001 at 03:04:23PM +0100
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Fri, Mar 16, 2001 at 03:04:23PM +0100, Ralf Baechle wrote:
> On Wed, Mar 14, 2001 at 11:11:47PM +0100, Kevin D. Kissell wrote:
> 
> > > Don't think of the r8000; the kernel only uses the -mcpu=r8000 option
> > > because the Nevada CPUs have _somewhat_ similar scheduling properties
> > > to the R8000.  This of it as an independant ISA expension which can
> > > be used with an arbitrary MIPS processor - even a R3000 processor.
> > 
> > In the interests of historical accuracy and general pedantry,
> > let me point out that -mcpu=r8000 is in effect a rather klugy
> > way of saying "-mips4" to compilers that predate official
> > MIPS IV ISA support.  The R8000 was the first MIPS IV
> > CPU, followed by the R10000 and the R5000.  The "Nevada"
> > processors added three implementation specific instructions
> > to the MIPS IV ISA: MAD, MADU, and MUL (targeted multiply).
> > "Correct" usage would be to enable those three instructions
> > with a "-mcpu=nevada", or better still, "-mcpu=r5200" (for 
> > consistency), and to enable the rest of the MIPS IV ISA 
> > with "-mips4" instead of the archaic r8000 hack.
> 
> Your historic facts may be right but the GCC fact aren't.  -mcpu=xxx tell
> GCC to schedule instructions for a certain processor xxx.  This does not
> enable the full use of it's instruction set.  Back in time when I choose
> these options I choose because GCC didn't know -mcpu=r5000 but the R8000
> was supported and it was the closest fit.  Gcc 1.1.2 knows this option
> so I just changed all instances of -mcpu=r8000 into -mcpu=r5000.

Are you saying that the -mcpu=r8000 options in linux/arch/mips/Makefile
for the nevada should be -mcpu=r5000 instead?

-- 
Daniel Jacobowitz                           Debian GNU/Linux Developer
Monta Vista Software                              Debian Security Team
                         "I am croutons!"
