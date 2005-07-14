Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 14 Jul 2005 16:58:11 +0100 (BST)
Received: from pollux.ds.pg.gda.pl ([IPv6:::ffff:153.19.208.7]:16906 "EHLO
	pollux.ds.pg.gda.pl") by linux-mips.org with ESMTP
	id <S8226709AbVGNP5w>; Thu, 14 Jul 2005 16:57:52 +0100
Received: from localhost (localhost [127.0.0.1])
	by pollux.ds.pg.gda.pl (Postfix) with ESMTP
	id 89590E1CBE; Thu, 14 Jul 2005 17:58:58 +0200 (CEST)
Received: from pollux.ds.pg.gda.pl ([127.0.0.1])
 by localhost (pollux [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
 id 21427-10; Thu, 14 Jul 2005 17:58:58 +0200 (CEST)
Received: from piorun.ds.pg.gda.pl (piorun.ds.pg.gda.pl [153.19.208.8])
	by pollux.ds.pg.gda.pl (Postfix) with ESMTP
	id 520EFE1CBC; Thu, 14 Jul 2005 17:58:58 +0200 (CEST)
Received: from blysk.ds.pg.gda.pl (macro@blysk.ds.pg.gda.pl [153.19.208.6])
	by piorun.ds.pg.gda.pl (8.13.3/8.13.1) with ESMTP id j6EFx1VT001854;
	Thu, 14 Jul 2005 17:59:01 +0200
Date:	Thu, 14 Jul 2005 16:59:11 +0100 (BST)
From:	"Maciej W. Rozycki" <macro@linux-mips.org>
To:	Pete Popov <ppopov@embeddedalley.com>
Cc:	"'linux-mips@linux-mips.org'" <linux-mips@linux-mips.org>
Subject: Re: CVS Update@linux-mips.org: linux
In-Reply-To: <1121356260.4797.364.camel@localhost.localdomain>
Message-ID: <Pine.LNX.4.61L.0507141653440.31857@blysk.ds.pg.gda.pl>
References: <20050714001711Z8226701-3678+2977@linux-mips.org> 
 <Pine.LNX.4.61L.0507141120450.31857@blysk.ds.pg.gda.pl>
 <1121356260.4797.364.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Virus-Scanned: ClamAV 0.85.1/978/Thu Jul 14 13:37:27 2005 on piorun.ds.pg.gda.pl
X-Virus-Status:	Clean
X-Virus-Scanned: by amavisd-new at pollux.ds.pg.gda.pl
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 8488
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Thu, 14 Jul 2005, Pete Popov wrote:

> >  Hmm, I think you should include <ioremap.h> instead as that's the header 
> > and not <asm/io.h> that provides the necessary bit for <asm/pgtable.h>.
> 
> I think I did and it couldn't pick up the right one since we have the
> generic one and then the cpu specific version.

 That would be strange -- the system-specific one (note it's not 
CPU-specific) should precede the generic one in the inclusion path list.  
And how does <asm/io.h> pick the right one then?

  Maciej
