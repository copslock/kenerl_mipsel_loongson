Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 09 Jul 2003 08:58:38 +0100 (BST)
Received: from mail2.sonytel.be ([IPv6:::ffff:195.0.45.172]:46823 "EHLO
	witte.sonytel.be") by linux-mips.org with ESMTP id <S8225210AbTGIH6g>;
	Wed, 9 Jul 2003 08:58:36 +0100
Received: from vervain.sonytel.be (localhost [127.0.0.1])
	by witte.sonytel.be (8.12.9/8.12.9) with ESMTP id h697w81W013669;
	Wed, 9 Jul 2003 09:58:09 +0200 (MEST)
Date: Wed, 9 Jul 2003 09:58:08 +0200 (MEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Ralf Baechle <ralf@linux-mips.org>
cc: Brian Murphy <brm@murphy.dk>,
	Linux/MIPS Development <linux-mips@linux-mips.org>
Subject: Nile 4 (was: Re: [PATCH 2.4] ndelay typo?)
In-Reply-To: <20030705225445.GA26533@linux-mips.org>
Message-ID: <Pine.GSO.4.21.0307090953320.18825-100000@vervain.sonytel.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <Geert.Uytterhoeven@sonycom.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 2777
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: geert@linux-m68k.org
Precedence: bulk
X-list: linux-mips

On Sun, 6 Jul 2003, Ralf Baechle wrote:
> On Sat, Jul 05, 2003 at 11:16:49PM +0200, Geert Uytterhoeven wrote:
> > > I'm wondering about the Nile4 support btw.   Vrc5074 == NILE4, right?
> > 
> > Yep.
> 
> Well, I was wondering because the code in arch/mips/pci/ops-nile4.c which
> was extraced from the lasat code is completly different from
> ddb5xxx/ddb5074/pci_ops.c, so it's hard to extract the commonc code into
> a shared file.

If you know the chip, they are actually quite similar :-)

The differences between the Lasat and the DDB code are these:
  - The Lasat code checks the PCI error registers to detect the presence of PCI
    devices, while the DDB code doesn't,
  - The Lasat code is limited to 8 PCI devices on bus 0, while the DDB code
    uses a different access scheme to access the extra devices,
  - The DDB code uses abstraction functions to access the Nile 4 registers,
    while the Lasat code accesses the registers directly.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
