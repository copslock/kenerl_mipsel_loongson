Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 26 Jan 2004 17:01:00 +0000 (GMT)
Received: from p508B5D28.dip.t-dialin.net ([IPv6:::ffff:80.139.93.40]:20564
	"EHLO mail.linux-mips.net") by linux-mips.org with ESMTP
	id <S8225251AbUAZRBA>; Mon, 26 Jan 2004 17:01:00 +0000
Received: from fluff.linux-mips.net (fluff.linux-mips.net [127.0.0.1])
	by mail.linux-mips.net (8.12.8/8.12.8) with ESMTP id i0QH0Wex017574;
	Mon, 26 Jan 2004 18:00:32 +0100
Received: (from ralf@localhost)
	by fluff.linux-mips.net (8.12.8/8.12.8/Submit) id i0QH0SXr017573;
	Mon, 26 Jan 2004 18:00:28 +0100
Date: Mon, 26 Jan 2004 18:00:28 +0100
From: Ralf Baechle <ralf@linux-mips.org>
To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
Cc: "Dominik 'Rathann' Mierzejewski" <rathann@icm.edu.pl>,
	linux-mips@linux-mips.org
Subject: Re: [patch] pg-r4k.c bugs for R4600 rev.2.0
Message-ID: <20040126170028.GA15176@linux-mips.org>
References: <20040115141427.GA28546@icm.edu.pl> <Pine.LNX.4.21.0401151816540.3511-100000@www.marty44.net> <20040115231735.GA6619@icm.edu.pl> <4007386F.80207@gentoo.org> <20040115172602.H18368@mvista.com> <20040116115053.GA18099@icm.edu.pl> <20040120130625.GA24435@icm.edu.pl> <20040120162800.GA29792@icm.edu.pl> <20040123161410.GC20047@icm.edu.pl> <Pine.LNX.4.55.0401261659540.14505@jurand.ds.pg.gda.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.55.0401261659540.14505@jurand.ds.pg.gda.pl>
User-Agent: Mutt/1.4.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 4136
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Mon, Jan 26, 2004 at 05:31:07PM +0100, Maciej W. Rozycki wrote:

>  I have two other fixes for the file -- you might try them as well, as
> I've only tested all three of them together, because of a different
> configuration of the system I've used.  They fix a problem with R4k
> systems with a secondary cache and a coprocessor 0 hazard with R4000/R4400
> systems with primary caches only.
> 
>  Ralf, OK to apply this one?

Looks good, so please feel free to apply.

I just bent the kernel for my R4600 v2.0 machine (RM200) into shape again
and will test it later; will let you know if there's any problems.

  Ralf
