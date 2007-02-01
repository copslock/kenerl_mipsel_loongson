Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 01 Feb 2007 13:21:01 +0000 (GMT)
Received: from pollux.ds.pg.gda.pl ([153.19.208.7]:11791 "EHLO
	pollux.ds.pg.gda.pl") by ftp.linux-mips.org with ESMTP
	id S20038926AbXBANU4 (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 1 Feb 2007 13:20:56 +0000
Received: from localhost (localhost [127.0.0.1])
	by pollux.ds.pg.gda.pl (Postfix) with ESMTP id 4575CE1CB9;
	Thu,  1 Feb 2007 14:20:13 +0100 (CET)
X-Virus-Scanned: by amavisd-new at pollux.ds.pg.gda.pl
Received: from pollux.ds.pg.gda.pl ([127.0.0.1])
	by localhost (pollux.ds.pg.gda.pl [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id rdqI+-4Y3Ser; Thu,  1 Feb 2007 14:20:12 +0100 (CET)
Received: from piorun.ds.pg.gda.pl (piorun.ds.pg.gda.pl [153.19.208.8])
	by pollux.ds.pg.gda.pl (Postfix) with ESMTP id C61C5E1C92;
	Thu,  1 Feb 2007 14:20:12 +0100 (CET)
Received: from blysk.ds.pg.gda.pl (macro@blysk.ds.pg.gda.pl [153.19.208.6])
	by piorun.ds.pg.gda.pl (8.13.8/8.13.8) with ESMTP id l11DKIYq001453;
	Thu, 1 Feb 2007 14:20:19 +0100
Date:	Thu, 1 Feb 2007 13:20:15 +0000 (GMT)
From:	"Maciej W. Rozycki" <macro@linux-mips.org>
To:	Franck Bui-Huu <vagabon.xyz@gmail.com>
cc:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>, dan@debian.org,
	linux-mips@linux-mips.org, ralf@linux-mips.org
Subject: Re: RFC: Sentosa boot fix
In-Reply-To: <cda58cb80702010151x62e3b92ap18c63110f7fd4f0c@mail.gmail.com>
Message-ID: <Pine.LNX.4.64N.0702011233240.7161@blysk.ds.pg.gda.pl>
References: <cda58cb80701290806p5d68ba5ck5e3e3b2b3490126f@mail.gmail.com> 
 <20070129161450.GA3384@nevyn.them.org>  <Pine.LNX.4.64N.0701291833480.26916@blysk.ds.pg.gda.pl>
  <20070130.234537.126574565.anemo@mba.ocn.ne.jp> 
 <Pine.LNX.4.64N.0701301713350.9231@blysk.ds.pg.gda.pl>
 <cda58cb80702010151x62e3b92ap18c63110f7fd4f0c@mail.gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Virus-Scanned: ClamAV 0.88.7/2510/Thu Feb  1 10:12:06 2007 on piorun.ds.pg.gda.pl
X-Virus-Status:	Clean
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 13877
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Thu, 1 Feb 2007, Franck Bui-Huu wrote:

> > Checking for code correctness and validation of the toolchain (Linux is
> > one of the few non-PIC users of (n)64) without having to chase hardware
> > that would support running from XPHYS without serious pain (the firmware
> > being the usual offender).
> 
> This use case was unknown by the time we introduced __pa_page_offset().

 Well, I am afraid it was known well before.  I introduced it first to 2.4 
a while ago and I forward-ported the patch immediately to 2.6.  Both 
changes went in on Oct 20th, 2004.  The help text for the option has not 
changed since.  And even 2.6.18 that I'm still using does not have this 
__pa_page_offset() macro!  I did build various kernel versions with 
BUILD_ELF64 set for the DECstation (which links at 0xffffffff80040000).

> Basically this macro assumes that if BUILD_ELF64 is set the load
> address is in XKPHYS. This allows to simplify __pa_page_offset()
> definition for this case.

 Wrong assumption.  And nowhere guaranteed either.

> However if BUILD_ELF64 is not set then the macro deals with both
> CKSEG0 and XKPHYS virtual addresses.

 Indeed.

> > That said, I have not checked the every single use of __pa_page_offset(),
> > but the sole existence of this condition raises a question about whether
> > we are sure __pa_page_offset() is going to be only used on virtual
> > addresses in the same segment the kernel is linked to.
> 
> Well it all depends if we consider the case with BUILD_ELF64 set and a
> load address in CKSEG0 a useful case. If so, then we can remove "&&
> !defined(CONFIG_BUILD_ELF64)"
> from __pa_page_offset(). It shouldn't hurt the case where BUILD_ELF64
> is not set and Atsushi seems to agree.

 It hurts performance a little bit, so if you can assure the macro shall 
never be used on addresses from CKSEG0 if the load address is in XPHYS, 
then you can easily arrange for the load address to be passed to the 
preprocessor and use it as a condition here instead, which will be 
optimised away as required by the compiler.

> BTW, maybe we can simply remove BUILD_ELF64 at all, since it's only
> used to add '-msym32' switch in the makefile. This switch could be
> automatically be added by the makefile instead thanks the following
> condition:
> 
> if CONFIG_64BITS and ${load-y} in CKSEG0
>    cflags-y += -msym32
> endif
> 
> what do you think ?

 I do not see enough of justification for -msym32 to be forced.  This will 
also raise the minimum version of binutils required to 2.16 for the 
affected platforms, which may be a little bit too aggressive.

> Please keep these conversions in the platform specific codes before
> calling back the firmware.

 The DECstation uses CPHYSADDR() for these purposes; see e.g.
arch/mips/dec/tc.c (not yet in the linux-mips.org repository -- to be 
merged from the -mm tree sometime after 2.6.20).  But I recall seeing 
suggestions for this macro to be removed.  Which I object against if there 
is no usable alternative available (and I refuse to implement generic 
functionality in platform-specific code -- there has been too much pain 
already to merge many such bits scattered around).

  Maciej
