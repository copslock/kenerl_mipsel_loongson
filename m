Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 05 Jul 2003 23:55:16 +0100 (BST)
Received: from p508B5C15.dip.t-dialin.net ([IPv6:::ffff:80.139.92.21]:15571
	"EHLO dea.linux-mips.net") by linux-mips.org with ESMTP
	id <S8224802AbTGEWzN>; Sat, 5 Jul 2003 23:55:13 +0100
Received: from dea.linux-mips.net (localhost [127.0.0.1])
	by dea.linux-mips.net (8.12.8/8.12.8) with ESMTP id h65MsoDB029046;
	Sun, 6 Jul 2003 00:54:50 +0200
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.12.8/8.12.8/Submit) id h65MsjVP029042;
	Sun, 6 Jul 2003 00:54:45 +0200
Date: Sun, 6 Jul 2003 00:54:45 +0200
From: Ralf Baechle <ralf@linux-mips.org>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Brian Murphy <brm@murphy.dk>,
	Linux/MIPS Development <linux-mips@linux-mips.org>
Subject: Re: [PATCH 2.4] ndelay typo?
Message-ID: <20030705225445.GA26533@linux-mips.org>
References: <20030705133426.GA3750@linux-mips.org> <Pine.GSO.4.21.0307052305180.23796-100000@vervain.sonytel.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.GSO.4.21.0307052305180.23796-100000@vervain.sonytel.be>
User-Agent: Mutt/1.4.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 2774
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Sat, Jul 05, 2003 at 11:16:49PM +0200, Geert Uytterhoeven wrote:

> And don't you want to rename the `usecs' parameter of ndelay() to `nsecs'?

You've not looked at what I actually checked in, I renamed the argument.

> > I'm wondering about the Nile4 support btw.   Vrc5074 == NILE4, right?
> 
> Yep.

Well, I was wondering because the code in arch/mips/pci/ops-nile4.c which
was extraced from the lasat code is completly different from
ddb5xxx/ddb5074/pci_ops.c, so it's hard to extract the commonc code into
a shared file.

  Ralf
