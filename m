Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id fB7J4iW18555
	for linux-mips-outgoing; Fri, 7 Dec 2001 11:04:44 -0800
Received: from neurosis.mit.edu (NEUROSIS.MIT.EDU [18.243.0.82])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id fB7J4do18551;
	Fri, 7 Dec 2001 11:04:39 -0800
Received: (from jim@localhost)
	by neurosis.mit.edu (8.11.4/8.11.4) id fB7I4XG03887;
	Fri, 7 Dec 2001 13:04:33 -0500
Date: Fri, 7 Dec 2001 13:04:33 -0500
From: Jim Paris <jim@jtan.com>
To: Daniel Jacobowitz <dan@debian.org>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>,
   "Bradley D. LaRonde" <brad@ltc.com>, Ralf Baechle <ralf@oss.sgi.com>,
   Linux/MIPS Development <linux-mips@oss.sgi.com>
Subject: Re: PATCH: io.h remove detrimental do {...} whiles, add sequence points, add const modifiers
Message-ID: <20011207130433.A3806@neurosis.mit.edu>
Reply-To: jim@jtan.com
References: <20011207121416.A9583@dev1.ltc.com> <Pine.GSO.4.21.0112071830000.29896-100000@mullein.sonytel.be> <20011207123833.A23784@nevyn.them.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20011207123833.A23784@nevyn.them.org>; from dan@debian.org on Fri, Dec 07, 2001 at 12:38:33PM -0500
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

> > >  #define set_io_port_base(base)	\
> > > -	do { * (unsigned long *) &mips_io_port_base = (base); } while (0)
> > > +	*(unsigned long *)&mips_io_port_base = (base);
>
> If Bradley loses the extra semicolon, what other problem is the
> do/while construct supposed to address?  I seem to recall there being
> another problem case, but I can't remember what it is.

For that particular #define, I can't think of any problem cases.  The
do/while helps with multiple statements, gives you a new scope for
variable declaration, and allows the code to do a break, but we don't
need any of that here.

-jim
