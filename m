Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 05 Jul 2003 14:34:51 +0100 (BST)
Received: from p508B5C15.dip.t-dialin.net ([IPv6:::ffff:80.139.92.21]:31666
	"EHLO dea.linux-mips.net") by linux-mips.org with ESMTP
	id <S8224802AbTGENet>; Sat, 5 Jul 2003 14:34:49 +0100
Received: from dea.linux-mips.net (localhost [127.0.0.1])
	by dea.linux-mips.net (8.12.8/8.12.8) with ESMTP id h65DYSDB004163;
	Sat, 5 Jul 2003 15:34:28 +0200
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.12.8/8.12.8/Submit) id h65DYRLB004162;
	Sat, 5 Jul 2003 15:34:27 +0200
Date: Sat, 5 Jul 2003 15:34:27 +0200
From: Ralf Baechle <ralf@linux-mips.org>
To: Brian Murphy <brm@murphy.dk>
Cc: linux-mips@linux-mips.org
Subject: Re: [PATCH 2.4] ndelay typo?
Message-ID: <20030705133426.GA3750@linux-mips.org>
References: <E19Ymze-0000xZ-00@brian.localnet>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E19Ymze-0000xZ-00@brian.localnet>
User-Agent: Mutt/1.4.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 2770
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Sat, Jul 05, 2003 at 03:22:22PM +0200, Brian Murphy wrote:

> 	I presume you meant this?

Yes, thanks, will fix.

> Index: include/asm/delay.h
> ===================================================================
> RCS file: /cvs/linux/include/asm-mips/delay.h,v
> retrieving revision 1.10.2.4
> diff -u -r1.10.2.4 delay.h
> --- include/asm/delay.h	5 Jul 2003 03:23:46 -0000	1.10.2.4

Btw, don't diff anything in include/asm/.  That's a symlink ...

Btw, sorry if I toasted the Lasat support with the Galileo cleanup.  There
was just so much code duplication, it was insane to maintain.

I'm wondering about the Nile4 support btw.   Vrc5074 == NILE4, right?

   Ralf
