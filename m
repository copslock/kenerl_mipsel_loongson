Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 11 Feb 2003 15:49:08 +0000 (GMT)
Received: from mail2.sonytel.be ([IPv6:::ffff:195.0.45.172]:28063 "EHLO
	mail.sonytel.be") by linux-mips.org with ESMTP id <S8225201AbTBKPtH>;
	Tue, 11 Feb 2003 15:49:07 +0000
Received: from vervain.sonytel.be (mail.sonytel.be [10.17.0.27])
	by mail.sonytel.be (8.9.0/8.8.6) with ESMTP id QAA08958;
	Tue, 11 Feb 2003 16:48:52 +0100 (MET)
Date: Tue, 11 Feb 2003 16:48:56 +0100 (MET)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Jiahan Chen <jiahanchen@yahoo.com>
cc: Linux/MIPS Development <linux-mips@linux-mips.org>
Subject: Re: Mips Kernel Build
In-Reply-To: <20030211153128.41512.qmail@web40804.mail.yahoo.com>
Message-ID: <Pine.GSO.4.21.0302111647110.13073-100000@vervain.sonytel.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <Geert.Uytterhoeven@sonycom.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 1391
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: geert@linux-m68k.org
Precedence: bulk
X-list: linux-mips

On Tue, 11 Feb 2003, Jiahan Chen wrote:
> I'm working on Linux embedded applications with
> PC (Intel) workstation as Development Host, and
> Mips as Target. Currently, I have the following
> questions:
> 
> 1. What is a easy way to create a new kernel for Mips?

>     I'm wondering if Kernel's 2.4.18 source tree distribution
>     from RedHat CD is working for Mips Kernel creation. 

Most probably not.

Get the kernel from Linux/MIPS CVS, cfr. www.linux-mips.org.

> 2. Do you have a simple procedure (scripts) to setup for
> cross-development environment on the PC Host? 

If you run Debian, `apt-get install -t unstable toolchain-source', and read
/usr/share/doc/toolchain-source/README.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
