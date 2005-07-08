Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 08 Jul 2005 13:12:34 +0100 (BST)
Received: from pollux.ds.pg.gda.pl ([IPv6:::ffff:153.19.208.7]:20753 "EHLO
	pollux.ds.pg.gda.pl") by linux-mips.org with ESMTP
	id <S8226340AbVGHMMP>; Fri, 8 Jul 2005 13:12:15 +0100
Received: from localhost (localhost [127.0.0.1])
	by pollux.ds.pg.gda.pl (Postfix) with ESMTP
	id 4E045E1CAE; Fri,  8 Jul 2005 14:12:45 +0200 (CEST)
Received: from pollux.ds.pg.gda.pl ([127.0.0.1])
 by localhost (pollux [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
 id 11750-05; Fri,  8 Jul 2005 14:12:45 +0200 (CEST)
Received: from piorun.ds.pg.gda.pl (piorun.ds.pg.gda.pl [153.19.208.8])
	by pollux.ds.pg.gda.pl (Postfix) with ESMTP
	id 14512E1CA8; Fri,  8 Jul 2005 14:12:45 +0200 (CEST)
Received: from blysk.ds.pg.gda.pl (macro@blysk.ds.pg.gda.pl [153.19.208.6])
	by piorun.ds.pg.gda.pl (8.13.3/8.13.1) with ESMTP id j68CCmP8028558;
	Fri, 8 Jul 2005 14:12:48 +0200
Date:	Fri, 8 Jul 2005 13:12:55 +0100 (BST)
From:	"Maciej W. Rozycki" <macro@linux-mips.org>
To:	Ralf Baechle <ralf@linux-mips.org>
Cc:	linux-mips@linux-mips.org
Subject: Re: CVS Update@linux-mips.org: linux
In-Reply-To: <20050708120238.GA2816@linux-mips.org>
Message-ID: <Pine.LNX.4.61L.0507081309530.25104@blysk.ds.pg.gda.pl>
References: <20050708091711Z8226352-3678+1954@linux-mips.org>
 <20050708120238.GA2816@linux-mips.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Virus-Scanned: ClamAV 0.85.1/971/Thu Jul  7 12:08:01 2005 on piorun.ds.pg.gda.pl
X-Virus-Status:	Clean
X-Virus-Scanned: by amavisd-new at pollux.ds.pg.gda.pl
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 8404
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Fri, 8 Jul 2005, Ralf Baechle wrote:

> > Log message:
> > 	Protect noat assembly with .set push/pop and make it somewhat readable.
> 
> It doesn't need protction.

 Are you absolutely sure future versions of GCC won't default to ".set 
noat" for inline asm?  I am not; in fact the opposite is not unlikely.

  Maciej
