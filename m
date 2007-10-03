Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 03 Oct 2007 14:55:28 +0100 (BST)
Received: from cerber.ds.pg.gda.pl ([153.19.208.18]:45246 "EHLO
	cerber.ds.pg.gda.pl") by ftp.linux-mips.org with ESMTP
	id S20021561AbXJCNzT (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 3 Oct 2007 14:55:19 +0100
Received: from localhost (unknown [127.0.0.17])
	by cerber.ds.pg.gda.pl (Postfix) with ESMTP id 3DF3B4012E;
	Wed,  3 Oct 2007 15:55:20 +0200 (CEST)
X-Virus-Scanned: amavisd-new at cerber.ds.pg.gda.pl
Received: from cerber.ds.pg.gda.pl ([153.19.208.18])
	by localhost (cerber.ds.pg.gda.pl [153.19.208.18]) (amavisd-new, port 10024)
	with ESMTP id XRvdaZQS4jvP; Wed,  3 Oct 2007 15:55:14 +0200 (CEST)
Received: from piorun.ds.pg.gda.pl (piorun.ds.pg.gda.pl [153.19.208.8])
	by cerber.ds.pg.gda.pl (Postfix) with ESMTP id 9AB48400FE;
	Wed,  3 Oct 2007 15:55:14 +0200 (CEST)
Received: from blysk.ds.pg.gda.pl (macro@blysk.ds.pg.gda.pl [153.19.208.6])
	by piorun.ds.pg.gda.pl (8.13.8/8.13.8) with ESMTP id l93DtFKg029802;
	Wed, 3 Oct 2007 15:55:16 +0200
Date:	Wed, 3 Oct 2007 14:55:11 +0100 (BST)
From:	"Maciej W. Rozycki" <macro@linux-mips.org>
To:	Alessandro Zummo <alessandro.zummo@towertech.it>
cc:	rtc-linux@googlegroups.com, Atsushi Nemoto <anemo@mba.ocn.ne.jp>,
	rongkai.zhan@windriver.com, i2c@lm-sensors.org,
	linux-mips@linux-mips.org, ralf@linux-mips.org,
	a.zummo@towertech.it
Subject: Re: [rtc-linux] Re: [PATCH 4/4] MIPS: Remove the legacy RTC codes
 of MIPS sibyte boards
In-Reply-To: <20071002151415.672d0a1e@i1501.lan.towertech.it>
Message-ID: <Pine.LNX.4.64N.0710031454220.6611@blysk.ds.pg.gda.pl>
References: <46FF7283.7050702@windriver.com> <Pine.LNX.4.64N.0710011608130.27280@blysk.ds.pg.gda.pl>
 <20071002.003020.21363605.anemo@mba.ocn.ne.jp>
 <Pine.LNX.4.64N.0710012001300.27280@blysk.ds.pg.gda.pl>
 <20071002151415.672d0a1e@i1501.lan.towertech.it>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Virus-Scanned: ClamAV 0.91.2/4461/Wed Oct  3 10:50:48 2007 on piorun.ds.pg.gda.pl
X-Virus-Status:	Clean
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 16827
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Tue, 2 Oct 2007, Alessandro Zummo wrote:

>  CONFIG_RTC_HCTOSYS defaults to YES, it should be enough...?

 Well, yes, probably...

  Maciej
