Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 03 Sep 2004 08:20:22 +0100 (BST)
Received: from mx2.redhat.com ([IPv6:::ffff:66.187.237.31]:63644 "EHLO
	mx2.redhat.com") by linux-mips.org with ESMTP id <S8224931AbUICHUS>;
	Fri, 3 Sep 2004 08:20:18 +0100
Received: from int-mx2.corp.redhat.com (int-mx2.corp.redhat.com [172.16.27.26])
	by mx2.redhat.com (8.12.10/8.12.10) with ESMTP id i837Jrl3008339;
	Fri, 3 Sep 2004 03:19:53 -0400
Received: from potter.sfbay.redhat.com (potter.sfbay.redhat.com [172.16.27.15])
	by int-mx2.corp.redhat.com (8.11.6/8.11.6) with ESMTP id i837KB729192;
	Fri, 3 Sep 2004 03:20:11 -0400
Received: from frothingslosh.sfbay.redhat.com (frothingslosh.sfbay.redhat.com [172.16.24.27])
	by potter.sfbay.redhat.com (8.11.6/8.11.6) with ESMTP id i837KAV04404;
	Fri, 3 Sep 2004 00:20:10 -0700
Received: from frothingslosh.sfbay.redhat.com (localhost.localdomain [127.0.0.1])
	by frothingslosh.sfbay.redhat.com (8.12.10/8.12.10) with ESMTP id i837KAOo032191;
	Fri, 3 Sep 2004 00:20:10 -0700
Received: (from rth@localhost)
	by frothingslosh.sfbay.redhat.com (8.12.10/8.12.10/Submit) id i837KA2i032188;
	Fri, 3 Sep 2004 00:20:10 -0700
X-Authentication-Warning: frothingslosh.sfbay.redhat.com: rth set sender to rth@redhat.com using -f
Date: Fri, 3 Sep 2004 00:20:10 -0700
From: Richard Henderson <rth@redhat.com>
To: Richard Sandiford <rsandifo@redhat.com>
Cc: "Maciej W. Rozycki" <macro@linux-mips.org>,
	Nigel Stephens <nigel@mips.com>, gcc-patches@gcc.gnu.org,
	linux-mips@linux-mips.org
Subject: Re: [patch] MIPS/gcc: Revert removal of DImode shifts for 32-bit targets
Message-ID: <20040903072010.GD24082@redhat.com>
Mail-Followup-To: Richard Henderson <rth@redhat.com>,
	Richard Sandiford <rsandifo@redhat.com>,
	"Maciej W. Rozycki" <macro@linux-mips.org>,
	Nigel Stephens <nigel@mips.com>, gcc-patches@gcc.gnu.org,
	linux-mips@linux-mips.org
References: <Pine.LNX.4.58L.0408042123030.31930@blysk.ds.pg.gda.pl> <87r7qiwz54.fsf@redhat.com> <20040809220838.GE16493@redhat.com> <87zn5336h7.fsf@redhat.com> <20040810232020.GA21922@redhat.com> <87eklnw0g7.fsf@redhat.com> <20040903065331.GG20559@redhat.com> <87sm9zg7dg.fsf@redhat.com> <20040903070858.GA24082@redhat.com> <87oekng72k.fsf@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87oekng72k.fsf@redhat.com>
User-Agent: Mutt/1.4.1i
Return-Path: <rth@redhat.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 5779
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: rth@redhat.com
Precedence: bulk
X-list: linux-mips

On Fri, Sep 03, 2004 at 08:11:47AM +0100, Richard Sandiford wrote:
> But the point as I understand it is that the generic optimisers
> (e.g. simplify-rtx.c) can't tell the difference between an ASHIFT
> that came from an (ashift ...) in the instruction stream or from
> something that was generated artificially by expand_compound_operation.

That would be a bug in expand_compound_operation, I would think.

The alternative is to not add your new hook and do what you can
with the existing SHIFT_COUNT_TRUNCATED macro.  Which I recommend
that you do; I don't think you really want to have the shift bits
dependent on a cleanup / infrastructure change of this scale.



r~
