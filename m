Received:  by oss.sgi.com id <S553795AbRCNTVW>;
	Wed, 14 Mar 2001 11:21:22 -0800
Received: from u-203-18.karlsruhe.ipdial.viaginterkom.de ([62.180.18.203]:48892
        "EHLO dea.waldorf-gmbh.de") by oss.sgi.com with ESMTP
	id <S553779AbRCNTVH>; Wed, 14 Mar 2001 11:21:07 -0800
Received: (from ralf@localhost)
	by dea.waldorf-gmbh.de (8.11.1/8.11.1) id f2EJKwL02386;
	Wed, 14 Mar 2001 20:20:58 +0100
Date:   Wed, 14 Mar 2001 20:20:58 +0100
From:   Ralf Baechle <ralf@oss.sgi.com>
To:     Daniel Jacobowitz <dan@debian.org>
Cc:     linux-mips@oss.sgi.com
Subject: Re: Can't build a CONFIG_CPU_NEVADA kernel
Message-ID: <20010314202058.B1911@bacchus.dhis.org>
References: <20010314084633.A25674@nevyn.them.org> <20010314195919.A1911@bacchus.dhis.org> <20010314140529.A29525@nevyn.them.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20010314140529.A29525@nevyn.them.org>; from dan@debian.org on Wed, Mar 14, 2001 at 02:05:29PM -0500
X-Accept-Language: de,en,fr
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

On Wed, Mar 14, 2001 at 02:05:29PM -0500, Daniel Jacobowitz wrote:

> OK, so that needs to change.  That's pretty easy to do, at least in our
> local toolchains.

If it's only in your local toolchains, it's lost.  Send your changes to
the FSF!

> > > I worked back in time in gcc, binutils, and kernel sources and I
> > > couldn't figure out what's changed - I'm sure this worked at some
> > > point.
> > 
> > You'll have to go back far in time.  I introduced the use of -mmad for
> > Nevada-class CPUs in late summor '97.
> > 
> > As a second bug which makes this one even more annoying something like
> > 
> > 	.set	mips3
> > 	sdc1    $f2, (a0)
> > 	.set	mips0
> > 
> > also doesn't work - the assembler will still throw an "opcode not supported
> > on this processor" message.  After all MIPS III means double precission fp.
> > And passing additional assembler options with -Wa,foo doesn't help either
> > in this case so without the necessary gcc / assembler changes this
> > optimization is lost for now.
> 
> Does -mmad make a sufficient difference on these processors to bother
> fixing it?

Not for the kernel but it's a sufficiently important optimization for some
specialised applications (signal processing type etc.) that it should be
fixed.

> If it does, I can probably whip up a -mmad patch to binutils to allow
> those opcodes - or I could introduce -mnevada, or whatever the
> appropriate term would be, to mean "r8000 with the mad* extensions". 
> In fact, that would probably be easiest, and sounds like the most
> correct.

Don't think of the r8000; the kernel only uses the -mcpu=r8000 option
because the Nevada CPUs have _somewhat_ similar scheduling properties
to the R8000.  This of it as an independant ISA expension which can
be used with an arbitrary MIPS processor - even a R3000 processor.

  Ralf
