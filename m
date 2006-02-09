Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 09 Feb 2006 08:56:04 +0000 (GMT)
Received: from witte.sonytel.be ([80.88.33.193]:52381 "EHLO witte.sonytel.be")
	by ftp.linux-mips.org with ESMTP id S8133355AbWBIIzu (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Thu, 9 Feb 2006 08:55:50 +0000
Received: from pademelon.sonytel.be (mail.sonytel.be [43.221.60.197])
	by witte.sonytel.be (8.12.10/8.12.10) with ESMTP id k1991eYL010748;
	Thu, 9 Feb 2006 10:01:40 +0100 (MET)
Date:	Thu, 9 Feb 2006 10:01:40 +0100 (CET)
From:	Geert Uytterhoeven <geert@linux-m68k.org>
To:	zhuzhenhua <zzh.hust@gmail.com>
cc:	linux-mips <linux-mips@linux-mips.org>
Subject: Re: how to use sde toolchain to compile a hello world?
In-Reply-To: <50c9a2250602082235k1add529ctff120d0184425048@mail.gmail.com>
Message-ID: <Pine.LNX.4.62.0602091000130.25466@pademelon.sonytel.be>
References: <50c9a2250602082235k1add529ctff120d0184425048@mail.gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <geert@linux-m68k.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 10377
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: geert@linux-m68k.org
Precedence: bulk
X-list: linux-mips

On Thu, 9 Feb 2006, zhuzhenhua wrote:
> some toolchain can use as "xxx-gcc -o hello hello.c" to compile, but
> sde toolchain can't find the printf function, does it means sde is not
> a complete toolchain to compile applications?

printf() is part of the C-library, which is distributed separately.
So you have to install a C-library for the target (e.g. glibc, uClibc,
dietlibc, newlib, klibc, ...).

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
