Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 04 Aug 2004 21:54:45 +0100 (BST)
Received: from pollux.ds.pg.gda.pl ([IPv6:::ffff:153.19.208.7]:50192 "EHLO
	pollux.ds.pg.gda.pl") by linux-mips.org with ESMTP
	id <S8224986AbUHDUyk>; Wed, 4 Aug 2004 21:54:40 +0100
Received: from localhost (localhost [127.0.0.1])
	by pollux.ds.pg.gda.pl (Postfix) with ESMTP
	id A2888E1CC5; Wed,  4 Aug 2004 22:54:33 +0200 (CEST)
Received: from pollux.ds.pg.gda.pl ([127.0.0.1])
 by localhost (pollux [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
 id 21857-07; Wed,  4 Aug 2004 22:54:33 +0200 (CEST)
Received: from piorun.ds.pg.gda.pl (piorun.ds.pg.gda.pl [153.19.208.8])
	by pollux.ds.pg.gda.pl (Postfix) with ESMTP
	id 67ECCE1CC2; Wed,  4 Aug 2004 22:54:33 +0200 (CEST)
Received: from blysk.ds.pg.gda.pl (macro@blysk.ds.pg.gda.pl [153.19.208.6])
	by piorun.ds.pg.gda.pl (8.12.11/8.11.4) with ESMTP id i74KspuH028027;
	Wed, 4 Aug 2004 22:54:51 +0200
Date: Wed, 4 Aug 2004 22:54:39 +0200 (CEST)
From: "Maciej W. Rozycki" <macro@linux-mips.org>
To: Nigel Stephens <nigel@mips.com>
Cc: Richard Sandiford <rsandifo@redhat.com>,
	Ralf Baechle <ralf@linux-mips.org>,
	Richard Henderson <rth@redhat.com>, gcc-patches@gcc.gnu.org,
	linux-mips@linux-mips.org
Subject: Re: [patch] MIPS/gcc: Revert removal of DImode shifts for 32-bit
 targets
In-Reply-To: <411148F0.2040605@mips.com>
Message-ID: <Pine.LNX.4.58L.0408042239260.11595@blysk.ds.pg.gda.pl>
References: <Pine.LNX.4.55.0407191648451.3667@jurand.ds.pg.gda.pl>
 <87hds49bmo.fsf@redhat.com> <Pine.LNX.4.55.0407191907300.3667@jurand.ds.pg.gda.pl>
 <20040719213801.GD14931@redhat.com> <Pine.LNX.4.55.0407201505330.14824@jurand.ds.pg.gda.pl>
 <20040723202703.GB30931@redhat.com> <20040723211232.GB5138@linux-mips.org>
 <Pine.LNX.4.58L.0407261325470.3873@blysk.ds.pg.gda.pl> <410E9E25.7080104@mips.com>
 <87acxcbxfl.fsf@redhat.com> <410F5964.3010109@mips.com> <876580bm2e.fsf@redhat.com>
 <410F60DF.9020400@mips.com> <Pine.LNX.4.58L.0408042123030.31930@blysk.ds.pg.gda.pl>
 <411148F0.2040605@mips.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Virus-Scanned: by amavisd-new at pollux.ds.pg.gda.pl
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 5592
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Wed, 4 Aug 2004, Nigel Stephens wrote:

> > Here are my proposals I've referred to previously.  Instruction counts
> >are 9, 9 and 10, respectively, as I've missed an additional instruction
> >required to handle shifts by 0 (or actually any multiples of 64). 
> 
> IMHO handling a shift by zero correctly is important.

 Agreed, hence an additional instruction needed.

> >		"not	%1, %3\n\t"
> >		"srlv	%1, %L2, %1\n\t"
> >		"srl	%1, %1, 1\n\t"
> >
> 
> Why not the shorter:
> 
> >		"neg	%1, %3\n\t"
> >		"srlv	%1, %L2, %1\n\t"

 Notice the difference -- this shorter code doesn't handle shifts by zero
correctly. ;-)

> And then in __ashrdi3:
> 
> 		"andi	%1, %3, 0x20\n\t"
> 		".set	push\n\t"
> 		".set	noat\n\t"
> 		"sra	$1, %M2, 31\n\t"
> 		"movn	%L0, %M0, %1\n\t"
> 		"movn	%M0, $1, %1\n\t"
> 		".set	pop"
> 
> Cute, but I think that should be
> 
> 	"sra	$1, %M0, 31\n\t"
> 
> (i.e %M0 not %M2)

 Well, I've tested it for all shift counts and it works properly as is --
we care of the value of bit #31 to be shifted only and at this stage it's
the same in both registers.  So it's just a matter of style.

  Maciej
