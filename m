Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 02 Feb 2004 14:09:28 +0000 (GMT)
Received: from p508B7363.dip.t-dialin.net ([IPv6:::ffff:80.139.115.99]:59968
	"EHLO mail.linux-mips.net") by linux-mips.org with ESMTP
	id <S8225226AbUBBOJ2>; Mon, 2 Feb 2004 14:09:28 +0000
Received: from fluff.linux-mips.net (fluff.linux-mips.net [127.0.0.1])
	by mail.linux-mips.net (8.12.8/8.12.8) with ESMTP id i12E9Pex024036;
	Mon, 2 Feb 2004 15:09:25 +0100
Received: (from ralf@localhost)
	by fluff.linux-mips.net (8.12.8/8.12.8/Submit) id i12E9PSl024035;
	Mon, 2 Feb 2004 15:09:25 +0100
Date: Mon, 2 Feb 2004 15:09:25 +0100
From: Ralf Baechle <ralf@linux-mips.org>
To: kip.r2@free.fr
Cc: linux-mips@linux-mips.org
Subject: Re: MIPS Kernel size
Message-ID: <20040202140925.GB22008@linux-mips.org>
References: <1075215091.40167af364b77@imp1-a.free.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1075215091.40167af364b77@imp1-a.free.fr>
User-Agent: Mutt/1.4.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 4226
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Tue, Jan 27, 2004 at 03:51:31PM +0100, kip.r2@free.fr wrote:

> What will be the approximate size for a minimal MIPS kernel?

Btw, the -tiny tree of 2.6 has been booted on a 2MB system.  Supposedly that
was an i386 system so MIPS16 should boot in an even smaller system and a
normal 32-bit MIPS kernel should have enough space to wiggle in 4 megs.

Does anybody on this list actually still care about that small systems?

  Ralf
