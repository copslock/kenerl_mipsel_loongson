Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 21 Jan 2004 15:22:53 +0000 (GMT)
Received: from nevyn.them.org ([IPv6:::ffff:66.93.172.17]:9111 "EHLO
	nevyn.them.org") by linux-mips.org with ESMTP id <S8225320AbUAUPWx>;
	Wed, 21 Jan 2004 15:22:53 +0000
Received: from drow by nevyn.them.org with local (Exim 4.30 #1 (Debian))
	id 1AjKBr-0000Ll-BV; Wed, 21 Jan 2004 10:22:47 -0500
Date: Wed, 21 Jan 2004 10:22:47 -0500
From: Daniel Jacobowitz <dan@debian.org>
To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
Cc: Ralf Baechle <ralf@linux-mips.org>,
	Pavel Kiryukhin <savl@dev.rtsoft.ru>, linux-mips@linux-mips.org
Subject: Re: __MIPSEL__ in sys32_rt_sigtimedwait
Message-ID: <20040121152247.GA1308@nevyn.them.org>
References: <400D6877.1000105@dev.rtsoft.ru> <20040120183157.GB5495@linux-mips.org> <20040120193918.GA2108@nevyn.them.org> <Pine.LNX.4.55.0401211414040.11137@jurand.ds.pg.gda.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.55.0401211414040.11137@jurand.ds.pg.gda.pl>
User-Agent: Mutt/1.5.1i
Return-Path: <drow@crack.them.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 4080
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dan@debian.org
Precedence: bulk
X-list: linux-mips

On Wed, Jan 21, 2004 at 02:47:17PM +0100, Maciej W. Rozycki wrote:
> On Tue, 20 Jan 2004, Daniel Jacobowitz wrote:
> 
> > No, I'm pretty sure Pavel's right.
> > 
> > -#ifdef __MIPSEB__
> >     case 1: these.sig[0] = these32.sig[0] | (((long)these32.sig[1]) << 32);
> > -#endif
> > -#ifdef __MIPSEL__
> > -    case 1: these.sig[0] = these32.sig[1] | (((long)these32.sig[0]) << 32);
> > -#endif
> > 
> > Consider a 64-bit sigset.  32-bit userland, 64-bit kernel.  Here's a
> > userland sigset with signal 33 set, only, on a little endian target.
> > Word 1, least significant bit, right?
> 
>  Right, but...
> 
> > byte address in memory
> > 	1	2	3	4	5	6	7	8
> > val	0	0	0	0	0	0	0	1
> 
> ... this is incorrect -- it would be right for big-endian; word #1, bit #1
> for little-endian is:
> 
> byte address in memory
> 	1	2	3	4	5	6	7	8
> val	0	0	0	0	1	0	0	0
> 
> 
> > Obviously, as a 64-bit integer the sigset looks different.  There it's
> > supposed to be 1 << (33 - 1).
> > val	0	0	0	1	0	0	0	0
> 
>  Again, for little-endian it should actually be:
> 
> val	0	0	0	0	1	0	0	0
> 
> i.e. the whole operation is actually a no-op, except that the 64-bit
> vector is assured to be properly aligned for doubleword accesses.

Re-reading what I wrote, the above was actually supposed to be a
big-endian example.  D'oh!  If you pretend I wrote "big endian" up at
the top, then it makes sense.

>  As a side note -- that's the reason certain C code portability problems
> related to the width of the machine word only get actually discovered when
> problematic software is run on a big-endian processor.  I've been hit by
> this property once -- I was porting a 16-bit program and it appeared to
> run just fine on both a 32-bit (i386) and a 64-bit (Alpha) little-endian
> CPU, but when run on a 32-bit big-endian one (SPARC) I discovered a few
> more bits to be cleaned up.
> 
> > So the correct algorithm to convert a userspace sigset to a kernel
> > sigset is to shift the second word left 32 bits, and leave the first
> > word right aligned, and or them together.  Which is what using the
> > __MIPSEB__ case does.
> 
>  But this conclusion is of course right.
> 
>   Maciej
> 
> -- 
> +  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
> +--------------------------------------------------------------+
> +        e-mail: macro@ds2.pg.gda.pl, PGP key available        +
> 

-- 
Daniel Jacobowitz
MontaVista Software                         Debian GNU/Linux Developer
