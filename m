Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 15 Jan 2008 13:57:25 +0000 (GMT)
Received: from cerber.ds.pg.gda.pl ([153.19.208.18]:13522 "EHLO
	cerber.ds.pg.gda.pl") by ftp.linux-mips.org with ESMTP
	id S20036819AbYAON5Q (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 15 Jan 2008 13:57:16 +0000
Received: from localhost (unknown [127.0.0.17])
	by cerber.ds.pg.gda.pl (Postfix) with ESMTP id 3F45C400BD;
	Tue, 15 Jan 2008 14:57:16 +0100 (CET)
X-Virus-Scanned: amavisd-new at cerber.ds.pg.gda.pl
Received: from cerber.ds.pg.gda.pl ([153.19.208.18])
	by localhost (cerber.ds.pg.gda.pl [153.19.208.18]) (amavisd-new, port 10024)
	with ESMTP id XCKM1lIybyFk; Tue, 15 Jan 2008 14:57:13 +0100 (CET)
Received: from piorun.ds.pg.gda.pl (piorun.ds.pg.gda.pl [153.19.208.8])
	by cerber.ds.pg.gda.pl (Postfix) with ESMTP id 652F1400B8;
	Tue, 15 Jan 2008 14:57:13 +0100 (CET)
Received: from blysk.ds.pg.gda.pl (macro@blysk.ds.pg.gda.pl [153.19.208.6])
	by piorun.ds.pg.gda.pl (8.13.8/8.13.8) with ESMTP id m0FDvGpP022734;
	Tue, 15 Jan 2008 14:57:16 +0100
Date:	Tue, 15 Jan 2008 13:57:08 +0000 (GMT)
From:	"Maciej W. Rozycki" <macro@linux-mips.org>
To:	Dmitri Vorobiev <dmitri.vorobiev@gmail.com>
cc:	Geert Uytterhoeven <geert@linux-m68k.org>,
	Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
	Linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [SPAM] [PATCH][MIPS] Add Atlas to feature-removal-schedule.
In-Reply-To: <478CB437.9080006@gmail.com>
Message-ID: <Pine.LNX.4.64N.0801151338150.23975@blysk.ds.pg.gda.pl>
References: <478BD0D2.2060004@gmail.com> <Pine.LNX.4.64.0801142302001.2335@anakin>
 <478BEDD7.6070100@gmail.com> <Pine.LNX.4.64N.0801151156460.23975@blysk.ds.pg.gda.pl>
 <478CB437.9080006@gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Virus-Scanned: ClamAV 0.92/5483/Mon Jan 14 15:45:01 2008 on piorun.ds.pg.gda.pl
X-Virus-Status:	Clean
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 18056
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Tue, 15 Jan 2008, Dmitri Vorobiev wrote:

> 1) I would like to make a massive cleanup in the arch/mips/mips-boards
>    for the reasons explained here:
> 
> http://www.linux-mips.org/archives/linux-mips/2008-01/msg00136.html

 You are certainly welcome to do so!

> 2) Removing Atlas would reduce the clean-up effort.

 You can make it a bonus project ;-) -- I would certainly do some testing 
with real hardware if pieces of software start flying by.

> 3) According to Ralf, the user base for Atlas is zero, the board itself
>    is buggy.

 The Ethernet controller embedded in the onboard SAA9730 chip is 
questionable, though some of the problems are apparently the result of our 
buggy driver.  For example the settings of the PHY chip are not 
synchronised to what is set in the MAC.  I cleaned up a lot of cruft at 
one point, but more can apparently be done.  Switching to PHYLIB could 
help and is on my to-do list.  The PHY is a QS6612 and is already 
supported by PHYLIB.

 Otherwise the board is just fine, though perhaps a little bit strange -- 
no south bridge for example (i.e. no subtractive ISA/LPC decoding, nor 
8259A or 8237A cores within), though the SAA9730 does implicit active 
decoding (i.e. not through PCI BARs) of some addresses that used to be 
assigned to motherboard devices in the PC/AT architecture (most notably 
the keyboard controller).  Essentially a PCI-based junk I/O controller of 
some sort.

> 4) History knows of an attempt to remove Atlas:
> 
> http://www.linux-mips.org/archives/linux-mips/2007-06/msg00153.html

 Yes, I know.

> 5) Nobody is losing, man-hours are saved. No explanation of why not to do that.
>    Hence, the patch to the feature-removal-schedule.txt.

 Well, I am always uneasy about removing stuff that is sufficiently 
different from what keeps being supported as quite frequently apparently 
oversimplification decisions are made afterwards which make the addition 
of support for less usual designs that appear later on unnecessarily 
painful.

> It would be nice if you could take a look at that (please see the "P.S." part):
> 
> http://git.kernel.org/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commit;h=84c21e254205ecac98f75b01589996440c6a6db0

 I have seen this, thanks.  I'll have look, time permitting.

  Maciej
