Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id fB7IcMR18032
	for linux-mips-outgoing; Fri, 7 Dec 2001 10:38:22 -0800
Received: from nevyn.them.org (mail@NEVYN.RES.CMU.EDU [128.2.145.6])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id fB7Ic5o18029;
	Fri, 7 Dec 2001 10:38:06 -0800
Received: from drow by nevyn.them.org with local (Exim 3.33 #1 (Debian))
	id 16COxF-0006Bu-00; Fri, 07 Dec 2001 12:38:33 -0500
Date: Fri, 7 Dec 2001 12:38:33 -0500
From: Daniel Jacobowitz <dan@debian.org>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: "Bradley D. LaRonde" <brad@ltc.com>, Ralf Baechle <ralf@oss.sgi.com>,
   Linux/MIPS Development <linux-mips@oss.sgi.com>
Subject: Re: PATCH: io.h remove detrimental do {...} whiles, add sequence points, add const modifiers
Message-ID: <20011207123833.A23784@nevyn.them.org>
References: <20011207121416.A9583@dev1.ltc.com> <Pine.GSO.4.21.0112071830000.29896-100000@mullein.sonytel.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.GSO.4.21.0112071830000.29896-100000@mullein.sonytel.be>
User-Agent: Mutt/1.3.23i
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Fri, Dec 07, 2001 at 06:30:43PM +0100, Geert Uytterhoeven wrote:
> On Fri, 7 Dec 2001, Bradley D. LaRonde wrote:
> > 2001-12-07  Bradley D. LaRonde <brad@ltc.com>
> > 
> > * remove detrimental do {...} whiles
> > * add sequence point to in[b,w,l] to prevent compiler from reordering
> > * add const modifier to outs[b,w,l] (quiets some compiler warnings)
> > 
> > 
> > --- linux-oss-2.4-2001-12-04/include/asm-mips/io.h	Thu Dec  6 17:07:24 2001
> > +++ linux-patch/include/asm-mips/io.h	Thu Dec  6 16:47:20 2001
> > @@ -63,7 +63,7 @@
> >  extern const unsigned long mips_io_port_base;
> >  
> >  #define set_io_port_base(base)	\
> > -	do { * (unsigned long *) &mips_io_port_base = (base); } while (0)
> > +	*(unsigned long *)&mips_io_port_base = (base);
> 
> Now consider someone writing
> 
>     if (...)
> 	set_io_port_base(...);
>     else
> 	...
> 
> And see what happens...

If Bradley loses the extra semicolon, what other problem is the
do/while construct supposed to address?  I seem to recall there being
another problem case, but I can't remember what it is.

-- 
Daniel Jacobowitz                           Carnegie Mellon University
MontaVista Software                         Debian GNU/Linux Developer
