Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 08 Nov 2007 11:13:14 +0000 (GMT)
Received: from cerber.ds.pg.gda.pl ([153.19.208.18]:54738 "EHLO
	cerber.ds.pg.gda.pl") by ftp.linux-mips.org with ESMTP
	id S20021509AbXKHLNE (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 8 Nov 2007 11:13:04 +0000
Received: from localhost (unknown [127.0.0.17])
	by cerber.ds.pg.gda.pl (Postfix) with ESMTP id 3F47D40092;
	Thu,  8 Nov 2007 12:12:34 +0100 (CET)
X-Virus-Scanned: amavisd-new at cerber.ds.pg.gda.pl
Received: from cerber.ds.pg.gda.pl ([153.19.208.18])
	by localhost (cerber.ds.pg.gda.pl [153.19.208.18]) (amavisd-new, port 10024)
	with ESMTP id Qrf6aTt6daxM; Thu,  8 Nov 2007 12:12:21 +0100 (CET)
Received: from piorun.ds.pg.gda.pl (piorun.ds.pg.gda.pl [153.19.208.8])
	by cerber.ds.pg.gda.pl (Postfix) with ESMTP id D44E84007E;
	Thu,  8 Nov 2007 12:12:21 +0100 (CET)
Received: from blysk.ds.pg.gda.pl (macro@blysk.ds.pg.gda.pl [153.19.208.6])
	by piorun.ds.pg.gda.pl (8.13.8/8.13.8) with ESMTP id lA8BCPMZ027927;
	Thu, 8 Nov 2007 12:12:25 +0100
Date:	Thu, 8 Nov 2007 11:12:21 +0000 (GMT)
From:	"Maciej W. Rozycki" <macro@linux-mips.org>
To:	Thomas Bogendoerfer <tsbogend@alpha.franken.de>
cc:	Martin Michlmayr <tbm@cyrius.com>,
	Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org
Subject: Re: [PATCH] IP22: Disable EARLY PRINTK, because it breaks serial
 console
In-Reply-To: <20071107215423.GA11915@alpha.franken.de>
Message-ID: <Pine.LNX.4.64N.0711081059120.23511@blysk.ds.pg.gda.pl>
References: <20070911104459.GB7624@alpha.franken.de>
 <20071030073349.GA15984@deprecation.cyrius.com>
 <Pine.LNX.4.64N.0711071648040.14970@blysk.ds.pg.gda.pl>
 <20071107215423.GA11915@alpha.franken.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Virus-Scanned: ClamAV 0.91.2/4708/Thu Nov  8 07:07:54 2007 on piorun.ds.pg.gda.pl
X-Virus-Status:	Clean
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 17448
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Wed, 7 Nov 2007, Thomas Bogendoerfer wrote:

> having a more generic zilog driver with platform backends is quite high on
> my todo list. But I won't make promisses when this happens...

 Synchronous and DMA operation is the tough part, at least for the 
DECstation.  OTOH, such a framework actually exists already as 
drivers/net/wan/z85230.[ch], but fitting it into the serial subsystem is a 
lot of work as the serial core currently has no notion of synchronous 
modes at all.  Ultimately you'd like to be able to switch between 
asynchronous and synchronous line disciplines on a port by port basis 
(possibly including halves of the same chip).

  Maciej
