Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 23 Aug 2004 12:40:20 +0100 (BST)
Received: from pollux.ds.pg.gda.pl ([IPv6:::ffff:153.19.208.7]:16905 "EHLO
	pollux.ds.pg.gda.pl") by linux-mips.org with ESMTP
	id <S8225221AbUHWLkQ>; Mon, 23 Aug 2004 12:40:16 +0100
Received: from localhost (localhost [127.0.0.1])
	by pollux.ds.pg.gda.pl (Postfix) with ESMTP
	id 41BF8E1C93; Mon, 23 Aug 2004 13:40:12 +0200 (CEST)
Received: from pollux.ds.pg.gda.pl ([127.0.0.1])
 by localhost (pollux [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
 id 06406-05; Mon, 23 Aug 2004 13:40:12 +0200 (CEST)
Received: from piorun.ds.pg.gda.pl (piorun.ds.pg.gda.pl [153.19.208.8])
	by pollux.ds.pg.gda.pl (Postfix) with ESMTP
	id 1B10CE1C91; Mon, 23 Aug 2004 13:40:12 +0200 (CEST)
Received: from blysk.ds.pg.gda.pl (macro@blysk.ds.pg.gda.pl [153.19.208.6])
	by piorun.ds.pg.gda.pl (8.12.11/8.11.4) with ESMTP id i7NBeJJ8010772;
	Mon, 23 Aug 2004 13:40:20 +0200
Date: Mon, 23 Aug 2004 13:40:14 +0200 (CEST)
From: "Maciej W. Rozycki" <macro@linux-mips.org>
To: Ralf Baechle <ralf@linux-mips.org>
Cc: linux-mips@linux-mips.org
Subject: Re: CVS Update@-mips.org: linux
In-Reply-To: <20040823102402.GC17067@linux-mips.org>
Message-ID: <Pine.LNX.4.58L.0408231319350.19572@blysk.ds.pg.gda.pl>
References: <20040820120223Z8225206-1530+8785@linux-mips.org>
 <Pine.LNX.4.58L.0408231124040.19572@blysk.ds.pg.gda.pl>
 <20040823102402.GC17067@linux-mips.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Virus-Scanned: by amavisd-new at pollux.ds.pg.gda.pl
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 5717
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Mon, 23 Aug 2004, Ralf Baechle wrote:

> Due to PAGE_SHIFT being undefined?  You meant the opposite?

 Yes.  No.  PAGE_SHIFT is defined conditionally based on 
CONFIG_PAGE_SIZE_*, which is of course undefined in a generic set of 
headers.

 With PAGE_SIZE undefined you can fall back to sysconf(_SC_PAGESIZE) or 
the page size in the ELF auxiliary vector (depending on the context).  

> Procps but I have dark memories of other packages doing the same thing, so
> I gave up and kludged the thing the same way other architectures do.
> Even IA-64 which is suffering the same pains with variable page size.

 Do they?  Anyway that's not a way to fix broken software.  Perhaps we 
could do the following hack to teach the resistant:

#ifndef __KERNEL__
#warning PAGE_SIZE is not a user macro, fix your program!
#define PAGE_SIZE sysconf(_SC_PAGESIZE)
#endif

but glibc might not be especially happy about such an alias.

 If you really insist on PAGE_SIZE being constant, then please at least
define it to the maximum supported size for the userland, so that page
alignment rules are kept.  I don't see any reason to keep bugs alive,
though.

  Maciej
