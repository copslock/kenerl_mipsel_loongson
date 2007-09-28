Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 28 Sep 2007 17:23:47 +0100 (BST)
Received: from cerber.ds.pg.gda.pl ([153.19.208.18]:11231 "EHLO
	cerber.ds.pg.gda.pl") by ftp.linux-mips.org with ESMTP
	id S20027275AbXI1QXi (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 28 Sep 2007 17:23:38 +0100
Received: from localhost (unknown [127.0.0.17])
	by cerber.ds.pg.gda.pl (Postfix) with ESMTP id 4E928400A7;
	Fri, 28 Sep 2007 18:23:09 +0200 (CEST)
X-Virus-Scanned: amavisd-new at cerber.ds.pg.gda.pl
Received: from cerber.ds.pg.gda.pl ([153.19.208.18])
	by localhost (cerber.ds.pg.gda.pl [153.19.208.18]) (amavisd-new, port 10024)
	with ESMTP id M0dqAJOrWqyr; Fri, 28 Sep 2007 18:23:03 +0200 (CEST)
Received: from piorun.ds.pg.gda.pl (piorun.ds.pg.gda.pl [153.19.208.8])
	by cerber.ds.pg.gda.pl (Postfix) with ESMTP id 5E4F440096;
	Fri, 28 Sep 2007 18:23:03 +0200 (CEST)
Received: from blysk.ds.pg.gda.pl (macro@blysk.ds.pg.gda.pl [153.19.208.6])
	by piorun.ds.pg.gda.pl (8.13.8/8.13.8) with ESMTP id l8SGN64M012602;
	Fri, 28 Sep 2007 18:23:06 +0200
Date:	Fri, 28 Sep 2007 17:23:00 +0100 (BST)
From:	"Maciej W. Rozycki" <macro@linux-mips.org>
To:	Andrew Morton <akpm@linux-foundation.org>
cc:	Jeff Garzik <jgarzik@pobox.com>, netdev@vger.kernel.org,
	linux-mips@linux-mips.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sb1250-mac: Driver model & phylib update
In-Reply-To: <20070924095559.c81f7061.akpm@linux-foundation.org>
Message-ID: <Pine.LNX.4.64N.0709281628130.10439@blysk.ds.pg.gda.pl>
References: <Pine.LNX.4.64N.0709191811040.24627@blysk.ds.pg.gda.pl>
 <20070921124409.7f3d122b.akpm@linux-foundation.org>
 <Pine.LNX.4.64N.0709241529570.22491@blysk.ds.pg.gda.pl>
 <20070924095559.c81f7061.akpm@linux-foundation.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Virus-Scanned: ClamAV 0.91.2/4419/Fri Sep 28 09:36:28 2007 on piorun.ds.pg.gda.pl
X-Virus-Status:	Clean
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 16728
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Mon, 24 Sep 2007, Andrew Morton wrote:

> >  Well, this is against Jeff's netdev-2.6 tree which hopefully is not as 
> > crufty as Linus's old mainline; if it is not possible to queue this change 
> > for 2.6.25 or suchlike, then I will try to resubmit later.
> 
> Most of Jeff's netdev tree got dumped into Dave's net-2.6.24 tree.  That's
> the one you want to be raising patches against for the next few weeks.

 OK, thanks for clarification.  Then both patches already submitted:

patch-netdev-2.6.23-rc6-20070920-sb1250-mac-typedef-9
patch-netdev-2.6.23-rc6-20070920-sb1250-mac-29

apply cleanly to net-2.6.24 one on top of the other in this order.

 I can resubmit them -- where?  netdev?  As I say I am fine with 2.6.25 as 
the target.

  Maciej
