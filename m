Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 11 Dec 2002 17:56:10 +0000 (GMT)
Received: from crack.them.org ([65.125.64.184]:64167 "EHLO crack.them.org")
	by linux-mips.org with ESMTP id <S8225241AbSLKR4J>;
	Wed, 11 Dec 2002 17:56:09 +0000
Received: from nevyn.them.org ([66.93.61.169] ident=mail)
	by crack.them.org with asmtp (Exim 3.12 #1 (Debian))
	id 18MCxx-0007FF-00; Wed, 11 Dec 2002 13:56:21 -0600
Received: from drow by nevyn.them.org with local (Exim 3.36 #1 (Debian))
	id 18MB6I-0003rb-00; Wed, 11 Dec 2002 12:56:50 -0500
Date: Wed, 11 Dec 2002 12:56:50 -0500
From: Daniel Jacobowitz <dan@debian.org>
To: Nigel Stephens <nigel@mips.com>
Cc: Carsten Langgaard <carstenl@mips.com>,
	Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org
Subject: Re: GDB patch
Message-ID: <20021211175650.GA14768@nevyn.them.org>
References: <15862.15924.283825.28108@hendon.algor.co.uk> <20021210193241.GA15908@nevyn.them.org> <3DF6514E.8040100@mips.com> <20021211165218.GA11767@nevyn.them.org> <3DF774DC.3010607@mips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3DF774DC.3010607@mips.com>
User-Agent: Mutt/1.5.1i
Return-Path: <drow@false.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 866
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dan@debian.org
Precedence: bulk
X-list: linux-mips

On Wed, Dec 11, 2002 at 05:24:44PM +0000, Nigel Stephens wrote:
> Daniel Jacobowitz wrote:
> 
> >>Certainly 'p' is the logical inverse of 'P', so we'll change our gdb 
> >>remote stub to use that. So how about accepting Carsten's change, with 
> >>the 'R' case removed, and 'r' changed to 'p'?
> >>   
> >>
> >
> >Can't do it.  I strongly suspect that it will render the stub unusable
> >with current versions of FSF GDB.  Your tools add an explicit size to
> >the packet and the community tools do not; so when they probe for and
> >discover the P packet, they will probably try to use it and get
> >confused.  That's why I'd like to discuss this on the GDB list first.
> > 
> >
> 
> I don't see why it wouldn't work:
> 
> 1) Existing FSF gdb doesn't use 'p' yet anyway - it will continue to 
> work as before, using the 'g' request to fetch all the registers.
> 
> 2) If and when gdb does use 'p', then there's still no problem - if the 
> kernel gdb stub sees a 'p' request without the ":SIZE" extension, it can 
> just treat it like the FSF protocol and use the "default" register size.

3) Existing FSF gdb does use 'P' when it is available.  This does not
work with Carsten's patch.

-- 
Daniel Jacobowitz
MontaVista Software                         Debian GNU/Linux Developer
