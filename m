Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 14 Aug 2003 04:08:45 +0100 (BST)
Received: from iris1.csv.ica.uni-stuttgart.de ([IPv6:::ffff:129.69.118.2]:59493
	"EHLO iris1.csv.ica.uni-stuttgart.de") by linux-mips.org with ESMTP
	id <S8225208AbTHNDIm>; Thu, 14 Aug 2003 04:08:42 +0100
Received: from rembrandt.csv.ica.uni-stuttgart.de ([129.69.118.42])
	by iris1.csv.ica.uni-stuttgart.de with esmtp (Exim 3.35 #1)
	id 19n8Th-0005rQ-00
	for linux-mips@linux-mips.org; Thu, 14 Aug 2003 05:08:41 +0200
Received: from ica2_ts by rembrandt.csv.ica.uni-stuttgart.de with local (Exim 3.35 #1 (Debian))
	id 19n8Th-00083c-00
	for <linux-mips@linux-mips.org>; Thu, 14 Aug 2003 05:08:41 +0200
Date: Thu, 14 Aug 2003 05:08:41 +0200
To: linux-mips@linux-mips.org
Subject: Re: GCCFLAGS for gcc 3.3.x (-march and _MIPS_ISA)
Message-ID: <20030814030841.GK10792@rembrandt.csv.ica.uni-stuttgart.de>
References: <20030812140452.GD10792@rembrandt.csv.ica.uni-stuttgart.de> <Pine.GSO.3.96.1030812163438.7029F-100000@delta.ds2.pg.gda.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.GSO.3.96.1030812163438.7029F-100000@delta.ds2.pg.gda.pl>
User-Agent: Mutt/1.5.4i
From: Thiemo Seufer <ica2_ts@csv.ica.uni-stuttgart.de>
Return-Path: <ica2_ts@csv.ica.uni-stuttgart.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 3046
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ica2_ts@csv.ica.uni-stuttgart.de
Precedence: bulk
X-list: linux-mips

Maciej W. Rozycki wrote:
> On Tue, 12 Aug 2003, Thiemo Seufer wrote:
> 
> > > > If the intention is to use mfc0 for 32bit kernels and dmfc0 for 64bit,
> > > > the check should probably be
> > > > 
> > > > #ifdef __mips64
> > > > # define MFC0		dmfc0
> > > > # define MTC0		dmtc0
> > > > #else
> > > > # define MFC0		mfc0
> > > > # define MTC0		mtc0
> > > > #endif
> > > 
> > >  I'd go for CONFIG_MIPS64 here.
> > 
> > This would work as well, but I prefer compiler intrinsic defines
> > over custom configury.
> 
>  Well, for Linux it seems appropriate to use a kernel's configuration to
> select run-time behaviour -- in this case it's CONFIG_MIPS64 that was
> selected by a user that matters (i.e. that we use 64-bit addressing) and
> not a compiler's configuration.  Just the opposite to what's expected in
> the userland. 

JFTR:
__mips64 denotes neither 64-bit addressing nor the compiler configuration.
It just means that the generated code uses 64 bit wide registers.


Thiemo
