Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id g18GGs704840
	for linux-mips-outgoing; Fri, 8 Feb 2002 08:16:54 -0800
Received: from mail.sonytel.be (mail.sonytel.be [193.74.243.200])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id g18GGkA04835
	for <linux-mips@oss.sgi.com>; Fri, 8 Feb 2002 08:16:47 -0800
Received: from vervain.sonytel.be (mail.sonytel.be [10.17.0.26])
	by mail.sonytel.be (8.9.0/8.8.6) with ESMTP id RAA21330;
	Fri, 8 Feb 2002 17:15:59 +0100 (MET)
Date: Fri, 8 Feb 2002 17:16:00 +0100 (MET)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: "Steven J. Hill" <sjhill@realitydiluted.com>
cc: Linux/MIPS Development <linux-mips@oss.sgi.com>
Subject: Re: [PATCH] Removal of warning messages for gdb-stub.c
In-Reply-To: <E16ZD2B-0003iv-00@real.realitydiluted.com>
Message-ID: <Pine.GSO.4.21.0202081713590.19681-100000@vervain.sonytel.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Fri, 8 Feb 2002, Steven J. Hill wrote:
> Just more clean ups. I tested it, it works.
> 
> -Steve
> 
> diff -urN -X cvs-exc.txt mipslinux-2.4.17-xfs/arch/mips/kernel/gdb-stub.c settop/arch/mips/kernel/gdb-stub.c
> --- mipslinux-2.4.17-xfs/arch/mips/kernel/gdb-stub.c	Thu Nov 29 09:13:08 2001
> +++ settop/arch/mips/kernel/gdb-stub.c	Fri Feb  8 09:14:52 2002
> @@ -306,7 +306,7 @@
>  	unsigned char ch;
>  
>  	while (count-- > 0) {
> -		if (kgdb_read_byte(mem++, &ch) != 0)
> +		if (kgdb_read_byte((unsigned *) mem++, (unsigned *) &ch) != 0)
>  			return 0;
>  		*buf++ = hexchars[ch >> 4];
>  		*buf++ = hexchars[ch & 0xf];
> @@ -332,7 +332,7 @@
>  	{
>  		ch = hex(*buf++) << 4;
>  		ch |= hex(*buf++);
> -		if (kgdb_write_byte(ch, mem++) != 0)
> +		if (kgdb_write_byte((unsigned) ch, (unsigned *) mem++) != 0)
>  			return 0;
>  	}
>  

Wouldn't it be better to change the prototypes

| int kgdb_read_byte(unsigned *address, unsigned *dest);
| int kgdb_write_byte(unsigned val, unsigned *dest);

instead?

If these routines work on bytes, why have them taking unsigned (wasn't plain
`unsigned' deprecated in some recent C standard?) parameters instead of char
parameters?

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
