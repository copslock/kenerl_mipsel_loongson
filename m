Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 07 May 2007 16:17:13 +0100 (BST)
Received: from mba.ocn.ne.jp ([122.1.175.29]:48334 "HELO smtp.mba.ocn.ne.jp")
	by ftp.linux-mips.org with SMTP id S20021871AbXEGPRL (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Mon, 7 May 2007 16:17:11 +0100
Received: from localhost (p1067-ipad301funabasi.chiba.ocn.ne.jp [122.17.251.67])
	by smtp.mba.ocn.ne.jp (Postfix) with ESMTP
	id 8785EA824; Tue,  8 May 2007 00:17:04 +0900 (JST)
Date:	Tue, 08 May 2007 00:17:14 +0900 (JST)
Message-Id: <20070508.001714.126573516.anemo@mba.ocn.ne.jp>
To:	vagabon.xyz@gmail.com
Cc:	ralf@linux-mips.org, linux-mips@linux-mips.org
Subject: Re: [RFC 0/3] Remove Momentum Jaguar and Ocelot G board supports
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
In-Reply-To: <11785362732731-git-send-email-fbuihuu@gmail.com>
References: <11785362732731-git-send-email-fbuihuu@gmail.com>
X-Fingerprint: 6ACA 1623 39BD 9A94 9B1A  B746 CA77 FE94 2874 D52F
X-Pgp-Public-Key: http://wwwkeys.pgp.net/pks/lookup?op=get&search=0x2874D52F
X-Mailer: Mew version 5.2 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-Path: <anemo@mba.ocn.ne.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 14976
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

On Mon,  7 May 2007 13:11:10 +0200, Franck Bui-Huu <vagabon.xyz@gmail.com> wrote:
> These 2 boards have several hacks that make them annoying to
> support. Specially when improving generic MIPS code.
> 
> Since they're scheduled for removal since June 2006, it should be high
> time to get rid of them.

JFI, here is the related discussion:

http://www.linux-mips.org/archives/linux-mips/2006-06/msg00139.html

I think nobody complained for Jaguar-atx and Ocelot boards at that time.

>  delete mode 100644 arch/mips/configs/jaguar-atx_defconfig
>  delete mode 100644 arch/mips/configs/ocelot_g_defconfig
>  delete mode 100644 arch/mips/momentum/Kconfig
>  delete mode 100644 arch/mips/momentum/jaguar_atx/Makefile
>  delete mode 100644 arch/mips/momentum/jaguar_atx/dbg_io.c
>  delete mode 100644 arch/mips/momentum/jaguar_atx/irq.c
>  delete mode 100644 arch/mips/momentum/jaguar_atx/ja-console.c
>  delete mode 100644 arch/mips/momentum/jaguar_atx/jaguar_atx_fpga.h
>  delete mode 100644 arch/mips/momentum/jaguar_atx/platform.c
>  delete mode 100644 arch/mips/momentum/jaguar_atx/prom.c
>  delete mode 100644 arch/mips/momentum/jaguar_atx/reset.c
>  delete mode 100644 arch/mips/momentum/jaguar_atx/setup.c
>  delete mode 100644 arch/mips/momentum/ocelot_g/Makefile
>  delete mode 100644 arch/mips/momentum/ocelot_g/dbg_io.c
>  delete mode 100644 arch/mips/momentum/ocelot_g/gt-irq.c
>  delete mode 100644 arch/mips/momentum/ocelot_g/irq.c
>  delete mode 100644 arch/mips/momentum/ocelot_g/ocelot_pld.h
>  delete mode 100644 arch/mips/momentum/ocelot_g/prom.c
>  delete mode 100644 arch/mips/momentum/ocelot_g/reset.c
>  delete mode 100644 arch/mips/momentum/ocelot_g/setup.c
>  delete mode 100644 arch/mips/pci/fixup-jaguar.c
>  delete mode 100644 arch/mips/pci/fixup-ocelot-g.c
>  delete mode 100644 arch/mips/pci/pci-ocelot-g.c

include/asm-mips/mach-ja/ and some lines in include/asm-mips/serial.h
can be zapped too. :-)

---
Atsushi Nemoto
