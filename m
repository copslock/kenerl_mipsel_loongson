Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 15 May 2003 04:55:17 +0100 (BST)
Received: from crack.them.org ([IPv6:::ffff:146.82.138.56]:15264 "EHLO
	crack.them.org") by linux-mips.org with ESMTP id <S8225206AbTEODzP>;
	Thu, 15 May 2003 04:55:15 +0100
Received: from nevyn.them.org ([66.93.61.169] ident=mail)
	by crack.them.org with asmtp (Exim 3.12 #1 (Debian))
	id 19G9qD-0001nL-00; Wed, 14 May 2003 22:55:37 -0500
Received: from drow by nevyn.them.org with local (Exim 3.36 #1 (Debian))
	id 19G9pj-0001DO-00; Wed, 14 May 2003 23:55:07 -0400
Date: Wed, 14 May 2003 23:55:07 -0400
From: Daniel Jacobowitz <dan@debian.org>
To: Thiemo Seufer <ica2_ts@csv.ica.uni-stuttgart.de>
Cc: linux-mips@linux-mips.org, Guido Guenther <agx@sigxcpu.org>
Subject: Re: -mcpu vs. binutils 2.13.90.0.18
Message-ID: <20030515035507.GA4654@nevyn.them.org>
References: <20030318154155.GF2613@bogon.ms20.nix> <20030318160303.GN13122@rembrandt.csv.ica.uni-stuttgart.de> <20030318174241.GG2613@bogon.ms20.nix> <20030318190841.GO13122@rembrandt.csv.ica.uni-stuttgart.de> <20030318232454.GA19990@bogon.ms20.nix> <20030319001652.GB19189@rembrandt.csv.ica.uni-stuttgart.de> <20030513113316.GU3889@bogon.ms20.nix> <20030513192735.GA16497@rembrandt.csv.ica.uni-stuttgart.de> <20030513193625.GA14066@nevyn.them.org> <20030513195928.GB16497@rembrandt.csv.ica.uni-stuttgart.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030513195928.GB16497@rembrandt.csv.ica.uni-stuttgart.de>
User-Agent: Mutt/1.5.1i
Return-Path: <drow@false.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 2391
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dan@debian.org
Precedence: bulk
X-list: linux-mips

On Tue, May 13, 2003 at 09:59:28PM +0200, Thiemo Seufer wrote:
> Daniel Jacobowitz wrote:
> [snip]
> > > > Just for completeness: I had to use:
> > > > 	GCCFLAGS += -mabi=32 -march=r4600 -mtune=r4600 -Wa,--trap
> > > > to make gcc-3.3 happy (note the 32 instead of o32).
> > > 
> > > Yes, IIRC 64 vs. n64 has the same problem.
> > 
> > That's not quite the same: 64 is o64, n64 is n64.
> 
> I don't think so (There's -mabi=o64).
> Otherwise I would have built all my NewABI 64bit Executables as
> o64 without noticing ever. :-)

You are, of course, right :)

> > GCC's never called the 32-bit ABI "o32".
> 
> True, but it might be clearer if it did.

I suppose... too late now.

-- 
Daniel Jacobowitz
MontaVista Software                         Debian GNU/Linux Developer
