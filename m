Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 03 Feb 2005 15:08:28 +0000 (GMT)
Received: from pollux.ds.pg.gda.pl ([IPv6:::ffff:153.19.208.7]:39953 "EHLO
	pollux.ds.pg.gda.pl") by linux-mips.org with ESMTP
	id <S8225471AbVBCPIM>; Thu, 3 Feb 2005 15:08:12 +0000
Received: from localhost (localhost [127.0.0.1])
	by pollux.ds.pg.gda.pl (Postfix) with ESMTP
	id 1EBACF5977; Thu,  3 Feb 2005 16:08:04 +0100 (CET)
Received: from pollux.ds.pg.gda.pl ([127.0.0.1])
 by localhost (pollux [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
 id 09670-01; Thu,  3 Feb 2005 16:08:04 +0100 (CET)
Received: from piorun.ds.pg.gda.pl (piorun.ds.pg.gda.pl [153.19.208.8])
	by pollux.ds.pg.gda.pl (Postfix) with ESMTP
	id BE695F5974; Thu,  3 Feb 2005 16:08:03 +0100 (CET)
Received: from blysk.ds.pg.gda.pl (macro@blysk.ds.pg.gda.pl [153.19.208.6])
	by piorun.ds.pg.gda.pl (8.13.1/8.13.1) with ESMTP id j13F86d9004909;
	Thu, 3 Feb 2005 16:08:07 +0100
Date:	Thu, 3 Feb 2005 15:08:15 +0000 (GMT)
From:	"Maciej W. Rozycki" <macro@linux-mips.org>
To:	Ralf Baechle <ralf@linux-mips.org>
Cc:	linux-mips@linux-mips.org
Subject: Re: [PATCH 20/20] mips/bcm1250_tbprof: remove interruptible_sleep_on()
 usage
In-Reply-To: <20050203133813.GA9796@linux-mips.org>
Message-ID: <Pine.LNX.4.61L.0502031504390.29325@blysk.ds.pg.gda.pl>
References: <20050202230853.GA2546@us.ibm.com> <20050203133813.GA9796@linux-mips.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Virus-Scanned: ClamAV 0.80/661/Tue Jan 11 02:44:13 2005
	clamav-milter version 0.80j
	on piorun.ds.pg.gda.pl
X-Virus-Status:	Clean
X-Virus-Scanned: by amavisd-new at pollux.ds.pg.gda.pl
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 7133
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Thu, 3 Feb 2005, Ralf Baechle wrote:

> > Description: Remove deprecated interruptible_sleep_on() function call
> > and replace with direct wait-queue usage.
> 
> Thanks,

 Except that should rather use wait_event_interruptible().

  Maciej
