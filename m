Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 26 Feb 2003 09:28:09 +0000 (GMT)
Received: from mail2.sonytel.be ([IPv6:::ffff:195.0.45.172]:58580 "EHLO
	mail.sonytel.be") by linux-mips.org with ESMTP id <S8224851AbTBZJ2I>;
	Wed, 26 Feb 2003 09:28:08 +0000
Received: from vervain.sonytel.be (mail.sonytel.be [10.17.0.26])
	by mail.sonytel.be (8.9.0/8.8.6) with ESMTP id KAA29667;
	Wed, 26 Feb 2003 10:27:49 +0100 (MET)
Date: Wed, 26 Feb 2003 10:27:55 +0100 (MET)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Jiahan Chen <jiahanchen@yahoo.com>
cc: Linux/MIPS Development <linux-mips@linux-mips.org>
Subject: Re: CVS Usage and Kernel Build
In-Reply-To: <20030226030636.95154.qmail@web40804.mail.yahoo.com>
Message-ID: <Pine.GSO.4.21.0302261027150.11509-100000@vervain.sonytel.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <Geert.Uytterhoeven@sonycom.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 1564
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: geert@linux-m68k.org
Precedence: bulk
X-list: linux-mips

On Tue, 25 Feb 2003, Jiahan Chen wrote:
> > > Where and how can I get CVS source tree to build customized 
> > > Linux kernel for Mips?
> > 
> > http://www.google.com/search?q=Linux+MIPS+CVS
> > 
> > Gr{oetje,eeting}s,
> >
> 
> >From Mips web-site, I read:
>  
> cvs -d :pserver:cvs@ftp.linux-mips.org:/home/cvs login
> (Only needed the first time you use anonymous CVS, the password is "cvs")
> cvs -d :pserver:cvs@ftp.linux-mips.org:/home/cvs co <repository>
> 
> I have a few questions:
> 1. There should be a client "cvs" in my linux PC, then to use 
>    above command to get CVS source files INDIVIDUALLY?

cvs -d :pserver:cvs@ftp.linux-mips.org:/home/cvs co linux/path/to/file.

> 2. After get everything from ftp site as above, do we use
>    the similar procedure to re-build linux kernel for MIPS, such as
>    make config; make dep; make vmlinux

Yes.

> 3. Does this source tree support R3000 (CPU) and USB?

Yes.

> 4. In order to add a new USB device driver, do I need update
>    drivers/usb/Config.In and drivers/usb/Makefile manully?

Yes.

> Currently, I am in the initial phase for development, the Network
> card is not available and Winmoden doesn't work with Linux,
> so I have no ftp connection from my Linux box to get
> CVS. In this case, is there any alternative to get CVS source
> tree?

Use CVS on another box.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
