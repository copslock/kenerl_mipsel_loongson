Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 24 Feb 2007 03:21:35 +0000 (GMT)
Received: from pollux.ds.pg.gda.pl ([153.19.208.7]:37134 "EHLO
	pollux.ds.pg.gda.pl") by ftp.linux-mips.org with ESMTP
	id S20039114AbXBXDVa (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Sat, 24 Feb 2007 03:21:30 +0000
Received: from localhost (localhost [127.0.0.1])
	by pollux.ds.pg.gda.pl (Postfix) with ESMTP id 67002E1F58;
	Sat, 24 Feb 2007 04:20:40 +0100 (CET)
X-Virus-Scanned: by amavisd-new at pollux.ds.pg.gda.pl
Received: from pollux.ds.pg.gda.pl ([127.0.0.1])
	by localhost (pollux.ds.pg.gda.pl [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id gWi5x8sYg3Y7; Sat, 24 Feb 2007 04:20:40 +0100 (CET)
Received: from piorun.ds.pg.gda.pl (piorun.ds.pg.gda.pl [153.19.208.8])
	by pollux.ds.pg.gda.pl (Postfix) with ESMTP id 3261410DDE5;
	Fri, 23 Feb 2007 17:38:25 +0100 (CET)
Received: from blysk.ds.pg.gda.pl (macro@blysk.ds.pg.gda.pl [153.19.208.6])
	by piorun.ds.pg.gda.pl (8.13.8/8.13.8) with ESMTP id l1NGTg2F030708;
	Fri, 23 Feb 2007 17:29:42 +0100
Date:	Fri, 23 Feb 2007 16:29:37 +0000 (GMT)
From:	"Maciej W. Rozycki" <macro@linux-mips.org>
To:	Ralf Baechle <ralf@linux-mips.org>
cc:	"Kevin D. Kissell" <kevink@mips.com>,
	Atsushi Nemoto <anemo@mba.ocn.ne.jp>,
	sathesh_edara2003@yahoo.co.in, rajat.noida.india@gmail.com,
	linux-mips@linux-mips.org
Subject: Re: unaligned access
In-Reply-To: <20070223161840.GA23178@linux-mips.org>
Message-ID: <Pine.LNX.4.64N.0702231627510.9153@blysk.ds.pg.gda.pl>
References: <20070223.123630.92584856.nemoto@toshiba-tops.co.jp>
 <005701c7573f$6aca0890$10eca8c0@grendel> <20070223161840.GA23178@linux-mips.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Virus-Scanned: ClamAV 0.90/2631/Thu Feb 22 22:33:11 2007 on piorun.ds.pg.gda.pl
X-Virus-Status:	Clean
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 14237
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Fri, 23 Feb 2007, Ralf Baechle wrote:

>  o Logging unaligned accesses is a dangerous thing; it can easily reach
>    a DoS-like volume.

 Providing a damn good incentive to fix your broken software?

  Maciej
