Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 21 Dec 2003 17:26:22 +0000 (GMT)
Received: from witte.sonytel.be ([IPv6:::ffff:80.88.33.193]:13821 "EHLO
	witte.sonytel.be") by linux-mips.org with ESMTP id <S8225370AbTLUR0V>;
	Sun, 21 Dec 2003 17:26:21 +0000
Received: from waterleaf.sonytel.be (localhost [127.0.0.1])
	by witte.sonytel.be (8.12.10/8.12.10) with ESMTP id hBLHQGQG007729;
	Sun, 21 Dec 2003 18:26:16 +0100 (MET)
Date: Sun, 21 Dec 2003 18:26:17 +0100 (MET)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Mark and Janice Juszczec <juszczec@hotmail.com>
cc: Linux/MIPS Development <linux-mips@linux-mips.org>
Subject: Re: hardware questions
In-Reply-To: <Law10-F61XsDQ1sMzqi00015abf@hotmail.com>
Message-ID: <Pine.GSO.4.58.0312211824580.739@waterleaf.sonytel.be>
References: <Law10-F61XsDQ1sMzqi00015abf@hotmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <geert@linux-m68k.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 3815
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: geert@linux-m68k.org
Precedence: bulk
X-list: linux-mips

On Sun, 21 Dec 2003, Mark and Janice Juszczec wrote:
> I'm the guy with the Helio pda running an r3912 chip.  In an effort to
> create a better development environment, I'm thinking about puchasing a
> Silicon Graphics Iris Indigo Workstation.
>
> But, I'm unfamiliar with MIPS hardware.
>
> First of all, will code developed on this machine run on the r3912 chip?
> The r3912 is little endian mips, 16 bit I think but maybe 32 bit.

SGI workstations are big endian, while WinCE hardware is always little endian.
So you still have to cross-compile if you want to use the SGI as a development
environment.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
