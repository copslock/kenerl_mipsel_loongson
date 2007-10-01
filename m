Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 01 Oct 2007 16:10:54 +0100 (BST)
Received: from cerber.ds.pg.gda.pl ([153.19.208.18]:57291 "EHLO
	cerber.ds.pg.gda.pl") by ftp.linux-mips.org with ESMTP
	id S20024201AbXJAPKq (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 1 Oct 2007 16:10:46 +0100
Received: from localhost (unknown [127.0.0.17])
	by cerber.ds.pg.gda.pl (Postfix) with ESMTP id 45110400A9;
	Mon,  1 Oct 2007 17:10:47 +0200 (CEST)
X-Virus-Scanned: amavisd-new at cerber.ds.pg.gda.pl
Received: from cerber.ds.pg.gda.pl ([153.19.208.18])
	by localhost (cerber.ds.pg.gda.pl [153.19.208.18]) (amavisd-new, port 10024)
	with ESMTP id Gkc+ZNB09VqQ; Mon,  1 Oct 2007 17:10:40 +0200 (CEST)
Received: from piorun.ds.pg.gda.pl (piorun.ds.pg.gda.pl [153.19.208.8])
	by cerber.ds.pg.gda.pl (Postfix) with ESMTP id 53C4940040;
	Mon,  1 Oct 2007 17:10:40 +0200 (CEST)
Received: from blysk.ds.pg.gda.pl (macro@blysk.ds.pg.gda.pl [153.19.208.6])
	by piorun.ds.pg.gda.pl (8.13.8/8.13.8) with ESMTP id l91FAhFA027946;
	Mon, 1 Oct 2007 17:10:43 +0200
Date:	Mon, 1 Oct 2007 16:10:38 +0100 (BST)
From:	"Maciej W. Rozycki" <macro@linux-mips.org>
To:	Mark Zhan <rongkai.zhan@windriver.com>
cc:	i2c@lm-sensors.org, linux-mips@linux-mips.org,
	rtc-linux@googlegroups.com, ralf@linux-mips.org,
	a.zummo@towertech.it
Subject: Re: [PATCH 4/4] MIPS: Remove the legacy RTC codes of MIPS sibyte
 boards
In-Reply-To: <46FF7283.7050702@windriver.com>
Message-ID: <Pine.LNX.4.64N.0710011608130.27280@blysk.ds.pg.gda.pl>
References: <46FF7283.7050702@windriver.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Virus-Scanned: ClamAV 0.91.2/4445/Mon Oct  1 10:32:46 2007 on piorun.ds.pg.gda.pl
X-Virus-Status:	Clean
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 16774
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Sun, 30 Sep 2007, Mark Zhan wrote:

> This patch removes the legacy RTC codes of MIPS sibyte boards,
> which are replaced by new RTC class drivers. And a board init
> routine is added to register sibyte platform devices.

 Is the system time still set correctly from the RTC chip upon bootstrap 
with your changes?  I cannot immediately infer it from the patches and my 
suspicion is it may not anymore.

  Maciej
