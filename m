Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 05 Sep 2004 01:03:37 +0100 (BST)
Received: from mx2.redhat.com ([IPv6:::ffff:66.187.237.31]:15027 "EHLO
	mx2.redhat.com") by linux-mips.org with ESMTP id <S8225074AbUIEADd>;
	Sun, 5 Sep 2004 01:03:33 +0100
Received: from int-mx2.corp.redhat.com (int-mx2.corp.redhat.com [172.16.27.26])
	by mx2.redhat.com (8.12.10/8.12.10) with ESMTP id i85037l3018299;
	Sat, 4 Sep 2004 20:03:08 -0400
Received: from potter.sfbay.redhat.com (potter.sfbay.redhat.com [172.16.27.15])
	by int-mx2.corp.redhat.com (8.11.6/8.11.6) with ESMTP id i8503T725943;
	Sat, 4 Sep 2004 20:03:29 -0400
Received: from frothingslosh.sfbay.redhat.com (frothingslosh.sfbay.redhat.com [172.16.24.27])
	by potter.sfbay.redhat.com (8.11.6/8.11.6) with ESMTP id i8503SV13692;
	Sat, 4 Sep 2004 17:03:28 -0700
Received: from frothingslosh.sfbay.redhat.com (localhost.localdomain [127.0.0.1])
	by frothingslosh.sfbay.redhat.com (8.12.10/8.12.10) with ESMTP id i8503SOo016834;
	Sat, 4 Sep 2004 17:03:28 -0700
Received: (from rth@localhost)
	by frothingslosh.sfbay.redhat.com (8.12.10/8.12.10/Submit) id i8503SYf016832;
	Sat, 4 Sep 2004 17:03:28 -0700
X-Authentication-Warning: frothingslosh.sfbay.redhat.com: rth set sender to rth@redhat.com using -f
Date: Sat, 4 Sep 2004 17:03:28 -0700
From: Richard Henderson <rth@redhat.com>
To: Richard Sandiford <rsandifo@redhat.com>
Cc: "Maciej W. Rozycki" <macro@linux-mips.org>,
	Nigel Stephens <nigel@mips.com>, gcc-patches@gcc.gnu.org,
	linux-mips@linux-mips.org
Subject: Re: [patch] MIPS/gcc: Revert removal of DImode shifts for 32-bit targets
Message-ID: <20040905000328.GA16819@redhat.com>
Mail-Followup-To: Richard Henderson <rth@redhat.com>,
	Richard Sandiford <rsandifo@redhat.com>,
	"Maciej W. Rozycki" <macro@linux-mips.org>,
	Nigel Stephens <nigel@mips.com>, gcc-patches@gcc.gnu.org,
	linux-mips@linux-mips.org
References: <20040810232020.GA21922@redhat.com> <87eklnw0g7.fsf@redhat.com> <20040903065331.GG20559@redhat.com> <87sm9zg7dg.fsf@redhat.com> <20040903070858.GA24082@redhat.com> <87oekng72k.fsf@redhat.com> <20040903072010.GD24082@redhat.com> <87k6vbg68s.fsf@redhat.com> <20040903201510.GB13228@redhat.com> <873c1ytnxz.fsf@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <873c1ytnxz.fsf@redhat.com>
User-Agent: Mutt/1.4.1i
Return-Path: <rth@redhat.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 5791
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: rth@redhat.com
Precedence: bulk
X-list: linux-mips

On Sat, Sep 04, 2004 at 09:53:28AM +0100, Richard Sandiford wrote:
> So, for example, the onus for verifying the ZERO_EXTRACT rewrites
> should be with combine rather than the backend.  Is that right?

Yes.


r~
