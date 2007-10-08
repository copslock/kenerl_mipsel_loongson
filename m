Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 08 Oct 2007 14:27:20 +0100 (BST)
Received: from cerber.ds.pg.gda.pl ([153.19.208.18]:3228 "EHLO
	cerber.ds.pg.gda.pl") by ftp.linux-mips.org with ESMTP
	id S20030010AbXJHN1L (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 8 Oct 2007 14:27:11 +0100
Received: from localhost (unknown [127.0.0.17])
	by cerber.ds.pg.gda.pl (Postfix) with ESMTP id DE5D74023B;
	Mon,  8 Oct 2007 15:27:11 +0200 (CEST)
X-Virus-Scanned: amavisd-new at cerber.ds.pg.gda.pl
Received: from cerber.ds.pg.gda.pl ([153.19.208.18])
	by localhost (cerber.ds.pg.gda.pl [153.19.208.18]) (amavisd-new, port 10024)
	with ESMTP id LzVxHPelrcR0; Mon,  8 Oct 2007 15:27:05 +0200 (CEST)
Received: from piorun.ds.pg.gda.pl (piorun.ds.pg.gda.pl [153.19.208.8])
	by cerber.ds.pg.gda.pl (Postfix) with ESMTP id 695564023F;
	Mon,  8 Oct 2007 15:27:05 +0200 (CEST)
Received: from blysk.ds.pg.gda.pl (macro@blysk.ds.pg.gda.pl [153.19.208.6])
	by piorun.ds.pg.gda.pl (8.13.8/8.13.8) with ESMTP id l98DR81P027902;
	Mon, 8 Oct 2007 15:27:08 +0200
Date:	Mon, 8 Oct 2007 14:27:04 +0100 (BST)
From:	"Maciej W. Rozycki" <macro@linux-mips.org>
To:	Giuseppe Sacco <giuseppe@eppesuigoccas.homedns.org>
cc:	Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org
Subject: Re: [PATCH]v2 mips/ip32: enable PCI bridges
In-Reply-To: <E1IeDrj-0002u6-2B@eppesuigoccas.homedns.org>
Message-ID: <Pine.LNX.4.64N.0710081422290.8873@blysk.ds.pg.gda.pl>
References: <E1IeDrj-0002u6-2B@eppesuigoccas.homedns.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Virus-Scanned: ClamAV 0.91.2/4502/Mon Oct  8 03:52:34 2007 on piorun.ds.pg.gda.pl
X-Virus-Status:	Clean
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 16882
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Sat, 6 Oct 2007, Giuseppe Sacco wrote:

> @@ -33,7 +33,7 @@ static inline int mkaddr(struct pci_bus *bus, unsigned int devfn,
>  	unsigned int reg)
>  {
>  	return ((bus->number & 0xff) << 16) |
> -		(devfn & 0xff) << 8) |
> +		((devfn & 0xff) << 8) |
>  		(reg & 0xfc);
>  }

 Bad formatting -- using correct one would make the typo more obvious 
(ditto about the function's header).

  Maciej
