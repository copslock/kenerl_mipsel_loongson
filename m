Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id fB7IV4n17892
	for linux-mips-outgoing; Fri, 7 Dec 2001 10:31:04 -0800
Received: from mail.sonytel.be (mail.sonytel.be [193.74.243.200])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id fB7IUvo17889;
	Fri, 7 Dec 2001 10:30:57 -0800
Received: from mullein.sonytel.be (mail.sonytel.be [10.17.0.26])
	by mail.sonytel.be (8.9.0/8.8.6) with ESMTP id SAA26631;
	Fri, 7 Dec 2001 18:30:42 +0100 (MET)
Date: Fri, 7 Dec 2001 18:30:43 +0100 (MET)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: "Bradley D. LaRonde" <brad@ltc.com>
cc: Ralf Baechle <ralf@oss.sgi.com>,
   Linux/MIPS Development <linux-mips@oss.sgi.com>
Subject: Re: PATCH: io.h remove detrimental do {...} whiles, add sequence
 points, add const modifiers
In-Reply-To: <20011207121416.A9583@dev1.ltc.com>
Message-ID: <Pine.GSO.4.21.0112071830000.29896-100000@mullein.sonytel.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Fri, 7 Dec 2001, Bradley D. LaRonde wrote:
> 2001-12-07  Bradley D. LaRonde <brad@ltc.com>
> 
> * remove detrimental do {...} whiles
> * add sequence point to in[b,w,l] to prevent compiler from reordering
> * add const modifier to outs[b,w,l] (quiets some compiler warnings)
> 
> 
> --- linux-oss-2.4-2001-12-04/include/asm-mips/io.h	Thu Dec  6 17:07:24 2001
> +++ linux-patch/include/asm-mips/io.h	Thu Dec  6 16:47:20 2001
> @@ -63,7 +63,7 @@
>  extern const unsigned long mips_io_port_base;
>  
>  #define set_io_port_base(base)	\
> -	do { * (unsigned long *) &mips_io_port_base = (base); } while (0)
> +	*(unsigned long *)&mips_io_port_base = (base);

Now consider someone writing

    if (...)
	set_io_port_base(...);
    else
	...

And see what happens...

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
