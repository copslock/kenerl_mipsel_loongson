Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 23 Mar 2004 13:05:05 +0000 (GMT)
Received: from p508B7879.dip.t-dialin.net ([IPv6:::ffff:80.139.120.121]:30039
	"EHLO mail.linux-mips.net") by linux-mips.org with ESMTP
	id <S8225525AbUCWNFE>; Tue, 23 Mar 2004 13:05:04 +0000
Received: from fluff.linux-mips.net (fluff.linux-mips.net [127.0.0.1])
	by mail.linux-mips.net (8.12.8/8.12.8) with ESMTP id i2ND4woM007590;
	Tue, 23 Mar 2004 14:04:58 +0100
Received: (from ralf@localhost)
	by fluff.linux-mips.net (8.12.8/8.12.8/Submit) id i2ND4w5E007589;
	Tue, 23 Mar 2004 14:04:58 +0100
Date: Tue, 23 Mar 2004 14:04:58 +0100
From: Ralf Baechle <ralf@linux-mips.org>
To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
Cc: Kumba <kumba@gentoo.org>, linux-mips@linux-mips.org
Subject: Re: 2.4 kernels + >=binutils-2.14.90.0.8
Message-ID: <20040323130458.GB6151@linux-mips.org>
References: <Pine.LNX.4.55.0403171829130.14525@jurand.ds.pg.gda.pl> <4058BC76.9020204@gentoo.org> <Pine.LNX.4.55.0403172202060.14525@jurand.ds.pg.gda.pl> <4058DAE2.8000902@gentoo.org> <Pine.LNX.4.55.0403180041560.14525@jurand.ds.pg.gda.pl> <4058E89B.3010208@gentoo.org> <Pine.LNX.4.55.0403180141400.14525@jurand.ds.pg.gda.pl> <Pine.LNX.4.55.0403221255200.6539@jurand.ds.pg.gda.pl> <20040323120033.GA6151@linux-mips.org> <Pine.LNX.4.55.0403231348010.16819@jurand.ds.pg.gda.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.55.0403231348010.16819@jurand.ds.pg.gda.pl>
User-Agent: Mutt/1.4.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 4622
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Tue, Mar 23, 2004 at 01:50:27PM +0100, Maciej W. Rozycki wrote:

>  Some picky firmware may be unhappy about a bit different ELF layout it
> yields.  Anyway, this is the right way to go and any problems with bad
> firmware may be able to be compensated with updates to our linker scripts.

I've had lots of trouble with ECOFF implementations but not with ELF
which is a nicer design - in particular the obvious way of implementing
ELF loading is even likely to be the right one.

Oh well, we'll see - and I guess a binutils person will object to obove
paragraph the next five minutes ;-)

  Ralf
