Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 07 Dec 2004 11:57:10 +0000 (GMT)
Received: from mx1.redhat.com ([IPv6:::ffff:66.187.233.31]:29117 "EHLO
	mx1.redhat.com") by linux-mips.org with ESMTP id <S8225237AbULGL5E>;
	Tue, 7 Dec 2004 11:57:04 +0000
Received: from int-mx1.corp.redhat.com (int-mx1.corp.redhat.com [172.16.52.254])
	by mx1.redhat.com (8.12.11/8.12.11) with ESMTP id iB7Bux02007467;
	Tue, 7 Dec 2004 06:56:59 -0500
Received: from talisman.cambridge.redhat.com (talisman.cambridge.redhat.com [172.16.18.81])
	by int-mx1.corp.redhat.com (8.11.6/8.11.6) with ESMTP id iB7Buvr16592;
	Tue, 7 Dec 2004 06:56:58 -0500
Received: from talisman.cambridge.redhat.com (localhost.localdomain [127.0.0.1])
	by talisman.cambridge.redhat.com (8.13.1/8.12.10) with ESMTP id iB7BuuaV016939;
	Tue, 7 Dec 2004 11:56:56 GMT
Received: (from rsandifo@localhost)
	by talisman.cambridge.redhat.com (8.13.1/8.12.10/Submit) id iB7BuscA016938;
	Tue, 7 Dec 2004 11:56:54 GMT
X-Authentication-Warning: talisman.cambridge.redhat.com: rsandifo set sender to rsandifo@redhat.com using -f
To: "Maciej W. Rozycki" <macro@linux-mips.org>
Cc: Ralf Baechle <ralf@linux-mips.org>,
	Dominic Sweetman <dom@mips.com>,
	Thiemo Seufer <ica2_ts@csv.ica.uni-stuttgart.de>,
	linux-mips@linux-mips.org, Nigel Stephens <nigel@mips.com>,
	David Ung <davidu@mips.com>
Subject: Re: [PATCH] Improve atomic.h implementation robustness
References: <20041201070014.GG3225@rembrandt.csv.ica.uni-stuttgart.de>
	<16813.39660.948092.328493@doms-laptop.algor.co.uk>
	<20041201123336.GA5612@linux-mips.org>
	<Pine.LNX.4.58L.0412012136480.13579@blysk.ds.pg.gda.pl>
From: Richard Sandiford <rsandifo@redhat.com>
Date: Tue, 07 Dec 2004 11:56:54 +0000
In-Reply-To: <Pine.LNX.4.58L.0412012136480.13579@blysk.ds.pg.gda.pl> (Maciej
 W. Rozycki's message of "Wed, 1 Dec 2004 21:50:45 +0000 (GMT)")
Message-ID: <wvn653epbi1.fsf@talisman.cambridge.redhat.com>
User-Agent: Gnus/5.1006 (Gnus v5.10.6) Emacs/21.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-Path: <rsandifo@redhat.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 6581
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: rsandifo@redhat.com
Precedence: bulk
X-list: linux-mips

I've only been reading this list in batches recently, so this reply
has quotes from several separate messages, sorry.

First some general comments:

  - Explicit relocs for n64 non-PIC weren't implemented before the gcc 3.4
    feature freeze.  gcc 3.4.x therefore still uses symbolic addresses when
    compiling a 64-bit kernel.

  - gcc 4.0 knows how to generate explicit relocs for n64 non-PIC and
    (by default) will use them instead of symbolic addresses.

  - As Thiemo says, there as talk of a -msym32 option (more below), but it
    hasn't been implemented yet.  This means that if you want to the use
    the 2-instruction dla hack, you'll need to use -mno-explicit-relocs
    when compiling with 4.0.  Don't count on that option being around
    forever though!

"Maciej W. Rozycki" <macro@linux-mips.org> writes:
> On Wed, 1 Dec 2004, Ralf Baechle wrote:
>> this problem here is specific to inline assembler.  The splitlock code for
>> a reasonable CPU is:
>> 
>> static __inline__ void atomic_add(int i, atomic_t * v)
>> {
>>         unsigned long temp;
>> 
>>         __asm__ __volatile__(
>>         "1:     ll      %0, %1          # atomic_add            \n"
>>         "       addu    %0, %2                                  \n"
>>         "       sc      %0, %1                                  \n"
>>         "       beqz    %0, 1b                                  \n"
>>         : "=&r" (temp), "=m" (v->counter)
>>         : "Ir" (i), "m" (v->counter));
>> }
>> 
>> For the average atomic op generated code is going to look about like:
>> 
>> 80100634:       lui     a0,0x802c
>> 80100638:       ll      a0,-24160(a0)
>> 8010063c:       addu    a0,a0,v0
>> 80100640:       lui     at,0x802c
>> 80100644:       addu    at,at,v1
>> 80100648:       sc      a0,-24160(at)
>> 8010064c:       beqz    a0,80100634 <init+0x194>
>> 80100650:       nop
>> 
>> It's significantly worse for 64-bit due to the excessive code sequence
>> generated for loading a 64-bit address.  One outside CKSEGx that is.
>
>  Only for old compilers.  For current (>= 3.4) ones you can use the "R"  
> constraint and get exactly what you need.

Right.  IMO, this is exactly the right fix.  It should be backward
compatible with old toolchains too.

FYI, the 'R' constraint has been kept around specifically for inline asms.
gcc itself no longer uses it.

"Maciej W. Rozycki" <macro@linux-mips.org> writes:
> On Wed, 1 Dec 2004, Ralf Baechle wrote:
>> On 64-bit the savings would be even more significant.  But what we actually
>> want would be using the "o" constraint.  Which just at least on the
>> compilers where I've tried it, didn't produce code any different from "m".
>
>  No surprise as the "o" constraint doesn't mean anything particular for
> MIPS.  All addresses are offsettable -- there is no addressing mode that
> would preclude it, so "o" is exactly the same as "m".

Right!

Thiemo Seufer <ica2_ts@csv.ica.uni-stuttgart.de> writes:
> Current 64bit MIPS kernels run in (C)KSEG0, and exploit sign-extension
> to optimize symbol loads (2 instead of 6/7 instructions, the same as in
> 32bit kernels). This optimization relies on an assembler macro
> expansion mode which was hacked in gas for exactly this purpose. Gcc
> currently doesn't have something similiar, and would try to do a regular
> 64bit load with explicit relocs.
>
> I discussed this with Richard Sandiford a while ago, and the conclusion
> was to implement an explicit --msym32 option for both gcc and gas to
> improve register scheduling and get rid of the gas hack. So far, nobody
> came around to actually do the work for it.

True.  FWIW, it's trivial to add this option to gcc.  As far as I remember,
the stumbling block was whether we should mark the objects in some way,
and whether the linker ought to check for overflow.

Richard
