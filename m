Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 06 Dec 2002 18:24:58 +0100 (MET)
Received: from iris1.csv.ica.uni-stuttgart.de ([IPv6:::ffff:129.69.118.2]:1041
	"EHLO iris1.csv.ica.uni-stuttgart.de") by ralf.linux-mips.org
	with ESMTP id <S869794AbSLFRYs>; Fri, 6 Dec 2002 18:24:48 +0100
Received: from rembrandt.csv.ica.uni-stuttgart.de ([129.69.118.42])
	by iris1.csv.ica.uni-stuttgart.de with esmtp (Exim 3.36 #2)
	id 18KMDP-0006pp-00; Fri, 06 Dec 2002 18:24:39 +0100
Received: from ica2_ts by rembrandt.csv.ica.uni-stuttgart.de with local (Exim 3.35 #1 (Debian))
	id 18KMDO-0003A4-00; Fri, 06 Dec 2002 18:24:38 +0100
Date: Fri, 6 Dec 2002 18:24:38 +0100
To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
Cc: Carsten Langgaard <carstenl@mips.com>,
	Ralf Baechle <ralf@linux-mips.org>,
	"Kevin D. Kissell" <kevink@mips.com>, linux-mips@linux-mips.org
Subject: Re: Latest sources from CVS.
Message-ID: <20021206172438.GJ23743@rembrandt.csv.ica.uni-stuttgart.de>
References: <20021206164558.GH23743@rembrandt.csv.ica.uni-stuttgart.de> <Pine.GSO.3.96.1021206175502.26674R-100000@delta.ds2.pg.gda.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.GSO.3.96.1021206175502.26674R-100000@delta.ds2.pg.gda.pl>
User-Agent: Mutt/1.4i
From: Thiemo Seufer <ica2_ts@csv.ica.uni-stuttgart.de>
Return-Path: <ica2_ts@csv.ica.uni-stuttgart.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 809
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ica2_ts@csv.ica.uni-stuttgart.de
Precedence: bulk
X-list: linux-mips

Maciej W. Rozycki wrote:
> On Fri, 6 Dec 2002, Thiemo Seufer wrote:
> 
> > >  Which wouldn't work either as it implies 32-bit pointers, while gcc still
> > > emits 64-bit assembly.
> > 
> > Which should be enough for smaller address spaces.
> 
>  But gas will complain of the same address truncation as for o32. 

Maybe I wasn't clear about it, I meant kernels with 32 bit address
space but 64 bit register width, allowing for userland N32 ABI.

E.g. the old DECstations with R4k CPU and limited memory would fit
in this scheme. :-)

> > > If we want to preserve the setup cleanly, we
> > > probably need yet another ABI model in gcc (especially in the face of the
> > > coming changes to get rid of assembly macros), with sign-extended 32-bit
> > > pointers for accessing program segments and 64-bit ones for the remaining
> > > addresses.
> > 
> > Do you think this is worth the hassle? N64 offers better flexibility in
> > the large memory case at some performance cost, and it's conceptionally
> > cleaner.
> 
>  Remember we are writing of the kernel -- we don't know what userland is
> going to bring us

I don't understand this. The kernel _defines_ what the userland is allowed
to do.

> -- a user pointer need not fit in 32 bits.

It needs to, if the kernel doesn't want to support 64 bit address space. :-)


Thiemo
