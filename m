Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 24 Feb 2005 18:04:24 +0000 (GMT)
Received: from pollux.ds.pg.gda.pl ([IPv6:::ffff:153.19.208.7]:32529 "EHLO
	pollux.ds.pg.gda.pl") by linux-mips.org with ESMTP
	id <S8225413AbVBXSEI>; Thu, 24 Feb 2005 18:04:08 +0000
Received: from localhost (localhost [127.0.0.1])
	by pollux.ds.pg.gda.pl (Postfix) with ESMTP
	id 92468E1CB5; Thu, 24 Feb 2005 19:03:57 +0100 (CET)
Received: from pollux.ds.pg.gda.pl ([127.0.0.1])
 by localhost (pollux [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
 id 20697-02; Thu, 24 Feb 2005 19:03:57 +0100 (CET)
Received: from piorun.ds.pg.gda.pl (piorun.ds.pg.gda.pl [153.19.208.8])
	by pollux.ds.pg.gda.pl (Postfix) with ESMTP
	id 3798AE1C6D; Thu, 24 Feb 2005 19:03:57 +0100 (CET)
Received: from blysk.ds.pg.gda.pl (macro@blysk.ds.pg.gda.pl [153.19.208.6])
	by piorun.ds.pg.gda.pl (8.13.1/8.13.1) with ESMTP id j1OI40E1029549;
	Thu, 24 Feb 2005 19:04:01 +0100
Date:	Thu, 24 Feb 2005 18:04:09 +0000 (GMT)
From:	"Maciej W. Rozycki" <macro@linux-mips.org>
To:	Tsang-Ren Chang <690190029@s90.tku.edu.tw>
Cc:	linux-mips@linux-mips.org
Subject: Re: ADM5120: Data bus error
In-Reply-To: <421DF870.30708@s90.tku.edu.tw>
Message-ID: <Pine.LNX.4.61L.0502241741570.23589@blysk.ds.pg.gda.pl>
References: <421DF870.30708@s90.tku.edu.tw>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Virus-Scanned: ClamAV 0.80/700/Fri Feb  4 00:33:15 2005
	clamav-milter version 0.80j
	on piorun.ds.pg.gda.pl
X-Virus-Status:	Clean
X-Virus-Scanned: by amavisd-new at pollux.ds.pg.gda.pl
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 7338
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Thu, 24 Feb 2005, Tsang-Ren Chang wrote:

> Why does the CPU raise data bus error exception when I copy or read
> /sbin/pppd every time? (cp0 hazards?)

 Bus error exceptions are triggered by an external signal, i.e. they come 
from board logic (the chipset).  See your board's documentation for what 
can cause them.  If the chipset provides any additional information for 
bus errors, you may decode it or at least dump in your own board-specific 
handler -- see the board_be_init variable for how to provide it and 
arch/mips/dec/ecc-berr.c for a reasonable working implementation.  You may 
request the generic handler to ignore a bus error exception if the 
additional information from the chipset shows it's a recoverable 
condition, like an ECC-corrected memory error (it shouldn't normally use 
bus errors for signalling such events, though).

  Maciej
