Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id fB7JFR718933
	for linux-mips-outgoing; Fri, 7 Dec 2001 11:15:27 -0800
Received: from neurosis.mit.edu (NEUROSIS.MIT.EDU [18.243.0.82])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id fB7JFMo18930;
	Fri, 7 Dec 2001 11:15:22 -0800
Received: (from jim@localhost)
	by neurosis.mit.edu (8.11.4/8.11.4) id fB7IFL603975;
	Fri, 7 Dec 2001 13:15:21 -0500
Date: Fri, 7 Dec 2001 13:15:21 -0500
From: Jim Paris <jim@jtan.com>
To: Ralf Baechle <ralf@oss.sgi.com>
Cc: Daniel Jacobowitz <dan@debian.org>,
   Geert Uytterhoeven <geert@linux-m68k.org>,
   "Bradley D. LaRonde" <brad@ltc.com>,
   Linux/MIPS Development <linux-mips@oss.sgi.com>
Subject: Re: PATCH: io.h remove detrimental do {...} whiles, add sequence points, add const modifiers
Message-ID: <20011207131521.A3942@neurosis.mit.edu>
Reply-To: jim@jtan.com
References: <20011207121416.A9583@dev1.ltc.com> <Pine.GSO.4.21.0112071830000.29896-100000@mullein.sonytel.be> <20011207123833.A23784@nevyn.them.org> <20011207160636.B23798@dea.linux-mips.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20011207160636.B23798@dea.linux-mips.net>; from ralf@oss.sgi.com on Fri, Dec 07, 2001 at 04:06:36PM -0200
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

> There is imho not very much sense in such a macro / function being written
> in a way that returns any value, that is something like
> 
>   foo = set_io_port_base(...)
> 
> doesn't make obvious sense.  So it's written in a way which will take care
> of any attempt to use the return type.

So Brad's way allows things that weren't allowed before.  But does
it break anything that works with the do/while construct?

You can take care of attempts to use the return type by voiding it:

#define set_io_port_base(base)		\
	(void)(*(unsigned long *)&mips_io_port_base = (base))

-jim
