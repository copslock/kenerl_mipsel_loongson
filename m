Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 07 Apr 2005 15:05:00 +0100 (BST)
Received: from witte.sonytel.be ([IPv6:::ffff:80.88.33.193]:35466 "EHLO
	witte.sonytel.be") by linux-mips.org with ESMTP id <S8225207AbVDGOEp>;
	Thu, 7 Apr 2005 15:04:45 +0100
Received: from numbat.sonytel.be (mail.sonytel.be [43.221.60.197])
	by witte.sonytel.be (8.12.10/8.12.10) with ESMTP id j37E4iGU010658;
	Thu, 7 Apr 2005 16:04:44 +0200 (MEST)
Date:	Thu, 7 Apr 2005 16:04:38 +0200 (CEST)
From:	Geert Uytterhoeven <geert@linux-m68k.org>
To:	Mile Davidovic <mile.davidovic@micronasnit.com>
cc:	Linux/MIPS Development <linux-mips@linux-mips.org>
Subject: Re: Porting new board
In-Reply-To: <200504071334.j37DYp1p021714@krt.neobee.net>
Message-ID: <Pine.LNX.4.62.0504071603460.9236@numbat.sonytel.be>
References: <200504071334.j37DYp1p021714@krt.neobee.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <geert@linux-m68k.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 7627
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: geert@linux-m68k.org
Precedence: bulk
X-list: linux-mips

On Thu, 7 Apr 2005, Mile Davidovic wrote:
> I try to port new board (MIPS 4KEC processor) to latest version
> of linux-mips kernel. I have question regarding Kconfig and adding
> new board.
> In arch/mips/Kconfig I add next lines:
> 
> config MIPS_VGCA_EVA
>   bool "Support for VGCA-Eva board"
>   select SYS_SUPPORTS_BIG_ENDIAN
>   help
> 	  This enables support for the VGCA-EVA board.
> 
> and in arch/mips/Makefile I add next lines:
> core-$(MIPS_VGCA_EVA)	+= arch/mips/vgca-eva/
         ^^^^^^^^^^^^^
> cflags-$(MIPS_VGCA_EVA)   += -Iinclude/asm-mips/vgca-eva
           ^^^^^^^^^^^^^
> load-$(MIPS_VGCA_EVA)	+= 0xffffffff80100000
         ^^^^^^^^^^^^^

All of these should be `CONFIG_MIPS_VGCA_EVA' instead of `MIPS_VGCA_EVA'.

> But when I try to build kernel with:
> 	make menuconfig  		---> choose VGCA-Eva board
> 	make arch=mips V=1 CROSS_COMPILE=mips-linux- 
> 
> it stop forever. When I try to choose some other board it work nice. 
> Any comment?

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
