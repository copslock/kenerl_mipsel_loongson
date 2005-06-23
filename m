Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 23 Jun 2005 16:12:59 +0100 (BST)
Received: from pollux.ds.pg.gda.pl ([IPv6:::ffff:153.19.208.7]:9993 "EHLO
	pollux.ds.pg.gda.pl") by linux-mips.org with ESMTP
	id <S8225534AbVFWPMm>; Thu, 23 Jun 2005 16:12:42 +0100
Received: from localhost (localhost [127.0.0.1])
	by pollux.ds.pg.gda.pl (Postfix) with ESMTP
	id 30B68E1C9C; Thu, 23 Jun 2005 17:11:40 +0200 (CEST)
Received: from pollux.ds.pg.gda.pl ([127.0.0.1])
 by localhost (pollux [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
 id 24762-03; Thu, 23 Jun 2005 17:11:40 +0200 (CEST)
Received: from piorun.ds.pg.gda.pl (piorun.ds.pg.gda.pl [153.19.208.8])
	by pollux.ds.pg.gda.pl (Postfix) with ESMTP
	id E78CEE1C8F; Thu, 23 Jun 2005 17:11:39 +0200 (CEST)
Received: from blysk.ds.pg.gda.pl (macro@blysk.ds.pg.gda.pl [153.19.208.6])
	by piorun.ds.pg.gda.pl (8.13.3/8.13.1) with ESMTP id j5NFBhmt029081;
	Thu, 23 Jun 2005 17:11:43 +0200
Date:	Thu, 23 Jun 2005 16:11:51 +0100 (BST)
From:	"Maciej W. Rozycki" <macro@linux-mips.org>
To:	Andy Isaacson <adi@hexapodia.org>
Cc:	Andrew Isaacson <adi@broadcom.com>, linux-mips@linux-mips.org
Subject: Re: [patch 4/5] SiByte fixes for 2.6.12
In-Reply-To: <20050623144926.GA10216@hexapodia.org>
Message-ID: <Pine.LNX.4.61L.0506231601270.17155@blysk.ds.pg.gda.pl>
References: <20050622230151.GA17970@broadcom.com>
 <Pine.LNX.4.61L.0506231208120.17155@blysk.ds.pg.gda.pl>
 <20050623144926.GA10216@hexapodia.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Virus-Scanned: ClamAV 0.85.1/954/Wed Jun 22 21:15:13 2005 on piorun.ds.pg.gda.pl
X-Virus-Status:	Clean
X-Virus-Scanned: by amavisd-new at pollux.ds.pg.gda.pl
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 8156
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Thu, 23 Jun 2005, Andy Isaacson wrote:

> The code looks like it's structured to be able to be compiled with
> support for multiple CPUs, say, r4k and SB1; using #error would seem to
> prevent that.
> 
> With the code as currently structured, you don't know it's going to be a
> noop until runtime comes along and cpu_has_4ktlb is true...

 Well, I've had a look at the code and it's such a mess.  Obviously 
calling ld_mmu_r4xx0() (or any of the other variants) should not be 
compiled conditionally and more specific cases, i.e. based on PRId values 
should take precedence.  I'll see if I can make it better.

  Maciej
