Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 02 Jun 2003 10:04:20 +0100 (BST)
Received: from mail2.sonytel.be ([IPv6:::ffff:195.0.45.172]:7664 "EHLO
	witte.sonytel.be") by linux-mips.org with ESMTP id <S8225214AbTFBJES>;
	Mon, 2 Jun 2003 10:04:18 +0100
Received: from vervain.sonytel.be (localhost [127.0.0.1])
	by witte.sonytel.be (8.12.9/8.12.9) with ESMTP id h52949LT008010;
	Mon, 2 Jun 2003 11:04:09 +0200 (MEST)
Date: Mon, 2 Jun 2003 11:04:10 +0200 (MEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Bjorn Hanch Sollie <bhs@pvv.org>
cc: Linux/MIPS Development <linux-mips@linux-mips.org>
Subject: Re: MIPSPro + GCC
In-Reply-To: <Pine.BSF.4.52.0306021029350.72800@verden.pvv.ntnu.no>
Message-ID: <Pine.GSO.4.21.0306021102300.149-100000@vervain.sonytel.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <Geert.Uytterhoeven@sonycom.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 2496
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: geert@linux-m68k.org
Precedence: bulk
X-list: linux-mips

On Mon, 2 Jun 2003, Bjorn Hanch Sollie wrote:
> Does anyone here have an idea about what it takes to link my MIPSPro
> compiled program (MIPSPro 7.4) to a gcc built library (GCC 3.2.2)?  I

> bjorns@octane:~/Surge/Segmentation/demo:$ g++ --version
> g++ (GCC) 3.2.2
> Copyright (C) 2002 Free Software Foundation, Inc.
> This is free software; see the source for copying conditions.  There is NO
> warranty; not even for MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
> 
> bjorns@octane:~/Surge/Segmentation/demo:$ CC -version
> MIPSpro Compilers: Version 7.4
> bjorns@octane:~/Surge/Segmentation/demo:$

C++ object files are not compatible across different compilers. Either fall
back to plain C, or compile everything with the same C++ compiler.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
