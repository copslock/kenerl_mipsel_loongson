Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 30 Jun 2005 20:51:13 +0100 (BST)
Received: from alg138.algor.co.uk ([IPv6:::ffff:62.254.210.138]:8908 "EHLO
	bacchus.net.dhis.org") by linux-mips.org with ESMTP
	id <S8226101AbVF3Tuw>; Thu, 30 Jun 2005 20:50:52 +0100
Received: from dea.linux-mips.net (localhost.localdomain [127.0.0.1])
	by bacchus.net.dhis.org (8.13.4/8.13.1) with ESMTP id j5UJoWhj004282;
	Thu, 30 Jun 2005 20:50:32 +0100
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.13.4/8.13.4/Submit) id j5UJoUL9004281;
	Thu, 30 Jun 2005 20:50:30 +0100
Date:	Thu, 30 Jun 2005 20:50:30 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	jrc@skylon.demon.co.uk
Cc:	maxim@mox.ru, Krishna B S <bskris@gmail.com>,
	linux-mips@linux-mips.org
Subject: Re: Popular MIPS4Kc boards?
Message-ID: <20050630195030.GB3245@linux-mips.org>
References: <6097c49050630030859b061c5@mail.gmail.com> <20050630191656Z8226101-3678+743@linux-mips.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050630191656Z8226101-3678+743@linux-mips.org>
User-Agent: Mutt/1.4.2.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 8275
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Thu, Jun 30, 2005 at 08:16:42PM +0100, jrc@skylon.demon.co.uk wrote:

> A possibility for a MIPS64 based device might be the recently announced
> Broadcom BCM97398 IPTV set-top box reference design platform:
> 
>     http://tinyurl.com/bm44b
> 
> This contains a BCM7038 with a 300 MHz R5Kf together with enough
> peripherals to make it interesting: 2 x UART; 2 x SATA; 2 x USB 2.0;
> 10/100 Ethernet.  If produced in quantity and available it would
> probably be more affordable than low volume evaluation boards.
> 
> What I would like to see is a multicore (multithreading?) MIPS64 chip
> attached by HyperTransport to a PC chipset (eg. Via KN800A) on a small
> form factor board (mini-itx; micro-atx; micro-btx).  An ideal plaything
> for the kernel hacker and a useful resource for academic teaching and
> research - a modern version of the UNSW U4600 ...

There's a wild difference between the 5Kf, a relativly simple 64-bit core
and one of the current 32-bit & 64-bit multithreading cores coming out.
For the latter ones you'll probably still have to hold the breath for little.

  Ralf
