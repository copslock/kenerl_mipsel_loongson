Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 28 Nov 2002 15:58:24 +0100 (MET)
Received: from mail2.sonytel.be ([IPv6:::ffff:195.0.45.172]:60116 "EHLO
	mail.sonytel.be") by ralf.linux-mips.org with ESMTP
	id <S868829AbSKZMlT>; Tue, 26 Nov 2002 13:41:19 +0100
Received: from vervain.sonytel.be (mail.sonytel.be [10.17.0.27])
	by mail.sonytel.be (8.9.0/8.8.6) with ESMTP id NAA21799;
	Tue, 26 Nov 2002 13:47:03 +0100 (MET)
Date: Tue, 26 Nov 2002 13:47:04 +0100 (MET)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Ralf Baechle <ralf@linux-mips.org>,
	Marc Zyngier <mzyngier@freesurf.fr>
cc: Linux/m68k <linux-m68k@lists.linux-m68k.org>,
	Linux/MIPS Development <linux-mips@linux-mips.org>
Subject: Re: cli/sti removal from wd33c93.c
In-Reply-To: <20021125123750.A11523@linux-mips.org>
Message-ID: <Pine.GSO.4.21.0211261340040.18990-100000@vervain.sonytel.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <Geert.Uytterhoeven@sonycom.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 731
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: geert@linux-m68k.org
Precedence: bulk
X-list: linux-mips

On Mon, 25 Nov 2002, Ralf Baechle wrote:
> Below are patches to replace cli/sti and accomplices from the WD33c93
> driver.  Who is currently the maintainer of this driver?  Ok to send to
> Linus?

Feel free to send it to Linus. Meanwhile I'll check it in in the m68k tree.

> 2.5 doesn't boot on MIPS yet so this patch is untested.  This patch gets
> it to build; it was written by Marc Zygnier and reviewed by me and we
> think it does the right thing.

To me it looks OK as well. Unfortunately I don't have wd33c93 hardware (except
in the old A500/A590, which doesn't run uClinux well/yet :-).

BTW, am I correct in assuming that the driver is broken on 2.4.x as well?
It looks like there are lots of paths in wd33c93_intr() where interrupts aren't
properly restored.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
