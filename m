Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 15 Oct 2007 17:19:58 +0100 (BST)
Received: from cerber.ds.pg.gda.pl ([153.19.208.18]:40341 "EHLO
	cerber.ds.pg.gda.pl") by ftp.linux-mips.org with ESMTP
	id S20036632AbXJOQTt (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 15 Oct 2007 17:19:49 +0100
Received: from localhost (unknown [127.0.0.17])
	by cerber.ds.pg.gda.pl (Postfix) with ESMTP id C44EC400DE;
	Mon, 15 Oct 2007 18:19:50 +0200 (CEST)
X-Virus-Scanned: amavisd-new at cerber.ds.pg.gda.pl
Received: from cerber.ds.pg.gda.pl ([153.19.208.18])
	by localhost (cerber.ds.pg.gda.pl [153.19.208.18]) (amavisd-new, port 10024)
	with ESMTP id L4pDNVUa0VAT; Mon, 15 Oct 2007 18:19:45 +0200 (CEST)
Received: from piorun.ds.pg.gda.pl (piorun.ds.pg.gda.pl [153.19.208.8])
	by cerber.ds.pg.gda.pl (Postfix) with ESMTP id 4E56240085;
	Mon, 15 Oct 2007 18:19:45 +0200 (CEST)
Received: from blysk.ds.pg.gda.pl (macro@blysk.ds.pg.gda.pl [153.19.208.6])
	by piorun.ds.pg.gda.pl (8.13.8/8.13.8) with ESMTP id l9FGJn5O025026;
	Mon, 15 Oct 2007 18:19:49 +0200
Date:	Mon, 15 Oct 2007 17:19:43 +0100 (BST)
From:	"Maciej W. Rozycki" <macro@linux-mips.org>
To:	Ralf Baechle <ralf@linux-mips.org>
cc:	Adrian Bunk <bunk@kernel.org>, linux-mips@linux-mips.org,
	linux-kernel@vger.kernel.org
Subject: Re: -git mips defconfig compile error
In-Reply-To: <20071015095535.GB9896@linux-mips.org>
Message-ID: <Pine.LNX.4.64N.0710151715200.16262@blysk.ds.pg.gda.pl>
References: <20071014131948.GF4211@stusta.de> <20071015095535.GB9896@linux-mips.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Virus-Scanned: ClamAV 0.91.2/4540/Sun Oct 14 03:43:55 2007 on piorun.ds.pg.gda.pl
X-Virus-Status:	Clean
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 17043
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Mon, 15 Oct 2007, Ralf Baechle wrote:

> The logo.c bit I've sent out a few weeks ago so I'm just waiting for that
> patch to resurface at the other end of the wormhole.

 Hmm, I would have waited for this to happen before committing the change 
depending on it not to keep things known-broken then...  That's what I do 
with my bits, e.g. I have an update to platform code waiting till 
sb1250-mac.c changes come over here.

  Maciej
