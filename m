Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.5/8.12.5) with ESMTP id g6BD8aRw030015
	for <linux-mips-outgoing@oss.sgi.com>; Thu, 11 Jul 2002 06:08:36 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.5/8.12.3/Submit) id g6BD8anM030014
	for linux-mips-outgoing; Thu, 11 Jul 2002 06:08:36 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from t111.niisi.ras.ru (t111.niisi.ras.ru [193.232.173.111])
	by oss.sgi.com (8.12.5/8.12.5) with SMTP id g6BD8ORw030005
	for <linux-mips@oss.sgi.com>; Thu, 11 Jul 2002 06:08:25 -0700
Received: from t06.niisi.ras.ru (t06.niisi.ras.ru [193.232.173.6])
	by t111.niisi.ras.ru (8.9.1/8.9.1) with ESMTP id RAA06424;
	Thu, 11 Jul 2002 17:12:46 +0400
Received: (from uucp@localhost) by t06.niisi.ras.ru (8.7.6/8.7.3) with UUCP id RAA25914; Thu, 11 Jul 2002 17:10:51 +0400
Received: from niisi.msk.ru (t34 [193.232.173.34]) by niisi.msk.ru (8.8.8/8.8.8) with ESMTP id RAA23766; Thu, 11 Jul 2002 17:06:52 +0400 (MSK)
Message-ID: <3D2D83FF.A2FAAB38@niisi.msk.ru>
Date: Thu, 11 Jul 2002 17:11:27 +0400
From: "Gleb O. Raiko" <raiko@niisi.msk.ru>
Organization: NIISI RAN
X-Mailer: Mozilla 4.79 [en] (WinNT; U)
X-Accept-Language: en,ru
MIME-Version: 1.0
To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
CC: linux-mips@oss.sgi.com
Subject: Re: mips32_flush_cache routine corrupts CP0_STATUS with gcc-2.96
References: <Pine.GSO.3.96.1020711130202.7876C-100000@delta.ds2.pg.gda.pl>
Content-Type: text/plain; charset=x-user-defined
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, hits=0.0 required=5.0 tests= version=2.20
X-Spam-Level: 
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

"Maciej W. Rozycki" wrote:
> 
> On Thu, 11 Jul 2002, Gleb O. Raiko wrote:
> > I don't wonder if other IDT CPUs also require this, including those that
> > conform MIPS32.
> 
>  Well, for r3k it may seem somewhat justified as cache flushing requires
> cache isolation.  But the IDT manual for their whole family of processors
> claims the D-cache can function as an I-cache (when swapped; doesn't
> apply when not, obviously) and cache flushing can run from KSEG0.
> 
>  See "IDT MIPS Microprocessor Family Software Reference Manual", chapter 5
> "Cache Management", section "Invalidation":
> 
>  "To invalidate the cache in the R30xx:
> [...]
>  The invalidate routine is normally executed with its instructions
> cacheable.  This sounds like a lot of trouble; but in fact shouldnt
> require any extra steps to run cached. An invalidation routine in uncached
> space will run 4-10 times slower."
> 

Aha, you also stepped on this rake. :-) The problem with IDT manuals
that they frequently contradict itself. You're right, SW manual allows
cached flushes, but hardware manuals for the family prohibit this and
state that flashes must be uncahed.
(a hw manual on family, the same chapter, the same section :-) )

It's not only the place where IDT manuals are wrong. For example, their
wbflush example suggests *(int*)KSEG0 instead *(int*)KSEG1.

> > Basically, requirement of uncached run makes hadrware logic much simpler
> > and allows  to save silicon a bit.
> 
>  Why?  I see no dependency.  What's the problem with interleaving cache
> fills and invalidations?

There're two possible optimization:
1. (Requires only the instruction that swaps caches must run uncached)
	CPU may skip implementation of double check of cache hit on loads.
	Scenario: mtc0 with cache swapping with ensuring next instructions are
in cache
	(pipelining here!); swap occurs; must check again the instructions are
in 
	the cache because the same cacheline in the data cache may have valid
bit set
	and CPU will get data instead of code.
2. (Requires the whole routine must run uncached)
	CPU may skip check of cache hit on loads from an isolated cache. 

i don't know what optimization IDT made, perhaps, number 3. But, 1. is
really worth to implement.

Regards,
Gleb.
