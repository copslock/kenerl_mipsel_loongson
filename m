Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 25 Feb 2003 13:51:42 +0000 (GMT)
Received: from mail2.sonytel.be ([IPv6:::ffff:195.0.45.172]:42963 "EHLO
	mail.sonytel.be") by linux-mips.org with ESMTP id <S8224939AbTBYNvm>;
	Tue, 25 Feb 2003 13:51:42 +0000
Received: from vervain.sonytel.be (mail.sonytel.be [10.17.0.26])
	by mail.sonytel.be (8.9.0/8.8.6) with ESMTP id OAA06182;
	Tue, 25 Feb 2003 14:51:34 +0100 (MET)
Date: Tue, 25 Feb 2003 14:51:40 +0100 (MET)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Gilad Benjamini <yaelgilad@myrealbox.com>
cc: Linux/MIPS Development <linux-mips@linux-mips.org>
Subject: Re: modules_install
In-Reply-To: <1046180941.4ef528e0yaelgilad@myrealbox.com>
Message-ID: <Pine.GSO.4.21.0302251451040.15407-100000@vervain.sonytel.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <Geert.Uytterhoeven@sonycom.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 1553
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: geert@linux-m68k.org
Precedence: bulk
X-list: linux-mips

On Tue, 25 Feb 2003, Gilad Benjamini wrote:
> How does one tweak the kernel's "modules_install" target in the 
> makefile to properly be used for cross compiling ?
> I can change the kernel Makefile, but I'd rather not.

make INSTALL_MOD_PATH=...

Note that depmod will fail anyway.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
