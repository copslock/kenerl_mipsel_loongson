Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 09 Oct 2003 09:31:07 +0100 (BST)
Received: from [IPv6:::ffff:80.88.36.193] ([IPv6:::ffff:80.88.36.193]:54673
	"EHLO witte.sonytel.be") by linux-mips.org with ESMTP
	id <S8225469AbTJIIbB>; Thu, 9 Oct 2003 09:31:01 +0100
Received: from waterleaf.sonytel.be (localhost [127.0.0.1])
	by witte.sonytel.be (8.12.10/8.12.10) with ESMTP id h998UvQG022398;
	Thu, 9 Oct 2003 10:30:57 +0200 (MEST)
Date: Thu, 9 Oct 2003 10:30:57 +0200 (MEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: =?iso-8859-1?Q?J=F8rg_Ulrich_Hansen?= <jh@hansen-telecom.dk>
cc: Linux-Mips <linux-mips@linux-mips.org>
Subject: Re: What toolchain for vr4181
In-Reply-To: <EIEHIDHKGJLNEPLOGOPOAEIGCFAA.jh@hansen-telecom.dk>
Message-ID: <Pine.GSO.4.21.0310091030110.7086-100000@waterleaf.sonytel.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-15
Content-Transfer-Encoding: 8BIT
Return-Path: <Geert.Uytterhoeven@sonycom.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 3394
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: geert@linux-m68k.org
Precedence: bulk
X-list: linux-mips

On Wed, 8 Oct 2003, [iso-8859-1] Jørg Ulrich Hansen wrote:
> I am about to start porting Linux to my hardware with an vr4181 processor.
> The hardware is very close to the osprey architecture. Now my problem is
> what toolchain to use.
> I could do with an up to date opinion.
> 
> ? gcc-2.95.3
> ? gcc-2.95.4
> ? egcs-1.1.2
> ? gcc-3.2
> ? binutils 2.13
> ? glibc 2.2.5
> ? Any patches
> ? http://www.ltc.com/~brad/mips/mips-cross-toolchain/index.html
> ? http://kegel.com/crosstool/
> 
> Where is a good starting point for a toolchain that will build and work?
> I would prefere to build it my self because at a later state I might build
> it under cygwin. But a prebuild does also have interest.

At work we use plain binutils 2.13.2.1 and gcc 3.2.2, which we build ourselves
(host is Solaris/SPARC).

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
