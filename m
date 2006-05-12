Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 12 May 2006 12:57:24 +0200 (CEST)
Received: from pollux.ds.pg.gda.pl ([153.19.208.7]:58889 "HELO
	pollux.ds.pg.gda.pl") by ftp.linux-mips.org with SMTP
	id S8133884AbWELK5L (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 12 May 2006 12:57:11 +0200
Received: from localhost (localhost [127.0.0.1])
	by pollux.ds.pg.gda.pl (Postfix) with ESMTP id CD157F5CD9;
	Fri, 12 May 2006 12:57:06 +0200 (CEST)
Received: from pollux.ds.pg.gda.pl ([127.0.0.1])
 by localhost (pollux.ds.pg.gda.pl [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 01396-07; Fri, 12 May 2006 12:57:06 +0200 (CEST)
Received: from piorun.ds.pg.gda.pl (piorun.ds.pg.gda.pl [153.19.208.8])
	by pollux.ds.pg.gda.pl (Postfix) with ESMTP id 79301F5CC8;
	Fri, 12 May 2006 12:57:06 +0200 (CEST)
Received: from blysk.ds.pg.gda.pl (macro@blysk.ds.pg.gda.pl [153.19.208.6])
	by piorun.ds.pg.gda.pl (8.13.6/8.13.1) with ESMTP id k4CAvCUl019261;
	Fri, 12 May 2006 12:57:12 +0200
Date:	Fri, 12 May 2006 11:57:08 +0100 (BST)
From:	"Maciej W. Rozycki" <macro@linux-mips.org>
To:	Martin Michlmayr <tbm@cyrius.com>
cc:	Karel van Houten <Karel@vhouten.xs4all.nl>,
	debian-mips@lists.debian.org, linux-mips@linux-mips.org
Subject: Re: 2.6 for DECstation, d-i
In-Reply-To: <20060511185446.GB7234@deprecation.cyrius.com>
Message-ID: <Pine.LNX.4.64N.0605121142240.14216@blysk.ds.pg.gda.pl>
References: <44635C0D.7040901@vhouten.xs4all.nl> <20060511173350.GM7827@deprecation.cyrius.com>
 <Pine.LNX.4.64N.0605111853500.20004@blysk.ds.pg.gda.pl>
 <20060511185446.GB7234@deprecation.cyrius.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Virus-Scanned: ClamAV 0.88.2/1459/Thu May 11 22:46:49 2006 on piorun.ds.pg.gda.pl
X-Virus-Status:	Clean
X-Virus-Scanned: by amavisd-new at pollux.ds.pg.gda.pl
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 11410
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Thu, 11 May 2006, Martin Michlmayr wrote:

> >  Well, not exactly ported, but hacked up enough it worked the last time I 
> > tried, but you have to disable the virtual terminal (CONFIG_VT) as it is 
> 
> Yeah, but the problem is that ZS is not a config option anymore.  I
> hacked up something to see if the driver works but I guess there's a
> nicer solution.

 Of course there is.  Just enable SERIAL_NONSTANDARD, SERIAL_DEC, 
SERIAL_DEC_CONSOLE and ZS.  They are all in drivers/char/Kconfig and it's 
not a coincidence the options are the same as in 2.4.

 The driver has NOT been ported to use the serial core and frankly I would 
rather it went away and write the necessary system specific glue 
(including that horrible stuff for incorrect wiring used in all DEC 
systems making use of the Zilog chips) to use drivers/net/wan/z85230.c 
instead which already has a lot of nice stuff like support for synchronous 
operation and DMA, HDLC framing, etc.

  Maciej
