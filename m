Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 17 Mar 2004 23:25:23 +0000 (GMT)
Received: from iris1.csv.ica.uni-stuttgart.de ([IPv6:::ffff:129.69.118.2]:49935
	"EHLO iris1.csv.ica.uni-stuttgart.de") by linux-mips.org with ESMTP
	id <S8225319AbUCQXZN>; Wed, 17 Mar 2004 23:25:13 +0000
Received: from rembrandt.csv.ica.uni-stuttgart.de ([129.69.118.42] ident=mail)
	by iris1.csv.ica.uni-stuttgart.de with esmtp
	id 1B3kPP-0007Jb-00
	for <linux-mips@linux-mips.org>; Thu, 18 Mar 2004 00:25:11 +0100
Received: from ica2_ts by rembrandt.csv.ica.uni-stuttgart.de with local (Exim 3.35 #1 (Debian))
	id 1B3kPP-0008Ha-00
	for <linux-mips@linux-mips.org>; Thu, 18 Mar 2004 00:25:11 +0100
Date: Thu, 18 Mar 2004 00:25:10 +0100
To: linux-mips@linux-mips.org
Subject: Re: 2.4 kernels + >=binutils-2.14.90.0.8
Message-ID: <20040317232510.GD28639@rembrandt.csv.ica.uni-stuttgart.de>
References: <404D0A18.6050802@gentoo.org> <20040309003447.GH16163@rembrandt.csv.ica.uni-stuttgart.de> <404D1909.1020005@gentoo.org> <20040309013841.GI16163@rembrandt.csv.ica.uni-stuttgart.de> <404D28B1.4010608@gentoo.org> <20040309023737.GJ16163@rembrandt.csv.ica.uni-stuttgart.de> <Pine.LNX.4.55.0403171829130.14525@jurand.ds.pg.gda.pl> <4058BC76.9020204@gentoo.org> <Pine.LNX.4.55.0403172202060.14525@jurand.ds.pg.gda.pl> <4058DAE2.8000902@gentoo.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4058DAE2.8000902@gentoo.org>
User-Agent: Mutt/1.5.5.1i
From: Thiemo Seufer <ica2_ts@csv.ica.uni-stuttgart.de>
Return-Path: <ica2_ts@csv.ica.uni-stuttgart.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 4567
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ica2_ts@csv.ica.uni-stuttgart.de
Precedence: bulk
X-list: linux-mips

Kumba wrote:
> Maciej W. Rozycki wrote:
> 
> > The patch just triggers it.  Previously, the segment's start address as
> >set by Linux in a linker script was already aligned to the page size as it
> >was defined then.
> 
> Hmm, so would removing the patch function as a temporary workaround 
> until the real problem is fixed, or not recommended (meaning unbootable 
> kernels till it's fixed)?

It works as a workaround, unless the kernel wants to take advantage
from pagesizes other than 4kB.


Thiemo
