Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 01 Dec 2004 12:35:53 +0000 (GMT)
Received: from p508B7F35.dip.t-dialin.net ([IPv6:::ffff:80.139.127.53]:20609
	"EHLO mail.linux-mips.net") by linux-mips.org with ESMTP
	id <S8225210AbULAMft>; Wed, 1 Dec 2004 12:35:49 +0000
Received: from fluff.linux-mips.net (localhost.localdomain [127.0.0.1])
	by mail.linux-mips.net (8.13.1/8.13.1) with ESMTP id iB1CXkHv005963;
	Wed, 1 Dec 2004 13:33:46 +0100
Received: (from ralf@localhost)
	by fluff.linux-mips.net (8.13.1/8.13.1/Submit) id iB1CXaXu005962;
	Wed, 1 Dec 2004 13:33:36 +0100
Date: Wed, 1 Dec 2004 13:33:36 +0100
From: Ralf Baechle <ralf@linux-mips.org>
To: Dominic Sweetman <dom@mips.com>
Cc: Thiemo Seufer <ica2_ts@csv.ica.uni-stuttgart.de>,
	linux-mips@linux-mips.org, Nigel Stephens <nigel@mips.com>,
	David Ung <davidu@mips.com>
Subject: Re: [PATCH] Improve atomic.h implementation robustness
Message-ID: <20041201123336.GA5612@linux-mips.org>
References: <20041201070014.GG3225@rembrandt.csv.ica.uni-stuttgart.de> <16813.39660.948092.328493@doms-laptop.algor.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <16813.39660.948092.328493@doms-laptop.algor.co.uk>
User-Agent: Mutt/1.4.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 6518
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Wed, Dec 01, 2004 at 10:20:28AM +0000, Dominic Sweetman wrote:

> > the atomic functions use so far memory references for the inline
> > assembler to access the semaphore. This can lead to additional
> > instructions in the ll/sc loop, because newer compilers don't
> > expand the memory reference any more but leave it to the assembler.
> > 
> > The appended patch...
> 
> I thought it was an explicit aim of the substantial rewrite of the
> MIPS backend for 3.x to get the compiler to generate only "real"
> instructions, not macros which expand to multiple instructions inside
> the assembler.  So it's disappointing if newer compilers got worse.
> 
> Can one of our compiler-knowledgable people follow this up?

Dominik,

this problem here is specific to inline assembler.  The splitlock code for
a reasonable CPU is:

static __inline__ void atomic_add(int i, atomic_t * v)
{
        unsigned long temp;

        __asm__ __volatile__(
        "1:     ll      %0, %1          # atomic_add            \n"
        "       addu    %0, %2                                  \n"
        "       sc      %0, %1                                  \n"
        "       beqz    %0, 1b                                  \n"
        : "=&r" (temp), "=m" (v->counter)
        : "Ir" (i), "m" (v->counter));
}

For the average atomic op generated code is going to look about like:

80100634:       lui     a0,0x802c
80100638:       ll      a0,-24160(a0)
8010063c:       addu    a0,a0,v0
80100640:       lui     at,0x802c
80100644:       addu    at,at,v1
80100648:       sc      a0,-24160(at)
8010064c:       beqz    a0,80100634 <init+0x194>
80100650:       nop

It's significantly worse for 64-bit due to the excessive code sequence
generated for loading a 64-bit address.  One outside CKSEGx that is.

On 32-bit Thiemo's patch would cut that down to something like:

80100630:       lui     t0,0x802c
80100634:       addiu	t0,t0,-24160
80100638:       ll      a0,0(t0)
8010063c:       addu    a0,a0,v0
80100648:       sc      a0,0(to)
8010064c:       beqz    a0,80100638 <init+0x194>
80100650:       nop

On 64-bit the savings would be even more significant.  But what we actually
want would be using the "o" constraint.  Which just at least on the
compilers where I've tried it, didn't produce code any different from "m".
The expected code would be something like:

80100634:       lui     t0,0x802c
80100638:       ll      a0,-24160(t0)
8010063c:       addu    a0,a0,v0
80100648:       sc      a0,-24160(to)
8010064c:       beqz    a0,80100634 <init+0x194>
80100650:       nop

So another instruction less.

  Ralf
