Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id g18HgdV06130
	for linux-mips-outgoing; Fri, 8 Feb 2002 09:42:39 -0800
Received: from nevyn.them.org (mail@NEVYN.RES.CMU.EDU [128.2.145.6])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id g18HgXA06126
	for <linux-mips@oss.sgi.com>; Fri, 8 Feb 2002 09:42:33 -0800
Received: from drow by nevyn.them.org with local (Exim 3.34 #1 (Debian))
	id 16ZF2Y-0006Lq-00; Fri, 08 Feb 2002 12:42:26 -0500
Date: Fri, 8 Feb 2002 12:42:26 -0500
From: Daniel Jacobowitz <dan@debian.org>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: "Steven J. Hill" <sjhill@realitydiluted.com>,
   Linux/MIPS Development <linux-mips@oss.sgi.com>
Subject: Re: [PATCH] Removal of warning messages for gdb-stub.c
Message-ID: <20020208124226.A24322@nevyn.them.org>
References: <E16ZD2B-0003iv-00@real.realitydiluted.com> <Pine.GSO.4.21.0202081713590.19681-100000@vervain.sonytel.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.GSO.4.21.0202081713590.19681-100000@vervain.sonytel.be>
User-Agent: Mutt/1.3.23i
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Fri, Feb 08, 2002 at 05:16:00PM +0100, Geert Uytterhoeven wrote:
> On Fri, 8 Feb 2002, Steven J. Hill wrote:
> > Just more clean ups. I tested it, it works.
> > 
> > -Steve
> > 
> > diff -urN -X cvs-exc.txt mipslinux-2.4.17-xfs/arch/mips/kernel/gdb-stub.c settop/arch/mips/kernel/gdb-stub.c
> > --- mipslinux-2.4.17-xfs/arch/mips/kernel/gdb-stub.c	Thu Nov 29 09:13:08 2001
> > +++ settop/arch/mips/kernel/gdb-stub.c	Fri Feb  8 09:14:52 2002
> > @@ -306,7 +306,7 @@
> >  	unsigned char ch;
> >  
> >  	while (count-- > 0) {
> > -		if (kgdb_read_byte(mem++, &ch) != 0)
> > +		if (kgdb_read_byte((unsigned *) mem++, (unsigned *) &ch) != 0)
> >  			return 0;
> >  		*buf++ = hexchars[ch >> 4];
> >  		*buf++ = hexchars[ch & 0xf];
> > @@ -332,7 +332,7 @@
> >  	{
> >  		ch = hex(*buf++) << 4;
> >  		ch |= hex(*buf++);
> > -		if (kgdb_write_byte(ch, mem++) != 0)
> > +		if (kgdb_write_byte((unsigned) ch, (unsigned *) mem++) != 0)
> >  			return 0;
> >  	}
> >  
> 
> Wouldn't it be better to change the prototypes
> 
> | int kgdb_read_byte(unsigned *address, unsigned *dest);
> | int kgdb_write_byte(unsigned val, unsigned *dest);
> 
> instead?
> 
> If these routines work on bytes, why have them taking unsigned (wasn't plain
> `unsigned' deprecated in some recent C standard?) parameters instead of char
> parameters?

Because Ralf dropped one of my patches, or messed up a merge, or more
likely I simply sent him a bad patch.  My working directory from when I
remember writing those functions says unsigned char...

-- 
Daniel Jacobowitz                           Carnegie Mellon University
MontaVista Software                         Debian GNU/Linux Developer
