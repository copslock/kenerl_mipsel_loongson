Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 04 Apr 2005 12:27:04 +0100 (BST)
Received: from pollux.ds.pg.gda.pl ([IPv6:::ffff:153.19.208.7]:35334 "EHLO
	pollux.ds.pg.gda.pl") by linux-mips.org with ESMTP
	id <S8226016AbVDDL0p>; Mon, 4 Apr 2005 12:26:45 +0100
Received: from localhost (localhost [127.0.0.1])
	by pollux.ds.pg.gda.pl (Postfix) with ESMTP
	id 4DEB2E1C95; Mon,  4 Apr 2005 13:26:30 +0200 (CEST)
Received: from pollux.ds.pg.gda.pl ([127.0.0.1])
 by localhost (pollux [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
 id 24609-07; Mon,  4 Apr 2005 13:26:30 +0200 (CEST)
Received: from piorun.ds.pg.gda.pl (piorun.ds.pg.gda.pl [153.19.208.8])
	by pollux.ds.pg.gda.pl (Postfix) with ESMTP
	id F0FCBE1C88; Mon,  4 Apr 2005 13:26:29 +0200 (CEST)
Received: from blysk.ds.pg.gda.pl (macro@blysk.ds.pg.gda.pl [153.19.208.6])
	by piorun.ds.pg.gda.pl (8.13.1/8.13.1) with ESMTP id j34BQWHf016682;
	Mon, 4 Apr 2005 13:26:32 +0200
Date:	Mon, 4 Apr 2005 12:26:38 +0100 (BST)
From:	"Maciej W. Rozycki" <macro@linux-mips.org>
To:	Thiemo Seufer <ths@networkno.de>
Cc:	linux-mips@linux-mips.org
Subject: Re: CVS Update@linux-mips.org: linux
In-Reply-To: <20050402101135.GB1641@hattusa.textio>
Message-ID: <Pine.LNX.4.61L.0504041214570.20089@blysk.ds.pg.gda.pl>
References: <20050401175340Z8226142-1340+5040@linux-mips.org>
 <20050402101135.GB1641@hattusa.textio>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Virus-Scanned: ClamAV 0.83/804/Mon Apr  4 16:38:58 2005 on piorun.ds.pg.gda.pl
X-Virus-Status:	Clean
X-Virus-Scanned: by amavisd-new at pollux.ds.pg.gda.pl
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 7579
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Sat, 2 Apr 2005, Thiemo Seufer wrote:

> > Log message:
> > 	Remove useless casts.  Fix formatting.
> 
> This patch leads for 64bit kernels to:
> 
>   CC      arch/mips/mm/pg-sb1.o
> arch/mips/mm/pg-sb1.c: In function `sb1_dma_init':
> arch/mips/mm/pg-sb1.c:220: warning: cast from pointer to integer of different size
> arch/mips/mm/pg-sb1.c:225: warning: passing arg 2 of `__raw_writeq' discards qualifiers from pointer target type
> arch/mips/mm/pg-sb1.c:226: warning: passing arg 2 of `__raw_writeq' discards qualifiers from pointer target type
> arch/mips/mm/pg-sb1.c:227: warning: passing arg 2 of `__raw_writeq' discards qualifiers from pointer target type

 Thanks for pointing this out.  That "const" shouldn't be on "base_reg" 
there, of course.  I'm committing a fix right now.  My apologies for 
inadequate testing.

> arch/mips/mm/pg-sb1.c: In function `clear_page':
> arch/mips/mm/pg-sb1.c:233: warning: cast from pointer to integer of different size
> arch/mips/mm/pg-sb1.c:237: warning: cast from pointer to integer of different size
> arch/mips/mm/pg-sb1.c: In function `copy_page':
> arch/mips/mm/pg-sb1.c:257: warning: cast from pointer to integer of different size
> arch/mips/mm/pg-sb1.c:258: warning: cast from pointer to integer of different size
> arch/mips/mm/pg-sb1.c:262: warning: cast from pointer to integer of different size
> arch/mips/mm/pg-sb1.c:263: warning: cast from pointer to integer of different size

 These are unrelated.  Essentially "CPHYSADDR(foo)" expands to 
"(int)(foo)" (that is, after having removed some unrelated bits) and it's 
not going to work in a portable way if "foo" is a pointer...  Thanks for 
your report though -- this code needs a rewrite for a proper 64-bit 
support and I'll try to have a look at it.

  Maciej
