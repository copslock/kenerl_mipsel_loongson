Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 27 Apr 2004 20:29:11 +0100 (BST)
Received: from p508B663E.dip.t-dialin.net ([IPv6:::ffff:80.139.102.62]:47382
	"EHLO mail.linux-mips.net") by linux-mips.org with ESMTP
	id <S8226052AbUD0T3K>; Tue, 27 Apr 2004 20:29:10 +0100
Received: from fluff.linux-mips.net (fluff.linux-mips.net [127.0.0.1])
	by mail.linux-mips.net (8.12.8/8.12.8) with ESMTP id i3RJSmxT009432
	for <linux-mips@linux-mips.org>; Tue, 27 Apr 2004 21:28:48 +0200
Received: (from ralf@localhost)
	by fluff.linux-mips.net (8.12.8/8.12.8/Submit) id i3RJSSSI009428;
	Tue, 27 Apr 2004 21:28:28 +0200
Date: Tue, 27 Apr 2004 21:28:28 +0200
From: Ralf Baechle <ralf@linux-mips.org>
To: Stanislaw Skowronek <sskowron@ET.PUT.Poznan.PL>
Cc: linux-mips@linux-mips.org
Subject: Re: TLB on R10k
Message-ID: <20040427192828.GA7739@linux-mips.org>
References: <Pine.GSO.4.10.10404272004460.14972-100000@helios.et.put.poznan.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.GSO.4.10.10404272004460.14972-100000@helios.et.put.poznan.pl>
User-Agent: Mutt/1.4.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 4915
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Tue, Apr 27, 2004 at 08:07:23PM +0200, Stanislaw Skowronek wrote:

> Why, in tlb-andes.c, all exception handlers are prefixed with an
> ampersand (&) when copying them to main memory, only the r10k fill handler
> isn't? I'm getting a blackhole-style crash (no messages, no panic,
> interrupts dead as a doornail, nobody knows what is happening) as soon as
> I try to jump to usermode.

Have you verified that the UX bit is set correctly by your kernel?  BEV
also plays a role but since you survive BogoMIPS it should be right.

  Ralf
