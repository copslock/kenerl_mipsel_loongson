Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 07 Nov 2005 11:45:31 +0000 (GMT)
Received: from pollux.ds.pg.gda.pl ([153.19.208.7]:21258 "EHLO
	pollux.ds.pg.gda.pl") by ftp.linux-mips.org with ESMTP
	id S8133606AbVKGLpN (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 7 Nov 2005 11:45:13 +0000
Received: from localhost (localhost [127.0.0.1])
	by pollux.ds.pg.gda.pl (Postfix) with ESMTP id AC1E2E1CAD;
	Mon,  7 Nov 2005 12:46:17 +0100 (CET)
Received: from pollux.ds.pg.gda.pl ([127.0.0.1])
 by localhost (pollux [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
 id 03446-09; Mon,  7 Nov 2005 12:46:17 +0100 (CET)
Received: from piorun.ds.pg.gda.pl (piorun.ds.pg.gda.pl [153.19.208.8])
	by pollux.ds.pg.gda.pl (Postfix) with ESMTP id 6B687E1C98;
	Mon,  7 Nov 2005 12:46:17 +0100 (CET)
Received: from blysk.ds.pg.gda.pl (macro@blysk.ds.pg.gda.pl [153.19.208.6])
	by piorun.ds.pg.gda.pl (8.13.3/8.13.1) with ESMTP id jA7Bk6gM031874;
	Mon, 7 Nov 2005 12:46:11 +0100
Date:	Mon, 7 Nov 2005 11:46:20 +0000 (GMT)
From:	"Maciej W. Rozycki" <macro@linux-mips.org>
To:	Jim Gifford <maillist@jg555.com>
Cc:	Linux MIPS List <linux-mips@linux-mips.org>
Subject: Re: MIPS - 64bit woes
In-Reply-To: <436D0061.5070100@jg555.com>
Message-ID: <Pine.LNX.4.55.0511071143210.28165@blysk.ds.pg.gda.pl>
References: <436D0061.5070100@jg555.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Virus-Scanned: ClamAV 0.87/1165/Sun Nov  6 06:12:58 2005 on piorun.ds.pg.gda.pl
X-Virus-Status:	Clean
X-Virus-Scanned: by amavisd-new at pollux.ds.pg.gda.pl
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 9434
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Sat, 5 Nov 2005, Jim Gifford wrote:

> I've been working on getting the RaQ2 to work with the current 2.6.14 
> kernel, but no luck at all. The last success I had was with 2.6.12.x 
> series.
> 
> I'm looking for ideas, patches or whatever to get this working again. I 
> know it has to do with the kernel using 32bit addressing instead of 64 
> bit, but have no clue where to start.

 It must be platform-specific -- I haven't checked 2.6.14, but 64-bit
2.6.13 is good enough to boot into multi-user with the SWARM.

  Maciej
