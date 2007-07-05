Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 06 Jul 2007 15:12:25 +0100 (BST)
Received: from phoenix.bawue.net ([193.7.176.60]:26542 "EHLO mail.bawue.net")
	by ftp.linux-mips.org with ESMTP id S20021638AbXGFOMV (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Fri, 6 Jul 2007 15:12:21 +0100
Received: from lagash (intrt.mips-uk.com [194.74.144.130])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.bawue.net (Postfix) with ESMTP id 4CE3F85E85;
	Fri,  6 Jul 2007 16:09:43 +0200 (CEST)
Received: from ths by lagash with local (Exim 4.67)
	(envelope-from <ths@networkno.de>)
	id 1I6YGR-0004ZK-5a; Thu, 05 Jul 2007 21:49:23 +0100
Date:	Thu, 5 Jul 2007 21:49:23 +0100
From:	Thiemo Seufer <ths@networkno.de>
To:	Ralf Baechle <ralf@linux-mips.org>
Cc:	Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>,
	linux-mips <linux-mips@linux-mips.org>
Subject: Re: [RFC] add to Category:Deprecated
Message-ID: <20070705204922.GC24487@networkno.de>
References: <200707060702.l6672Eq9011401@po-mbox300.hop.2iij.net> <20070706115100.GB8551@linux-mips.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20070706115100.GB8551@linux-mips.org>
User-Agent: Mutt/1.5.16 (2007-06-11)
Return-Path: <ths@networkno.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 15634
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ths@networkno.de
Precedence: bulk
X-list: linux-mips

Ralf Baechle wrote:
> On Fri, Jul 06, 2007 at 04:02:14PM +0900, Yoichi Yuasa wrote:
> 
> > There are the older boards that seem to be not maintained. 
> > * NEC DDB5477
> > * LASAT Networks paltform
> 
> Last I checked the Lasat machines were still being used as the Debian
> build daemons.
> 
> Tbm?  Ths?

We used to use LASAT machines, but we replaced them with Broadcom SWARMs
when the LASATs became too slow and their PSUs started to fail.


Thiemo
