Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 15 Apr 2003 16:02:00 +0100 (BST)
Received: from p508B74BA.dip.t-dialin.net ([IPv6:::ffff:80.139.116.186]:64663
	"EHLO dea.linux-mips.net") by linux-mips.org with ESMTP
	id <S8225268AbTDOPB7>; Tue, 15 Apr 2003 16:01:59 +0100
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.11.6/8.11.6) id h3FF1sM09613;
	Tue, 15 Apr 2003 17:01:54 +0200
Date: Tue, 15 Apr 2003 17:01:54 +0200
From: Ralf Baechle <ralf@linux-mips.org>
To: Chris Dearman <chris@mips.com>
Cc: linux-mips@linux-mips.org
Subject: Re: [PATCH] waybit not set for MIPS32/MIPS64 caches
Message-ID: <20030415170154.A9601@linux-mips.org>
References: <3E9C02A8.4090008@mips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <3E9C02A8.4090008@mips.com>; from chris@mips.com on Tue, Apr 15, 2003 at 02:01:28PM +0100
Return-Path: <ralf@linux-mips.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 2059
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Tue, Apr 15, 2003 at 02:01:28PM +0100, Chris Dearman wrote:

>    The unified cache code (c-r4k.c) does not set the waybit for 
> MIPS32/MIPS64 processors.  This patch needs to be applied to 
> {mips,mips64}/mm/c-r4k.c in 2.4 and 2.5.

Thanks, applied.

  Ralf
