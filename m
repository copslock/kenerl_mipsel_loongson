Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 04 Aug 2004 20:57:12 +0100 (BST)
Received: from pollux.ds.pg.gda.pl ([IPv6:::ffff:153.19.208.7]:10770 "EHLO
	pollux.ds.pg.gda.pl") by linux-mips.org with ESMTP
	id <S8224924AbUHDT5H>; Wed, 4 Aug 2004 20:57:07 +0100
Received: from localhost (localhost [127.0.0.1])
	by pollux.ds.pg.gda.pl (Postfix) with ESMTP
	id 7303DE1CC2; Wed,  4 Aug 2004 21:56:59 +0200 (CEST)
Received: from pollux.ds.pg.gda.pl ([127.0.0.1])
 by localhost (pollux [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
 id 06975-09; Wed,  4 Aug 2004 21:56:59 +0200 (CEST)
Received: from piorun.ds.pg.gda.pl (piorun.ds.pg.gda.pl [153.19.208.8])
	by pollux.ds.pg.gda.pl (Postfix) with ESMTP
	id 3B6BCE1C64; Wed,  4 Aug 2004 21:56:59 +0200 (CEST)
Received: from blysk.ds.pg.gda.pl (macro@blysk.ds.pg.gda.pl [153.19.208.6])
	by piorun.ds.pg.gda.pl (8.12.11/8.11.4) with ESMTP id i74JvFfF025382;
	Wed, 4 Aug 2004 21:57:16 +0200
Date: Wed, 4 Aug 2004 21:57:04 +0200 (CEST)
From: "Maciej W. Rozycki" <macro@linux-mips.org>
To: Nigel Stephens <nigel@mips.com>
Cc: Richard Sandiford <rsandifo@redhat.com>,
	Ralf Baechle <ralf@linux-mips.org>,
	Richard Henderson <rth@redhat.com>, gcc-patches@gcc.gnu.org,
	linux-mips@linux-mips.org
Subject: Re: [patch] MIPS/gcc: Revert removal of DImode shifts for 32-bit
 targets
In-Reply-To: <410F60DF.9020400@mips.com>
Message-ID: <Pine.LNX.4.58L.0408042123030.31930@blysk.ds.pg.gda.pl>
References: <Pine.LNX.4.55.0407191648451.3667@jurand.ds.pg.gda.pl>
 <87hds49bmo.fsf@redhat.com> <Pine.LNX.4.55.0407191907300.3667@jurand.ds.pg.gda.pl>
 <20040719213801.GD14931@redhat.com> <Pine.LNX.4.55.0407201505330.14824@jurand.ds.pg.gda.pl>
 <20040723202703.GB30931@redhat.com> <20040723211232.GB5138@linux-mips.org>
 <Pine.LNX.4.58L.0407261325470.3873@blysk.ds.pg.gda.pl> <410E9E25.7080104@mips.com>
 <87acxcbxfl.fsf@redhat.com> <410F5964.3010109@mips.com> <876580bm2e.fsf@redhat.com>
 <410F60DF.9020400@mips.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Virus-Scanned: by amavisd-new at pollux.ds.pg.gda.pl
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 5590
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Tue, 3 Aug 2004, Nigel Stephens wrote:

> Note that there is one slightly controversial aspect of these sequences, 
> which is that they don't truncate the shift count, so a shift outside of 
> the range 0 to 63 will generate an "unusual" result.  This didn't cause 
> any regression failures, and I believe that this is strictly speaking 
> acceptable for C, since a shift is undefined outside of this range - but 
> it could cause some "buggy" code to break. It wouldn't be hard to add an 
> extra mask with 0x3f if people were nervous about this - it's just that 
> I didn't have enough spare temp registers within the constraints of the 
> existing DImode patterns.

 Well, masking is trivial with no additional temporary :-) and for ashrdi3
we can "cheat" and use $at to require only a single additional instruction
compared to the others.

 Here are my proposals I've referred to previously.  Instruction counts
are 9, 9 and 10, respectively, as I've missed an additional instruction
required to handle shifts by 0 (or actually any multiples of 64).  The
semantics they implement corresponds to one of the dsllv, dsrlv and dsrav,
respectively.  I've expressed them in terms of functions rather than RTL
patterns, but a conversion is trivial.  This form was simply easier to
validate for me and they can be used as libgcc function replacements for
Linux for MIPS IV and higher ISAs.

long long __ashldi3(long long v, int c)
{
	long long r;
	long r0;

	asm(
		"sllv	%L0, %L2, %3\n\t"
		"sllv	%M0, %M2, %3\n\t"
		"not	%1, %3\n\t"
		"srlv	%1, %L2, %1\n\t"
		"srl	%1, %1, 1\n\t"
		"or	%M0, %M0, %1\n\t"
		"andi	%1, %3, 0x20\n\t"
		"movn	%M0, %L0, %1\n\t"
		"movn	%L0, $0, %1"
		: "=&r" (r), "=&r" (r0)
		: "r" (v), "r" (c));

	return r;
}

unsigned long long __lshrdi3(unsigned long long v, int c)
{
	unsigned long long r;
	long r0;

	asm(
		"srlv	%M0, %M2, %3\n\t"
		"srlv	%L0, %L2, %3\n\t"
		"not	%1, %3\n\t"
		"sllv	%1, %M2, %1\n\t"
		"sll	%1, %1, 1\n\t"
		"or	%L0, %L0, %1\n\t"
		"andi	%1, %3, 0x20\n\t"
		"movn	%L0, %M0, %1\n\t"
		"movn	%M0, $0, %1"
		: "=&r" (r), "=&r" (r0)
		: "r" (v), "r" (c));

	return r;
}

long long __ashrdi3(long long v, int c)
{
	long long r;
	long r0;

	asm(
		"not	%1, %3\n\t"
		"srav	%M0, %M2, %3\n\t"
		"srlv	%L0, %L2, %3\n\t"
		"sllv	%1, %M2, %1\n\t"
		"sll	%1, %1, 1\n\t"
		"or	%L0, %L0, %1\n\t"
		"andi	%1, %3, 0x20\n\t"
		".set	push\n\t"
		".set	noat\n\t"
		"sra	$1, %M2, 31\n\t"
		"movn	%L0, %M0, %1\n\t"
		"movn	%M0, $1, %1\n\t"
		".set	pop"
		: "=&r" (r), "=&r" (r0)
		: "r" (v), "r" (c));

	return r;
}

 I don't know if the middle-end is capable to express these operations,
but they are pure ALU, so I'd expect it to.

  Maciej
