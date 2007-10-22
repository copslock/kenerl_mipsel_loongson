Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 22 Oct 2007 16:07:19 +0100 (BST)
Received: from cerber.ds.pg.gda.pl ([153.19.208.18]:43493 "EHLO
	cerber.ds.pg.gda.pl") by ftp.linux-mips.org with ESMTP
	id S20024710AbXJVPHK (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 22 Oct 2007 16:07:10 +0100
Received: from localhost (unknown [127.0.0.17])
	by cerber.ds.pg.gda.pl (Postfix) with ESMTP id 2C3C7400A9;
	Mon, 22 Oct 2007 17:07:04 +0200 (CEST)
X-Virus-Scanned: amavisd-new at cerber.ds.pg.gda.pl
Received: from cerber.ds.pg.gda.pl ([153.19.208.18])
	by localhost (cerber.ds.pg.gda.pl [153.19.208.18]) (amavisd-new, port 10024)
	with ESMTP id BkILFIHCWsVV; Mon, 22 Oct 2007 17:06:57 +0200 (CEST)
Received: from piorun.ds.pg.gda.pl (piorun.ds.pg.gda.pl [153.19.208.8])
	by cerber.ds.pg.gda.pl (Postfix) with ESMTP id 4081D40085;
	Mon, 22 Oct 2007 17:06:57 +0200 (CEST)
Received: from blysk.ds.pg.gda.pl (macro@blysk.ds.pg.gda.pl [153.19.208.6])
	by piorun.ds.pg.gda.pl (8.13.8/8.13.8) with ESMTP id l9MF70no017132;
	Mon, 22 Oct 2007 17:07:00 +0200
Date:	Mon, 22 Oct 2007 16:06:55 +0100 (BST)
From:	"Maciej W. Rozycki" <macro@linux-mips.org>
To:	Ralf Baechle <ralf@linux-mips.org>
cc:	Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>,
	linux-mips <linux-mips@linux-mips.org>
Subject: Re: [PATCH][MIPS] add GT641xx timer0 clockevent
In-Reply-To: <20071022121451.GA31041@linux-mips.org>
Message-ID: <Pine.LNX.4.64N.0710221605380.988@blysk.ds.pg.gda.pl>
References: <20071022194315.f75738ba.yoichi_yuasa@tripeaks.co.jp>
 <20071022121451.GA31041@linux-mips.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Virus-Scanned: ClamAV 0.91.2/4559/Mon Oct 22 06:02:57 2007 on piorun.ds.pg.gda.pl
X-Virus-Status:	Clean
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 17156
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Mon, 22 Oct 2007, Ralf Baechle wrote:

> > Add GT641xx timer0 clockevent.
> 
> Thanks, applied.

 Ah, we could use this one with the Malta and some CoreLV cards too. ;-)

  Maciej
