Received:  by oss.sgi.com id <S553709AbRBOLFh>;
	Thu, 15 Feb 2001 03:05:37 -0800
Received: from mail.sonytel.be ([193.74.243.200]:49871 "EHLO mail.sonytel.be")
	by oss.sgi.com with ESMTP id <S553687AbRBOLFK>;
	Thu, 15 Feb 2001 03:05:10 -0800
Received: from escobaria.sonytel.be (escobaria.sonytel.be [10.34.80.3])
	by mail.sonytel.be (8.9.0/8.8.6) with ESMTP id MAA03835;
	Thu, 15 Feb 2001 12:03:43 +0100 (MET)
Date:   Thu, 15 Feb 2001 12:03:43 +0100 (MET)
From:   Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
To:     Deepa Suresh <deepa.suresh@WIPRO.COM>
cc:     linux-mips@oss.sgi.com
Subject: Re: your mail
In-Reply-To: <77452A3CA92.AAA7057@santa.mail.wipro.com>
Message-ID: <Pine.GSO.4.10.10102151201280.10238-100000@escobaria.sonytel.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

On Wed, 14 Feb 2001, Deepa  Suresh wrote:
> We have a QED based MIPs processor, running Linux 2.4-test6. 
> We use our own graphics card.
> We want to get X/display up on this board. WE have a frame buffer driver
> written
> for the same card running on x86 Linux version and running X using
> XFBDev server.

Does the frame buffer driver you wrote for x86 Linux relies on the card being
initialised by the video BIOS on the card? If not, it'll work out-of-the-box.
If yes, you'll have to make sure a similar initialization is done on the MIPS
platform.

> I want to know if we can reuse the same driver for mips also?
> In the case of i386 Linux, fbcon.c and fbmem.c do most of the
> processing before giving control to the corresponding graphics card.
> 
> In mips port can we use the same fbcon.c and fbmem.c functionality 
> with our graphics driver. Is this enough for X to come up
> without any problems. (i have seen sgi using newport_con , can we use
> fb_con itself instead , what are the problems?)

Fbmem and fbcon should work fine. They are not architecture specific.

And if these work, XF{68,86}_FBDev should work as well.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven ------------- Sony Software Development Center Europe (SDCE)
Geert.Uytterhoeven@sonycom.com ------------------- Sint-Stevens-Woluwestraat 55
Voice +32-2-7248626 Fax +32-2-7262686 ---------------- B-1130 Brussels, Belgium
