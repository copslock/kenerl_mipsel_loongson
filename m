Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 20 Jan 2005 14:18:05 +0000 (GMT)
Received: from pollux.ds.pg.gda.pl ([IPv6:::ffff:153.19.208.7]:32262 "EHLO
	pollux.ds.pg.gda.pl") by linux-mips.org with ESMTP
	id <S8225224AbVATOR7>; Thu, 20 Jan 2005 14:17:59 +0000
Received: from localhost (localhost [127.0.0.1])
	by pollux.ds.pg.gda.pl (Postfix) with ESMTP
	id 6BA6AE1C90; Thu, 20 Jan 2005 15:17:51 +0100 (CET)
Received: from pollux.ds.pg.gda.pl ([127.0.0.1])
 by localhost (pollux [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
 id 21508-07; Thu, 20 Jan 2005 15:17:51 +0100 (CET)
Received: from piorun.ds.pg.gda.pl (piorun.ds.pg.gda.pl [153.19.208.8])
	by pollux.ds.pg.gda.pl (Postfix) with ESMTP
	id 32718E1C7F; Thu, 20 Jan 2005 15:17:51 +0100 (CET)
Received: from blysk.ds.pg.gda.pl (macro@blysk.ds.pg.gda.pl [153.19.208.6])
	by piorun.ds.pg.gda.pl (8.13.1/8.13.1) with ESMTP id j0KEHs4m015227;
	Thu, 20 Jan 2005 15:17:55 +0100
Date:	Thu, 20 Jan 2005 14:18:00 +0000 (GMT)
From:	"Maciej W. Rozycki" <macro@linux-mips.org>
To:	moreau francis <francis_moreau2000@yahoo.fr>
Cc:	Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org
Subject: Re: dcache issue...
In-Reply-To: <20050120140025.96779.qmail@web25101.mail.ukl.yahoo.com>
Message-ID: <Pine.LNX.4.61L.0501201414250.18294@blysk.ds.pg.gda.pl>
References: <20050120140025.96779.qmail@web25101.mail.ukl.yahoo.com>
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
X-archive-position: 6961
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Thu, 20 Jan 2005, moreau francis wrote:

> > Live is tough, use caches ;-)
> 
> oh yes it is. But I would only understand what was
> my problem using the mixed cache modes...

 Note that ll/sc sequences don't work as expected on uncached memory, so 
atomic accesses are not going to work in the kernel memory in your 
configuration.  This may cause arbitrary corruptions due to an 
inconsistent state of the kernel.

  Maciej
