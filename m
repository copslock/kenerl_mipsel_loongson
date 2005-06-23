Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 23 Jun 2005 12:03:20 +0100 (BST)
Received: from pollux.ds.pg.gda.pl ([IPv6:::ffff:153.19.208.7]:19722 "EHLO
	pollux.ds.pg.gda.pl") by linux-mips.org with ESMTP
	id <S8225477AbVFWLDB>; Thu, 23 Jun 2005 12:03:01 +0100
Received: from localhost (localhost [127.0.0.1])
	by pollux.ds.pg.gda.pl (Postfix) with ESMTP
	id DC3AFE1CC1; Thu, 23 Jun 2005 13:01:54 +0200 (CEST)
Received: from pollux.ds.pg.gda.pl ([127.0.0.1])
 by localhost (pollux [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
 id 00672-10; Thu, 23 Jun 2005 13:01:54 +0200 (CEST)
Received: from piorun.ds.pg.gda.pl (piorun.ds.pg.gda.pl [153.19.208.8])
	by pollux.ds.pg.gda.pl (Postfix) with ESMTP
	id A38FFE1C8F; Thu, 23 Jun 2005 13:01:54 +0200 (CEST)
Received: from blysk.ds.pg.gda.pl (macro@blysk.ds.pg.gda.pl [153.19.208.6])
	by piorun.ds.pg.gda.pl (8.13.3/8.13.1) with ESMTP id j5NB1pEw017567;
	Thu, 23 Jun 2005 13:01:56 +0200
Date:	Thu, 23 Jun 2005 12:01:57 +0100 (BST)
From:	"Maciej W. Rozycki" <macro@linux-mips.org>
To:	Andrew Isaacson <adi@broadcom.com>
Cc:	linux-mips@linux-mips.org
Subject: Re: [patch 1/5] SiByte fixes for 2.6.12
In-Reply-To: <20050622230042.GA17919@broadcom.com>
Message-ID: <Pine.LNX.4.61L.0506231153080.17155@blysk.ds.pg.gda.pl>
References: <20050622230042.GA17919@broadcom.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Virus-Scanned: ClamAV 0.85.1/954/Wed Jun 22 21:15:13 2005 on piorun.ds.pg.gda.pl
X-Virus-Status:	Clean
X-Virus-Scanned: by amavisd-new at pollux.ds.pg.gda.pl
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 8150
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Wed, 22 Jun 2005, Andrew Isaacson wrote:

> SB1 does not use the R4K TLB code.

 Well, the flag is not really to specify whether the common code is to be 
used or not.  It's about whether the TLB is like that of the R4k.  
Actually it's always been a mystery for me why the common code cannot be 
used for the SB1, but perhaps there is something specific that I could 
only discover in that "SB-1 Core User Manual" that I yet have to see, 
sigh...

 Of course if your TLB is indeed different from that of the R4k, then you 
shouldn't be setting cp0.config.mt to 1 in the first place...

  Maciej
