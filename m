Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 25 Feb 2003 12:44:47 +0000 (GMT)
Received: from p508B7D68.dip.t-dialin.net ([IPv6:::ffff:80.139.125.104]:54918
	"EHLO dea.linux-mips.net") by linux-mips.org with ESMTP
	id <S8224939AbTBYMoq>; Tue, 25 Feb 2003 12:44:46 +0000
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.11.6/8.11.6) id h1PCecX14470;
	Tue, 25 Feb 2003 13:40:38 +0100
Date: Tue, 25 Feb 2003 13:40:38 +0100
From: Ralf Baechle <ralf@linux-mips.org>
To: Santosh <ipv6_san@rediffmail.com>
Cc: yoshfuji@wide.ad.jp, usagi-users@linux-ipv6.org,
	netdev@oss.sgi.com, linux-mips@linux-mips.org
Subject: Re: USAGI Kernel for MIPS based device
Message-ID: <20030225134038.A14292@linux-mips.org>
References: <20030225101731.9289.qmail@webmail14.rediffmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20030225101731.9289.qmail@webmail14.rediffmail.com>; from ipv6_san@rediffmail.com on Tue, Feb 25, 2003 at 10:17:31AM -0000
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 1550
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Tue, Feb 25, 2003 at 10:17:31AM -0000, Santosh  wrote:

> I have a MIPS processor based device, currently running with
> Linux-2.4.5-pre1.
> I have a BSP for my device from Lineo Inc., which incorporates
> Linux-2.4.5-pre1 source code.

2.4.5 is almost two years old by now.  You're missing a huge pule of bug
fixes among them MIPS IPv6 fixes.

  Ralf
