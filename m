Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 11 Feb 2008 10:27:56 +0000 (GMT)
Received: from cerber.ds.pg.gda.pl ([153.19.208.18]:7657 "EHLO
	cerber.ds.pg.gda.pl") by ftp.linux-mips.org with ESMTP
	id S20024449AbYBKK1s (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 11 Feb 2008 10:27:48 +0000
Received: from localhost (unknown [127.0.0.17])
	by cerber.ds.pg.gda.pl (Postfix) with ESMTP id 882E840091;
	Mon, 11 Feb 2008 11:27:47 +0100 (CET)
X-Virus-Scanned: amavisd-new at cerber.ds.pg.gda.pl
Received: from cerber.ds.pg.gda.pl ([153.19.208.18])
	by localhost (cerber.ds.pg.gda.pl [153.19.208.18]) (amavisd-new, port 10024)
	with ESMTP id qNkqO7aD5Si4; Mon, 11 Feb 2008 11:27:42 +0100 (CET)
Received: from piorun.ds.pg.gda.pl (piorun.ds.pg.gda.pl [153.19.208.8])
	by cerber.ds.pg.gda.pl (Postfix) with ESMTP id 79D1F40082;
	Mon, 11 Feb 2008 11:27:42 +0100 (CET)
Received: from blysk.ds.pg.gda.pl (macro@blysk.ds.pg.gda.pl [153.19.208.6])
	by piorun.ds.pg.gda.pl (8.13.8/8.13.8) with ESMTP id m1BARiV5027707;
	Mon, 11 Feb 2008 11:27:45 +0100
Date:	Mon, 11 Feb 2008 10:27:41 +0000 (GMT)
From:	"Maciej W. Rozycki" <macro@linux-mips.org>
To:	"M. Warner Losh" <imp@bsdimp.com>
cc:	florian.fainelli@telecomint.eu, linux-mips@linux-mips.org
Subject: Re: early_ioremap for MIPS
In-Reply-To: <20080210.154401.1655407815.imp@bsdimp.com>
Message-ID: <Pine.LNX.4.64N.0802111022550.13679@blysk.ds.pg.gda.pl>
References: <200802071932.23965.florian.fainelli@telecomint.eu>
 <Pine.LNX.4.64N.0802081058350.7017@blysk.ds.pg.gda.pl>
 <20080210.154401.1655407815.imp@bsdimp.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Virus-Scanned: ClamAV 0.92/5768/Mon Feb 11 07:31:03 2008 on piorun.ds.pg.gda.pl
X-Virus-Status:	Clean
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 18212
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Sun, 10 Feb 2008, M. Warner Losh wrote:

> :  There is hardly any need as generally KSEG0/KSEG1 and XPHYS mappings 
> : fulfil the need and are always available, even before paging has been 
> : initialised.  Some 32-bit systems with devices outside low 512MB of 
> : physical address space could potentially benefit though.  I recall some 
> : Alchemy systems may fall into this category.
> 
> The Acer Pica machines, as well as the Deskstation Tynes, had devices
> mapped outside of this range...  Of course Ralf will be able to say
> more, if he chooses to jump into the way-back machine...

 Please note that it is not the sole existence of some hardware in the 
physical address range inaccessible through the mapped space that matters 
here.  It is the need to use such a piece of hardware before paging has 
been initialised that is of concern for early ioremap() and for most 
devices it means there is no issue.

  Maciej
