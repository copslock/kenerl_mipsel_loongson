Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 10 Aug 2004 06:30:43 +0100 (BST)
Received: from mx1.redhat.com ([IPv6:::ffff:66.187.233.31]:46535 "EHLO
	mx1.redhat.com") by linux-mips.org with ESMTP id <S8224841AbUHJFai>;
	Tue, 10 Aug 2004 06:30:38 +0100
Received: from int-mx1.corp.redhat.com (int-mx1.corp.redhat.com [172.16.52.254])
	by mx1.redhat.com (8.12.10/8.12.10) with ESMTP id i7A5UZe1007950;
	Tue, 10 Aug 2004 01:30:35 -0400
Received: from localhost (mail@vpnuser2.surrey.redhat.com [172.16.9.2])
	by int-mx1.corp.redhat.com (8.11.6/8.11.6) with ESMTP id i7A5UUa11250;
	Tue, 10 Aug 2004 01:30:30 -0400
Received: from rsandifo by localhost with local (Exim 3.35 #1)
	id 1BuPDQ-00008W-00; Tue, 10 Aug 2004 06:30:28 +0100
To: Richard Henderson <rth@redhat.com>
Cc: "Maciej W. Rozycki" <macro@linux-mips.org>,
	Nigel Stephens <nigel@mips.com>, gcc-patches@gcc.gnu.org,
	linux-mips@linux-mips.org
Subject: Re: [patch] MIPS/gcc: Revert removal of DImode shifts for 32-bit
 targets
References: <20040723202703.GB30931@redhat.com>
	<20040723211232.GB5138@linux-mips.org>
	<Pine.LNX.4.58L.0407261325470.3873@blysk.ds.pg.gda.pl>
	<410E9E25.7080104@mips.com> <87acxcbxfl.fsf@redhat.com>
	<410F5964.3010109@mips.com> <876580bm2e.fsf@redhat.com>
	<410F60DF.9020400@mips.com>
	<Pine.LNX.4.58L.0408042123030.31930@blysk.ds.pg.gda.pl>
	<87r7qiwz54.fsf@redhat.com> <20040809220838.GE16493@redhat.com>
From: Richard Sandiford <rsandifo@redhat.com>
Date: Tue, 10 Aug 2004 06:30:28 +0100
In-Reply-To: <20040809220838.GE16493@redhat.com> (Richard Henderson's
 message of "Mon, 9 Aug 2004 15:08:38 -0700")
Message-ID: <87zn5336h7.fsf@redhat.com>
User-Agent: Gnus/5.1006 (Gnus v5.10.6) Emacs/21.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-Path: <rsandifo@redhat.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 5616
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: rsandifo@redhat.com
Precedence: bulk
X-list: linux-mips

Richard Henderson <rth@redhat.com> writes:
> On Sat, Aug 07, 2004 at 08:01:43PM +0100, Richard Sandiford wrote:
>> +   do_compare_rtx_and_jump (cmp1, cmp2, cmp_code, true, op1_mode,
>> + 			   0, 0, subword_label);
>> + 
>> +   if (!expand_superword_shift (op1_mode, binoptab,
>> + 			       outof_input, op1,
>> + 			       outof_target, into_target,
>> + 			       unsignedp, methods))
>> +     return false;
>
> Return without cleaning up the branch emitted?  In particular,
> doing so without emitting the labels will result in ICEs.

The whole thing's in a sequence that gets discarded if
expand_doubleword_shift returns false.  Isn't that enough?

Richad
