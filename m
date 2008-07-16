Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 16 Jul 2008 16:19:27 +0100 (BST)
Received: from nelson.telenet-ops.be ([195.130.133.66]:35994 "EHLO
	nelson.telenet-ops.be") by ftp.linux-mips.org with ESMTP
	id S28581105AbYGPPTY (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 16 Jul 2008 16:19:24 +0100
Received: from localhost (localhost.localdomain [127.0.0.1])
	by nelson.telenet-ops.be (Postfix) with SMTP id 72D4650032;
	Wed, 16 Jul 2008 17:19:23 +0200 (CEST)
Received: from anakin.of.borg (78-21-204-88.access.telenet.be [78.21.204.88])
	by nelson.telenet-ops.be (Postfix) with ESMTP id BE9585001D;
	Wed, 16 Jul 2008 17:19:20 +0200 (CEST)
Received: from anakin.of.borg (localhost [127.0.0.1])
	by anakin.of.borg (8.14.3/8.14.3/Debian-4) with ESMTP id m6GFJJji002341
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Wed, 16 Jul 2008 17:19:20 +0200
Received: from localhost (geert@localhost)
	by anakin.of.borg (8.14.3/8.14.3/Submit) with ESMTP id m6GFJBZZ002305;
	Wed, 16 Jul 2008 17:19:12 +0200
X-Authentication-Warning: anakin.of.borg: geert owned process doing -bs
Date:	Wed, 16 Jul 2008 17:19:11 +0200 (CEST)
From:	Geert Uytterhoeven <geert@linux-m68k.org>
To:	Ralf Baechle <ralf@linux-mips.org>,
	Michael Schmitz <schmitz@zirkon.biophys.uni-duesseldorf.de>
cc:	Linus Torvalds <torvalds@linux-foundation.org>,
	linux-stable@linux-mips.org,
	Dmitri Vorobiev <dmitri.vorobiev@movial.fi>,
	Sam Ravnborg <sam@ravnborg.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Linux/MIPS Development <linux-mips@linux-mips.org>,
	Linux Kernel Development <linux-kernel@vger.kernel.org>,
	Andi Kleen <andi@firstfloor.org>,
	Linux/m68k <linux-m68k@vger.kernel.org>
Subject: Re: MIPS toolchain
In-Reply-To: <20080716120224.GA6061@linux-mips.org>
Message-ID: <Pine.LNX.4.64.0807161716290.7399@anakin>
References: <487DA40C.6010405@movial.fi> <20080716104533.GA7198@linux-mips.org>
 <487DD559.3020802@movial.fi> <20080716120224.GA6061@linux-mips.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <geert@linux-m68k.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 19866
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: geert@linux-m68k.org
Precedence: bulk
X-list: linux-mips

On Wed, 16 Jul 2008, Ralf Baechle wrote:
> Crosscompiling on a Fedora 9 machine running gcc 4.3.0 as its host compiler
> and gcc 3.4.6 for the mips-linux target results in the following build
> error:
> 
> $ make malta_defconfig
> $ make
> cc1: error: unrecognized command line option "-fno-stack-protector"
> scripts/kconfig/conf -s arch/mips/Kconfig
> cc1: error: unrecognized command line option "-fno-stack-protector"
> 
> The arch Makefile is included too late so the host compiler is feature
> tested, not the crosscompiler as intended and thus the Makefile applies
> adds -fno-stack-protector to crosscompiler's flags which fails for gcc
> 3.4.6.  The bug was introduced by e06b8b98da071f7dd78fb7822991694288047df0
> in 2.6.25; 35bb5b1e0e84cfa1a8906f7e6a77f391ff315791 did add more flags
> testing before the arch Makefile inclusion.
> 
> Signed-off-by: Ralf Baechle <ralf@linux-mips.org>
> 
> diff --git a/Makefile b/Makefile
> index bfde079..312fcaa 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -509,6 +509,8 @@ else
>  KBUILD_CFLAGS	+= -O2
>  endif
>  
> +include $(srctree)/arch/$(SRCARCH)/Makefile
> +
>  ifneq (CONFIG_FRAME_WARN,0)
>  KBUILD_CFLAGS += $(call cc-option,-Wframe-larger-than=${CONFIG_FRAME_WARN})
>  endif
> @@ -517,8 +519,6 @@ endif
>  # Arch Makefiles may override this setting
>  KBUILD_CFLAGS += $(call cc-option, -fno-stack-protector)
>  
> -include $(srctree)/arch/$(SRCARCH)/Makefile
> -
>  ifdef CONFIG_FRAME_POINTER
>  KBUILD_CFLAGS	+= -fno-omit-frame-pointer -fno-optimize-sibling-calls
>  else

Thank you!

Michael Schmitz also saw this problem, but we never found what caused
it...

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
