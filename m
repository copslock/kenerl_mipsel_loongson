Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 25 Jan 2004 17:04:09 +0000 (GMT)
Received: from nevyn.them.org ([IPv6:::ffff:66.93.172.17]:57017 "EHLO
	nevyn.them.org") by linux-mips.org with ESMTP id <S8225237AbUAYREI>;
	Sun, 25 Jan 2004 17:04:08 +0000
Received: from drow by nevyn.them.org with local (Exim 4.30 #1 (Debian))
	id 1Aknfr-0002r9-Gt; Sun, 25 Jan 2004 12:03:51 -0500
Date: Sun, 25 Jan 2004 12:03:51 -0500
From: Daniel Jacobowitz <drow@mvista.com>
To: Andi Kleen <ak@suse.de>
Cc: Jan Hubicka <jh@suse.cz>, echristo@redhat.com, hubicka@ucw.cz,
	eager@mvista.com, gcc@gcc.gnu.org, linux-mips@linux-mips.org
Subject: Re: GCC-3.4 reorders asm() with -O2
Message-ID: <20040125170351.GA10938@nevyn.them.org>
Mail-Followup-To: Andi Kleen <ak@suse.de>, Jan Hubicka <jh@suse.cz>,
	echristo@redhat.com, hubicka@ucw.cz, eager@mvista.com,
	gcc@gcc.gnu.org, linux-mips@linux-mips.org
References: <4011C72C.613E25@mvista.com> <20040124011955.GA12040@nevyn.them.org> <20040124012303.GJ32288@atrey.karlin.mff.cuni.cz> <20040124050849.GB14951@nevyn.them.org> <1075009125.3649.0.camel@dzur.sfbay.redhat.com> <20040125100514.GA8810@kam.mff.cuni.cz> <20040125164758.79373419.ak@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040125164758.79373419.ak@suse.de>
User-Agent: Mutt/1.5.1i
Return-Path: <drow@crack.them.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 4129
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: drow@mvista.com
Precedence: bulk
X-list: linux-mips

On Sun, Jan 25, 2004 at 04:47:58PM +0100, Andi Kleen wrote:
> On Sun, 25 Jan 2004 11:05:14 +0100
> Jan Hubicka <jh@suse.cz> wrote:
> 
> > > 
> > > > 
> > > > For x86 it does.  For MIPS I'm quite sure it doesn't - well, it will
> > > > compile, but not work.
> > > 
> > > but, unlike x86 this is hardly a surprise on a daily basis.
> > 
> > I think Andi has sollution that shall fix the other architectures in the
> > kernel too.
> 
> If it's the same problem that broke i386: Current bitkeeper should sort the exception tables
> and fix it. It's actually done with a patch from Paul Mackerras. Of course it could be a different
> issue too that's breaking MIPS.

It is.  Ralf already knows about the problem, I think - we leave
markers outside of functions which define an entry point, save some
additional registers to the stack, and try to fall through to the
following function.  If the function gets emitted elsewhere, obviously,
we've lost :)

[This is save_static_function...]

-- 
Daniel Jacobowitz
MontaVista Software                         Debian GNU/Linux Developer
