Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 01 Dec 2004 21:50:56 +0000 (GMT)
Received: from pollux.ds.pg.gda.pl ([IPv6:::ffff:153.19.208.7]:35849 "EHLO
	pollux.ds.pg.gda.pl") by linux-mips.org with ESMTP
	id <S8225979AbULAVuv>; Wed, 1 Dec 2004 21:50:51 +0000
Received: from localhost (localhost [127.0.0.1])
	by pollux.ds.pg.gda.pl (Postfix) with ESMTP
	id 2C8ACF59C4; Wed,  1 Dec 2004 22:50:44 +0100 (CET)
Received: from pollux.ds.pg.gda.pl ([127.0.0.1])
 by localhost (pollux [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
 id 26042-02; Wed,  1 Dec 2004 22:50:44 +0100 (CET)
Received: from piorun.ds.pg.gda.pl (piorun.ds.pg.gda.pl [153.19.208.8])
	by pollux.ds.pg.gda.pl (Postfix) with ESMTP
	id 26DDAF59BB; Wed,  1 Dec 2004 22:50:43 +0100 (CET)
Received: from blysk.ds.pg.gda.pl (macro@blysk.ds.pg.gda.pl [153.19.208.6])
	by piorun.ds.pg.gda.pl (8.13.1/8.13.1) with ESMTP id iB1LovVx003190;
	Wed, 1 Dec 2004 22:50:59 +0100
Date: Wed, 1 Dec 2004 21:50:45 +0000 (GMT)
From: "Maciej W. Rozycki" <macro@linux-mips.org>
To: Ralf Baechle <ralf@linux-mips.org>
Cc: Dominic Sweetman <dom@mips.com>,
	Thiemo Seufer <ica2_ts@csv.ica.uni-stuttgart.de>,
	linux-mips@linux-mips.org, Nigel Stephens <nigel@mips.com>,
	David Ung <davidu@mips.com>
Subject: Re: [PATCH] Improve atomic.h implementation robustness
In-Reply-To: <20041201123336.GA5612@linux-mips.org>
Message-ID: <Pine.LNX.4.58L.0412012136480.13579@blysk.ds.pg.gda.pl>
References: <20041201070014.GG3225@rembrandt.csv.ica.uni-stuttgart.de>
 <16813.39660.948092.328493@doms-laptop.algor.co.uk> <20041201123336.GA5612@linux-mips.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Virus-Scanned: ClamAV 0.80/605/Wed Nov 24 15:09:47 2004
	clamav-milter version 0.80j
	on piorun.ds.pg.gda.pl
X-Virus-Status: Clean
X-Virus-Scanned: by amavisd-new at pollux.ds.pg.gda.pl
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 6528
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Wed, 1 Dec 2004, Ralf Baechle wrote:

> this problem here is specific to inline assembler.  The splitlock code for
> a reasonable CPU is:
> 
> static __inline__ void atomic_add(int i, atomic_t * v)
> {
>         unsigned long temp;
> 
>         __asm__ __volatile__(
>         "1:     ll      %0, %1          # atomic_add            \n"
>         "       addu    %0, %2                                  \n"
>         "       sc      %0, %1                                  \n"
>         "       beqz    %0, 1b                                  \n"
>         : "=&r" (temp), "=m" (v->counter)
>         : "Ir" (i), "m" (v->counter));
> }
> 
> For the average atomic op generated code is going to look about like:
> 
> 80100634:       lui     a0,0x802c
> 80100638:       ll      a0,-24160(a0)
> 8010063c:       addu    a0,a0,v0
> 80100640:       lui     at,0x802c
> 80100644:       addu    at,at,v1
> 80100648:       sc      a0,-24160(at)
> 8010064c:       beqz    a0,80100634 <init+0x194>
> 80100650:       nop
> 
> It's significantly worse for 64-bit due to the excessive code sequence
> generated for loading a 64-bit address.  One outside CKSEGx that is.

 Only for old compilers.  For current (>= 3.4) ones you can use the "R"  
constraint and get exactly what you need.  Rewriting inline asms to use
"R" for GCC >= 3.4 has actually been on my to-do list for some time;  
predating the current working implementation even.

> On 32-bit Thiemo's patch would cut that down to something like:
> 
> 80100630:       lui     t0,0x802c
> 80100634:       addiu	t0,t0,-24160
> 80100638:       ll      a0,0(t0)
> 8010063c:       addu    a0,a0,v0
> 80100648:       sc      a0,0(to)
> 8010064c:       beqz    a0,80100638 <init+0x194>
> 80100650:       nop

 Plus it clobbers memory requiring a writeback and a refetch of all
unrelated variables that have happened to be cached in registers.

> On 64-bit the savings would be even more significant.  But what we actually
> want would be using the "o" constraint.  Which just at least on the
> compilers where I've tried it, didn't produce code any different from "m".

 No surprise as the "o" constraint doesn't mean anything particular for
MIPS.  All addresses are offsettable -- there is no addressing mode that
would preclude it, so "o" is exactly the same as "m".

> The expected code would be something like:
> 
> 80100634:       lui     t0,0x802c
> 80100638:       ll      a0,-24160(t0)
> 8010063c:       addu    a0,a0,v0
> 80100648:       sc      a0,-24160(to)
> 8010064c:       beqz    a0,80100634 <init+0x194>
> 80100650:       nop
> 
> So another instruction less.

 That's exactly what's emitted with "R".  Should I accelerate my work on
it?  It's nothing that would require a lot of effort -- it's more boring 
than challenging.

  Maciej
