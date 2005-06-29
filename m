Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 29 Jun 2005 18:07:55 +0100 (BST)
Received: from pollux.ds.pg.gda.pl ([IPv6:::ffff:153.19.208.7]:59396 "EHLO
	pollux.ds.pg.gda.pl") by linux-mips.org with ESMTP
	id <S8226041AbVF2RHi>; Wed, 29 Jun 2005 18:07:38 +0100
Received: from localhost (localhost [127.0.0.1])
	by pollux.ds.pg.gda.pl (Postfix) with ESMTP
	id 8A196E1CB9; Wed, 29 Jun 2005 19:07:12 +0200 (CEST)
Received: from pollux.ds.pg.gda.pl ([127.0.0.1])
 by localhost (pollux [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
 id 10276-06; Wed, 29 Jun 2005 19:07:12 +0200 (CEST)
Received: from piorun.ds.pg.gda.pl (piorun.ds.pg.gda.pl [153.19.208.8])
	by pollux.ds.pg.gda.pl (Postfix) with ESMTP
	id 4BEA6E1CB3; Wed, 29 Jun 2005 19:07:12 +0200 (CEST)
Received: from blysk.ds.pg.gda.pl (macro@blysk.ds.pg.gda.pl [153.19.208.6])
	by piorun.ds.pg.gda.pl (8.13.3/8.13.1) with ESMTP id j5TH7Gxd021080;
	Wed, 29 Jun 2005 19:07:16 +0200
Date:	Wed, 29 Jun 2005 18:07:26 +0100 (BST)
From:	"Maciej W. Rozycki" <macro@linux-mips.org>
To:	Ralf Baechle <ralf@linux-mips.org>
Cc:	linux-mips@linux-mips.org
Subject: Re: [PATCH] Inline ioremap() magic for 32-bit constant addresses
In-Reply-To: <20050629131437.GE3211@linux-mips.org>
Message-ID: <Pine.LNX.4.61L.0506291541340.31188@blysk.ds.pg.gda.pl>
References: <Pine.LNX.4.61L.0506281713050.13758@blysk.ds.pg.gda.pl>
 <20050629131437.GE3211@linux-mips.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Virus-Scanned: ClamAV 0.85.1/960/Wed Jun 29 06:31:06 2005 on piorun.ds.pg.gda.pl
X-Virus-Status:	Clean
X-Virus-Scanned: by amavisd-new at pollux.ds.pg.gda.pl
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 8248
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Wed, 29 Jun 2005, Ralf Baechle wrote:

> >  I'd like to get rid of CKSEG1ADDR() wherever possible from code I am 
> > looking after as the macro is unportable and has already proven to cause 
> > maintenance hassle.  I don't want to get rid of its advantages though, so 
> > here's an update for ioremap() that makes it be expanded inline when 
> > constant arguments are used and the resulting mapping fits in KSEG1.  
> > Likewise for iounmap().
> 
> I don't think I'd complain about taking the whole thing out off line.  Last
> I checked we had no driver that did substancially benefit from being
> initialized a few nanoseconds faster.

 I haven't checked it yet, but it may be possible for my updates to add 
calls to ioremap() from interrupt handlers, which may not necessarily be 
so neutral to performance if calculations are done out of line.  With this 
inline implementation ioremap() expands to at most two instructions for 
qualifying calls and iounmap() expands to nothing.  With an out of line 
version not only the address calculations are done at the run time, but 
you need to add an overhead of two function calls.

 I like the MIPS64 version best, though. ;-)

> >  Apparently the generic version is used for all platforms but the Au1000.  
> > I have only implemented the bare minimum required for the platform to keep 
> > working.  The platform seems to be maintained though, so I'm leaving the 
> > decision as to whether to inline the platform-specific variation or not up 
> > to the maintainer.
> 
> So I guess your patch leaves getting rid of that indirection of
> fixup_bigphys_addr calling into __fixup_bigphys_addr to Pete :-)

 Yes, formally.  Technically, I can probably get convinced to do the dirty 
cut & paste work if asked to appropriately. ;-)

  Maciej
