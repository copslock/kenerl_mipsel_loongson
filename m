Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 23 Mar 2004 14:22:25 +0000 (GMT)
Received: from iris1.csv.ica.uni-stuttgart.de ([IPv6:::ffff:129.69.118.2]:39780
	"EHLO iris1.csv.ica.uni-stuttgart.de") by linux-mips.org with ESMTP
	id <S8225198AbUCWOWV>; Tue, 23 Mar 2004 14:22:21 +0000
Received: from rembrandt.csv.ica.uni-stuttgart.de ([129.69.118.42] ident=mail)
	by iris1.csv.ica.uni-stuttgart.de with esmtp
	id 1B5mnL-00031I-00
	for <linux-mips@linux-mips.org>; Tue, 23 Mar 2004 15:22:19 +0100
Received: from ica2_ts by rembrandt.csv.ica.uni-stuttgart.de with local (Exim 3.35 #1 (Debian))
	id 1B5mnL-0000d7-00
	for <linux-mips@linux-mips.org>; Tue, 23 Mar 2004 15:22:19 +0100
Date: Tue, 23 Mar 2004 15:22:19 +0100
To: linux-mips@linux-mips.org
Subject: Re: 2.4 kernels + >=binutils-2.14.90.0.8
Message-ID: <20040323142219.GP26428@rembrandt.csv.ica.uni-stuttgart.de>
References: <4058BC76.9020204@gentoo.org> <Pine.LNX.4.55.0403172202060.14525@jurand.ds.pg.gda.pl> <4058DAE2.8000902@gentoo.org> <Pine.LNX.4.55.0403180041560.14525@jurand.ds.pg.gda.pl> <4058E89B.3010208@gentoo.org> <Pine.LNX.4.55.0403180141400.14525@jurand.ds.pg.gda.pl> <Pine.LNX.4.55.0403221255200.6539@jurand.ds.pg.gda.pl> <20040323120033.GA6151@linux-mips.org> <Pine.LNX.4.55.0403231348010.16819@jurand.ds.pg.gda.pl> <20040323130458.GB6151@linux-mips.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040323130458.GB6151@linux-mips.org>
User-Agent: Mutt/1.5.5.1i
From: Thiemo Seufer <ica2_ts@csv.ica.uni-stuttgart.de>
Return-Path: <ica2_ts@csv.ica.uni-stuttgart.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 4623
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ica2_ts@csv.ica.uni-stuttgart.de
Precedence: bulk
X-list: linux-mips

Ralf Baechle wrote:
> On Tue, Mar 23, 2004 at 01:50:27PM +0100, Maciej W. Rozycki wrote:
> 
> >  Some picky firmware may be unhappy about a bit different ELF layout it
> > yields.  Anyway, this is the right way to go and any problems with bad
> > firmware may be able to be compensated with updates to our linker scripts.
> 
> I've had lots of trouble with ECOFF implementations but not with ELF
> which is a nicer design - in particular the obvious way of implementing
> ELF loading is even likely to be the right one.

Well, some people chose to analyse ELF sections for their boot loader
as the "obvious" way...

> Oh well, we'll see - and I guess a binutils person will object to obove
> paragraph the next five minutes ;-)

Am I still in time? ;-)


Thiemo
