Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 03 Sep 2004 08:09:11 +0100 (BST)
Received: from mx2.redhat.com ([IPv6:::ffff:66.187.237.31]:38299 "EHLO
	mx2.redhat.com") by linux-mips.org with ESMTP id <S8224931AbUICHJH>;
	Fri, 3 Sep 2004 08:09:07 +0100
Received: from int-mx2.corp.redhat.com (int-mx2.corp.redhat.com [172.16.27.26])
	by mx2.redhat.com (8.12.10/8.12.10) with ESMTP id i8378gl3007429;
	Fri, 3 Sep 2004 03:08:43 -0400
Received: from potter.sfbay.redhat.com (potter.sfbay.redhat.com [172.16.27.15])
	by int-mx2.corp.redhat.com (8.11.6/8.11.6) with ESMTP id i83790728863;
	Fri, 3 Sep 2004 03:09:00 -0400
Received: from frothingslosh.sfbay.redhat.com (frothingslosh.sfbay.redhat.com [172.16.24.27])
	by potter.sfbay.redhat.com (8.11.6/8.11.6) with ESMTP id i8378xV04025;
	Fri, 3 Sep 2004 00:08:59 -0700
Received: from frothingslosh.sfbay.redhat.com (localhost.localdomain [127.0.0.1])
	by frothingslosh.sfbay.redhat.com (8.12.10/8.12.10) with ESMTP id i8378xOo001458;
	Fri, 3 Sep 2004 00:08:59 -0700
Received: (from rth@localhost)
	by frothingslosh.sfbay.redhat.com (8.12.10/8.12.10/Submit) id i8378xDM001443;
	Fri, 3 Sep 2004 00:08:59 -0700
X-Authentication-Warning: frothingslosh.sfbay.redhat.com: rth set sender to rth@redhat.com using -f
Date: Fri, 3 Sep 2004 00:08:58 -0700
From: Richard Henderson <rth@redhat.com>
To: Richard Sandiford <rsandifo@redhat.com>
Cc: "Maciej W. Rozycki" <macro@linux-mips.org>,
	Nigel Stephens <nigel@mips.com>, gcc-patches@gcc.gnu.org,
	linux-mips@linux-mips.org
Subject: Re: [patch] MIPS/gcc: Revert removal of DImode shifts for 32-bit targets
Message-ID: <20040903070858.GA24082@redhat.com>
Mail-Followup-To: Richard Henderson <rth@redhat.com>,
	Richard Sandiford <rsandifo@redhat.com>,
	"Maciej W. Rozycki" <macro@linux-mips.org>,
	Nigel Stephens <nigel@mips.com>, gcc-patches@gcc.gnu.org,
	linux-mips@linux-mips.org
References: <876580bm2e.fsf@redhat.com> <410F60DF.9020400@mips.com> <Pine.LNX.4.58L.0408042123030.31930@blysk.ds.pg.gda.pl> <87r7qiwz54.fsf@redhat.com> <20040809220838.GE16493@redhat.com> <87zn5336h7.fsf@redhat.com> <20040810232020.GA21922@redhat.com> <87eklnw0g7.fsf@redhat.com> <20040903065331.GG20559@redhat.com> <87sm9zg7dg.fsf@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87sm9zg7dg.fsf@redhat.com>
User-Agent: Mutt/1.4.1i
Return-Path: <rth@redhat.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 5777
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: rth@redhat.com
Precedence: bulk
X-list: linux-mips

On Fri, Sep 03, 2004 at 08:05:15AM +0100, Richard Sandiford wrote:
>      However, on some machines, such as the 80386 and the 680x0, truncation
>      only applies to shift operations and not the (real or pretended)
>      bit-field operations.  Define @code{SHIFT_COUNT_TRUNCATED} to be zero on
>      such machines.  Instead, add patterns to the @file{md} file that include
>      the implied truncation of the shift instructions.
> 
> I was deliberately trying to avoid this fuzziness with the new target hook.

Hmm.  I suppose we could pass the shift operation in there; 
ASHIFT, LSHIFT, ZERO_EXTRACT, SIGN_EXTRACT.


r~
