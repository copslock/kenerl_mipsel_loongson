Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id g1KG6Hf18263
	for linux-mips-outgoing; Wed, 20 Feb 2002 08:06:17 -0800
Received: from dea.linux-mips.net (a1as06-p249.stg.tli.de [195.252.187.249])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id g1KG6C918260
	for <linux-mips@oss.sgi.com>; Wed, 20 Feb 2002 08:06:12 -0800
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.11.6/8.11.1) id g1KF5D817400;
	Wed, 20 Feb 2002 16:05:13 +0100
Date: Wed, 20 Feb 2002 16:05:13 +0100
From: Ralf Baechle <ralf@oss.sgi.com>
To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
Cc: Jun Sun <jsun@mvista.com>, "Kevin D. Kissell" <kevink@mips.com>,
   linux-mips@oss.sgi.com
Subject: Re: FPU emulator unsafe for SMP?
Message-ID: <20020220160513.A17227@dea.linux-mips.net>
References: <20020220140917.C15588@dea.linux-mips.net> <Pine.GSO.3.96.1020220153608.5781A-100000@delta.ds2.pg.gda.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.GSO.3.96.1020220153608.5781A-100000@delta.ds2.pg.gda.pl>; from macro@ds2.pg.gda.pl on Wed, Feb 20, 2002 at 03:46:32PM +0100
X-Accept-Language: de,en,fr
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Wed, Feb 20, 2002 at 03:46:32PM +0100, Maciej W. Rozycki wrote:

> > The context register is actually intended to be used for indexing a flat
> > 4mb array of pagetables on a 32-bit processor.  It's a bit ill-defined
> > on R4000-class processors as it assumes a size of 8 bytes per pte, so
> > cannot be used in the Linux/MIPS kernel without shifting bits around.
> 
>  Ill???  I think someone was just longsighted enough not to limit PTEs to
> 38-bit physical addresses.  A shift costs a single cycle if we want to
> save memory. 

The idea of the register was to directly generate the address of a PTE.
An extra instruction in TLB exception handlers isn't only visible in
performance, it also means introducing constraints on the address itself -
an arithmetic shift by one bit for 4 byte PTEs will result in the two
high bits of the address being identical, an arithmetic shift will make
the high bit a null etc.  Just on 32-bit kernels on 64-bit hw you're
lucky, you have a bit 32 in c0_context which will be shifted into bit 31.

Messy?

  Ralf
