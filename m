Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 19 Dec 2004 03:41:05 +0000 (GMT)
Received: from pollux.ds.pg.gda.pl ([IPv6:::ffff:153.19.208.7]:44814 "EHLO
	pollux.ds.pg.gda.pl") by linux-mips.org with ESMTP
	id <S8225215AbULSDkv>; Sun, 19 Dec 2004 03:40:51 +0000
Received: from localhost (localhost [127.0.0.1])
	by pollux.ds.pg.gda.pl (Postfix) with ESMTP
	id 71E46F5A91; Sun, 19 Dec 2004 01:25:57 +0100 (CET)
Received: from pollux.ds.pg.gda.pl ([127.0.0.1])
 by localhost (pollux [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
 id 05866-09; Sun, 19 Dec 2004 01:25:57 +0100 (CET)
Received: from piorun.ds.pg.gda.pl (piorun.ds.pg.gda.pl [153.19.208.8])
	by pollux.ds.pg.gda.pl (Postfix) with ESMTP
	id DAC76FFBA9; Sat, 18 Dec 2004 23:28:54 +0100 (CET)
Received: from blysk.ds.pg.gda.pl (macro@blysk.ds.pg.gda.pl [153.19.208.6])
	by piorun.ds.pg.gda.pl (8.13.1/8.13.1) with ESMTP id iBIMTBYm009496;
	Sat, 18 Dec 2004 23:29:12 +0100
Date: Sat, 18 Dec 2004 22:28:59 +0000 (GMT)
From: "Maciej W. Rozycki" <macro@linux-mips.org>
To: "Steven J. Hill" <sjhill@realitydiluted.com>
Cc: linux-mips@linux-mips.org
Subject: Re: CVS Update@-mips.org: linux
In-Reply-To: <41C4A1DD.2090003@realitydiluted.com>
Message-ID: <Pine.LNX.4.58L.0412182221470.27710@blysk.ds.pg.gda.pl>
References: <20041218022359Z8225198-1751+3809@linux-mips.org>
 <41C4A1DD.2090003@realitydiluted.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Virus-Scanned: ClamAV 0.80/617/Sun Dec  5 16:25:39 2004
	clamav-milter version 0.80j
	on piorun.ds.pg.gda.pl
X-Virus-Status: Clean
X-Virus-Scanned: by amavisd-new at pollux.ds.pg.gda.pl
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 6707
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Sat, 18 Dec 2004, Steven J. Hill wrote:

> > Log message:
> > 	Fixup the SiByte PCI-HT bridge lying about being a host bridge.
> > 
> The file 'arch/mips/pci/fixup-sb1250.c' is missing. Please place into
> CVS. Thank you.

 Gosh, thanks for the notice.  I've just fixed it up.

  Maciej
