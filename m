Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 03 Sep 2004 21:15:20 +0100 (BST)
Received: from mx2.redhat.com ([IPv6:::ffff:66.187.237.31]:62855 "EHLO
	mx2.redhat.com") by linux-mips.org with ESMTP id <S8225246AbUICUPP>;
	Fri, 3 Sep 2004 21:15:15 +0100
Received: from int-mx2.corp.redhat.com (int-mx2.corp.redhat.com [172.16.27.26])
	by mx2.redhat.com (8.12.10/8.12.10) with ESMTP id i83KErl3004408;
	Fri, 3 Sep 2004 16:14:53 -0400
Received: from potter.sfbay.redhat.com (potter.sfbay.redhat.com [172.16.27.15])
	by int-mx2.corp.redhat.com (8.11.6/8.11.6) with ESMTP id i83KFB716491;
	Fri, 3 Sep 2004 16:15:11 -0400
Received: from frothingslosh.sfbay.redhat.com (frothingslosh.sfbay.redhat.com [172.16.24.27])
	by potter.sfbay.redhat.com (8.11.6/8.11.6) with ESMTP id i83KFBV04250;
	Fri, 3 Sep 2004 13:15:11 -0700
Received: from frothingslosh.sfbay.redhat.com (localhost.localdomain [127.0.0.1])
	by frothingslosh.sfbay.redhat.com (8.12.10/8.12.10) with ESMTP id i83KFBOo013425;
	Fri, 3 Sep 2004 13:15:11 -0700
Received: (from rth@localhost)
	by frothingslosh.sfbay.redhat.com (8.12.10/8.12.10/Submit) id i83KFANx013423;
	Fri, 3 Sep 2004 13:15:10 -0700
X-Authentication-Warning: frothingslosh.sfbay.redhat.com: rth set sender to rth@redhat.com using -f
Date: Fri, 3 Sep 2004 13:15:10 -0700
From: Richard Henderson <rth@redhat.com>
To: Richard Sandiford <rsandifo@redhat.com>
Cc: "Maciej W. Rozycki" <macro@linux-mips.org>,
	Nigel Stephens <nigel@mips.com>, gcc-patches@gcc.gnu.org,
	linux-mips@linux-mips.org
Subject: Re: [patch] MIPS/gcc: Revert removal of DImode shifts for 32-bit targets
Message-ID: <20040903201510.GB13228@redhat.com>
Mail-Followup-To: Richard Henderson <rth@redhat.com>,
	Richard Sandiford <rsandifo@redhat.com>,
	"Maciej W. Rozycki" <macro@linux-mips.org>,
	Nigel Stephens <nigel@mips.com>, gcc-patches@gcc.gnu.org,
	linux-mips@linux-mips.org
References: <20040809220838.GE16493@redhat.com> <87zn5336h7.fsf@redhat.com> <20040810232020.GA21922@redhat.com> <87eklnw0g7.fsf@redhat.com> <20040903065331.GG20559@redhat.com> <87sm9zg7dg.fsf@redhat.com> <20040903070858.GA24082@redhat.com> <87oekng72k.fsf@redhat.com> <20040903072010.GD24082@redhat.com> <87k6vbg68s.fsf@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87k6vbg68s.fsf@redhat.com>
User-Agent: Mutt/1.4.1i
Return-Path: <rth@redhat.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 5786
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: rth@redhat.com
Precedence: bulk
X-list: linux-mips

On Fri, Sep 03, 2004 at 08:29:39AM +0100, Richard Sandiford wrote:
> The patch I posted this week was in response to the request for
> wider-ranging target support:
> 
>     http://gcc.gnu.org/ml/gcc-patches/2004-08/msg00606.html

Ah.  I wasn't actually asking for wider target support.  I was 
commenting that if we wanted something better, we'd have to add
new target support.  Sorry for the confusion.

> Is the new target hook really that invasive?  It doesn't affect any
> other code as such.

No... I guess not.  And it is a start if we ever do decide to
expand its meaning to replace S_C_T.

> The only change not directly related to the optabs expansion was the
> simplify-rtx.c thing, and like I said in my covering message, I think
> that code's bogus anyway ...

Agreed.

Ok, revised patch approved.


r~
