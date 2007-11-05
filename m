Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 05 Nov 2007 12:38:52 +0000 (GMT)
Received: from cerber.ds.pg.gda.pl ([153.19.208.18]:13998 "EHLO
	cerber.ds.pg.gda.pl") by ftp.linux-mips.org with ESMTP
	id S20029944AbXKEMio (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 5 Nov 2007 12:38:44 +0000
Received: from localhost (unknown [127.0.0.17])
	by cerber.ds.pg.gda.pl (Postfix) with ESMTP id 8B7D64003B;
	Mon,  5 Nov 2007 13:38:14 +0100 (CET)
X-Virus-Scanned: amavisd-new at cerber.ds.pg.gda.pl
Received: from cerber.ds.pg.gda.pl ([153.19.208.18])
	by localhost (cerber.ds.pg.gda.pl [153.19.208.18]) (amavisd-new, port 10024)
	with ESMTP id wiQkQxpME0b2; Mon,  5 Nov 2007 13:38:08 +0100 (CET)
Received: from piorun.ds.pg.gda.pl (piorun.ds.pg.gda.pl [153.19.208.8])
	by cerber.ds.pg.gda.pl (Postfix) with ESMTP id B989E400A6;
	Mon,  5 Nov 2007 13:38:07 +0100 (CET)
Received: from blysk.ds.pg.gda.pl (macro@blysk.ds.pg.gda.pl [153.19.208.6])
	by piorun.ds.pg.gda.pl (8.13.8/8.13.8) with ESMTP id lA5Cc9Dl024326;
	Mon, 5 Nov 2007 13:38:10 +0100
Date:	Mon, 5 Nov 2007 12:38:06 +0000 (GMT)
From:	"Maciej W. Rozycki" <macro@linux-mips.org>
To:	Franck Bui-Huu <vagabon.xyz@gmail.com>
cc:	Ralf Baechle <ralf@linux-mips.org>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	linux-mips <linux-mips@linux-mips.org>
Subject: Re: [RFC] Add __initbss section
In-Reply-To: <472D82D1.1050401@gmail.com>
Message-ID: <Pine.LNX.4.64N.0711051234230.857@blysk.ds.pg.gda.pl>
References: <470DF25E.60009@gmail.com> <Pine.LNX.4.64N.0710111307180.16370@blysk.ds.pg.gda.pl>
 <4712738A.5000703@gmail.com> <Pine.LNX.4.64N.0710151311350.16262@blysk.ds.pg.gda.pl>
 <4713C840.8080206@gmail.com> <Pine.LNX.4.64N.0710161123110.22596@blysk.ds.pg.gda.pl>
 <4717C1FB.4030602@gmail.com> <Pine.LNX.4.64N.0710191239490.13279@blysk.ds.pg.gda.pl>
 <472D82D1.1050401@gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Virus-Scanned: ClamAV 0.91.2/4673/Sun Nov  4 23:22:25 2007 on piorun.ds.pg.gda.pl
X-Virus-Status:	Clean
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 17401
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Sun, 4 Nov 2007, Franck Bui-Huu wrote:

> >  Hmm, isn't what `info ld' says enough?
> 
> Hmm, I'm must be blind but I missed that each time I read it. Could
> you point out the section number please ?

 That's section 3.8, I would guess, but if what you are looking for is not 
there, then perhaps the description could be improved.

  Maciej
