Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 12 Aug 2004 20:05:07 +0100 (BST)
Received: from witte.sonytel.be ([IPv6:::ffff:80.88.33.193]:20181 "EHLO
	witte.sonytel.be") by linux-mips.org with ESMTP id <S8225212AbUHLTFC>;
	Thu, 12 Aug 2004 20:05:02 +0100
Received: from waterleaf.sonytel.be (mail.sonytel.be [43.221.60.197])
	by witte.sonytel.be (8.12.10/8.12.10) with ESMTP id i7CJ4wn1017863;
	Thu, 12 Aug 2004 21:04:58 +0200 (MEST)
Date: Thu, 12 Aug 2004 21:04:58 +0200 (MEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Ralf Ackermann <rac@KOM.tu-darmstadt.de>
cc: linuxconsole-dev@lists.sourceforge.net,
	Linux/MIPS Development <linux-mips@linux-mips.org>
Subject: Re: Q: problems with missing /dev/tty0 on X startup in MIPS system
In-Reply-To: <Pine.LNX.4.58.0408121954270.14123@shofar.kom.e-technik.tu-darmstadt.de>
Message-ID: <Pine.GSO.4.58.0408122101460.18214@waterleaf.sonytel.be>
References: <Pine.LNX.4.58.0408121954270.14123@shofar.kom.e-technik.tu-darmstadt.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <geert@linux-m68k.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 5634
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: geert@linux-m68k.org
Precedence: bulk
X-list: linux-mips

On Thu, 12 Aug 2004, Ralf Ackermann wrote:
> I'm trying to get VGA output on a MIPSel system (MeshCube
> http://www.meshcube.org) to work.
> The system uses a miniPCI ATI Rage VGA card (=> problem does not get
> initialized due to lack of system BIOS => hopefully initialized by int10
> XFree86 x86 emulator code).

So virtual consoles are not working.

> I've attached an USB mouse and keyboard but fail to start X due to
>
> Fatal server error:
> xf86OpenConsole: Cannot open /dev/tty0 (No such file or directory)

>  - 2. Any hints on the missing /dev/tty0 stuff? (this is maybe
> 	related to the console / keyboard stuff?)

Yep, that's the current virtual console. Do you have CONFIG_VT enabled? If yes,
probably the VC initialization failed due to vgacon failing. In that case, you
can try enabling dummycon (and hope X can wake up your graphics card).

BTW, there exists (depending on your kernel version) code in atyfb to
initialize the RAGE XL.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
