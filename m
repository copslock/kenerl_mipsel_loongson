Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 03 Sep 2004 08:12:01 +0100 (BST)
Received: from mx1.redhat.com ([IPv6:::ffff:66.187.233.31]:21210 "EHLO
	mx1.redhat.com") by linux-mips.org with ESMTP id <S8224931AbUICHL5>;
	Fri, 3 Sep 2004 08:11:57 +0100
Received: from int-mx1.corp.redhat.com (int-mx1.corp.redhat.com [172.16.52.254])
	by mx1.redhat.com (8.12.10/8.12.10) with ESMTP id i837BuS0021027;
	Fri, 3 Sep 2004 03:11:56 -0400
Received: from localhost (mail@vpnuser5.surrey.redhat.com [172.16.9.5])
	by int-mx1.corp.redhat.com (8.11.6/8.11.6) with ESMTP id i837Bm324951;
	Fri, 3 Sep 2004 03:11:48 -0400
Received: from rsandifo by localhost with local (Exim 3.35 #1)
	id 1C38Ed-0000Eh-00; Fri, 03 Sep 2004 08:11:47 +0100
To: Richard Henderson <rth@redhat.com>
Cc: "Maciej W. Rozycki" <macro@linux-mips.org>,
	Nigel Stephens <nigel@mips.com>, gcc-patches@gcc.gnu.org,
	linux-mips@linux-mips.org
Subject: Re: [patch] MIPS/gcc: Revert removal of DImode shifts for 32-bit
 targets
References: <876580bm2e.fsf@redhat.com> <410F60DF.9020400@mips.com>
	<Pine.LNX.4.58L.0408042123030.31930@blysk.ds.pg.gda.pl>
	<87r7qiwz54.fsf@redhat.com> <20040809220838.GE16493@redhat.com>
	<87zn5336h7.fsf@redhat.com> <20040810232020.GA21922@redhat.com>
	<87eklnw0g7.fsf@redhat.com> <20040903065331.GG20559@redhat.com>
	<87sm9zg7dg.fsf@redhat.com> <20040903070858.GA24082@redhat.com>
From: Richard Sandiford <rsandifo@redhat.com>
Date: Fri, 03 Sep 2004 08:11:47 +0100
In-Reply-To: <20040903070858.GA24082@redhat.com> (Richard Henderson's
 message of "Fri, 3 Sep 2004 00:08:58 -0700")
Message-ID: <87oekng72k.fsf@redhat.com>
User-Agent: Gnus/5.1006 (Gnus v5.10.6) Emacs/21.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-Path: <rsandifo@redhat.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 5778
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: rsandifo@redhat.com
Precedence: bulk
X-list: linux-mips

Richard Henderson <rth@redhat.com> writes:
> On Fri, Sep 03, 2004 at 08:05:15AM +0100, Richard Sandiford wrote:
>>      However, on some machines, such as the 80386 and the 680x0, truncation
>>      only applies to shift operations and not the (real or pretended)
>>      bit-field operations.  Define @code{SHIFT_COUNT_TRUNCATED} to be zero on
>>      such machines.  Instead, add patterns to the @file{md} file that include
>>      the implied truncation of the shift instructions.
>> 
>> I was deliberately trying to avoid this fuzziness with the new target hook.
>
> Hmm.  I suppose we could pass the shift operation in there; 
> ASHIFT, LSHIFT, ZERO_EXTRACT, SIGN_EXTRACT.

But the point as I understand it is that the generic optimisers
(e.g. simplify-rtx.c) can't tell the difference between an ASHIFT
that came from an (ashift ...) in the instruction stream or from
something that was generated artificially by expand_compound_operation.

Richard
