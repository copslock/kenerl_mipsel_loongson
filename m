Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f6OFtli22141
	for linux-mips-outgoing; Tue, 24 Jul 2001 08:55:47 -0700
Received: from mail.sonytel.be (mail.sonytel.be [193.74.243.200])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f6OFtiO22136
	for <linux-mips@oss.sgi.com>; Tue, 24 Jul 2001 08:55:45 -0700
Received: from mullein.sonytel.be (mullein.sonytel.be [10.34.64.30])
	by mail.sonytel.be (8.9.0/8.8.6) with ESMTP id RAA01480;
	Tue, 24 Jul 2001 17:55:34 +0200 (MET DST)
Date: Tue, 24 Jul 2001 17:55:34 +0200 (MEST)
From: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
To: Andrew Thornton <andrew.thornton@insignia.com>
cc: James Simmons <jsimmons@transvirtual.com>,
   Linux-MIPS <linux-mips@oss.sgi.com>
Subject: Re: ATI Victoria on Malta
In-Reply-To: <013401c11458$7813b6c0$d11110ac@snow.isltd.insignia.com>
Message-ID: <Pine.GSO.4.21.0107241753310.3373-100000@mullein.sonytel.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Tue, 24 Jul 2001, Andrew Thornton wrote:
> >Using `atydebug' (from tools in CVS module atyfb at
> >http://www.sourceforge.net/projects/linux-fbdev/), the PLL debug values
> mean:
> >
> >| tux$ ./atydebug ac ac 24 df f6 04 00 fd 8e 9e 65 05 00 00 00 00
> >| PLL rate = 417.901480 MHz (guessed)
> >| bad MCLK post divider 5
> >| VCLK0 = 414.623821 MHz
> >| VCLK1 = 232.713765 MHz
> >| VCLK2 = 86.311678 MHz
> >| VCLK3 = 165.521763 MHz
> >| tux$
> >
> >Which looks a bit odd. The same for the 512 K SGRAM.
> >
> >So I guess the Malta firmware hasn't initialized the RAGE XL yet. And atyfb
> >requires an initialized chip.
> 
> I guess this is not surprising because the Malta firmware isn't a PC BIOS.

If the RAGE XL is the officially supported video board for the Malta, I
wouldn't have been surprised if its firmware would have contained code to
initialize the RAGE XL. But unfortunately this doesn't seem to be the case.

Next question: is there sample code available (e.g. with the `supported' OS for
the Malta) to initialize the RAGE XL?

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven ------------- Sony Software Development Center Europe (SDCE)
Geert.Uytterhoeven@sonycom.com ------------------- Sint-Stevens-Woluwestraat 55
Voice +32-2-7248626 Fax +32-2-7262686 ---------------- B-1130 Brussels, Belgium
