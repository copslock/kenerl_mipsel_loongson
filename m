Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 07 Jul 2005 13:19:16 +0100 (BST)
Received: from pollux.ds.pg.gda.pl ([IPv6:::ffff:153.19.208.7]:7431 "EHLO
	pollux.ds.pg.gda.pl") by linux-mips.org with ESMTP
	id <S8226161AbVGGMS5>; Thu, 7 Jul 2005 13:18:57 +0100
Received: from localhost (localhost [127.0.0.1])
	by pollux.ds.pg.gda.pl (Postfix) with ESMTP
	id C8F20E1C89; Thu,  7 Jul 2005 14:19:22 +0200 (CEST)
Received: from pollux.ds.pg.gda.pl ([127.0.0.1])
 by localhost (pollux [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
 id 23367-05; Thu,  7 Jul 2005 14:19:22 +0200 (CEST)
Received: from piorun.ds.pg.gda.pl (piorun.ds.pg.gda.pl [153.19.208.8])
	by pollux.ds.pg.gda.pl (Postfix) with ESMTP
	id 9B4ECE1C88; Thu,  7 Jul 2005 14:19:22 +0200 (CEST)
Received: from blysk.ds.pg.gda.pl (macro@blysk.ds.pg.gda.pl [153.19.208.6])
	by piorun.ds.pg.gda.pl (8.13.3/8.13.1) with ESMTP id j67CJPJU001168;
	Thu, 7 Jul 2005 14:19:25 +0200
Date:	Thu, 7 Jul 2005 13:19:31 +0100 (BST)
From:	"Maciej W. Rozycki" <macro@linux-mips.org>
To:	Thiemo Seufer <ths@networkno.de>
Cc:	linux-mips@linux-mips.org
Subject: Re: CVS Update@linux-mips.org: linux
In-Reply-To: <20050707121235.GV1645@hattusa.textio>
Message-ID: <Pine.LNX.4.61L.0507071314010.3205@blysk.ds.pg.gda.pl>
References: <20050707091937Z8226163-3678+1737@linux-mips.org>
 <Pine.LNX.4.61L.0507071227170.3205@blysk.ds.pg.gda.pl> <20050707121235.GV1645@hattusa.textio>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Virus-Scanned: ClamAV 0.85.1/970/Wed Jul  6 18:00:45 2005 on piorun.ds.pg.gda.pl
X-Virus-Status:	Clean
X-Virus-Scanned: by amavisd-new at pollux.ds.pg.gda.pl
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 8384
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Thu, 7 Jul 2005, Thiemo Seufer wrote:

> -mel/-meb aren't documented.

 They are:

$ gcc -v --help 2>/dev/null | egrep 'mel|meb'
  -mel                      Use little-endian byte order
  -meb                      Use big-endian byte order

They are not in the info pages, but that should probably be considered an 
accidental omission.  Is using something that's documented but doesn't 
work, to the contrary, any better?

  Maciej
