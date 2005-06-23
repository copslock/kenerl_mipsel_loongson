Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 23 Jun 2005 15:26:30 +0100 (BST)
Received: from pollux.ds.pg.gda.pl ([IPv6:::ffff:153.19.208.7]:42508 "EHLO
	pollux.ds.pg.gda.pl") by linux-mips.org with ESMTP
	id <S8225534AbVFWO0O>; Thu, 23 Jun 2005 15:26:14 +0100
Received: from localhost (localhost [127.0.0.1])
	by pollux.ds.pg.gda.pl (Postfix) with ESMTP
	id 9EB55E1C9C; Thu, 23 Jun 2005 16:25:06 +0200 (CEST)
Received: from pollux.ds.pg.gda.pl ([127.0.0.1])
 by localhost (pollux [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
 id 10476-10; Thu, 23 Jun 2005 16:25:06 +0200 (CEST)
Received: from piorun.ds.pg.gda.pl (piorun.ds.pg.gda.pl [153.19.208.8])
	by pollux.ds.pg.gda.pl (Postfix) with ESMTP
	id F40C2E1C8F; Thu, 23 Jun 2005 16:25:05 +0200 (CEST)
Received: from blysk.ds.pg.gda.pl (macro@blysk.ds.pg.gda.pl [153.19.208.6])
	by piorun.ds.pg.gda.pl (8.13.3/8.13.1) with ESMTP id j5NEP9Nj027198;
	Thu, 23 Jun 2005 16:25:09 +0200
Date:	Thu, 23 Jun 2005 15:25:17 +0100 (BST)
From:	"Maciej W. Rozycki" <macro@linux-mips.org>
To:	moreau francis <francis_moreau2000@yahoo.fr>
Cc:	linux-mips@linux-mips.org
Subject: Re: CONFIG_HZ for mips
In-Reply-To: <20050623134825.73797.qmail@web25807.mail.ukl.yahoo.com>
Message-ID: <Pine.LNX.4.61L.0506231457200.17155@blysk.ds.pg.gda.pl>
References: <20050623134825.73797.qmail@web25807.mail.ukl.yahoo.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Virus-Scanned: ClamAV 0.85.1/954/Wed Jun 22 21:15:13 2005 on piorun.ds.pg.gda.pl
X-Virus-Status:	Clean
X-Virus-Scanned: by amavisd-new at pollux.ds.pg.gda.pl
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 8154
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Thu, 23 Jun 2005, moreau francis wrote:

> A patch is being integrated into the kernel in order to be able to tune HZ
> value while configuring the kernel. The values can be 100, 250, 1000 and
> default value has been moved to 250. The patch is for i386 arch.
> 
> Why not doing the same on mips arch ?

 Well, you are welcomed to submit a patch.  Except our situation a bit 
more complicated as some platforms these values and may need something 
like 128, 256 or 1024 instead.  This should be properly taken care of.

> BTW why the default value on mips is 1000 ?

 Perhaps we have too much processing power by default.

  Maciej
