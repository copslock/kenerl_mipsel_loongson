Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 28 Nov 2004 02:01:57 +0000 (GMT)
Received: from pollux.ds.pg.gda.pl ([IPv6:::ffff:153.19.208.7]:46596 "EHLO
	pollux.ds.pg.gda.pl") by linux-mips.org with ESMTP
	id <S8225249AbUK1CBw>; Sun, 28 Nov 2004 02:01:52 +0000
Received: from localhost (localhost [127.0.0.1])
	by pollux.ds.pg.gda.pl (Postfix) with ESMTP
	id 2F92CE1CC2; Sun, 28 Nov 2004 03:01:39 +0100 (CET)
Received: from pollux.ds.pg.gda.pl ([127.0.0.1])
 by localhost (pollux [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
 id 19954-04; Sun, 28 Nov 2004 03:01:39 +0100 (CET)
Received: from piorun.ds.pg.gda.pl (piorun.ds.pg.gda.pl [153.19.208.8])
	by pollux.ds.pg.gda.pl (Postfix) with ESMTP
	id B8BADE1CB6; Sun, 28 Nov 2004 03:01:38 +0100 (CET)
Received: from blysk.ds.pg.gda.pl (macro@blysk.ds.pg.gda.pl [153.19.208.6])
	by piorun.ds.pg.gda.pl (8.13.1/8.13.1) with ESMTP id iAS21wP2011649;
	Sun, 28 Nov 2004 03:01:59 +0100
Date: Sun, 28 Nov 2004 02:01:44 +0000 (GMT)
From: "Maciej W. Rozycki" <macro@linux-mips.org>
To: Ralf Baechle <ralf@linux-mips.org>
Cc: sjhill@linux-mips.org, linux-mips@linux-mips.org
Subject: Re: CVS Update@-mips.org: linux
In-Reply-To: <20041127231543.GA14252@linux-mips.org>
Message-ID: <Pine.LNX.4.58L.0411280138200.27645@blysk.ds.pg.gda.pl>
References: <20041127061929Z8224786-1751+2584@linux-mips.org>
 <Pine.LNX.4.58L.0411272202100.12787@blysk.ds.pg.gda.pl>
 <20041127231543.GA14252@linux-mips.org>
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
X-archive-position: 6473
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Sun, 28 Nov 2004, Ralf Baechle wrote:

> We're already printing way too much stuff and this is a not very useful
> message so why not removing the whole thing for good ...

 This is useful for reliability verification.  See the thread starting at:  
"http://oss.sgi.com/projects/netdev/archive/2004-11/msg00475.html".  The
setting should also be user controllable, but for now people should at
least know whether it's in effect or not.

 Anyone is free to bump their console/syslog loglevel to get rid of less
important messages to suit there preferences.  And INFO, which is what the
message uses, is the lowest level for stuff for non-developers.

  Maciej
