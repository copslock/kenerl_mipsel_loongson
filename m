Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 14 Apr 2003 17:01:09 +0100 (BST)
Received: from p508B5EC1.dip.t-dialin.net ([IPv6:::ffff:80.139.94.193]:65153
	"EHLO dea.linux-mips.net") by linux-mips.org with ESMTP
	id <S8225202AbTDNQBI>; Mon, 14 Apr 2003 17:01:08 +0100
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.11.6/8.11.6) id h3EFmQF18553;
	Mon, 14 Apr 2003 17:48:26 +0200
Date: Mon, 14 Apr 2003 17:48:25 +0200
From: Ralf Baechle <ralf@linux-mips.org>
To: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
Cc: nemoto@toshiba-tops.co.jp, linux-mips@linux-mips.org
Subject: Re: End c-tx49.c's misserable existence
Message-ID: <20030414174825.A9808@linux-mips.org>
References: <20030412163215Z8225197-1272+1264@linux-mips.org> <20030414.123514.74756574.nemoto@toshiba-tops.co.jp> <20030414055038.A29923@linux-mips.org> <20030414.152903.41628304.nemoto@toshiba-tops.co.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20030414.152903.41628304.nemoto@toshiba-tops.co.jp>; from anemo@mba.ocn.ne.jp on Mon, Apr 14, 2003 at 03:29:03PM +0900
Return-Path: <ralf@linux-mips.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 2025
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Mon, Apr 14, 2003 at 03:29:03PM +0900, Atsushi Nemoto wrote:

> >>>>> On Mon, 14 Apr 2003 05:50:38 +0200, Ralf Baechle <ralf@linux-mips.org> said:
> ralf> Excellent.  This should provide a good performance boost for the
> ralf> TX49 also as disabling the I-cache during the flush made the
> ralf> operation even slower than it has to be.
> 
> Thank you for quick response.
> 
> One more request.  Please enclose R4600_V1_HIT_CACHEOP_WAR and
> R4600_V2_HIT_CACHEOP_WAR with appropriate CONFIG_CPU_XXX.  I do not
> know what CPUs need this workaround... (at least TX49 does not need
> this)

I'll leave it unconditionally enabled for now because the Makefiles could
behave in undefined ways if multiple CONFIG_CPU_* options are selected
and quite a few systems support both the R4600 and other processors like
the Indy.  Another day.

  Ralf
