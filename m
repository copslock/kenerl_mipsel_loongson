Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 27 Nov 2004 22:05:18 +0000 (GMT)
Received: from pollux.ds.pg.gda.pl ([IPv6:::ffff:153.19.208.7]:61200 "EHLO
	pollux.ds.pg.gda.pl") by linux-mips.org with ESMTP
	id <S8225219AbUK0WFM>; Sat, 27 Nov 2004 22:05:12 +0000
Received: from localhost (localhost [127.0.0.1])
	by pollux.ds.pg.gda.pl (Postfix) with ESMTP
	id 87037F5944; Sat, 27 Nov 2004 23:05:04 +0100 (CET)
Received: from pollux.ds.pg.gda.pl ([127.0.0.1])
 by localhost (pollux [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
 id 31508-09; Sat, 27 Nov 2004 23:05:04 +0100 (CET)
Received: from piorun.ds.pg.gda.pl (piorun.ds.pg.gda.pl [153.19.208.8])
	by pollux.ds.pg.gda.pl (Postfix) with ESMTP
	id 93316F5943; Sat, 27 Nov 2004 23:05:02 +0100 (CET)
Received: from blysk.ds.pg.gda.pl (macro@blysk.ds.pg.gda.pl [153.19.208.6])
	by piorun.ds.pg.gda.pl (8.13.1/8.13.1) with ESMTP id iARM5JSx028524;
	Sat, 27 Nov 2004 23:05:19 +0100
Date: Sat, 27 Nov 2004 22:05:07 +0000 (GMT)
From: "Maciej W. Rozycki" <macro@linux-mips.org>
To: sjhill@linux-mips.org
Cc: linux-mips@linux-mips.org
Subject: Re: CVS Update@-mips.org: linux 
In-Reply-To: <20041127061929Z8224786-1751+2584@linux-mips.org>
Message-ID: <Pine.LNX.4.58L.0411272202100.12787@blysk.ds.pg.gda.pl>
References: <20041127061929Z8224786-1751+2584@linux-mips.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Virus-Scanned: ClamAV 0.80/605/Wed Nov 24 15:09:47 2004
	clamav-milter version 0.80j
	on piorun.ds.pg.gda.pl
X-Virus-Status: Clean
X-Virus-Scanned: by amavisd-new at pollux.ds.pg.gda.pl
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 6471
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Sat, 27 Nov 2004 sjhill@linux-mips.org wrote:

> Modified files:
> 	drivers/net    : sb1250-mac.c 
> 
> Log message:
> 	Clean up comments, add in new module parameter handling to get rid of compiler
> 	warnings and Manish's printk patch for ethernet device names shown in email
> 	(http://www.linux-mips.org/archives/linux-mips/2004-11/msg00116.html).

 Hmm, shouldn't that be:

if (sc->rx_hw_checksum == ENABLE)
        printk(KERN_INFO "%s: enabling TCP rcv checksum\n", sc->sbm_dev->name);

Otherwise the report doesn't actually reflect the condition.

 I'll change it thus as obvious.

  Maciej
