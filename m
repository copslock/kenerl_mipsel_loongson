Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 03 Aug 2004 10:36:18 +0100 (BST)
Received: from mx1.redhat.com ([IPv6:::ffff:66.187.233.31]:48045 "EHLO
	mx1.redhat.com") by linux-mips.org with ESMTP id <S8224935AbUHCJgO>;
	Tue, 3 Aug 2004 10:36:14 +0100
Received: from int-mx1.corp.redhat.com (int-mx1.corp.redhat.com [172.16.52.254])
	by mx1.redhat.com (8.12.10/8.12.10) with ESMTP id i739aCe1002002;
	Tue, 3 Aug 2004 05:36:12 -0400
Received: from localhost (mail@vpnuser3.surrey.redhat.com [172.16.9.3])
	by int-mx1.corp.redhat.com (8.11.6/8.11.6) with ESMTP id i739aBa08652;
	Tue, 3 Aug 2004 05:36:11 -0400
Received: from rsandifo by localhost with local (Exim 3.35 #1)
	id 1BrviM-0006kp-00; Tue, 03 Aug 2004 10:36:10 +0100
To: Nigel Stephens <nigel@mips.com>
Cc: "Maciej W. Rozycki" <macro@linux-mips.org>,
	Ralf Baechle <ralf@linux-mips.org>,
	Richard Henderson <rth@redhat.com>, gcc-patches@gcc.gnu.org,
	linux-mips@linux-mips.org
Subject: Re: [patch] MIPS/gcc: Revert removal of DImode shifts for 32-bit
 targets
References: <Pine.LNX.4.55.0407191648451.3667@jurand.ds.pg.gda.pl>
	<87hds49bmo.fsf@redhat.com>
	<Pine.LNX.4.55.0407191907300.3667@jurand.ds.pg.gda.pl>
	<20040719213801.GD14931@redhat.com>
	<Pine.LNX.4.55.0407201505330.14824@jurand.ds.pg.gda.pl>
	<20040723202703.GB30931@redhat.com>
	<20040723211232.GB5138@linux-mips.org>
	<Pine.LNX.4.58L.0407261325470.3873@blysk.ds.pg.gda.pl>
	<410E9E25.7080104@mips.com> <87acxcbxfl.fsf@redhat.com>
	<410F5964.3010109@mips.com>
From: Richard Sandiford <rsandifo@redhat.com>
Date: Tue, 03 Aug 2004 10:36:09 +0100
In-Reply-To: <410F5964.3010109@mips.com> (Nigel Stephens's message of "Tue,
 03 Aug 2004 10:22:44 +0100")
Message-ID: <876580bm2e.fsf@redhat.com>
User-Agent: Gnus/5.1006 (Gnus v5.10.6) Emacs/21.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-Path: <rsandifo@redhat.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 5583
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: rsandifo@redhat.com
Precedence: bulk
X-list: linux-mips

Nigel Stephens <nigel@mips.com> writes:
>>If we handle it in a target-independent way, with each insn exposed
>>separately, we will be able to optimize special cases better.
>>We'll also get the usual scheduling benefits.
>
> I agree that we should open-code it for the obvious reasons, but does it
> have to be target independent, or could/should we prototype it with
> define_expand?

I think we should only use define_expands if there's a truly
MIPS-specific feature in the expansion (as there is in the block
move stuff, for example, where we use left/right loads and stores).

Now obviously I'm only guessing what insn sequence you're using,
but I suspect it doesn't involve anything that the middle-end
couldn't work out from stock optabs.  If there are different
trade-offs to be made during the expansion, they should probably
be predicated on rtx_costs.

Richard
