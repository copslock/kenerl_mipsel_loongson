Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 13 Jun 2005 21:19:04 +0100 (BST)
Received: from pollux.ds.pg.gda.pl ([IPv6:::ffff:153.19.208.7]:10756 "EHLO
	pollux.ds.pg.gda.pl") by linux-mips.org with ESMTP
	id <S8225884AbVFMUSt>; Mon, 13 Jun 2005 21:18:49 +0100
Received: from localhost (localhost [127.0.0.1])
	by pollux.ds.pg.gda.pl (Postfix) with ESMTP
	id D1FEEF598B; Mon, 13 Jun 2005 22:18:38 +0200 (CEST)
Received: from pollux.ds.pg.gda.pl ([127.0.0.1])
 by localhost (pollux [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
 id 25845-10; Mon, 13 Jun 2005 22:18:38 +0200 (CEST)
Received: from piorun.ds.pg.gda.pl (piorun.ds.pg.gda.pl [153.19.208.8])
	by pollux.ds.pg.gda.pl (Postfix) with ESMTP
	id 15C17F5981; Mon, 13 Jun 2005 22:18:38 +0200 (CEST)
Received: from blysk.ds.pg.gda.pl (macro@blysk.ds.pg.gda.pl [153.19.208.6])
	by piorun.ds.pg.gda.pl (8.13.3/8.13.1) with ESMTP id j5DKIQK4028469;
	Mon, 13 Jun 2005 22:18:26 +0200
Date:	Mon, 13 Jun 2005 21:18:38 +0100 (BST)
From:	"Maciej W. Rozycki" <macro@linux-mips.org>
To:	Christoph Hellwig <hch@lst.de>
Cc:	Daniel Jacobowitz <dan@debian.org>,
	Jim Gifford <maillist@jg555.com>,
	Linux MIPS List <linux-mips@linux-mips.org>
Subject: Re: Building o32 glibc on mips64
In-Reply-To: <20050613200820.GA29872@lst.de>
Message-ID: <Pine.LNX.4.61L.0506132112500.1725@blysk.ds.pg.gda.pl>
References: <42AB3366.8030206@jg555.com> <20050613195602.GA3739@nevyn.them.org>
 <Pine.LNX.4.61L.0506132100080.1725@blysk.ds.pg.gda.pl> <20050613200820.GA29872@lst.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Virus-Scanned: ClamAV 0.85.1/935/Mon Jun 13 18:27:50 2005 on piorun.ds.pg.gda.pl
X-Virus-Status:	Clean
X-Virus-Scanned: by amavisd-new at pollux.ds.pg.gda.pl
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 8081
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Mon, 13 Jun 2005, Christoph Hellwig wrote:

> >  Do you think HEAD is stable enough for a non-glibc developer?  It's soon 
> > after a fork after all, so I'd expect more serious changes to be applied 
> > nowadays.
> 
> Btw, what is the chance to see a biarch toolchain for mips?  It seems
> all linux architectures with 32bit and 64bit variants seem to have one
> these days, except mips.

 What do you mean?  Multilib, per chance?  If so, please feel free to 
build one yourself -- as of 4.0.0 GCC will build libraries for all three 
ABIs (o32, (n)64 and n32) if configured for mips64{,el}-linux and 
--enable-multilib is in effect (I think it is by default).  Bi-endian is 
probably tougher, but it should be possible -- GCC itself supports the 
"-mabi=" and "-mel" and "-meb" switches all the time AFAIK.

 Of course you may need to have system libraries installed in place for 
all requested configurations as appropriate; at least glibc, but perhaps 
others as well (gmp, mpfr for Fortran; zlib for Java).

  Maciej
