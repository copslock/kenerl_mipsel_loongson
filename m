Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 12 Aug 2003 15:04:56 +0100 (BST)
Received: from iris1.csv.ica.uni-stuttgart.de ([IPv6:::ffff:129.69.118.2]:14175
	"EHLO iris1.csv.ica.uni-stuttgart.de") by linux-mips.org with ESMTP
	id <S8225290AbTHLOEy>; Tue, 12 Aug 2003 15:04:54 +0100
Received: from rembrandt.csv.ica.uni-stuttgart.de ([129.69.118.42])
	by iris1.csv.ica.uni-stuttgart.de with esmtp (Exim 3.35 #1)
	id 19mZlc-0001rz-00
	for linux-mips@linux-mips.org; Tue, 12 Aug 2003 16:04:52 +0200
Received: from ica2_ts by rembrandt.csv.ica.uni-stuttgart.de with local (Exim 3.35 #1 (Debian))
	id 19mZlc-0001wt-00
	for <linux-mips@linux-mips.org>; Tue, 12 Aug 2003 16:04:52 +0200
Date: Tue, 12 Aug 2003 16:04:52 +0200
To: linux-mips@linux-mips.org
Subject: Re: GCCFLAGS for gcc 3.3.x (-march and _MIPS_ISA)
Message-ID: <20030812140452.GD10792@rembrandt.csv.ica.uni-stuttgart.de>
References: <20030812065118.GD23104@rembrandt.csv.ica.uni-stuttgart.de> <Pine.GSO.3.96.1030812155517.7029C-100000@delta.ds2.pg.gda.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.GSO.3.96.1030812155517.7029C-100000@delta.ds2.pg.gda.pl>
User-Agent: Mutt/1.5.4i
From: Thiemo Seufer <ica2_ts@csv.ica.uni-stuttgart.de>
Return-Path: <ica2_ts@csv.ica.uni-stuttgart.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 3037
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ica2_ts@csv.ica.uni-stuttgart.de
Precedence: bulk
X-list: linux-mips

Maciej W. Rozycki wrote:
> On Tue, 12 Aug 2003, Thiemo Seufer wrote:
> 
> > If the intention is to use mfc0 for 32bit kernels and dmfc0 for 64bit,
> > the check should probably be
> > 
> > #ifdef __mips64
> > # define MFC0		dmfc0
> > # define MTC0		dmtc0
> > #else
> > # define MFC0		mfc0
> > # define MTC0		mtc0
> > #endif
> 
>  I'd go for CONFIG_MIPS64 here.

This would work as well, but I prefer compiler intrinsic defines
over custom configury.


Thiemo
