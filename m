Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 07 Nov 2007 17:21:41 +0000 (GMT)
Received: from cerber.ds.pg.gda.pl ([153.19.208.18]:7136 "EHLO
	cerber.ds.pg.gda.pl") by ftp.linux-mips.org with ESMTP
	id S20029312AbXKGRVc (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 7 Nov 2007 17:21:32 +0000
Received: from localhost (unknown [127.0.0.17])
	by cerber.ds.pg.gda.pl (Postfix) with ESMTP id 412B44007F;
	Wed,  7 Nov 2007 18:21:33 +0100 (CET)
X-Virus-Scanned: amavisd-new at cerber.ds.pg.gda.pl
Received: from cerber.ds.pg.gda.pl ([153.19.208.18])
	by localhost (cerber.ds.pg.gda.pl [153.19.208.18]) (amavisd-new, port 10024)
	with ESMTP id ikCVI9WG9jEO; Wed,  7 Nov 2007 18:21:23 +0100 (CET)
Received: from piorun.ds.pg.gda.pl (piorun.ds.pg.gda.pl [153.19.208.8])
	by cerber.ds.pg.gda.pl (Postfix) with ESMTP id 979434007E;
	Wed,  7 Nov 2007 18:21:23 +0100 (CET)
Received: from blysk.ds.pg.gda.pl (macro@blysk.ds.pg.gda.pl [153.19.208.6])
	by piorun.ds.pg.gda.pl (8.13.8/8.13.8) with ESMTP id lA7HLRAl027110;
	Wed, 7 Nov 2007 18:21:28 +0100
Date:	Wed, 7 Nov 2007 17:21:22 +0000 (GMT)
From:	"Maciej W. Rozycki" <macro@linux-mips.org>
To:	Giuseppe Sacco <giuseppe@eppesuigoccas.homedns.org>
cc:	mips kernel list <linux-mips@linux-mips.org>
Subject: Re: Preliminary patch for ip32 ttyS* device
In-Reply-To: <1194446585.5849.21.camel@scarafaggio>
Message-ID: <Pine.LNX.4.64N.0711071716470.14970@blysk.ds.pg.gda.pl>
References: <20071030214015.050b7950.giuseppe@eppesuigoccas.homedns.org> 
 <20071031130828.GE14187@linux-mips.org> <1194446585.5849.21.camel@scarafaggio>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Virus-Scanned: ClamAV 0.91.2/4691/Wed Nov  7 06:39:41 2007 on piorun.ds.pg.gda.pl
X-Virus-Status:	Clean
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 17438
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Wed, 7 Nov 2007, Giuseppe Sacco wrote:

> I have been investigating about it for one week and I am still not
> convinced that mapbase must be initialised. I tried to understand the
> meaning of mapbase and membase, but I am unsure about the value I should
> set mapbase to.
> 
> I learnt that when specifying mapbase its region would be registered and
> reserved using request_mem_region(). Otherwise, if you do not specify
> mapbase, the region is not reserved. Apart from reserving the memory
> region, mapbase isn't use anymore. Is mapbase mandatory? 
> 
> If mapbase isn't mandatory, the second part of my patch is probably
> right and fixes a bug.

 You ought to use mapbase and ioremap() with new code as you are not 
allowed to use readb()/writeb()/etc. on addresses obtained otherwise than 
by calling ioremap().  The use of request_mem_region(), etc. is not 
strictly mandatory, but it is nice to have.  Many serial drivers use these 
functions, so I cannot see a reason why it would be a hassle for ip32.

  Maciej
