Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 14 Apr 2003 04:50:47 +0100 (BST)
Received: from p508B7216.dip.t-dialin.net ([IPv6:::ffff:80.139.114.22]:53479
	"EHLO dea.linux-mips.net") by linux-mips.org with ESMTP
	id <S8225221AbTDNDur>; Mon, 14 Apr 2003 04:50:47 +0100
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.11.6/8.11.6) id h3E3oc332472;
	Mon, 14 Apr 2003 05:50:38 +0200
Date: Mon, 14 Apr 2003 05:50:38 +0200
From: Ralf Baechle <ralf@linux-mips.org>
To: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
Cc: linux-mips@linux-mips.org,
	Atsushi Nemoto <nemoto@toshiba-tops.co.jp>
Subject: Re: End c-tx49.c's misserable existence
Message-ID: <20030414055038.A29923@linux-mips.org>
References: <20030412163215Z8225197-1272+1264@linux-mips.org> <20030414.123514.74756574.nemoto@toshiba-tops.co.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20030414.123514.74756574.nemoto@toshiba-tops.co.jp>; from anemo@mba.ocn.ne.jp on Mon, Apr 14, 2003 at 12:35:14PM +0900
Return-Path: <ralf@linux-mips.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 2015
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Mon, Apr 14, 2003 at 12:35:14PM +0900, Atsushi Nemoto wrote:

> TOSHIBA_ICACHE_WAR can be removed.  This workaround is not needed
> if kernel does not modify the cache codes itself in run-time.
> 
> When I wrote c-tx49.c I blindly followed the statement in TX49/H2
> manual's statement. ("If the instruction (i.e. CACHE) is issued for
> the line which this instruction itself exists, the following operation
> is not guaranteed.")  Now I know this warning is only for
> self-modified code.  There must be no problem if the codes is not
> modified in run-time.  So please remove all TOSHIBA_ICACHE_WAR stuff
> and make c-r4k.c more clean.

Excellent.  This should provide a good performance boost for the TX49
also as disabling the I-cache during the flush made the operation even
slower than it has to be.

  Ralf
