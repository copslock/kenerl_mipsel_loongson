Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 26 Jul 2004 12:23:50 +0100 (BST)
Received: from pollux.ds.pg.gda.pl ([IPv6:::ffff:153.19.208.7]:29700 "EHLO
	pollux.ds.pg.gda.pl") by linux-mips.org with ESMTP
	id <S8224934AbUGZLXo>; Mon, 26 Jul 2004 12:23:44 +0100
Received: from localhost (localhost [127.0.0.1])
	by pollux.ds.pg.gda.pl (Postfix) with ESMTP
	id ECCBFE1CA6; Mon, 26 Jul 2004 13:23:38 +0200 (CEST)
Received: from pollux.ds.pg.gda.pl ([127.0.0.1])
 by localhost (pollux [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
 id 04727-02; Mon, 26 Jul 2004 13:23:38 +0200 (CEST)
Received: from piorun.ds.pg.gda.pl (piorun.ds.pg.gda.pl [153.19.208.8])
	by pollux.ds.pg.gda.pl (Postfix) with ESMTP
	id A6A45E1CA4; Mon, 26 Jul 2004 13:23:38 +0200 (CEST)
Received: from blysk.ds.pg.gda.pl (macro@blysk.ds.pg.gda.pl [153.19.208.6])
	by piorun.ds.pg.gda.pl (8.12.11/8.11.4) with ESMTP id i6QBNkhQ027169;
	Mon, 26 Jul 2004 13:23:46 +0200
Date: Mon, 26 Jul 2004 13:23:41 +0200 (CEST)
From: "Maciej W. Rozycki" <macro@linux-mips.org>
To: Ralf Baechle <ralf@linux-mips.org>
Cc: Srinivas Kommu <kommu@hotmail.com>, linux-mips@linux-mips.org
Subject: Re: mips32 kernel memory mapping
In-Reply-To: <20040723202439.GA3711@linux-mips.org>
Message-ID: <Pine.LNX.4.58L.0407261258010.3873@blysk.ds.pg.gda.pl>
References: <BAY1-F25sCR6nWqNG2Y00092cf9@hotmail.com>
 <Pine.LNX.4.58L.0407231348580.5644@blysk.ds.pg.gda.pl> <20040723202439.GA3711@linux-mips.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Virus-Scanned: by amavisd-new at pollux.ds.pg.gda.pl
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 5555
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Fri, 23 Jul 2004, Ralf Baechle wrote:

> There is a general perception among Linux users that 64-bit is new an
> not really needed which in part I blame on the bs Intel is spreading to
> hide the fact that for a long time they simply had no 64-bit roadmap at
> all.

 Huh?  How's Intel's policy related to 64-bit Linux?  Especially for other
processors, like MIPS.

 Linux has supported 64-bit operation since ~1995 and around 1998 when I
had an opportunity to use it on DEC Alpha, it (2.0.x) was already stable
enough for regular use.  That is the generic core and the Alpha bits, of
course -- the maturity of other processor support may vary, but for MIPS
it's not worse than the 32-bit support.

> There are still improvments to be made for BCM1250 support.  Somebody
> thought scattering the first 1GB of memory through the lowest 4GB of
> physical address space like a three year old his toys over the floor
> was a good thing ...  The resulting holes in the memory map are wasting
> significant amounts of memory for unused memory; the worst case number
> that is reached for 64-bit kernel on a system with > 1GB of RAM is 96MB!

 Well, there are some resons given in the manual.  Anyway, memory seems to
be remappable to 0x100000000 in the DRAM controller.  Still we probably
have to keep low 256MB mapped and registered within Linux at 0 for bounce
buffers for broken PCI hardware ("hidden" mapping for exception handlers 
and kernel segments would be easier).

 With only 256MB installed in my system it would be tough for me to code
anything interesting, though.  Perhaps another time.

  Maciej
