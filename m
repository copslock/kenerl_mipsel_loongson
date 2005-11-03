Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 03 Nov 2005 13:14:59 +0000 (GMT)
Received: from pollux.ds.pg.gda.pl ([153.19.208.7]:4879 "EHLO
	pollux.ds.pg.gda.pl") by ftp.linux-mips.org with ESMTP
	id S8133850AbVKCNOk (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 3 Nov 2005 13:14:40 +0000
Received: from localhost (localhost [127.0.0.1])
	by pollux.ds.pg.gda.pl (Postfix) with ESMTP id 838FAE1C91;
	Thu,  3 Nov 2005 14:15:24 +0100 (CET)
Received: from pollux.ds.pg.gda.pl ([127.0.0.1])
 by localhost (pollux [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
 id 30479-06; Thu,  3 Nov 2005 14:15:24 +0100 (CET)
Received: from piorun.ds.pg.gda.pl (piorun.ds.pg.gda.pl [153.19.208.8])
	by pollux.ds.pg.gda.pl (Postfix) with ESMTP id 325B4E1C67;
	Thu,  3 Nov 2005 14:15:23 +0100 (CET)
Received: from blysk.ds.pg.gda.pl (macro@blysk.ds.pg.gda.pl [153.19.208.6])
	by piorun.ds.pg.gda.pl (8.13.3/8.13.1) with ESMTP id jA3DFGXY025647;
	Thu, 3 Nov 2005 14:15:16 +0100
Date:	Thu, 3 Nov 2005 13:15:32 +0000 (GMT)
From:	"Maciej W. Rozycki" <macro@linux-mips.org>
To:	Ralf Baechle <ralf@linux-mips.org>
Cc:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>, linux-mips@linux-mips.org
Subject: Re: [PATCH] use rtc_lock to protect RTC operations
In-Reply-To: <20051103125926.GB3149@linux-mips.org>
Message-ID: <Pine.LNX.4.55.0511031305280.24109@blysk.ds.pg.gda.pl>
References: <20051103.010115.07642880.anemo@mba.ocn.ne.jp>
 <20051103125926.GB3149@linux-mips.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Virus-Scanned: ClamAV 0.87/1160/Wed Nov  2 17:26:43 2005 on piorun.ds.pg.gda.pl
X-Virus-Status:	Clean
X-Virus-Scanned: by amavisd-new at pollux.ds.pg.gda.pl
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 9415
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Thu, 3 Nov 2005, Ralf Baechle wrote:

> Unlike on PC CMOS_READ on a DEC is a single read operation, so atomic
> and so doesn't need to be protected.  I'd have to check the datasheet
> for any other reason why it might need locking though, so I apply your
> patch for now and leave this to Maciej for later optimization.

 You are correct -- unless you need to perform multiple RTC access cycles
uninterrupted in a row, a lock is not needed.  Single accesses are
executed as single cycles on the system bus, with some glue logic attached
to the RTC chip converting them into pairs of chip accesses consisting of
an index register write and the actual data cycle.  Even the exact latency
of the whole operation is specified for some system models. ;-)

 Welcome to a clean design!

  Maciej
