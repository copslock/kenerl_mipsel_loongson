Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 25 Aug 2004 10:32:13 +0100 (BST)
Received: from witte.sonytel.be ([IPv6:::ffff:80.88.33.193]:23269 "EHLO
	witte.sonytel.be") by linux-mips.org with ESMTP id <S8224922AbUHYJcJ>;
	Wed, 25 Aug 2004 10:32:09 +0100
Received: from waterleaf.sonytel.be (mail.sonytel.be [43.221.60.197])
	by witte.sonytel.be (8.12.10/8.12.10) with ESMTP id i7P9W6n1025935;
	Wed, 25 Aug 2004 11:32:07 +0200 (MEST)
Date: Wed, 25 Aug 2004 11:32:06 +0200 (MEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Thomas Koeller <thomas.koeller@baslerweb.com>
cc: Linux/MIPS Development <linux-mips@linux-mips.org>
Subject: Re: ioremap() and CONFIG_SWAP_IO_SPACE
In-Reply-To: <200408251130.53865.thomas.koeller@baslerweb.com>
Message-ID: <Pine.GSO.4.58.0408251131020.18759@waterleaf.sonytel.be>
References: <200408251130.53865.thomas.koeller@baslerweb.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <geert@linux-m68k.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 5737
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: geert@linux-m68k.org
Precedence: bulk
X-list: linux-mips

On Wed, 25 Aug 2004, Thomas Koeller wrote:
> my platform (PMC-Sierra Yosemite in big endian mode),
> like many others, uses ioremap() to map device
> registers, such as the RM9000's OCD registers.
> To access those registers, the return value of
> ioremap() is casted to a suitable pointer type and
> dereferenced. This of course works, but the return
> value of ioremap() is documented not to be a
> directly dereferenceable pointer value, and accesses
> to ioremapped addresses should be performed using
> the readx/writex APIs.

In theory, ioremap() and readb() and friends are meant for PCI memory space
only. RM9000's OCD registers are not PCI memory space, so there's no strict
guarantee readb() and friends will actually work.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
