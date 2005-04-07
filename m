Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 07 Apr 2005 16:38:39 +0100 (BST)
Received: from krt.tmd.ns.ac.yu ([IPv6:::ffff:147.91.177.65]:34759 "EHLO
	krt.neobee.net") by linux-mips.org with ESMTP id <S8225234AbVDGPiY>;
	Thu, 7 Apr 2005 16:38:24 +0100
Received: from localhost (localhost [127.0.0.1])
	by krt.neobee.net (8.12.7/8.12.7/SuSE Linux 0.6) with ESMTP id j37FbUZF025791;
	Thu, 7 Apr 2005 17:37:30 +0200
Received: from krt.neobee.net ([127.0.0.1])
 by localhost (krt.neobee.net [127.0.0.1]) (amavisd-new, port 10024) with LMTP
 id 25054-07; Thu,  7 Apr 2005 17:37:30 +0200 (CEST)
Received: from davidovic ([192.168.0.89])
	by krt.neobee.net (8.12.7/8.12.7/SuSE Linux 0.6) with ESMTP id j37FbS1p025786;
	Thu, 7 Apr 2005 17:37:28 +0200
Message-Id: <200504071537.j37FbS1p025786@krt.neobee.net>
Reply-To: <mile.davidovic@micronasnit.com>
From:	"Mile Davidovic" <mile.davidovic@micronasnit.com>
To:	"'Geert Uytterhoeven'" <geert@linux-m68k.org>
Cc:	"'Linux/MIPS Development'" <linux-mips@linux-mips.org>
Subject: RE: Porting new board
Date:	Thu, 7 Apr 2005 17:37:45 +0200
Organization: MicronasNIT
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook, Build 11.0.6353
In-Reply-To: <200504071523.j37FNd1p025409@krt.neobee.net>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2527
Thread-Index: AcU7esi/O6dyZaWpQ5q7Jj6TSPEDBQACmO5QAACXuKA=
X-Virus-Scanned: by amavisd-new at krt.neobee.net
Return-Path: <mile.davidovic@micronasnit.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 7632
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mile.davidovic@micronasnit.com
Precedence: bulk
X-list: linux-mips

 
I found what cause my problem after adding 
  select SYS_SUPPORTS_BIG_ENDIAN
  select SYS_SUPPORTS_32BIT_KERNEL
in Kconfig compilation start.

Sorry for posting stupid questions..

Best regards Mile
-----Original Message-----
From: linux-mips-bounce@linux-mips.org
[mailto:linux-mips-bounce@linux-mips.org] On Behalf Of Mile Davidovic
Sent: Thursday, April 07, 2005 5:24 PM
To: 'Geert Uytterhoeven'
Cc: 'Linux/MIPS Development'
Subject: RE: Porting new board

Thank for Your comment. Yes this was obviouse error but unfortunately it
does not work.

Best regards mile

-----Original Message-----
From: linux-mips-bounce@linux-mips.org
[mailto:linux-mips-bounce@linux-mips.org] On Behalf Of Geert Uytterhoeven
Sent: Thursday, April 07, 2005 4:05 PM
To: Mile Davidovic
Cc: Linux/MIPS Development
Subject: Re: Porting new board

On Thu, 7 Apr 2005, Mile Davidovic wrote:
> I try to port new board (MIPS 4KEC processor) to latest version of 
> linux-mips kernel. I have question regarding Kconfig and adding new 
> board.
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
Geert Uytterhoeven -- There's lots of Linux beyond ia32 --
geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like
that.
							    -- Linus
Torvalds
