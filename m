Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 07 Nov 2007 16:56:01 +0000 (GMT)
Received: from cerber.ds.pg.gda.pl ([153.19.208.18]:29338 "EHLO
	cerber.ds.pg.gda.pl") by ftp.linux-mips.org with ESMTP
	id S20030075AbXKGQzw (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 7 Nov 2007 16:55:52 +0000
Received: from localhost (unknown [127.0.0.17])
	by cerber.ds.pg.gda.pl (Postfix) with ESMTP id 4119B4007E;
	Wed,  7 Nov 2007 17:55:22 +0100 (CET)
X-Virus-Scanned: amavisd-new at cerber.ds.pg.gda.pl
Received: from cerber.ds.pg.gda.pl ([153.19.208.18])
	by localhost (cerber.ds.pg.gda.pl [153.19.208.18]) (amavisd-new, port 10024)
	with ESMTP id 97NHDMBLtFiM; Wed,  7 Nov 2007 17:55:12 +0100 (CET)
Received: from piorun.ds.pg.gda.pl (piorun.ds.pg.gda.pl [153.19.208.8])
	by cerber.ds.pg.gda.pl (Postfix) with ESMTP id B89774008F;
	Wed,  7 Nov 2007 17:55:11 +0100 (CET)
Received: from blysk.ds.pg.gda.pl (macro@blysk.ds.pg.gda.pl [153.19.208.6])
	by piorun.ds.pg.gda.pl (8.13.8/8.13.8) with ESMTP id lA7GtFIE020409;
	Wed, 7 Nov 2007 17:55:15 +0100
Date:	Wed, 7 Nov 2007 16:55:10 +0000 (GMT)
From:	"Maciej W. Rozycki" <macro@linux-mips.org>
To:	Martin Michlmayr <tbm@cyrius.com>
cc:	Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Subject: Re: [PATCH] IP22: Disable EARLY PRINTK, because it breaks serial
 console
In-Reply-To: <20071030073349.GA15984@deprecation.cyrius.com>
Message-ID: <Pine.LNX.4.64N.0711071648040.14970@blysk.ds.pg.gda.pl>
References: <20070911104459.GB7624@alpha.franken.de>
 <20071030073349.GA15984@deprecation.cyrius.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Virus-Scanned: ClamAV 0.91.2/4691/Wed Nov  7 06:39:41 2007 on piorun.ds.pg.gda.pl
X-Virus-Status:	Clean
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 17437
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Tue, 30 Oct 2007, Martin Michlmayr wrote:

> * Thomas Bogendoerfer <tsbogend@alpha.franken.de> [2007-09-11 12:44]:
> > Disable EARLY PRINTK, because it breaks serial console
> 
> Ralf, at the moment IP22 output stops after "Serial: IP22 Zilog driver
> (1 chips).".  Can you put this patch in until there's a real fix?

 Is it by any chance the same problem that I noticed with the DECstation 
and reported in the thread starting at: 
"http://marc.info/?l=linux-kernel&m=119030963931879&w=2"?  If so, there is 
a fix for the DECstation provided somewhere down the discussion which you 
may consider porting to IP22.  I think the change to the serial core by 
RMK mentioned there has already been applied upstream.

 Ideally, of course, all the SCC drivers should get merged eventually, but 
due to subtle (and sometimes broken, as it is the case with the 
DECstation) differences in wiring for various systems it may never really 
happen, sigh...

  Maciej
