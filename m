Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 03 Sep 2004 08:29:49 +0100 (BST)
Received: from mx1.redhat.com ([IPv6:::ffff:66.187.233.31]:32225 "EHLO
	mx1.redhat.com") by linux-mips.org with ESMTP id <S8224952AbUICH3o>;
	Fri, 3 Sep 2004 08:29:44 +0100
Received: from int-mx1.corp.redhat.com (int-mx1.corp.redhat.com [172.16.52.254])
	by mx1.redhat.com (8.12.10/8.12.10) with ESMTP id i837ThS0024900;
	Fri, 3 Sep 2004 03:29:43 -0400
Received: from localhost (mail@vpnuser5.surrey.redhat.com [172.16.9.5])
	by int-mx1.corp.redhat.com (8.11.6/8.11.6) with ESMTP id i837Tf327840;
	Fri, 3 Sep 2004 03:29:41 -0400
Received: from rsandifo by localhost with local (Exim 3.35 #1)
	id 1C38Vv-0000H9-00; Fri, 03 Sep 2004 08:29:39 +0100
To: Richard Henderson <rth@redhat.com>
Cc: "Maciej W. Rozycki" <macro@linux-mips.org>,
	Nigel Stephens <nigel@mips.com>, gcc-patches@gcc.gnu.org,
	linux-mips@linux-mips.org
Subject: Re: [patch] MIPS/gcc: Revert removal of DImode shifts for 32-bit
 targets
References: <Pine.LNX.4.58L.0408042123030.31930@blysk.ds.pg.gda.pl>
	<87r7qiwz54.fsf@redhat.com> <20040809220838.GE16493@redhat.com>
	<87zn5336h7.fsf@redhat.com> <20040810232020.GA21922@redhat.com>
	<87eklnw0g7.fsf@redhat.com> <20040903065331.GG20559@redhat.com>
	<87sm9zg7dg.fsf@redhat.com> <20040903070858.GA24082@redhat.com>
	<87oekng72k.fsf@redhat.com> <20040903072010.GD24082@redhat.com>
From: Richard Sandiford <rsandifo@redhat.com>
Date: Fri, 03 Sep 2004 08:29:39 +0100
In-Reply-To: <20040903072010.GD24082@redhat.com> (Richard Henderson's
 message of "Fri, 3 Sep 2004 00:20:10 -0700")
Message-ID: <87k6vbg68s.fsf@redhat.com>
User-Agent: Gnus/5.1006 (Gnus v5.10.6) Emacs/21.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-Path: <rsandifo@redhat.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 5780
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: rsandifo@redhat.com
Precedence: bulk
X-list: linux-mips

Richard Henderson <rth@redhat.com> writes:
> On Fri, Sep 03, 2004 at 08:11:47AM +0100, Richard Sandiford wrote:
>> But the point as I understand it is that the generic optimisers
>> (e.g. simplify-rtx.c) can't tell the difference between an ASHIFT
>> that came from an (ashift ...) in the instruction stream or from
>> something that was generated artificially by expand_compound_operation.
>
> That would be a bug in expand_compound_operation, I would think.
>
> The alternative is to not add your new hook and do what you can
> with the existing SHIFT_COUNT_TRUNCATED macro.  Which I recommend
> that you do; I don't think you really want to have the shift bits
> dependent on a cleanup / infrastructure change of this scale.

FWIW, that's what my original patch did:

    http://gcc.gnu.org/ml/gcc-patches/2004-08/msg00461.html   

The patch I posted this week was in response to the request for
wider-ranging target support:

    http://gcc.gnu.org/ml/gcc-patches/2004-08/msg00606.html

But because it depended on S_C_T, the original patch produced much
worse code for ARM than the new one does.

Is the new target hook really that invasive?  It doesn't affect any
other code as such.

The only change not directly related to the optabs expansion was the
simplify-rtx.c thing, and like I said in my covering message, I think
that code's bogus anyway:

    This seems pretty dubious anyway.  What if a define_expand in the backend
    uses shifts to implement a complex named pattern?  I'd have thought the
    backend would be free to use target-specific knowledge about what that
    shift does with out-of-range values.  And if we are later able to
    constant-fold the result, the code above might not do what the
    target machine would do.

To be honest, I'd still like to apply that hunk even if we go back to S_C_T.

Richard
