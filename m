Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 08 Feb 2008 11:05:31 +0000 (GMT)
Received: from cerber.ds.pg.gda.pl ([153.19.208.18]:24450 "EHLO
	cerber.ds.pg.gda.pl") by ftp.linux-mips.org with ESMTP
	id S28575405AbYBHLFX (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 8 Feb 2008 11:05:23 +0000
Received: from localhost (unknown [127.0.0.17])
	by cerber.ds.pg.gda.pl (Postfix) with ESMTP id 5FEF040044;
	Fri,  8 Feb 2008 12:05:22 +0100 (CET)
X-Virus-Scanned: amavisd-new at cerber.ds.pg.gda.pl
Received: from cerber.ds.pg.gda.pl ([153.19.208.18])
	by localhost (cerber.ds.pg.gda.pl [153.19.208.18]) (amavisd-new, port 10024)
	with ESMTP id mMUlYh5B2G0D; Fri,  8 Feb 2008 12:05:15 +0100 (CET)
Received: from piorun.ds.pg.gda.pl (piorun.ds.pg.gda.pl [153.19.208.8])
	by cerber.ds.pg.gda.pl (Postfix) with ESMTP id AA0E6400BE;
	Fri,  8 Feb 2008 12:05:15 +0100 (CET)
Received: from blysk.ds.pg.gda.pl (macro@blysk.ds.pg.gda.pl [153.19.208.6])
	by piorun.ds.pg.gda.pl (8.13.8/8.13.8) with ESMTP id m18B5II7000451;
	Fri, 8 Feb 2008 12:05:18 +0100
Date:	Fri, 8 Feb 2008 11:05:12 +0000 (GMT)
From:	"Maciej W. Rozycki" <macro@linux-mips.org>
To:	Florian Fainelli <florian.fainelli@telecomint.eu>
cc:	linux-mips@linux-mips.org
Subject: Re: early_ioremap for MIPS
In-Reply-To: <200802071932.23965.florian.fainelli@telecomint.eu>
Message-ID: <Pine.LNX.4.64N.0802081058350.7017@blysk.ds.pg.gda.pl>
References: <200802071932.23965.florian.fainelli@telecomint.eu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Virus-Scanned: ClamAV 0.92/5739/Fri Feb  8 11:19:58 2008 on piorun.ds.pg.gda.pl
X-Virus-Status:	Clean
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 18201
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Thu, 7 Feb 2008, Florian Fainelli wrote:

> Is there any need for early_ioremap on MIPS ? Seems like only x86_64 is 
> implementing it for now.

 There is hardly any need as generally KSEG0/KSEG1 and XPHYS mappings 
fulfil the need and are always available, even before paging has been 
initialised.  Some 32-bit systems with devices outside low 512MB of 
physical address space could potentially benefit though.  I recall some 
Alchemy systems may fall into this category.

  Maciej
