Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 23 Jun 2005 18:38:46 +0100 (BST)
Received: from pollux.ds.pg.gda.pl ([IPv6:::ffff:153.19.208.7]:3852 "EHLO
	pollux.ds.pg.gda.pl") by linux-mips.org with ESMTP
	id <S8225534AbVFWRi2>; Thu, 23 Jun 2005 18:38:28 +0100
Received: from localhost (localhost [127.0.0.1])
	by pollux.ds.pg.gda.pl (Postfix) with ESMTP
	id BCE58F5979; Thu, 23 Jun 2005 19:37:24 +0200 (CEST)
Received: from pollux.ds.pg.gda.pl ([127.0.0.1])
 by localhost (pollux [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
 id 22356-05; Thu, 23 Jun 2005 19:37:24 +0200 (CEST)
Received: from piorun.ds.pg.gda.pl (piorun.ds.pg.gda.pl [153.19.208.8])
	by pollux.ds.pg.gda.pl (Postfix) with ESMTP
	id D6276E1CB9; Thu, 23 Jun 2005 19:37:23 +0200 (CEST)
Received: from blysk.ds.pg.gda.pl (macro@blysk.ds.pg.gda.pl [153.19.208.6])
	by piorun.ds.pg.gda.pl (8.13.3/8.13.1) with ESMTP id j5NHbR4h003825;
	Thu, 23 Jun 2005 19:37:28 +0200
Date:	Thu, 23 Jun 2005 18:37:38 +0100 (BST)
From:	"Maciej W. Rozycki" <macro@linux-mips.org>
To:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
Cc:	kumba@gentoo.org, linux-mips@linux-mips.org
Subject: Re: .set mips2 breaks 64bit kernel
In-Reply-To: <20050623.012629.41198930.anemo@mba.ocn.ne.jp>
Message-ID: <Pine.LNX.4.61L.0506231832140.31113@blysk.ds.pg.gda.pl>
References: <Pine.LNX.4.61L.0506221330240.4849@blysk.ds.pg.gda.pl>
 <42B95FB2.1090604@gentoo.org> <Pine.LNX.4.61L.0506221403420.4849@blysk.ds.pg.gda.pl>
 <20050623.012629.41198930.anemo@mba.ocn.ne.jp>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Virus-Scanned: ClamAV 0.85.1/954/Wed Jun 22 21:15:13 2005 on piorun.ds.pg.gda.pl
X-Virus-Status:	Clean
X-Virus-Scanned: by amavisd-new at pollux.ds.pg.gda.pl
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 8157
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Thu, 23 Jun 2005, Atsushi Nemoto wrote:

> Then gas expands the 'll' to LUI and LL (no high 32bit).

 I've fixed it by using ".set mips3" universally -- alternating between it 
and ".set mips2" would be too ugly and the only difference between these 
ISAs are 64-bit operations, so for code that does not use them explicitly 
these settings should be equivalent.

> I'm using gcc 3.4.4 and binutils 2.16.1.  Not so brand new but not so
> obsolete (I hope :-))

 Well, GCC 3.4.4 is a bit old-fashioned, but it's not the worst one and 
certainly we are going to support it for a while yet. ;-)  Binutils 2.16.1 
should be OK -- I don't think there's been any problems discovered with 
them yet that would urge an update.

  Maciej
