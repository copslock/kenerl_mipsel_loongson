Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 10 Oct 2003 15:28:47 +0100 (BST)
Received: from [IPv6:::ffff:80.88.36.193] ([IPv6:::ffff:80.88.36.193]:12726
	"EHLO witte.sonytel.be") by linux-mips.org with ESMTP
	id <S8225401AbTJJO2k>; Fri, 10 Oct 2003 15:28:40 +0100
Received: from waterleaf.sonytel.be (localhost [127.0.0.1])
	by witte.sonytel.be (8.12.10/8.12.10) with ESMTP id h9AESRQG002034;
	Fri, 10 Oct 2003 16:28:27 +0200 (MEST)
Date: Fri, 10 Oct 2003 16:28:27 +0200 (MEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: durai <durai@isofttech.com>
cc: mips <linux-mips@linux-mips.org>
Subject: Re: unresolved symbol litodp,dptoli,dpmul - floating point operations
 in kernel
In-Reply-To: <02d001c38f36$ba4a8e00$6b00a8c0@DURAI>
Message-ID: <Pine.GSO.4.21.0310101627400.8302-100000@waterleaf.sonytel.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <Geert.Uytterhoeven@sonycom.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 3418
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: geert@linux-m68k.org
Precedence: bulk
X-list: linux-mips

On Fri, 10 Oct 2003, durai wrote:
> I am using a mips cross compiler (mips-linux-gcc, version 2.95.3) to build my driver
> I am using some floating point operations in a wireless lan driver for a mips platform in ucLinux, When i load the driver I am getting unresolved symbols
> 
> > 
> > insmod: unresolved symbol dptoli
> > insmod: unresolved symbol dpmul
> > insmod: unresolved symbol litodp
> 
> And somebody told me that we cannot use floating point operations in kernel code, but i desperately need to use floating point operations. 
> please tell me how to use floating point operations in kernel code.

Do not use floating point operations in kernel code.
Re-implement using fixed point or something like that.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
