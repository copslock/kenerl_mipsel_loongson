Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f6Q7e3U01460
	for linux-mips-outgoing; Thu, 26 Jul 2001 00:40:03 -0700
Received: from mail.sonytel.be (mail.sonytel.be [193.74.243.200])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f6Q7e0V01447
	for <linux-mips@oss.sgi.com>; Thu, 26 Jul 2001 00:40:01 -0700
Received: from mullein.sonytel.be (mullein.sonytel.be [10.34.64.30])
	by mail.sonytel.be (8.9.0/8.8.6) with ESMTP id JAA00511;
	Thu, 26 Jul 2001 09:39:10 +0200 (MET DST)
Date: Thu, 26 Jul 2001 09:39:05 +0200 (MEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: "John D. Davis" <johnd@Stanford.EDU>
cc: Debian MIPS list <debian-mips@lists.debian.org>,
   SGI MIPS list <linux-mips@oss.sgi.com>
Subject: Re: Replacing the Console driver
In-Reply-To: <Pine.GSO.4.31.0107251427180.21227-100000@myth1.Stanford.EDU>
Message-ID: <Pine.GSO.4.21.0107260937530.4260-100000@mullein.sonytel.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Wed, 25 Jul 2001, John D. Davis wrote:
> I am modifying the linux kernel to be able to be run by a simulator.  I
> need to modify the console driver and interrupt handler.  I have been
> going through the various files, console.*, tty.* and the serial files to
> see how to interface to the console.  I have also read some kernel korner
> articles, but they seem a little out of date.  Is there any other
> recommended documentation on the console driver and how it works on an
> indy? I am trying to sort out the low-level interfaces from the
> higher-level ones.  I just need to change the low-level interface from
> using the hardware to using the simulator interface.

The interface to the console is specified in <linux/console.h>.

So write your own console implementation, and set

    conswitchp = &consw_for_your_emulator

in early kernel initialization code.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
