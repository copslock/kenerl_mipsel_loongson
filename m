Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 14 Apr 2004 21:36:43 +0100 (BST)
Received: from witte.sonytel.be ([IPv6:::ffff:80.88.33.193]:51595 "EHLO
	witte.sonytel.be") by linux-mips.org with ESMTP id <S8225742AbUDNUgm>;
	Wed, 14 Apr 2004 21:36:42 +0100
Received: from waterleaf.sonytel.be (localhost [127.0.0.1])
	by witte.sonytel.be (8.12.10/8.12.10) with ESMTP id i3EKaa4P000042;
	Wed, 14 Apr 2004 22:36:39 +0200 (MEST)
Date: Wed, 14 Apr 2004 22:36:36 +0200 (MEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: "Xu, Jiang" <Jiang.Xu@echostar.com>
cc: Linux/MIPS Development <linux-mips@linux-mips.org>
Subject: RE: questions about keyboard
In-Reply-To: <F71A246055866844B66AFEB10654E7860F1B0C@riv-exchb6.echostar.com>
Message-ID: <Pine.GSO.4.58.0404142235540.22408@waterleaf.sonytel.be>
References: <F71A246055866844B66AFEB10654E7860F1B0C@riv-exchb6.echostar.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <geert@linux-m68k.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 4781
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: geert@linux-m68k.org
Precedence: bulk
X-list: linux-mips

On Wed, 14 Apr 2004, Xu, Jiang wrote:
> Well, this is the problem.
> For some reasons, none of the /dev/tty /dev/tty0... /dev/console is
> connected to the keyboard, I have tried listening all of them.  Did I
> configured something wrong? But kernel seems to be getting the key event
> from the keyboard.
> Another question is if it should connect to one of those device nodes, is
> there anyway I can hack the kernel to see where the key event sent to?

Do you have CONFIG_VT=y? I guess not.

Do you receive anything on /dev/input/eventX?

> -----Original Message-----
> From: Jan-Benedict Glaw [mailto:jbglaw@lug-owl.de]
> Sent: Wednesday, April 14, 2004 2:26 PM
> To: linux-mips@linux-mips.org
> Subject: Re: questions about keyboard
>
>
> On Wed, 2004-04-14 14:18:18 -0600, Xu, Jiang <Jiang.Xu@echostar.com> wrote
> in message <F71A246055866844B66AFEB10654E7860F1B0B@riv-exchb6.echostar.com>:
> > However, what I don't get is how can I get the key event from the
> > kernel?  I tried to listen to all the ttyN, but none of them connect to
> the keyboard.
> > I wonder how I can write a user space application that can get the key
> > event?  Could somebody help me out?  Because it is an embedded device,
> there
> > is no X.
>
> Well, one of /dev/tty, /dev/tty0 or /dev/console should work. If you'd likt
> to use the new'n'fancy style, use /dev/input/eventX .

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
