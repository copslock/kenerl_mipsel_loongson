Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 14 Apr 2004 21:56:44 +0100 (BST)
Received: from mailout1.echostar.com ([IPv6:::ffff:204.76.128.101]:40714 "EHLO
	mailout1.echostar.com") by linux-mips.org with ESMTP
	id <S8225742AbUDNU4n>; Wed, 14 Apr 2004 21:56:43 +0100
Received: by riv-exchcon.echostar.com with Internet Mail Service (5.5.2653.19)
	id <2LYLTAR0>; Wed, 14 Apr 2004 14:56:25 -0600
Message-ID: <F71A246055866844B66AFEB10654E7860F1B0D@riv-exchb6.echostar.com>
From: "Xu, Jiang" <Jiang.Xu@echostar.com>
To: 'Geert Uytterhoeven' <geert@linux-m68k.org>
Cc: Linux/MIPS Development <linux-mips@linux-mips.org>
Subject: RE: questions about keyboard
Date: Wed, 14 Apr 2004 14:56:20 -0600
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain
Return-Path: <Jiang.Xu@echostar.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 4782
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: Jiang.Xu@echostar.com
Precedence: bulk
X-list: linux-mips

I do turn on CONFIG_VT, if I don't I will not be able to pass compiling the
keyboard.c and some other stuffs.
Because I did not turn on INPUT_EVDEV, so I did not create the device node
before. 

However, I just gave it a quick try by turning on INPUT_EVDEV and create the
device nodes; and actually I saw response on input/event0!! Thanks!

Now I have some questions:
1.  I have CONFIG_VT on, so why ttyN is not connected to the device? I saw
console.o and tty_io.o, etc.
What may be wrong or did I miss doing some things that I should do?
2.  In the application, how can I know which input/event# the usb keyboard
connects to?
3.  Is there some reference documents about how to read things from
input/event# ? I mean such as how to read key event?

Thanks

John




-----Original Message-----
From: Geert Uytterhoeven [mailto:geert@linux-m68k.org] 
Sent: Wednesday, April 14, 2004 2:37 PM
To: Xu, Jiang
Cc: Linux/MIPS Development
Subject: RE: questions about keyboard


On Wed, 14 Apr 2004, Xu, Jiang wrote:
> Well, this is the problem.
> For some reasons, none of the /dev/tty /dev/tty0... /dev/console is 
> connected to the keyboard, I have tried listening all of them.  Did I 
> configured something wrong? But kernel seems to be getting the key 
> event from the keyboard. Another question is if it should connect to 
> one of those device nodes, is there anyway I can hack the kernel to 
> see where the key event sent to?

Do you have CONFIG_VT=y? I guess not.

Do you receive anything on /dev/input/eventX?

> -----Original Message-----
> From: Jan-Benedict Glaw [mailto:jbglaw@lug-owl.de]
> Sent: Wednesday, April 14, 2004 2:26 PM
> To: linux-mips@linux-mips.org
> Subject: Re: questions about keyboard
>
>
> On Wed, 2004-04-14 14:18:18 -0600, Xu, Jiang <Jiang.Xu@echostar.com> 
> wrote in message 
> <F71A246055866844B66AFEB10654E7860F1B0B@riv-exchb6.echostar.com>:
> > However, what I don't get is how can I get the key event from the 
> > kernel?  I tried to listen to all the ttyN, but none of them connect 
> > to
> the keyboard.
> > I wonder how I can write a user space application that can get the 
> > key event?  Could somebody help me out?  Because it is an embedded 
> > device,
> there
> > is no X.
>
> Well, one of /dev/tty, /dev/tty0 or /dev/console should work. If you'd 
> likt to use the new'n'fancy style, use /dev/input/eventX .

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
