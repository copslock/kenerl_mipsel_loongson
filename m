Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id fB7J7Hc18729
	for linux-mips-outgoing; Fri, 7 Dec 2001 11:07:17 -0800
Received: from dea.linux-mips.net (localhost [127.0.0.1])
	by oss.sgi.com (8.11.2/8.11.3) with ESMTP id fB7J7Bo18724
	for <linux-mips@oss.sgi.com>; Fri, 7 Dec 2001 11:07:12 -0800
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.11.1/8.11.1) id fB7I6aP24108;
	Fri, 7 Dec 2001 16:06:36 -0200
Date: Fri, 7 Dec 2001 16:06:36 -0200
From: Ralf Baechle <ralf@oss.sgi.com>
To: Daniel Jacobowitz <dan@debian.org>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>,
   "Bradley D. LaRonde" <brad@ltc.com>,
   Linux/MIPS Development <linux-mips@oss.sgi.com>
Subject: Re: PATCH: io.h remove detrimental do {...} whiles, add sequence points, add const modifiers
Message-ID: <20011207160636.B23798@dea.linux-mips.net>
References: <20011207121416.A9583@dev1.ltc.com> <Pine.GSO.4.21.0112071830000.29896-100000@mullein.sonytel.be> <20011207123833.A23784@nevyn.them.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20011207123833.A23784@nevyn.them.org>; from dan@debian.org on Fri, Dec 07, 2001 at 12:38:33PM -0500
X-Accept-Language: de,en,fr
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Fri, Dec 07, 2001 at 12:38:33PM -0500, Daniel Jacobowitz wrote:

> > > -	do { * (unsigned long *) &mips_io_port_base = (base); } while (0)
> > > +	*(unsigned long *)&mips_io_port_base = (base);
> > 
> > Now consider someone writing
> > 
> >     if (...)
> > 	set_io_port_base(...);
> >     else
> > 	...
> > 
> > And see what happens...
> 
> If Bradley loses the extra semicolon, what other problem is the
> do/while construct supposed to address?  I seem to recall there being
> another problem case, but I can't remember what it is.

There is imho not very much sense in such a macro / function being written
in a way that returns any value, that is something like

  foo = set_io_port_base(...)

doesn't make obvious sense.  So it's written in a way which will take care
of any attempt to use the return type.

  Ralf
