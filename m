Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 11 Nov 2004 02:39:39 +0000 (GMT)
Received: from pollux.ds.pg.gda.pl ([IPv6:::ffff:153.19.208.7]:41479 "EHLO
	pollux.ds.pg.gda.pl") by linux-mips.org with ESMTP
	id <S8224917AbUKKCjf>; Thu, 11 Nov 2004 02:39:35 +0000
Received: from localhost (localhost [127.0.0.1])
	by pollux.ds.pg.gda.pl (Postfix) with ESMTP
	id 7E268F596F; Thu, 11 Nov 2004 03:39:27 +0100 (CET)
Received: from pollux.ds.pg.gda.pl ([127.0.0.1])
 by localhost (pollux [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
 id 10744-10; Thu, 11 Nov 2004 03:39:27 +0100 (CET)
Received: from piorun.ds.pg.gda.pl (piorun.ds.pg.gda.pl [153.19.208.8])
	by pollux.ds.pg.gda.pl (Postfix) with ESMTP
	id 4E7A2E1C9A; Thu, 11 Nov 2004 03:39:27 +0100 (CET)
Received: from blysk.ds.pg.gda.pl (macro@blysk.ds.pg.gda.pl [153.19.208.6])
	by piorun.ds.pg.gda.pl (8.13.1/8.13.1) with ESMTP id iAB2diMO000698;
	Thu, 11 Nov 2004 03:39:44 +0100
Date: Thu, 11 Nov 2004 02:39:29 +0000 (GMT)
From: "Maciej W. Rozycki" <macro@linux-mips.org>
To: Ralf Baechle <ralf@linux-mips.org>
Cc: "Maciej W. Rozycki" <macro@mips.com>, linux-mips@linux-mips.org,
	libc-alpha@sources.redhat.com, Nigel Stephens <nigel@mips.com>
Subject: Re: [PATCH] MIPS/Linux: Kernel vs libc struct siginfo discrepancy
In-Reply-To: <20041111014759.GA29699@linux-mips.org>
Message-ID: <Pine.LNX.4.58L.0411110224380.5685@blysk.ds.pg.gda.pl>
References: <Pine.LNX.4.61.0411101657420.11408@perivale.mips.com>
 <20041111014759.GA29699@linux-mips.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Virus-Scanned: ClamAV 0.80/578/Mon Nov  8 15:26:49 2004
	clamav-milter version 0.80j
	on piorun.ds.pg.gda.pl
X-Virus-Status: Clean
X-Virus-Scanned: by amavisd-new at pollux.ds.pg.gda.pl
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 6302
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Thu, 11 Nov 2004, Ralf Baechle wrote:

> > dated back to Aug 1999 (!), the definitions of struct siginfo in Linux and 
> > GNU libc differ to each other.  While it's the kernel that is at fault by 
> > changing its ABI, at this stage it may be more acceptable to update glibc 
> > as it's not the only program interfacing to Linux (uClibc?).  It doesn't 
> 
> uClibc copies it's headers from glibc it seems.  The change in 1999 was
> quite intensional because back then there was no SA_SIGINFO using libc for
> MIPS yet.

 Well, I'm afraid the glibc's header dates back to Jan 1999, so it
predates the change to Linux and this is why it uses the original
definition.  Of course I know what the relationship between MIPS/Linux and
glibc was back then and problems like this prove this wasn't the best idea
ever.  They are the very reason I insist on pushing changes upstream as
soon as possible.  Otherwise fixes get forgotten or lost as patches for
old versions get discarded.  This change should have made its way to glibc
at the time of the change to Linux.

  Maciej
