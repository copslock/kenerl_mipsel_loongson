Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 21 Jul 2004 15:44:16 +0100 (BST)
Received: from witte.sonytel.be ([IPv6:::ffff:80.88.33.193]:9960 "EHLO
	witte.sonytel.be") by linux-mips.org with ESMTP id <S8224901AbUGUOoM>;
	Wed, 21 Jul 2004 15:44:12 +0100
Received: from waterleaf.sonytel.be (localhost [127.0.0.1])
	by witte.sonytel.be (8.12.10/8.12.10) with ESMTP id i6LEi6XK012280;
	Wed, 21 Jul 2004 16:44:06 +0200 (MEST)
Date: Wed, 21 Jul 2004 16:44:06 +0200 (MEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: "Srinivas JT." <srinivasjt@esntechnologies.co.in>
cc: Linux/MIPS Development <linux-mips@linux-mips.org>
Subject: Re: Error :Nomatch found in TLB ?????
In-Reply-To: <4EE0CBA31942E547B99B3D4BFAB34811067510@mail.esn.co.in>
Message-ID: <Pine.GSO.4.58.0407211641341.8147@waterleaf.sonytel.be>
References: <4EE0CBA31942E547B99B3D4BFAB34811067510@mail.esn.co.in>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <geert@linux-m68k.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 5534
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: geert@linux-m68k.org
Precedence: bulk
X-list: linux-mips

On Wed, 21 Jul 2004, Srinivas JT. wrote:
> I tried to load my .serc file into my Db1500 SDB. The steps that I followed are,
>
> 1) I wrote a filein C(Linux).
> 2) I generated an object file using gcc.

Using the plain `gcc' command, I guess?

> 3) By using objcopy I converted my obj file into srec file.
> 4) Then I tried to download my srec file into Db1500 SDB in Yamon using tftp.
>
> then I got error as,
>
> Error: No match in TLB for mapped address  : Address = 0x00000000
>
> Why I am getting this error ?. Is any error there in my procedure..?

By default gcc creates ELF files for a virtual memory OS. Hence the load
address (0x00000000) is virtual as well.

You have to explicitly tell the linker to create an image to be loaded at a
specific address, cfr. arch/mips/kernel/vmlinux.lds.S.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
