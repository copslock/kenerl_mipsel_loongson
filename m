Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 18 Jan 2004 07:28:26 +0000 (GMT)
Received: from iris1.csv.ica.uni-stuttgart.de ([IPv6:::ffff:129.69.118.2]:37684
	"EHLO iris1.csv.ica.uni-stuttgart.de") by linux-mips.org with ESMTP
	id <S8225228AbUARH20>; Sun, 18 Jan 2004 07:28:26 +0000
Received: from rembrandt.csv.ica.uni-stuttgart.de ([129.69.118.42])
	by iris1.csv.ica.uni-stuttgart.de with esmtp
	id 1Ai7M9-0000rz-00
	for <linux-mips@linux-mips.org>; Sun, 18 Jan 2004 08:28:25 +0100
Received: from ica2_ts by rembrandt.csv.ica.uni-stuttgart.de with local (Exim 3.35 #1 (Debian))
	id 1Ai7M8-0007LH-00
	for <linux-mips@linux-mips.org>; Sun, 18 Jan 2004 08:28:24 +0100
Date: Sun, 18 Jan 2004 08:28:24 +0100
To: linux-mips@linux-mips.org
Subject: Re: Trouble compiling MIPS cross-compiler
Message-ID: <20040118072824.GU22218@rembrandt.csv.ica.uni-stuttgart.de>
References: <200401171711.34964@korath> <200401181510.35686@korath> <400A1B5F.6010307@gentoo.org> <200401181646.04740@korath> <1074409013.3602.16.camel@dzur.sfbay.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1074409013.3602.16.camel@dzur.sfbay.redhat.com>
User-Agent: Mutt/1.5.4i
From: Thiemo Seufer <ica2_ts@csv.ica.uni-stuttgart.de>
Return-Path: <ica2_ts@csv.ica.uni-stuttgart.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 4020
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ica2_ts@csv.ica.uni-stuttgart.de
Precedence: bulk
X-list: linux-mips

Eric Christopher wrote:
> 
> > If I copy the command line and change -mcpu to -march then it works fine, but 
> > this isn't happening automatically for some reason.  Any ideas?  (I tried 
> > downgrading to binutils-2.13.xxx but it still gave the error, so I'm guessing 
> > it's a gcc problem - oh how much easier life would be if they didn't remove 
> > the -mcpu option somewhere along the way ;-))
> 
> Actually, I removed it :)
> 
> If you'd like the rant behind it I'll mail it privately.
> 
> Anyhow, I've been trying to push for the kernel to use either
> 
> a) -march depending on whatever cpu is specified

AFAICS current CVS defaults to that (modulo changing it immediately
afterwards to the generic base arch by an superfluous -mipsX option).

> b) -mtune otherwise (this will generate generic code and then tune for
> something)

Actually, -mtune=r3900 breaks the "generic" part due to an assembler bug
(and did so for a long time).


Thiemo
