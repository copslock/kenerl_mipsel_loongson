Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 04 Feb 2005 14:58:20 +0000 (GMT)
Received: from p3EE076D7.dip.t-dialin.net ([IPv6:::ffff:62.224.118.215]:39699
	"EHLO mail.linux-mips.net") by linux-mips.org with ESMTP
	id <S8225218AbVBDO6F>; Fri, 4 Feb 2005 14:58:05 +0000
Received: from fluff.linux-mips.net (localhost.localdomain [127.0.0.1])
	by mail.linux-mips.net (8.13.1/8.13.1) with ESMTP id j14Ew3lo005770;
	Fri, 4 Feb 2005 15:58:03 +0100
Received: (from ralf@localhost)
	by fluff.linux-mips.net (8.13.1/8.13.1/Submit) id j14Ew3i5005769;
	Fri, 4 Feb 2005 15:58:03 +0100
Date:	Fri, 4 Feb 2005 15:58:03 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Nigel Stephens <nigel@mips.com>
Cc:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>, linux-mips@linux-mips.org
Subject: Re: c-r4k.c cleanup
Message-ID: <20050204145803.GA5618@linux-mips.org>
References: <20050204.231254.74753794.anemo@mba.ocn.ne.jp> <4203890B.5030305@mips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4203890B.5030305@mips.com>
User-Agent: Mutt/1.4.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 7151
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Fri, Feb 04, 2005 at 02:39:07PM +0000, Nigel Stephens wrote:

> The MIPS 24K family's caches are not physically indexed, but they do 
> have optional h/w assist to prevent aliases in certain cache 
> configurations. This optional feature is indicated by the read-only AR 
> (alias removed) flag being set - that's bit 16 in the CP0 Config7 register.

That's not a new feature in the MIPS world; the R10000 family introduced
that first and Linux knows how to make use of it.  So now I just need to
teach c-r4k.c to check the AR bit on the 24K.

  Ralf
