Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 15 Jan 2008 17:52:23 +0000 (GMT)
Received: from cerber.ds.pg.gda.pl ([153.19.208.18]:63954 "EHLO
	cerber.ds.pg.gda.pl") by ftp.linux-mips.org with ESMTP
	id S20035761AbYAORwN (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 15 Jan 2008 17:52:13 +0000
Received: from localhost (unknown [127.0.0.17])
	by cerber.ds.pg.gda.pl (Postfix) with ESMTP id A0ED4400BD;
	Tue, 15 Jan 2008 18:52:14 +0100 (CET)
X-Virus-Scanned: amavisd-new at cerber.ds.pg.gda.pl
Received: from cerber.ds.pg.gda.pl ([153.19.208.18])
	by localhost (cerber.ds.pg.gda.pl [153.19.208.18]) (amavisd-new, port 10024)
	with ESMTP id MHOsrp9ZSZ81; Tue, 15 Jan 2008 18:52:12 +0100 (CET)
Received: from piorun.ds.pg.gda.pl (piorun.ds.pg.gda.pl [153.19.208.8])
	by cerber.ds.pg.gda.pl (Postfix) with ESMTP id 1215B400B8;
	Tue, 15 Jan 2008 18:52:12 +0100 (CET)
Received: from blysk.ds.pg.gda.pl (macro@blysk.ds.pg.gda.pl [153.19.208.6])
	by piorun.ds.pg.gda.pl (8.13.8/8.13.8) with ESMTP id m0FHqGBx024780;
	Tue, 15 Jan 2008 18:52:16 +0100
Date:	Tue, 15 Jan 2008 17:52:04 +0000 (GMT)
From:	"Maciej W. Rozycki" <macro@linux-mips.org>
To:	Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
cc:	Karsten Merker <merker@debian.org>,
	Thiemo Seufer <ths@networkno.de>,
	Linux/MIPS Development <linux-mips@linux-mips.org>
Subject: Re: pmag-aa-fb
In-Reply-To: <Pine.LNX.4.64.0801151831370.12445@vixen.sonytel.be>
Message-ID: <Pine.LNX.4.64N.0801151743480.23975@blysk.ds.pg.gda.pl>
References: <Pine.LNX.4.64.0801151831370.12445@vixen.sonytel.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Virus-Scanned: ClamAV 0.92/5483/Mon Jan 14 15:45:01 2008 on piorun.ds.pg.gda.pl
X-Virus-Status:	Clean
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 18062
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Tue, 15 Jan 2008, Geert Uytterhoeven wrote:

> I've just noticed drivers/video/pmag-aa-fb.c is the single remaining frame
> buffer device driver that still uses the old 2.4 API (all others have been
> converted or removed). So it doesn't work anymore.
> 
> Does anyone still care about it?

 Probably.  I have the right piece of hardware (thanks, Thiemo), but 
little time these days.  I mean to have a look at it, but I have no 
timeline, sorry.  I started converting it at one point, but I recall I 
stumbled on porting the hardware cursor support that turned out to be 
unsupported with the new API or something.

  Maciej
