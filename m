Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.3/8.11.3) id f3IL3th21264
	for linux-mips-outgoing; Wed, 18 Apr 2001 14:03:55 -0700
Received: from nevyn.them.org (mail@NEVYN.RES.CMU.EDU [128.2.145.225])
	by oss.sgi.com (8.11.3/8.11.3) with ESMTP id f3IL3sM21259
	for <linux-mips@oss.sgi.com>; Wed, 18 Apr 2001 14:03:54 -0700
Received: from drow by nevyn.them.org with local (Exim 3.22 #1 (Debian))
	id 14pz7G-0007yn-00; Wed, 18 Apr 2001 17:03:58 -0400
Date: Wed, 18 Apr 2001 17:03:58 -0400
From: Daniel Jacobowitz <dan@debian.org>
To: Andreas Jaeger <aj@suse.de>
Cc: "Steven J. Hill" <sjhill@cotw.com>, linux-mips@oss.sgi.com
Subject: Re: Question on the binutils tradlittlemips patch
Message-ID: <20010418170358.B29531@nevyn.them.org>
References: <20010418141959.A24473@nevyn.them.org> <u8vgo23r4w.fsf@gromit.rhein-neckar.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.16i
In-Reply-To: <u8vgo23r4w.fsf@gromit.rhein-neckar.de>; from aj@suse.de on Wed, Apr 18, 2001 at 10:11:11PM +0200
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Wed, Apr 18, 2001 at 10:11:11PM +0200, Andreas Jaeger wrote:
> Daniel Jacobowitz <dan@debian.org> writes:
> 
> > I've been trying to make this patch work as part of a complete
> > toolchain, based on glibc.  In addition to a little snag (when building
> > glibc for big-endian mips you need an equivalent change in the target
> > format), I hit a serious shared library error - nothing linked
> 
> Do I understand you correctly that glibc needs a patch?  Please send
> it to me.

Yes, I think it does.  Do we care about being able to build with old
(including every released version before [I think] HJ's 2.10.91.0.5)
binutils on MIPS?  Having it both ways is pretty hard, but it could
probably be autoconfed.

> You might be - but it's quite difficult to fix in glibc.  If you get
> it working in glibc, send me a patch that works with old and new
> binaries - and I'll gladly review and commit it.

Well, this will need a comment from someone with a better understanding
of ELF than I, but my thought:

How harmful would it be, given that we've been assuming the hardcoded
base address of 0x5ffe0000, to assume that the base address is either
that or 0?  Just check if subtracting 0x5ffe0000 from the base address
of the first load would be an obvious error (i.e. if it would
overflow).

Could someone enlighten me on when the vaddr of the first load command
is not the same as MIPS_BASE_ADDRESS?  I could easily enough (since
we've already seen the PT_DYNAMIC entry at this point) read the
BASE_ADDRESS value out of the library, but that's a bit of a speed hit.

-- 
Daniel Jacobowitz                           Debian GNU/Linux Developer
Monta Vista Software                              Debian Security Team
