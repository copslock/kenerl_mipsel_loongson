Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f9CBwLw18756
	for linux-mips-outgoing; Fri, 12 Oct 2001 04:58:21 -0700
Received: from sgi.com (sgi.SGI.COM [192.48.153.1])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f9CBw7D18737;
	Fri, 12 Oct 2001 04:58:07 -0700
Received: from mail.sonytel.be (admin.sonytel.be [195.0.45.167] (may be forged)) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id EAA02636; Fri, 12 Oct 2001 04:57:55 -0700 (PDT)
	mail_from (Geert.Uytterhoeven@sonycom.com)
Received: from mullein.sonytel.be (mullein.sonytel.be [10.34.64.30])
	by mail.sonytel.be (8.9.0/8.8.6) with ESMTP id NAA28424;
	Fri, 12 Oct 2001 13:52:25 +0200 (MET DST)
Date: Fri, 12 Oct 2001 13:52:19 +0200 (MEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Jun Sun <jsun@mvista.com>
cc: Ralf Baechle <ralf@oss.sgi.com>,
   Gerald Champagne <gerald.champagne@esstech.com>,
   "linux-mips@oss.sgi.com" <linux-mips@oss.sgi.com>
Subject: Re: Remove ifdefs from setup_arch()
In-Reply-To: <3BBB7F14.C864736A@mvista.com>
Message-ID: <Pine.GSO.4.21.0110121350300.20566-100000@mullein.sonytel.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Wed, 3 Oct 2001, Jun Sun wrote:
> I talked about machine detection a while back.  My idea is following:
> 
> 0. all machines that are *configured* into the image will supply <my>_detect()
> and <my>_setup() functions.
> 
> 1. at MIPS start up, we loop through all <my>_detect(), which returns three
> values, a) run-time detection negative, b) run-time detection positive, and c)
> no run-time detection code, but I return positive because I am configured in.
> 
> 2. the startup code resolves conflicts (which sometimes may panic); and decide
> on one machine.
> 
> 3. then the startup code calls the right <my>_setup() code which will set up
> the mach_type and other stuff. 

Nice!

I suppose you want to have struct containing pointers to both the detect() and
setup() functions, so you know which setup() function you have to call?

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
