Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 13 May 2003 20:36:53 +0100 (BST)
Received: from crack.them.org ([IPv6:::ffff:146.82.138.56]:61843 "EHLO
	crack.them.org") by linux-mips.org with ESMTP id <S8225221AbTEMTgv>;
	Tue, 13 May 2003 20:36:51 +0100
Received: from nevyn.them.org ([66.93.61.169] ident=mail)
	by crack.them.org with asmtp (Exim 3.12 #1 (Debian))
	id 19Ffa3-00070H-00; Tue, 13 May 2003 14:36:55 -0500
Received: from drow by nevyn.them.org with local (Exim 3.36 #1 (Debian))
	id 19FfZZ-0003fU-00; Tue, 13 May 2003 15:36:25 -0400
Date: Tue, 13 May 2003 15:36:25 -0400
From: Daniel Jacobowitz <dan@debian.org>
To: Thiemo Seufer <ica2_ts@csv.ica.uni-stuttgart.de>
Cc: linux-mips@linux-mips.org, Guido Guenther <agx@sigxcpu.org>
Subject: Re: -mcpu vs. binutils 2.13.90.0.18
Message-ID: <20030513193625.GA14066@nevyn.them.org>
References: <20030318154155.GF2613@bogon.ms20.nix> <20030318160303.GN13122@rembrandt.csv.ica.uni-stuttgart.de> <20030318174241.GG2613@bogon.ms20.nix> <20030318190841.GO13122@rembrandt.csv.ica.uni-stuttgart.de> <20030318232454.GA19990@bogon.ms20.nix> <20030319001652.GB19189@rembrandt.csv.ica.uni-stuttgart.de> <20030513113316.GU3889@bogon.ms20.nix> <20030513192735.GA16497@rembrandt.csv.ica.uni-stuttgart.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030513192735.GA16497@rembrandt.csv.ica.uni-stuttgart.de>
User-Agent: Mutt/1.5.1i
Return-Path: <drow@false.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 2362
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dan@debian.org
Precedence: bulk
X-list: linux-mips

On Tue, May 13, 2003 at 09:27:35PM +0200, Thiemo Seufer wrote:
> Guido Guenther wrote:
> [snip]
> > > > So to build kernels for say IP22 R5k I'd change the current
> > > > 	GCCFLAGS += -mcpu=r5000 -mips2 -Wa,--trap
> > > > to 
> > > > 	GCCFLAGS += -mabi=o32 -march=R5000 -mtune=R5000 -Wa,--trap
> > > > where as for R4X00 I use
> > > > 	GCCFLAGS += -mabi=o32 -march=R4600 -mtune=R4600 -Wa,--trap
> > > > Correct?
> > > 
> > > Yes, this should work. You can leave the -mtune out, since it defaults
> > > to the value of -march anyway.
> > Just for completeness: I had to use:
> > 	GCCFLAGS += -mabi=32 -march=r4600 -mtune=r4600 -Wa,--trap
> > to make gcc-3.3 happy (note the 32 instead of o32).
> 
> Yes, IIRC 64 vs. n64 has the same problem.

That's not quite the same: 64 is o64, n64 is n64.  GCC's never called
the 32-bit ABI "o32".

-- 
Daniel Jacobowitz
MontaVista Software                         Debian GNU/Linux Developer
