Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 19 Jul 2005 16:04:47 +0100 (BST)
Received: from pollux.ds.pg.gda.pl ([IPv6:::ffff:153.19.208.7]:36621 "EHLO
	pollux.ds.pg.gda.pl") by linux-mips.org with ESMTP
	id <S8226834AbVGSPEb>; Tue, 19 Jul 2005 16:04:31 +0100
Received: from localhost (localhost [127.0.0.1])
	by pollux.ds.pg.gda.pl (Postfix) with ESMTP
	id 28C4FE1CB8; Tue, 19 Jul 2005 17:06:10 +0200 (CEST)
Received: from pollux.ds.pg.gda.pl ([127.0.0.1])
 by localhost (pollux [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
 id 15467-03; Tue, 19 Jul 2005 17:06:10 +0200 (CEST)
Received: from piorun.ds.pg.gda.pl (piorun.ds.pg.gda.pl [153.19.208.8])
	by pollux.ds.pg.gda.pl (Postfix) with ESMTP
	id BA633E1CB5; Tue, 19 Jul 2005 17:06:09 +0200 (CEST)
Received: from blysk.ds.pg.gda.pl (macro@blysk.ds.pg.gda.pl [153.19.208.6])
	by piorun.ds.pg.gda.pl (8.13.3/8.13.1) with ESMTP id j6JF6CHB027715;
	Tue, 19 Jul 2005 17:06:13 +0200
Date:	Tue, 19 Jul 2005 16:06:21 +0100 (BST)
From:	"Maciej W. Rozycki" <macro@linux-mips.org>
To:	Jan-Benedict Glaw <jbglaw@lug-owl.de>
Cc:	linux-mips@linux-mips.org
Subject: Re: Updating RTC with date command
In-Reply-To: <20050719144230.GE20065@lug-owl.de>
Message-ID: <Pine.LNX.4.61L.0507191555360.10363@blysk.ds.pg.gda.pl>
References: <CBD77117272E1249BFDC21E33D555FDC06018D@dbde01.ent.ti.com>
 <20050719143110.GD3108@linux-mips.org> <20050719144230.GE20065@lug-owl.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; CHARSET=US-ASCII
Content-ID: <Pine.LNX.4.61L.0507191602281.10363@blysk.ds.pg.gda.pl>
X-Virus-Scanned: ClamAV 0.85.1/984/Tue Jul 19 11:16:09 2005 on piorun.ds.pg.gda.pl
X-Virus-Status:	Clean
X-Virus-Scanned: by amavisd-new at pollux.ds.pg.gda.pl
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 8553
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Tue, 19 Jul 2005, Jan-Benedict Glaw wrote:

> hwclock is the userspace utility to manually once set the time. In
> normal operation, this should only be called _once_, after the system is
> switched on for the very first time.

 Well, `hwclock' should normally be used to update the RTC every time 
after a manual system clock update.

> During lifetime, ntpd should execute and thus the system's current time
> will be written to the HW clock every now and then. Additionally, most

 Note that ntpd only updates minutes and seconds and then only if the 
difference is small -- to account for the existence of time zones and a 
system-specific relation between the time recoreded by the system and one 
handled by the RTC.  Also the feature is broken by design -- ntpd 
shouldn't do that at all in principle and in practice it leads to the 
system time being corrupted on some machines using an RTC interrupt for 
the system timer tick.

> distributions seem to also update the HW clock at system shutdown time.

 Which is where it should really happen.

> So the correct solution to your problem is to either shutdown once
> (workaround) or keep ntpd running (the solution[tm]).

 I think you've got the figures reversed (well, it's useful to have ntpd 
running, but it should not fiddle with the RTC).

  Maciej
