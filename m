Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 04 Sep 2004 09:53:38 +0100 (BST)
Received: from mx1.redhat.com ([IPv6:::ffff:66.187.233.31]:9922 "EHLO
	mx1.redhat.com") by linux-mips.org with ESMTP id <S8224922AbUIDIxe>;
	Sat, 4 Sep 2004 09:53:34 +0100
Received: from int-mx1.corp.redhat.com (int-mx1.corp.redhat.com [172.16.52.254])
	by mx1.redhat.com (8.12.10/8.12.10) with ESMTP id i848rWS0010600;
	Sat, 4 Sep 2004 04:53:32 -0400
Received: from localhost (mail@vpnuser1.surrey.redhat.com [172.16.9.1])
	by int-mx1.corp.redhat.com (8.11.6/8.11.6) with ESMTP id i848rT325150;
	Sat, 4 Sep 2004 04:53:30 -0400
Received: from rsandifo by localhost with local (Exim 3.35 #1)
	id 1C3WIb-0005nd-00; Sat, 04 Sep 2004 09:53:29 +0100
To: Richard Henderson <rth@redhat.com>
Cc: "Maciej W. Rozycki" <macro@linux-mips.org>,
	Nigel Stephens <nigel@mips.com>, gcc-patches@gcc.gnu.org,
	linux-mips@linux-mips.org
Subject: Re: [patch] MIPS/gcc: Revert removal of DImode shifts for 32-bit
 targets
References: <20040809220838.GE16493@redhat.com> <87zn5336h7.fsf@redhat.com>
	<20040810232020.GA21922@redhat.com> <87eklnw0g7.fsf@redhat.com>
	<20040903065331.GG20559@redhat.com> <87sm9zg7dg.fsf@redhat.com>
	<20040903070858.GA24082@redhat.com> <87oekng72k.fsf@redhat.com>
	<20040903072010.GD24082@redhat.com> <87k6vbg68s.fsf@redhat.com>
	<20040903201510.GB13228@redhat.com>
From: Richard Sandiford <rsandifo@redhat.com>
Date: Sat, 04 Sep 2004 09:53:28 +0100
In-Reply-To: <20040903201510.GB13228@redhat.com> (Richard Henderson's
 message of "Fri, 3 Sep 2004 13:15:10 -0700")
Message-ID: <873c1ytnxz.fsf@redhat.com>
User-Agent: Gnus/5.1006 (Gnus v5.10.6) Emacs/21.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-Path: <rsandifo@redhat.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 5788
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: rsandifo@redhat.com
Precedence: bulk
X-list: linux-mips

Richard Henderson <rth@redhat.com> writes:
> On Fri, Sep 03, 2004 at 08:29:39AM +0100, Richard Sandiford wrote:
>> The patch I posted this week was in response to the request for
>> wider-ranging target support:
>> 
>>     http://gcc.gnu.org/ml/gcc-patches/2004-08/msg00606.html
>
> Ah.  I wasn't actually asking for wider target support.  I was 
> commenting that if we wanted something better, we'd have to add
> new target support.

Ooops!  I misunderstood, sorry.

>> Is the new target hook really that invasive?  It doesn't affect any
>> other code as such.
>
> No... I guess not.  And it is a start if we ever do decide to
> expand its meaning to replace S_C_T.
[...]
> Ok, revised patch approved.

Thanks, applied.

Looking back, I see I didn't do a very good job of explaining why
I think S_C_T and this target hook are doing two different things.
A bit more explanation (mostly for the record, since I doubt I'm
saying anything surprising here):

I can only see two optimisations guarded by !S_C_T, both of them in
combine.c.  They only disallow S_C_T because we might have already
optimised the construct in a different way.  All other uses of S_C_T
are used for shifts.

So the important point is that: although S_C_T requires a particular
behaviour for things like ZERO_EXTRACT, it is never actually used in
a positive context for ZERO_EXTRACT rtxes.  S_C_T is only ever used
in a positive context for shift rtxes.

As I understand it, the reason that S_C_T has those extra requirements
is that we have no way of tracking where a particular shift came from.
Sometimes it might come from an insn's PATTERN, sometimes it might be
the result of some temporary rewrites, such as that performed by combine.c
for "compound" operations.  The definition of S_C_T says that these
rewrites must be valid.


It sounds like you're saying that the target hook should eventually
be extended to cover shift rtxes rather than shift optabs, and that
anything which generates a shift rtx should make sure the rtx behaves
correctly wrt these hooks.  So, for example, the onus for verifying the
ZERO_EXTRACT rewrites should be with combine rather than the backend.
Is that right?  If so, I'll try to look at that in the 3.6 timeframe.

Richard
