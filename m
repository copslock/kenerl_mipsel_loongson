Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id g1Q6Aor02306
	for linux-mips-outgoing; Mon, 25 Feb 2002 22:10:50 -0800
Received: from nevyn.them.org (mail@NEVYN.RES.CMU.EDU [128.2.145.6])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id g1Q6AY902301;
	Mon, 25 Feb 2002 22:10:34 -0800
Received: from drow by nevyn.them.org with local (Exim 3.34 #1 (Debian))
	id 16fZsW-0000sq-00; Tue, 26 Feb 2002 00:10:16 -0500
Date: Tue, 26 Feb 2002 00:10:16 -0500
From: Daniel Jacobowitz <dan@debian.org>
To: Ralf Baechle <ralf@oss.sgi.com>
Cc: Jay Carlson <nop@nop.com>, mad-dev@lists.mars.org,
   Carlo Agostini <carlo.agostini@yacme.com>, linux-mips@oss.sgi.com
Subject: Re: Problems compiling . soft-float
Message-ID: <20020226001016.A3303@nevyn.them.org>
References: <20020225132559.A3500@dea.linux-mips.net> <F91731D8-2A73-11D6-AB38-0030658AB11E@nop.com> <20020226060236.A5293@dea.linux-mips.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020226060236.A5293@dea.linux-mips.net>
User-Agent: Mutt/1.3.23i
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Tue, Feb 26, 2002 at 06:02:37AM +0100, Ralf Baechle wrote:
> On Mon, Feb 25, 2002 at 11:47:44PM -0500, Jay Carlson wrote:
> 
> > Ralf is right that the kernel emulator is the supported route.  But if 
> > you're willing to go to the trouble of building everything from scratch, 
> > this does work.
> 
> It's really a major pain.  Softfp isn't defined in the ABI which assumes
> an FPU is available.  As the result there is no provision for mixing
> softfp and fp-less code.
> 
> Something for the binutils to-do list - ld should make mixing hard-fp
> and soft-fp binaries impossible.

Or we could see if it is possible to define the ABIs in such a way that
they can call each other... I don't immediately see a problem.  The
only code that will clobber FP registers is FP code.

-- 
Daniel Jacobowitz                           Carnegie Mellon University
MontaVista Software                         Debian GNU/Linux Developer
