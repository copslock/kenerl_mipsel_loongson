Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 10 Jul 2003 08:30:03 +0100 (BST)
Received: from mail2.sonytel.be ([IPv6:::ffff:195.0.45.172]:20352 "EHLO
	witte.sonytel.be") by linux-mips.org with ESMTP id <S8224861AbTGJHaA>;
	Thu, 10 Jul 2003 08:30:00 +0100
Received: from vervain.sonytel.be (localhost [127.0.0.1])
	by witte.sonytel.be (8.12.9/8.12.9) with ESMTP id h6A7TT1W017871;
	Thu, 10 Jul 2003 09:29:30 +0200 (MEST)
Date: Thu, 10 Jul 2003 09:29:29 +0200 (MEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Ralf Baechle <ralf@linux-mips.org>
cc: Brian Murphy <brm@murphy.dk>,
	Linux/MIPS Development <linux-mips@linux-mips.org>
Subject: Re: Nile 4
In-Reply-To: <20030709224550.GA30793@linux-mips.org>
Message-ID: <Pine.GSO.4.21.0307100927340.3972-100000@vervain.sonytel.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <Geert.Uytterhoeven@sonycom.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 2781
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: geert@linux-m68k.org
Precedence: bulk
X-list: linux-mips

On Thu, 10 Jul 2003, Ralf Baechle wrote:
> Does anybody still care about the DDB5074?  I was just told somebody tried
> it and it didn't boot into userspace ...

A few weeks ago I gave it a try (2.4.21-pre4), but I didn't bother to set up a
Debian root on NFS to check userspace. At least the kernel booted until IP
autoconfig.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
