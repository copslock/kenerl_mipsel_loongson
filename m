Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 31 May 2005 15:29:42 +0100 (BST)
Received: from pollux.ds.pg.gda.pl ([IPv6:::ffff:153.19.208.7]:14857 "EHLO
	pollux.ds.pg.gda.pl") by linux-mips.org with ESMTP
	id <S8225795AbVEaO31>; Tue, 31 May 2005 15:29:27 +0100
Received: from localhost (localhost [127.0.0.1])
	by pollux.ds.pg.gda.pl (Postfix) with ESMTP
	id A207FF5977; Tue, 31 May 2005 16:29:22 +0200 (CEST)
Received: from pollux.ds.pg.gda.pl ([127.0.0.1])
 by localhost (pollux [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
 id 26914-04; Tue, 31 May 2005 16:29:22 +0200 (CEST)
Received: from piorun.ds.pg.gda.pl (piorun.ds.pg.gda.pl [153.19.208.8])
	by pollux.ds.pg.gda.pl (Postfix) with ESMTP
	id 5A96CE1CA5; Tue, 31 May 2005 16:29:22 +0200 (CEST)
Received: from blysk.ds.pg.gda.pl (macro@blysk.ds.pg.gda.pl [153.19.208.6])
	by piorun.ds.pg.gda.pl (8.13.3/8.13.1) with ESMTP id j4VESWiH008835;
	Tue, 31 May 2005 16:28:32 +0200
Date:	Tue, 31 May 2005 15:28:39 +0100 (BST)
From:	"Maciej W. Rozycki" <macro@linux-mips.org>
To:	maxim@mox.ru
Cc:	Daniel Jacobowitz <dan@debian.org>, linux-mips@linux-mips.org
Subject: Re: glibc-2.3.4 mips64 compilation failure
In-Reply-To: <6097c4905052703152b50f717@mail.gmail.com>
Message-ID: <Pine.LNX.4.61L.0505311520140.30850@blysk.ds.pg.gda.pl>
References: <6097c4905052609326a4c1232@mail.gmail.com> 
 <20050526170603.GA13272@nevyn.them.org>  <Pine.LNX.4.61L.0505261815330.29423@blysk.ds.pg.gda.pl>
 <6097c4905052703152b50f717@mail.gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Virus-Scanned: ClamAV 0.85.1/901/Tue May 31 15:33:04 2005 on piorun.ds.pg.gda.pl
X-Virus-Status:	Clean
X-Virus-Scanned: by amavisd-new at pollux.ds.pg.gda.pl
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 8030
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Fri, 27 May 2005, Maxim Osipov wrote:

> Do anyone have a clue what is happening? AFAIK, some people already
> had success building glibc for mips64. Probably I miss something?

 Please feel free to have a look at packages available at my site -- the 
setup may seem a little bit odd (n64 is used as the default format and 
actually the only one supported), but if you are after general setup, 
patches, etc. it is still relevant; just ignore the odd stuff.  Binary 
packages have been built with GCC 4.0.0, so probably the sources + patches 
are going to work with older tools as well.  You may consider using 
binutils 2.16, though (in general, not to solve your particular problem).

  Maciej
