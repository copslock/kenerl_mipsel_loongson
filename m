Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 04 Aug 2004 21:37:34 +0100 (BST)
Received: from alg145.algor.co.uk ([IPv6:::ffff:62.254.210.145]:12551 "EHLO
	dmz.algor.co.uk") by linux-mips.org with ESMTP id <S8224986AbUHDUhV>;
	Wed, 4 Aug 2004 21:37:21 +0100
Received: from alg158.algor.co.uk ([62.254.210.158] helo=olympia.mips.com)
	by dmz.algor.co.uk with esmtp (Exim 3.35 #1 (Debian))
	id 1BsSh9-0008J3-00; Wed, 04 Aug 2004 21:49:07 +0100
Received: from highbury.mips.com ([192.168.192.236] helo=mips.com)
	by olympia.mips.com with esmtp (Exim 3.36 #1 (Debian))
	id 1BsSVU-00054D-00; Wed, 04 Aug 2004 21:37:04 +0100
Message-ID: <411148F0.2040605@mips.com>
Date: Wed, 04 Aug 2004 21:37:04 +0100
From: Nigel Stephens <nigel@mips.com>
Organization: MIPS Technologies
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-GB; rv:1.4) Gecko/20030624
X-Accept-Language: en-gb, en-us, en
MIME-Version: 1.0
To: "Maciej W. Rozycki" <macro@linux-mips.org>
CC: Richard Sandiford <rsandifo@redhat.com>,
	Ralf Baechle <ralf@linux-mips.org>,
	Richard Henderson <rth@redhat.com>, gcc-patches@gcc.gnu.org,
	linux-mips@linux-mips.org
Subject: Re: [patch] MIPS/gcc: Revert removal of DImode shifts for 32-bit
 targets
References: <Pine.LNX.4.55.0407191648451.3667@jurand.ds.pg.gda.pl> <87hds49bmo.fsf@redhat.com> <Pine.LNX.4.55.0407191907300.3667@jurand.ds.pg.gda.pl> <20040719213801.GD14931@redhat.com> <Pine.LNX.4.55.0407201505330.14824@jurand.ds.pg.gda.pl> <20040723202703.GB30931@redhat.com> <20040723211232.GB5138@linux-mips.org> <Pine.LNX.4.58L.0407261325470.3873@blysk.ds.pg.gda.pl> <410E9E25.7080104@mips.com> <87acxcbxfl.fsf@redhat.com> <410F5964.3010109@mips.com> <876580bm2e.fsf@redhat.com> <410F60DF.9020400@mips.com> <Pine.LNX.4.58L.0408042123030.31930@blysk.ds.pg.gda.pl>
In-Reply-To: <Pine.LNX.4.58L.0408042123030.31930@blysk.ds.pg.gda.pl>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-MTUK-Scanner: Found to be clean
X-MTUK-SpamCheck: not spam, SpamAssassin (score=-4.226, required 4, AWL,
	BAYES_00, USER_AGENT_MOZILLA_UA)
Return-Path: <nigel@mips.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 5591
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: nigel@mips.com
Precedence: bulk
X-list: linux-mips

Maciej W. Rozycki wrote:

> Here are my proposals I've referred to previously.  Instruction counts
>are 9, 9 and 10, respectively, as I've missed an additional instruction
>required to handle shifts by 0 (or actually any multiples of 64). 
>

IMHO handling a shift by zero correctly is important.

>		"not	%1, %3\n\t"
>		"srlv	%1, %L2, %1\n\t"
>		"srl	%1, %1, 1\n\t"
>

Why not the shorter:

>		"neg	%1, %3\n\t"
>		"srlv	%1, %L2, %1\n\t"
>
>  
>

And then in __ashrdi3:

		"andi	%1, %3, 0x20\n\t"
		".set	push\n\t"
		".set	noat\n\t"
		"sra	$1, %M2, 31\n\t"
		"movn	%L0, %M0, %1\n\t"
		"movn	%M0, $1, %1\n\t"
		".set	pop"

Cute, but I think that should be

	"sra	$1, %M0, 31\n\t"

(i.e %M0 not %M2)

Nigel
