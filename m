Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 01 Apr 2003 15:58:38 +0100 (BST)
Received: from mail2.sonytel.be ([IPv6:::ffff:195.0.45.172]:919 "EHLO
	mail.sonytel.be") by linux-mips.org with ESMTP id <S8225073AbTDAO6i>;
	Tue, 1 Apr 2003 15:58:38 +0100
Received: from vervain.sonytel.be (mail.sonytel.be [10.17.0.27])
	by mail.sonytel.be (8.9.0p/8.8.6) with ESMTP id QAA04684;
	Tue, 1 Apr 2003 16:58:29 +0200 (MET DST)
Date: Tue, 1 Apr 2003 16:58:43 +0200 (MEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Brian Murphy <brm@tt.dk>
cc: Ralf Baechle <ralf@linux-mips.org>,
	"Neeraj Garg, Noida" <ngarg@noida.hcltech.com>,
	Linux/MIPS Development <linux-mips@linux-mips.org>
Subject: Re: Linux-MIPS compilation
In-Reply-To: <3E899ABF.3070704@tt.dk>
Message-ID: <Pine.GSO.4.21.0304011657130.23134-100000@vervain.sonytel.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <Geert.Uytterhoeven@sonycom.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 1890
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: geert@linux-m68k.org
Precedence: bulk
X-list: linux-mips

On Tue, 1 Apr 2003, Brian Murphy wrote:
> Ralf Baechle wrote:
> >The options -D__linux__ -D_MIPS_SZLONG=32 and the error messages make it
> >look like you're forcing a non-Linux toolchain into building a kernel.
> >
> What is the problem with this? At least a mips(el)-elf should have no 
> problem compiling the kernel
> (at least apart from the check you have somewhere which gives an error 
> if you try).

Nope, I actually tried it yesterday with a 3.2.2. mips-elf-gcc I had lying
around from some other project, and it complained about the missing __linux__
and _MIPS_SZLONG.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
