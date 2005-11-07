Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 07 Nov 2005 08:52:10 +0000 (GMT)
Received: from witte.sonytel.be ([80.88.33.193]:48295 "EHLO witte.sonytel.be")
	by ftp.linux-mips.org with ESMTP id S8133374AbVKGIvw (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Mon, 7 Nov 2005 08:51:52 +0000
Received: from numbat.sonytel.be (mail.sonytel.be [43.221.60.197])
	by witte.sonytel.be (8.12.10/8.12.10) with ESMTP id jA78r1va010783;
	Mon, 7 Nov 2005 09:53:01 +0100 (MET)
Date:	Mon, 7 Nov 2005 09:53:00 +0100 (CET)
From:	Geert Uytterhoeven <geert@linux-m68k.org>
To:	Yoichi Yuasa <yyuasa@gmail.com>
cc:	Andre <armcc2000@yahoo.com>,
	Linux/MIPS Development <linux-mips@linux-mips.org>
Subject: Re: 2.6.14-git9 cobalt build fails
In-Reply-To: <4955666b0511062017q5ea4fbc3g@mail.gmail.com>
Message-ID: <Pine.LNX.4.62.0511070951260.10822@numbat.sonytel.be>
References: <20051106152314.10450.qmail@web35615.mail.mud.yahoo.com>
 <4955666b0511062017q5ea4fbc3g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <geert@linux-m68k.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 9433
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: geert@linux-m68k.org
Precedence: bulk
X-list: linux-mips

On Mon, 7 Nov 2005, Yoichi Yuasa wrote:
> 2005/11/7, Andre <armcc2000@yahoo.com>:
> > Not sure if the cobalt support that's just gone into the mainstream
> > kernel is even supposed to compile yet... but it doesn't ;-) I tried
> > 2.6.14 + git9 patch from kernel.org.
> >
> > Note that default config was tweaked slightly (to enable IDE DMA and
> > a network driver).
> >
> >   ...
> >   CC      arch/mips/pci/pci.o
> >   CC      arch/mips/pci/ops-gt64111.o
> >   CC      arch/mips/pci/fixup-cobalt.o
> > arch/mips/pci/fixup-cobalt.c:35: error:
> > `PCI_DEVICE_ID_MARVELL_GT64111' undeclared here (not in a function)
> > arch/mips/pci/fixup-cobalt.c:35: error: initializer element is not
> > constant
> > arch/mips/pci/fixup-cobalt.c:35: error: (near initialization for
> > `__pci_fixup_PCI_VENDOR_ID_MARVELLPCI_DEVICE_ID_MARVELL_GT64111qube_raq_galileo_early_fixup.device')
> > arch/mips/pci/fixup-cobalt.c:116: error: initializer element is not
> > constant
> > arch/mips/pci/fixup-cobalt.c:116: error: (near initialization for
> > `__pci_fixup_PCI_VENDOR_ID_MARVELLPCI_DEVICE_ID_MARVELL_GT64111qube_raq_galileo_fixup.device')
> > arch/mips/pci/fixup-cobalt.c:58: error:
> > __pci_fixup_PCI_VENDOR_ID_VIAPCI_DEVICE_ID_VIA_82C586_1qube_raq_via_bmIDE_fixup
> > causes a section type conflict
> > make[1]: *** [arch/mips/pci/fixup-cobalt.o] Error 1
> > make: *** [arch/mips/pci] Error 2
> > root@qube2:/usr/src/linux-2.6.14#
> >
> 
> PCI_DEVICE_ID_MARVELL_GT64111 was removed from kernel.org git(I don't know why).

All `unused' definitions were removed from pci_ids.h. Hence if fixup-cobalt.c
in Linus' tree was not in sync, it was removed.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
