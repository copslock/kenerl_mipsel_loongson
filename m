Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 09 Jul 2003 23:46:18 +0100 (BST)
Received: from p508B5A26.dip.t-dialin.net ([IPv6:::ffff:80.139.90.38]:15318
	"EHLO dea.linux-mips.net") by linux-mips.org with ESMTP
	id <S8225212AbTGIWqQ>; Wed, 9 Jul 2003 23:46:16 +0100
Received: from dea.linux-mips.net (localhost [127.0.0.1])
	by dea.linux-mips.net (8.12.8/8.12.8) with ESMTP id h69MjrDB029305;
	Thu, 10 Jul 2003 00:45:53 +0200
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.12.8/8.12.8/Submit) id h69MjoMT029304;
	Thu, 10 Jul 2003 00:45:50 +0200
Date: Thu, 10 Jul 2003 00:45:50 +0200
From: Ralf Baechle <ralf@linux-mips.org>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Brian Murphy <brm@murphy.dk>,
	Linux/MIPS Development <linux-mips@linux-mips.org>
Subject: Re: Nile 4
Message-ID: <20030709224550.GA30793@linux-mips.org>
References: <20030705225445.GA26533@linux-mips.org> <Pine.GSO.4.21.0307090953320.18825-100000@vervain.sonytel.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.GSO.4.21.0307090953320.18825-100000@vervain.sonytel.be>
User-Agent: Mutt/1.4.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 2779
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Wed, Jul 09, 2003 at 09:58:08AM +0200, Geert Uytterhoeven wrote:

> > Well, I was wondering because the code in arch/mips/pci/ops-nile4.c which
> > was extraced from the lasat code is completly different from
> > ddb5xxx/ddb5074/pci_ops.c, so it's hard to extract the commonc code into
> > a shared file.
> 
> If you know the chip, they are actually quite similar :-)
> 
> The differences between the Lasat and the DDB code are these:
>   - The Lasat code checks the PCI error registers to detect the presence of PCI
>     devices, while the DDB code doesn't,
>   - The Lasat code is limited to 8 PCI devices on bus 0, while the DDB code
>     uses a different access scheme to access the extra devices,
>   - The DDB code uses abstraction functions to access the Nile 4 registers,
>     while the Lasat code accesses the registers directly.

Time to cleanup that mess also then.

Does anybody still care about the DDB5074?  I was just told somebody tried
it and it didn't boot into userspace ...

  Ralf
