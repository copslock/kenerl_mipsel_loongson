Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 18 Jan 2004 10:05:42 +0000 (GMT)
Received: from witte.sonytel.be ([IPv6:::ffff:80.88.33.193]:2958 "EHLO
	witte.sonytel.be") by linux-mips.org with ESMTP id <S8225228AbUARKFl>;
	Sun, 18 Jan 2004 10:05:41 +0000
Received: from waterleaf.sonytel.be (localhost [127.0.0.1])
	by witte.sonytel.be (8.12.10/8.12.10) with ESMTP id i0IA5dw2003939;
	Sun, 18 Jan 2004 11:05:40 +0100 (MET)
Date: Sun, 18 Jan 2004 11:05:37 +0100 (MET)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Adam Nielsen <a.nielsen@optushome.com.au>
cc: Linux/MIPS Development <linux-mips@linux-mips.org>
Subject: Re: Trouble compiling MIPS cross-compiler
In-Reply-To: <200401181804.31114@korath>
Message-ID: <Pine.GSO.4.58.0401181102370.2808@waterleaf.sonytel.be>
References: <200401171711.34964@korath> <200401181646.04740@korath>
 <400A3353.6050903@gentoo.org> <200401181804.31114@korath>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <geert@linux-m68k.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 4025
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: geert@linux-m68k.org
Precedence: bulk
X-list: linux-mips

On Sun, 18 Jan 2004, Adam Nielsen wrote:
> At any rate, I think I'll have to call it a day - it's way too much of a
> hassle just to get a working MIPS cross-compiler, and with all the hoops you
> have to jump through I haven't got any patience left :-(

If you have Debian (use at least testing, not stable):
  - apt-get install toolchain-source
  - Follow the instructions in /usr/share/doc/toolchain-source/README

and you'll have a cross-compiler for whatever supported architecture in less
than an hour (depending on the speed of your host machine, of course).

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
