Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 23 Aug 2004 10:29:54 +0100 (BST)
Received: from pollux.ds.pg.gda.pl ([IPv6:::ffff:153.19.208.7]:51470 "EHLO
	pollux.ds.pg.gda.pl") by linux-mips.org with ESMTP
	id <S8224953AbUHWJ3t>; Mon, 23 Aug 2004 10:29:49 +0100
Received: from localhost (localhost [127.0.0.1])
	by pollux.ds.pg.gda.pl (Postfix) with ESMTP
	id 5434BE1C91; Mon, 23 Aug 2004 11:29:45 +0200 (CEST)
Received: from pollux.ds.pg.gda.pl ([127.0.0.1])
 by localhost (pollux [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
 id 18425-01; Mon, 23 Aug 2004 11:29:45 +0200 (CEST)
Received: from piorun.ds.pg.gda.pl (piorun.ds.pg.gda.pl [153.19.208.8])
	by pollux.ds.pg.gda.pl (Postfix) with ESMTP
	id 1D271E1C7B; Mon, 23 Aug 2004 11:29:45 +0200 (CEST)
Received: from blysk.ds.pg.gda.pl (macro@blysk.ds.pg.gda.pl [153.19.208.6])
	by piorun.ds.pg.gda.pl (8.12.11/8.11.4) with ESMTP id i7N9To0X004564;
	Mon, 23 Aug 2004 11:29:51 +0200
Date: Mon, 23 Aug 2004 11:29:46 +0200 (CEST)
From: "Maciej W. Rozycki" <macro@linux-mips.org>
To: Ralf Baechle <ralf@linux-mips.org>
Cc: linux-mips@linux-mips.org
Subject: Re: CVS Update@-mips.org: linux 
In-Reply-To: <20040820120223Z8225206-1530+8785@linux-mips.org>
Message-ID: <Pine.LNX.4.58L.0408231124040.19572@blysk.ds.pg.gda.pl>
References: <20040820120223Z8225206-1530+8785@linux-mips.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Virus-Scanned: by amavisd-new at pollux.ds.pg.gda.pl
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 5713
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Fri, 20 Aug 2004 ralf@linux-mips.org wrote:

> Log message:
> 	Undo change from rev 1.37; some userspace software is expecting
> 	PAGE_SIZE, PAGE_SHIFT and PAGE_MASK to be accessible through
> 	<asm/page.h>.  Sigh ...

 Fix that software then, instead of breaking good one (hint -- what is the
"right" value of PAGE_SHIFT and why it doesn't work for that system over
there?).  With these macros exported it's hard to guess whether the page
size can be hardcoded or it should get determined at the run time.  And 
with glibc you get a compilation error due to PAGE_SHIFT being undefined.  
Please revert the braindamage.

 What software is the offender, BTW?

  Maciej
