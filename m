Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 07 Feb 2005 21:42:03 +0000 (GMT)
Received: from alg138.algor.co.uk ([IPv6:::ffff:62.254.210.138]:5593 "EHLO
	mail.linux-mips.net") by linux-mips.org with ESMTP
	id <S8225212AbVBGVls>; Mon, 7 Feb 2005 21:41:48 +0000
Received: from dea.linux-mips.net (localhost.localdomain [127.0.0.1])
	by mail.linux-mips.net (8.13.1/8.13.1) with ESMTP id j17LaoKd014756;
	Mon, 7 Feb 2005 21:36:50 GMT
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.13.1/8.13.1/Submit) id j17Lams4014755;
	Mon, 7 Feb 2005 21:36:48 GMT
Date:	Mon, 7 Feb 2005 21:36:48 +0000
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
Cc:	nigel@mips.com, linux-mips@linux-mips.org
Subject: Re: c-r4k.c cleanup
Message-ID: <20050207213648.GC6703@linux-mips.org>
References: <20050204.231254.74753794.anemo@mba.ocn.ne.jp> <4203890B.5030305@mips.com> <20050204145803.GA5618@linux-mips.org> <20050207.192450.55145246.nemoto@toshiba-tops.co.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050207.192450.55145246.nemoto@toshiba-tops.co.jp>
User-Agent: Mutt/1.4.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 7190
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Mon, Feb 07, 2005 at 07:24:50PM +0900, Atsushi Nemoto wrote:

> >>>>> On Fri, 4 Feb 2005 15:58:03 +0100, Ralf Baechle <ralf@linux-mips.org> said:
> ralf> That's not a new feature in the MIPS world; the R10000 family
> ralf> introduced that first and Linux knows how to make use of it.  So
> ralf> now I just need to teach c-r4k.c to check the AR bit on the 24K.
> 
> 20KC Users Manual says it has physically indexed data cache.

Correct - and just to make this CPU one of a rare breed in the MIPS world
it also has virtually indexed, virtually tagged caches, similar to the
Sibyte SB1.  Sibyte still uses it's own cache code but eventually that
should go away, so I've listed it also.

  Ralf
