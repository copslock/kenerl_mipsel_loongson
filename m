Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f6ODrH110975
	for linux-mips-outgoing; Tue, 24 Jul 2001 06:53:17 -0700
Received: from mail.sonytel.be (mail.sonytel.be [193.74.243.200])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f6ODrFO10967
	for <linux-mips@oss.sgi.com>; Tue, 24 Jul 2001 06:53:15 -0700
Received: from mullein.sonytel.be (mullein.sonytel.be [10.34.64.30])
	by mail.sonytel.be (8.9.0/8.8.6) with ESMTP id PAA24406;
	Tue, 24 Jul 2001 15:53:05 +0200 (MET DST)
Date: Tue, 24 Jul 2001 15:53:05 +0200 (MEST)
From: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
To: Andrew Thornton <andrew.thornton@insignia.com>
cc: James Simmons <jsimmons@transvirtual.com>,
   Linux-MIPS <linux-mips@oss.sgi.com>
Subject: Re: ATI Victoria on Malta
In-Reply-To: <00b201c11443$f02eae40$d11110ac@snow.isltd.insignia.com>
Message-ID: <Pine.GSO.4.21.0107241550130.3373-100000@mullein.sonytel.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Tue, 24 Jul 2001, Andrew Thornton wrote:
> >Turn on debugging in atyfb.c and post the results.
> >
> >/*
> > * Debug flags.
> > */
> >#undef DEBUG
> 
> OK. I'm afraid I haven't got that much time to spare on this, which is why I
> asked if anyone else had managed this!
> 
> What I've got is linux-2.4.3.mips-src-01.00.tar.gz (from ftp.mips.com)
> patched to make the FPU emulator work reliably (taken from the mail list),
> aty.h and atyfb.c from linux-2.4.6.tar.gz (from ftp.kernel.org) with DEBUG
> defined. The kernel is configured for a little endian Malta board, virtual
> terminal, framebuffer, ATI Mach64, PS2 keyboard (I had to change the MIPS
> config.in for this), GDB debugging.
> 
> The relevant console output is:
> 
> atyfb: 3D RAGE (XL) [0x4752 rev 0x65] 512K SGRAM, 14.31818 MHz XTAL, 230 MHz
> PLL
> , 120 Mhz MCLK
> BUS_CNTL DAC_CNTL MEM_CNTL EXT_MEM_CNTL CRTC_GEN_CNTL DSP_CONFIG DSP_ON_OFF
> 80000001 06010000 00085838 00000081     04000000      00000000   00000000
> PLL ac ac 24 df f6 04 00 fd 8e 9e 65 05 00 00 00 00
> 
> It hangs here.
> 
> Adding printk()'s, it seems that one of the places it hangs is in
> wait_for_fifo() reading FIFO_STAT.

Using `atydebug' (from tools in CVS module atyfb at
http://www.sourceforge.net/projects/linux-fbdev/), the PLL debug values mean:

| tux$ ./atydebug ac ac 24 df f6 04 00 fd 8e 9e 65 05 00 00 00 00
| PLL rate = 417.901480 MHz (guessed)
| bad MCLK post divider 5
| VCLK0 = 414.623821 MHz
| VCLK1 = 232.713765 MHz
| VCLK2 = 86.311678 MHz
| VCLK3 = 165.521763 MHz
| tux$ 

Which looks a bit odd. The same for the 512 K SGRAM.

So I guess the Malta firmware hasn't initialized the RAGE XL yet. And atyfb
requires an initialized chip.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven ------------- Sony Software Development Center Europe (SDCE)
Geert.Uytterhoeven@sonycom.com ------------------- Sint-Stevens-Woluwestraat 55
Voice +32-2-7248626 Fax +32-2-7262686 ---------------- B-1130 Brussels, Belgium
