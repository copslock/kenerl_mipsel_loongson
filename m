Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id fB8M3Il19723
	for linux-mips-outgoing; Sat, 8 Dec 2001 14:03:18 -0800
Received: from nevyn.them.org (mail@NEVYN.RES.CMU.EDU [128.2.145.6])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id fB8M3Eo19720
	for <linux-mips@oss.sgi.com>; Sat, 8 Dec 2001 14:03:14 -0800
Received: from drow by nevyn.them.org with local (Exim 3.33 #1 (Debian))
	id 16Cock-00007T-00; Sat, 08 Dec 2001 16:03:06 -0500
Date: Sat, 8 Dec 2001 16:03:06 -0500
From: Daniel Jacobowitz <dan@debian.org>
To: Andreas Jaeger <aj@suse.de>
Cc: Guido Guenther <guido.guenther@gmx.net>, linux-mips@oss.sgi.com
Subject: Re: understanding elf_machine_load_address
Message-ID: <20011208160306.A385@nevyn.them.org>
References: <20011208141141.GA11437@bogon.ms20.nix> <u8n10tg2oy.fsf@gromit.moeb> <20011208114713.A20432@nevyn.them.org> <u8wuzxe8pa.fsf@gromit.moeb>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <u8wuzxe8pa.fsf@gromit.moeb>
User-Agent: Mutt/1.3.23i
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Sat, Dec 08, 2001 at 09:52:01PM +0100, Andreas Jaeger wrote:
> Daniel Jacobowitz <dan@debian.org> writes:
> 
> > On Sat, Dec 08, 2001 at 04:18:53PM +0100, Andreas Jaeger wrote:
> >> >        "	bltzal $0, here\n"
> >> >        "	nop\n"
> >> >        "here:	subu %0, $31, %0\n"
> >> 
> >> Subtract shared address of "here" from address of "here" at build time
> >> - and you know at which address byte 0 of the shared library is
> >>   loaded.
> >
> > Wait a second.  Does bltzal fill in $31 even on a not-taken branch? 
> > Because bltzal $0 should never be taken.  My handy MIPS reference and
> > SPIM seem to agree that it won't fill in $31.
> 
> I just checked the MIPS R4000 Microprocessor Manual, 2nd Ed. by Joe
> Heinrich and it mentions "Unconditanally, the address of the
> instruction after the delay slot is placed in the link register, $31".
> Therefore the code is correct.

OK, thanks.  Yet another thing that changed between my simulator and my
hardware :)

-- 
Daniel Jacobowitz                           Carnegie Mellon University
MontaVista Software                         Debian GNU/Linux Developer
