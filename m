Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 10 Dec 2002 20:32:09 +0100 (CET)
Received: from crack.them.org ([65.125.64.184]:34720 "EHLO crack.them.org")
	by linux-mips.org with ESMTP id <S8225193AbSLJTcI>;
	Tue, 10 Dec 2002 20:32:08 +0100
Received: from nevyn.them.org ([66.93.61.169] ident=mail)
	by crack.them.org with asmtp (Exim 3.12 #1 (Debian))
	id 18LrzC-0005D6-00; Tue, 10 Dec 2002 15:32:14 -0600
Received: from drow by nevyn.them.org with local (Exim 3.36 #1 (Debian))
	id 18Lq7V-0004Fd-00; Tue, 10 Dec 2002 14:32:41 -0500
Date: Tue, 10 Dec 2002 14:32:41 -0500
From: Daniel Jacobowitz <dan@debian.org>
To: nigel@mips.com
Cc: Carsten Langgaard <carstenl@mips.com>,
	Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org
Subject: Re: GDB patch
Message-ID: <20021210193241.GA15908@nevyn.them.org>
References: <15862.15924.283825.28108@hendon.algor.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <15862.15924.283825.28108@hendon.algor.co.uk>
User-Agent: Mutt/1.5.1i
Return-Path: <drow@false.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 845
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dan@debian.org
Precedence: bulk
X-list: linux-mips

On Tue, Dec 10, 2002 at 07:19:16PM +0000, Nigel Stephens wrote:
> > On Tue, Dec 10, 2002 at 01:07:31PM +0100, Carsten Langgaard wrote:
> > 
> > > I've attached a patch for gdb-stub.c to make it work better with the
> > > sde-gdb.
> > > These changes should be backwards compatible with a standard gdb, so it
> > > shouldn't break anything.
> > > Ralf, could you please apply it.
> > 
> > 
> > Strongly object.  While I didn't check the implementation, it's nice to
> > see 'X' implemented.  And P.  But what the heck is this?
> > 
> > 
> > > @@ -816,13 +839,64 @@
> > >  		case 'k' :
> > >  			break;		/* do nothing */
> > >  
> > > +		case 'R':
> > > +			/* RNN[:SS],	Set the value of CPU register NN (size SS) */
> > > +			/* FALL THROUGH */
> > 
> > 
> > > -		/*
> > > -		 * Reset the whole machine (FIXME: system dependent)
> > > -		 */
> > >  		case 'r':
> > > -			break;
> > > +			/* rNN[:SS]	Return the value of CPU register NN (size SS) */
> > 
> > 
> > 
> > We're not making up a protocol here, we're implementing one.  R and r
> > don't have anything to do with setting registers.
> 
> Hi Dan
> 
> Actually Carsten *is* trying to implement a protocol, it's just that
> it's an extension to the gdb remote debug protocol, as used in our
> SDE-MIPS toolchain (viz sde-gdb).  Algorithmics (now MIPS Technologies
> UK), always extended the gdb remote debug protocol to support reading
> and writing of single registers, and to support variable register
> sizes (to allow a 64-bit debug stub to inter-work with gdb debugging a
> 32-bit application).

My point is that we implement the GDB protocol, for use with GDB -
implementing random extensions to it is not a good idea.  I would
strongly prefer these extensions be discussed on the GDB list before
you try adding them to the CVS tree.  Also, I bet Andrew has a
different idea of how the 64/32 thing ought to work than you do.  He's
the remote protocol maintainer.

These things should be planned on the GDB side before making yet more
stubs use them.

> When we first implemented these extensions we used the 'R' command to
> write a single register, and 'r' to read one (they weren't then used
> by gdb). Since then the remote protocol has gained the 'P' command to

'R' was added in 1995 according to my records.  Really?

> write a single register, so we no longer use 'R' - and it would be
> dangerous to do so since it can restart the target (so you can get rid
> of the special 'R' case, Carsten).
> 
> But the standard gdb remote protocol still doesn't have the ability to
> read a single register, so I believe that 'r' (or something like it)
> is a useful addition, which speeds up the remote protocol
> significantly when running over a serial line. And it won't break the
> kernel to add support for this extension.

The protocol does, actually.  GDB doesn't _implement_ it, but the
extension is documented in the manual ('p') and I wouldn't be surprised
if Red Hat actually had an implementation somewhere.  I recommend the
documentation of the protocol, on the GDB web site.

Also note that `R' is extended restart process; the manual lists `r' as
"restart entire target system".  I don't know when that was used but
it's reason enough to stay away from using that letter to read a
register.

-- 
Daniel Jacobowitz
MontaVista Software                         Debian GNU/Linux Developer
