Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 30 Jan 2009 08:23:42 +0000 (GMT)
Received: from wilson.telenet-ops.be ([195.130.132.42]:48257 "EHLO
	wilson.telenet-ops.be") by ftp.linux-mips.org with ESMTP
	id S21103106AbZA3IXk (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 30 Jan 2009 08:23:40 +0000
Received: from localhost (localhost.localdomain [127.0.0.1])
	by wilson.telenet-ops.be (Postfix) with SMTP id 3F5843403A;
	Fri, 30 Jan 2009 09:23:39 +0100 (CET)
Received: from anakin.of.borg (d54C15368.access.telenet.be [84.193.83.104])
	by wilson.telenet-ops.be (Postfix) with ESMTP id 0244534038;
	Fri, 30 Jan 2009 09:23:38 +0100 (CET)
Received: from anakin.of.borg (localhost [127.0.0.1])
	by anakin.of.borg (8.14.3/8.14.3/Debian-5) with ESMTP id n0U8NcMf012090
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Fri, 30 Jan 2009 09:23:38 +0100
Received: from localhost (geert@localhost)
	by anakin.of.borg (8.14.3/8.14.3/Submit) with ESMTP id n0U8Nc9K012087;
	Fri, 30 Jan 2009 09:23:38 +0100
X-Authentication-Warning: anakin.of.borg: geert owned process doing -bs
Date:	Fri, 30 Jan 2009 09:23:38 +0100 (CET)
From:	Geert Uytterhoeven <geert@linux-m68k.org>
To:	Manuel Lauss <mano@roarinelk.homelinux.net>
cc:	linux-mips@linux-mips.org
Subject: Re: GCC-4.3.3 sillyness
In-Reply-To: <20090130074407.GA12368@roarinelk.homelinux.net>
Message-ID: <Pine.LNX.4.64.0901300921380.17617@anakin>
References: <20090130074407.GA12368@roarinelk.homelinux.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <geert@linux-m68k.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 21890
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: geert@linux-m68k.org
Precedence: bulk
X-list: linux-mips

On Fri, 30 Jan 2009, Manuel Lauss wrote:
>   CC      arch/mips/kernel/traps.o
> cc1: warnings being treated as errors
> /linux-2.6.git/arch/mips/kernel/traps.c: In function 'set_uncached_handler':
> /linux-2.6.git/arch/mips/kernel/traps.c:1599: error: format not a string literal and no format arguments
> 
> The fastest fix is the patch below, but I don't know whether it is
> the right thing to do.
> 
> ---
> 
> diff --git a/arch/mips/Makefile b/arch/mips/Makefile
> index 7378b91..70ddf83 100644
> --- a/arch/mips/Makefile
> +++ b/arch/mips/Makefile
> @@ -78,7 +78,7 @@ all-$(CONFIG_BOOT_ELF64)	:= $(vmlinux-64)
>  # machines may also.  Since BFD is incredibly buggy with respect to
>  # crossformat linking we rely on the elf2ecoff tool for format conversion.
>  #
> -cflags-y			+= -G 0 -mno-abicalls -fno-pic -pipe
> +cflags-y			+= -G 0 -mno-abicalls -fno-pic -pipe -Wno-format
>  cflags-y			+= -msoft-float
>  LDFLAGS_vmlinux			+= -G 0 -static -n -nostdlib
>  MODFLAGS			+= -mlong-calls

No, you don't want to disable printf()-style format checking.

diff --git a/arch/mips/kernel/traps.c b/arch/mips/kernel/traps.c
index f6083c6..16f499c 100644
--- a/arch/mips/kernel/traps.c
+++ b/arch/mips/kernel/traps.c
@@ -1596,7 +1596,7 @@ void __cpuinit set_uncached_handler(unsigned long offset, void *addr,
 		ebase += (read_c0_ebase() & 0x3ffff000);
 
 	if (!addr)
-		panic(panic_null_cerr);
+		panic("%s", panic_null_cerr);
 
 	memcpy((void *)(uncached_ebase + offset), addr, size);
 }

Hwoever, I'm a bit surprised gcc isn't smart enough to notice the string is
fixed and safe. Perhaps because panic_null_cerr is not const?

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
