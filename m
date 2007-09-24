Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 24 Sep 2007 15:42:43 +0100 (BST)
Received: from cerber.ds.pg.gda.pl ([153.19.208.18]:63701 "EHLO
	cerber.ds.pg.gda.pl") by ftp.linux-mips.org with ESMTP
	id S20022886AbXIXOmf (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 24 Sep 2007 15:42:35 +0100
Received: from localhost (unknown [127.0.0.17])
	by cerber.ds.pg.gda.pl (Postfix) with ESMTP id 993AB400B6;
	Mon, 24 Sep 2007 16:42:05 +0200 (CEST)
X-Virus-Scanned: amavisd-new at cerber.ds.pg.gda.pl
Received: from cerber.ds.pg.gda.pl ([153.19.208.18])
	by localhost (cerber.ds.pg.gda.pl [153.19.208.18]) (amavisd-new, port 10024)
	with ESMTP id kQsp83J7W0x9; Mon, 24 Sep 2007 16:42:00 +0200 (CEST)
Received: from piorun.ds.pg.gda.pl (piorun.ds.pg.gda.pl [153.19.208.8])
	by cerber.ds.pg.gda.pl (Postfix) with ESMTP id B9CBD400A9;
	Mon, 24 Sep 2007 16:42:00 +0200 (CEST)
Received: from blysk.ds.pg.gda.pl (macro@blysk.ds.pg.gda.pl [153.19.208.6])
	by piorun.ds.pg.gda.pl (8.13.8/8.13.8) with ESMTP id l8OEg4Yv023517;
	Mon, 24 Sep 2007 16:42:04 +0200
Date:	Mon, 24 Sep 2007 15:41:54 +0100 (BST)
From:	"Maciej W. Rozycki" <macro@linux-mips.org>
To:	Andrew Morton <akpm@linux-foundation.org>
cc:	Jeff Garzik <jgarzik@pobox.com>, netdev@vger.kernel.org,
	linux-mips@linux-mips.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sb1250-mac: Driver model & phylib update
In-Reply-To: <20070921124409.7f3d122b.akpm@linux-foundation.org>
Message-ID: <Pine.LNX.4.64N.0709241529570.22491@blysk.ds.pg.gda.pl>
References: <Pine.LNX.4.64N.0709191811040.24627@blysk.ds.pg.gda.pl>
 <20070921124409.7f3d122b.akpm@linux-foundation.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Virus-Scanned: ClamAV 0.91.2/4378/Mon Sep 24 14:25:35 2007 on piorun.ds.pg.gda.pl
X-Virus-Status:	Clean
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 16643
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Fri, 21 Sep 2007, Andrew Morton wrote:

> >  A driver model and phylib update.
> 
> akpm:/usr/src/25> diffstat patches/git-net.patch | tail -n 1
>  1013 files changed, 187667 insertions(+), 23587 deletions(-)
> 
> Sorry, but raising networking patches against Linus's crufty
> old mainline tree just isn't viable at present.

 Well, this is against Jeff's netdev-2.6 tree which hopefully is not as 
crufty as Linus's old mainline; if it is not possible to queue this change 
for 2.6.25 or suchlike, then I will try to resubmit later.  Thanks for 
your attention though.

  Maciej
