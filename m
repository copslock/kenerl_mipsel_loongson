Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 23 Dec 2002 14:23:12 +0000 (GMT)
Received: from postfix4-1.free.fr ([IPv6:::ffff:213.228.0.62]:7904 "EHLO
	postfix4-1.free.fr") by linux-mips.org with ESMTP
	id <S8225597AbSLWOXL>; Mon, 23 Dec 2002 14:23:11 +0000
Received: from yak (lns-p19-13-81-56-50-121.adsl.proxad.net [81.56.50.121])
	by postfix4-1.free.fr (Postfix) with SMTP
	id E0FB1D77B; Mon, 23 Dec 2002 15:23:07 +0100 (CET)
Message-ID: <004d01c2aa8e$cffc4690$8700a8c0@yak>
From: "nsauzede" <nsauzede@online.fr>
To: "Geert Uytterhoeven" <geert@linux-m68k.org>
Cc: "linux-mips" <linux-mips@linux-mips.org>
References: <Pine.GSO.4.21.0212221454130.11726-100000@vervain.sonytel.be>
Subject: Re: linux-mips fbdev
Date: Mon, 23 Dec 2002 15:23:00 +0100
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2600.0000
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Return-Path: <nsauzede@online.fr>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 1049
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: nsauzede@online.fr
Precedence: bulk
X-list: linux-mips

Hello !
Thank you so much for your response !! :-)

> Yes, you always have to use the graphics accelerator.

Ok

> By using the tricks also used in vga256fb (cfr.
> http://www.kyuzz.org/antirez/vga256fb.html), you can emulate a normal
linear
> frame buffer and use the Indy's graphics accelerator to update the screen.
> But it will be slow.

This link is really interesting, thanks !

> An alternative is to use mmap() tricks to find out what's updated in the
fake
> linear frame buffer, and update the screen afterwards.
>
> Or program the Indy graphics accelerator directly from user space :-)

Hmm, may be that would be the best I have to do for now, at least in order
to get familiarized with the "Indy graphics accelerator" you're talking
about...
Any pointers ?? All I could find about it was kernel code fragments found in
the linux mips source, that crashed my indy
when trying to play with pixels in user mode..
But, maybe you're not implied a lot in Indy graphics, and I'm sorry if I
bother  you to much with my problems !!

> Gr{oetje,eeting}s,
>
> Geert

Thank you !

Nicolas Sauzede.
