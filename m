Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 07 Dec 2004 12:57:07 +0000 (GMT)
Received: from iris1.csv.ica.uni-stuttgart.de ([IPv6:::ffff:129.69.118.2]:37942
	"EHLO iris1.csv.ica.uni-stuttgart.de") by linux-mips.org with ESMTP
	id <S8225237AbULGM5C>; Tue, 7 Dec 2004 12:57:02 +0000
Received: from rembrandt.csv.ica.uni-stuttgart.de ([129.69.118.42])
	by iris1.csv.ica.uni-stuttgart.de with esmtp
	id 1Cbeto-00018z-00; Tue, 07 Dec 2004 13:57:00 +0100
Received: from ica2_ts by rembrandt.csv.ica.uni-stuttgart.de with local (Exim 3.35 #1 (Debian))
	id 1Cbetn-0002mP-00; Tue, 07 Dec 2004 13:56:59 +0100
Date: Tue, 7 Dec 2004 13:56:59 +0100
To: Richard Sandiford <rsandifo@redhat.com>
Cc: "Maciej W. Rozycki" <macro@linux-mips.org>,
	Ralf Baechle <ralf@linux-mips.org>,
	Dominic Sweetman <dom@mips.com>, linux-mips@linux-mips.org,
	Nigel Stephens <nigel@mips.com>, David Ung <davidu@mips.com>
Subject: Re: [PATCH] Improve atomic.h implementation robustness
Message-ID: <20041207125659.GP8714@rembrandt.csv.ica.uni-stuttgart.de>
References: <20041201070014.GG3225@rembrandt.csv.ica.uni-stuttgart.de> <16813.39660.948092.328493@doms-laptop.algor.co.uk> <20041201123336.GA5612@linux-mips.org> <Pine.LNX.4.58L.0412012136480.13579@blysk.ds.pg.gda.pl> <wvn653epbi1.fsf@talisman.cambridge.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <wvn653epbi1.fsf@talisman.cambridge.redhat.com>
User-Agent: Mutt/1.5.6i
From: Thiemo Seufer <ica2_ts@csv.ica.uni-stuttgart.de>
Return-Path: <ica2_ts@csv.ica.uni-stuttgart.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 6582
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ica2_ts@csv.ica.uni-stuttgart.de
Precedence: bulk
X-list: linux-mips

Richard Sandiford wrote:
[snip]
> >  Only for old compilers.  For current (>= 3.4) ones you can use the "R"  
> > constraint and get exactly what you need.
> 
> Right.  IMO, this is exactly the right fix.  It should be backward
> compatible with old toolchains too.
> 
> FYI, the 'R' constraint has been kept around specifically for inline asms.
> gcc itself no longer uses it.

I tried to use "R" in atomic.h but this failed in some (but not all)
cases with

include/asm/atomic.h:64: error: inconsistent operand constraints in an asm'

where the argument happens to be a member of a global struct.
Simple testcases work, however, as well as PIC code.

[snip]
> > I discussed this with Richard Sandiford a while ago, and the conclusion
> > was to implement an explicit --msym32 option for both gcc and gas to
> > improve register scheduling and get rid of the gas hack. So far, nobody
> > came around to actually do the work for it.
> 
> True.  FWIW, it's trivial to add this option to gcc.  As far as I remember,
> the stumbling block was whether we should mark the objects in some way,
> and whether the linker ought to check for overflow.

Both might be nice but isn't exactly reqired. The use of --msym32 will
be limited to ELF64 non-PIC code, which is only used in kernels or
other stand-alone programs with limited exposure to other binaries with
incompatible code models.


Thiemo
