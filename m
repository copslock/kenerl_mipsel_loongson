Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 01 Oct 2007 20:09:42 +0100 (BST)
Received: from cerber.ds.pg.gda.pl ([153.19.208.18]:25275 "EHLO
	cerber.ds.pg.gda.pl") by ftp.linux-mips.org with ESMTP
	id S20021799AbXJATJe (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 1 Oct 2007 20:09:34 +0100
Received: from localhost (unknown [127.0.0.17])
	by cerber.ds.pg.gda.pl (Postfix) with ESMTP id D6492400A9;
	Mon,  1 Oct 2007 21:09:05 +0200 (CEST)
X-Virus-Scanned: amavisd-new at cerber.ds.pg.gda.pl
Received: from cerber.ds.pg.gda.pl ([153.19.208.18])
	by localhost (cerber.ds.pg.gda.pl [153.19.208.18]) (amavisd-new, port 10024)
	with ESMTP id hOPhRCtRomdI; Mon,  1 Oct 2007 21:08:59 +0200 (CEST)
Received: from piorun.ds.pg.gda.pl (piorun.ds.pg.gda.pl [153.19.208.8])
	by cerber.ds.pg.gda.pl (Postfix) with ESMTP id 893F840040;
	Mon,  1 Oct 2007 21:08:59 +0200 (CEST)
Received: from blysk.ds.pg.gda.pl (macro@blysk.ds.pg.gda.pl [153.19.208.6])
	by piorun.ds.pg.gda.pl (8.13.8/8.13.8) with ESMTP id l91J92iJ006517;
	Mon, 1 Oct 2007 21:09:03 +0200
Date:	Mon, 1 Oct 2007 20:08:55 +0100 (BST)
From:	"Maciej W. Rozycki" <macro@linux-mips.org>
To:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
cc:	rongkai.zhan@windriver.com, i2c@lm-sensors.org,
	linux-mips@linux-mips.org, rtc-linux@googlegroups.com,
	ralf@linux-mips.org, a.zummo@towertech.it
Subject: Re: [PATCH 4/4] MIPS: Remove the legacy RTC codes of MIPS sibyte
 boards
In-Reply-To: <20071002.003020.21363605.anemo@mba.ocn.ne.jp>
Message-ID: <Pine.LNX.4.64N.0710012001300.27280@blysk.ds.pg.gda.pl>
References: <46FF7283.7050702@windriver.com> <Pine.LNX.4.64N.0710011608130.27280@blysk.ds.pg.gda.pl>
 <20071002.003020.21363605.anemo@mba.ocn.ne.jp>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Virus-Scanned: ClamAV 0.91.2/4445/Mon Oct  1 10:32:46 2007 on piorun.ds.pg.gda.pl
X-Virus-Status:	Clean
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 16779
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Tue, 2 Oct 2007, Atsushi Nemoto wrote:

> >  Is the system time still set correctly from the RTC chip upon bootstrap 
> > with your changes?  I cannot immediately infer it from the patches and my 
> > suspicion is it may not anymore.
> 
> CONFIG_RTC_HCTOSYS=y can do it, isn't it?

 Hmm, I wonder whether this shouldn't be enabled via a reverse dependency.  
Or even unconditionally perhaps -- if the initial system time gets set 
from incorrect RTC time (e.g. because it is not battery-backed) it does 
not get less correct than it would be otherwise, does it?

 Any reason for not doing either of these?

  Maciej
