Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 02 Feb 2004 18:57:46 +0000 (GMT)
Received: from p508B7363.dip.t-dialin.net ([IPv6:::ffff:80.139.115.99]:49220
	"EHLO mail.linux-mips.net") by linux-mips.org with ESMTP
	id <S8225226AbUBBS5q>; Mon, 2 Feb 2004 18:57:46 +0000
Received: from fluff.linux-mips.net (fluff.linux-mips.net [127.0.0.1])
	by mail.linux-mips.net (8.12.8/8.12.8) with ESMTP id i12IvRex024142;
	Mon, 2 Feb 2004 19:57:27 +0100
Received: (from ralf@localhost)
	by fluff.linux-mips.net (8.12.8/8.12.8/Submit) id i12IvQGf024141;
	Mon, 2 Feb 2004 19:57:26 +0100
Date: Mon, 2 Feb 2004 19:57:26 +0100
From: Ralf Baechle <ralf@linux-mips.org>
To: Karsten Merker <karsten@excalibur.cologne.de>,
	linux-mips@linux-mips.org
Subject: Re: MIPS Kernel size
Message-ID: <20040202185726.GB23667@linux-mips.org>
References: <1075215091.40167af364b77@imp1-a.free.fr> <20040202140925.GB22008@linux-mips.org> <20040202184325.GE913@excalibur.cologne.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040202184325.GE913@excalibur.cologne.de>
User-Agent: Mutt/1.4.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 4234
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Mon, Feb 02, 2004 at 07:43:25PM +0100, Karsten Merker wrote:

> Depends on what you consider "that small". Kernel size is a large
> issue for the Cobalt series due to the firmware limits (although
> Peter Hortons attempts at a Cobalt bootloader will hopefully help in
> this regard). Embedded stuff and PDAs is another field where 2.6
> currently seems to pose a problem.

I really hate that term "embedded" - it's very hard to define.  Anyway,
there's an increasing amount of so-called embedded systems with several
gigabytes of memory and even for much smaller system 2.6 is already
making 2.4 look pale.

The Cobalt case is special; it's firmware could almost be the definition
of the term crap ...

  Ralf
