Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 11 Aug 2004 00:20:35 +0100 (BST)
Received: from mx2.redhat.com ([IPv6:::ffff:66.187.237.31]:16011 "EHLO
	mx2.redhat.com") by linux-mips.org with ESMTP id <S8225197AbUHJXUa>;
	Wed, 11 Aug 2004 00:20:30 +0100
Received: from int-mx2.corp.redhat.com (int-mx2.corp.redhat.com [172.16.27.26])
	by mx2.redhat.com (8.12.10/8.12.10) with ESMTP id i7AMijfu010383;
	Tue, 10 Aug 2004 18:44:45 -0400
Received: from potter.sfbay.redhat.com (potter.sfbay.redhat.com [172.16.27.15])
	by int-mx2.corp.redhat.com (8.11.6/8.11.6) with ESMTP id i7ANKLX29034;
	Tue, 10 Aug 2004 19:20:21 -0400
Received: from frothingslosh.sfbay.redhat.com (frothingslosh.sfbay.redhat.com [172.16.24.27])
	by potter.sfbay.redhat.com (8.11.6/8.11.6) with ESMTP id i7ANKLV13418;
	Tue, 10 Aug 2004 16:20:21 -0700
Received: from frothingslosh.sfbay.redhat.com (localhost.localdomain [127.0.0.1])
	by frothingslosh.sfbay.redhat.com (8.12.10/8.12.10) with ESMTP id i7ANKLOo021940;
	Tue, 10 Aug 2004 16:20:21 -0700
Received: (from rth@localhost)
	by frothingslosh.sfbay.redhat.com (8.12.10/8.12.10/Submit) id i7ANKK3q021938;
	Tue, 10 Aug 2004 16:20:20 -0700
X-Authentication-Warning: frothingslosh.sfbay.redhat.com: rth set sender to rth@redhat.com using -f
Date: Tue, 10 Aug 2004 16:20:20 -0700
From: Richard Henderson <rth@redhat.com>
To: Richard Sandiford <rsandifo@redhat.com>
Cc: "Maciej W. Rozycki" <macro@linux-mips.org>,
	Nigel Stephens <nigel@mips.com>, gcc-patches@gcc.gnu.org,
	linux-mips@linux-mips.org
Subject: Re: [patch] MIPS/gcc: Revert removal of DImode shifts for 32-bit targets
Message-ID: <20040810232020.GA21922@redhat.com>
Mail-Followup-To: Richard Henderson <rth@redhat.com>,
	Richard Sandiford <rsandifo@redhat.com>,
	"Maciej W. Rozycki" <macro@linux-mips.org>,
	Nigel Stephens <nigel@mips.com>, gcc-patches@gcc.gnu.org,
	linux-mips@linux-mips.org
References: <Pine.LNX.4.58L.0407261325470.3873@blysk.ds.pg.gda.pl> <410E9E25.7080104@mips.com> <87acxcbxfl.fsf@redhat.com> <410F5964.3010109@mips.com> <876580bm2e.fsf@redhat.com> <410F60DF.9020400@mips.com> <Pine.LNX.4.58L.0408042123030.31930@blysk.ds.pg.gda.pl> <87r7qiwz54.fsf@redhat.com> <20040809220838.GE16493@redhat.com> <87zn5336h7.fsf@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87zn5336h7.fsf@redhat.com>
User-Agent: Mutt/1.4.1i
Return-Path: <rth@redhat.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 5620
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: rth@redhat.com
Precedence: bulk
X-list: linux-mips

On Tue, Aug 10, 2004 at 06:30:28AM +0100, Richard Sandiford wrote:
> The whole thing's in a sequence that gets discarded if
> expand_doubleword_shift returns false.  Isn't that enough?

Missed that, sorry.

Patch seems ok then.  We'd have to add a new macro/target flag
to handle non-truncating shifts -- we've got cases:

  (1) Large shift shifts out all bits (ARM)
  (2) Large shifts trap (VAX)
  (3) Shift count truncated to 31, always, which means QI/HI
      shifts are yield undefined results with large shifts.  (i386)


r~
