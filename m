Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 19 Jul 2004 22:38:12 +0100 (BST)
Received: from mx2.redhat.com ([IPv6:::ffff:66.187.237.31]:50562 "EHLO
	mx2.redhat.com") by linux-mips.org with ESMTP id <S8225009AbUGSViI>;
	Mon, 19 Jul 2004 22:38:08 +0100
Received: from int-mx2.corp.redhat.com (int-mx2.corp.redhat.com [172.16.27.26])
	by mx2.redhat.com (8.12.10/8.12.10) with ESMTP id i6JLY0St018951;
	Mon, 19 Jul 2004 17:34:00 -0400
Received: from potter.sfbay.redhat.com (potter.sfbay.redhat.com [172.16.27.15])
	by int-mx2.corp.redhat.com (8.11.6/8.11.6) with ESMTP id i6JLc2H20039;
	Mon, 19 Jul 2004 17:38:02 -0400
Received: from frothingslosh.sfbay.redhat.com (frothingslosh.sfbay.redhat.com [172.16.24.27])
	by potter.sfbay.redhat.com (8.11.6/8.11.6) with ESMTP id i6JLc1L15600;
	Mon, 19 Jul 2004 14:38:01 -0700
Received: from frothingslosh.sfbay.redhat.com (localhost.localdomain [127.0.0.1])
	by frothingslosh.sfbay.redhat.com (8.12.10/8.12.10) with ESMTP id i6JLc1Qw016347;
	Mon, 19 Jul 2004 14:38:01 -0700
Received: (from rth@localhost)
	by frothingslosh.sfbay.redhat.com (8.12.10/8.12.10/Submit) id i6JLc1ud016345;
	Mon, 19 Jul 2004 14:38:01 -0700
X-Authentication-Warning: frothingslosh.sfbay.redhat.com: rth set sender to rth@redhat.com using -f
Date: Mon, 19 Jul 2004 14:38:01 -0700
From: Richard Henderson <rth@redhat.com>
To: "Maciej W. Rozycki" <macro@linux-mips.org>
Cc: Richard Sandiford <rsandifo@redhat.com>,
	Ralf Baechle <ralf@linux-mips.org>, gcc-patches@gcc.gnu.org,
	linux-mips@linux-mips.org
Subject: Re: [patch] MIPS/gcc: Revert removal of DImode shifts for 32-bit targets
Message-ID: <20040719213801.GD14931@redhat.com>
Mail-Followup-To: Richard Henderson <rth@redhat.com>,
	"Maciej W. Rozycki" <macro@linux-mips.org>,
	Richard Sandiford <rsandifo@redhat.com>,
	Ralf Baechle <ralf@linux-mips.org>, gcc-patches@gcc.gnu.org,
	linux-mips@linux-mips.org
References: <Pine.LNX.4.55.0407191648451.3667@jurand.ds.pg.gda.pl> <87hds49bmo.fsf@redhat.com> <Pine.LNX.4.55.0407191907300.3667@jurand.ds.pg.gda.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.55.0407191907300.3667@jurand.ds.pg.gda.pl>
User-Agent: Mutt/1.4.1i
Return-Path: <rth@redhat.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 5512
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: rth@redhat.com
Precedence: bulk
X-list: linux-mips

On Mon, Jul 19, 2004 at 07:33:14PM +0200, Maciej W. Rozycki wrote:
>  Well, other targets, like the i386 (which didn't even have a 64-bit
> variation till recently)...

Except that 80386 has 64-bit shifts in hardware.

And in rebuttal to the "does not make linux jump through hoops"
argument, see arch/*/lib/ for arm, h8300, m68k, sparc, v850.



r~
