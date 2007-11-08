Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 08 Nov 2007 11:25:18 +0000 (GMT)
Received: from cerber.ds.pg.gda.pl ([153.19.208.18]:19436 "EHLO
	cerber.ds.pg.gda.pl") by ftp.linux-mips.org with ESMTP
	id S20021864AbXKHLZJ (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 8 Nov 2007 11:25:09 +0000
Received: from localhost (unknown [127.0.0.17])
	by cerber.ds.pg.gda.pl (Postfix) with ESMTP id 4BEC2400C1;
	Thu,  8 Nov 2007 12:25:09 +0100 (CET)
X-Virus-Scanned: amavisd-new at cerber.ds.pg.gda.pl
Received: from cerber.ds.pg.gda.pl ([153.19.208.18])
	by localhost (cerber.ds.pg.gda.pl [153.19.208.18]) (amavisd-new, port 10024)
	with ESMTP id YY7s097Hh0U7; Thu,  8 Nov 2007 12:25:03 +0100 (CET)
Received: from piorun.ds.pg.gda.pl (piorun.ds.pg.gda.pl [153.19.208.8])
	by cerber.ds.pg.gda.pl (Postfix) with ESMTP id E4B5E4007E;
	Thu,  8 Nov 2007 12:25:02 +0100 (CET)
Received: from blysk.ds.pg.gda.pl (macro@blysk.ds.pg.gda.pl [153.19.208.6])
	by piorun.ds.pg.gda.pl (8.13.8/8.13.8) with ESMTP id lA8BP6Z3030135;
	Thu, 8 Nov 2007 12:25:06 +0100
Date:	Thu, 8 Nov 2007 11:25:03 +0000 (GMT)
From:	"Maciej W. Rozycki" <macro@linux-mips.org>
To:	Ralf Baechle <ralf@linux-mips.org>
cc:	Florian Fainelli <florian.fainelli@telecomint.eu>,
	linux-mips@linux-mips.org
Subject: Re: [PATCH][au1000] Remove useless EXTRA_CFLAGS
In-Reply-To: <20071108094708.GA10665@linux-mips.org>
Message-ID: <Pine.LNX.4.64N.0711081114200.23511@blysk.ds.pg.gda.pl>
References: <200710252108.43357.florian.fainelli@telecomint.eu>
 <20071029151010.GA3953@linux-mips.org> <Pine.LNX.4.64N.0711071239560.14970@blysk.ds.pg.gda.pl>
 <20071108094708.GA10665@linux-mips.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Virus-Scanned: ClamAV 0.91.2/4708/Thu Nov  8 07:07:54 2007 on piorun.ds.pg.gda.pl
X-Virus-Status:	Clean
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 17449
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Thu, 8 Nov 2007, Ralf Baechle wrote:

> >  Yeah...  If only GCC had no bugs and always had a clue of what to warn 
> > about...
> 
> The least of all problems.

 It depends for whom I suppose. ;-)  It is a pain when you have to stretch 
your imagination to rewrite a piece of source code GCC warns about unduly 
and both keep it readable and not make the generated binary worse...  
Especially where configuration-specific macros are involved.

> As of 2.6.20-rc2-git2 we had 137 warnings in MIPS specific code of a total
> of 218 for the kernel and 44 for modules - that's a insane 52%.  And people
> happily added more crappy code because they didn't not even _notice_ the
> warnings some of which indeed were bugs.

 Well, adding no warnings should be the rule #1 and I can understand it is 
easier for you to enforce it by the means of -Werror. ;-)

  Maciej
