Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id fBLJjP523236
	for linux-mips-outgoing; Fri, 21 Dec 2001 11:45:25 -0800
Received: from neurosis.mit.edu (NEUROSIS.MIT.EDU [18.243.0.82])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id fBLJjLX23233
	for <linux-mips@oss.sgi.com>; Fri, 21 Dec 2001 11:45:21 -0800
Received: (from jim@localhost)
	by neurosis.mit.edu (8.11.4/8.11.4) id fBLIiqr21627;
	Fri, 21 Dec 2001 13:44:52 -0500
Date: Fri, 21 Dec 2001 13:44:52 -0500
From: Jim Paris <jim@jtan.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>,
   "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>, Jun Sun <jsun@mvista.com>,
   Linux/MIPS Development <linux-mips@oss.sgi.com>
Subject: Re: ISA
Message-ID: <20011221134452.A21586@neurosis.mit.edu>
Reply-To: jim@jtan.com
References: <Pine.GSO.4.21.0112191456410.28777-100000@vervain.sonytel.be> <E16HSHp-0000ay-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <E16HSHp-0000ay-00@the-village.bc.nu>; from alan@lxorguk.ukuu.org.uk on Fri, Dec 21, 2001 at 04:12:40PM +0000
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

> Interesting - I'd not considered that. Is ISA and non ISA space seperate on
> MIPS or is it all rather ambiguous ?

On my particular machine, system RAM is at 0x00000000, and ISA I/O
memory is at 0x10000000.  The driver I'm currently trying to work with
calls check_mem_region with ISA addresses, which of course breaks when
ISA memory isn't at zero.  One suggestion was to patch the driver to
use something like

    check_mem_region(virt_to_phys(ioremap(ISA_address)), ...)

which might be the best way for now?  I think a more generic way to
abstract away a bus (and support multiple types and numbers of I/O
busses) is really necessary though.  Some way to register a bus with
the kernel, and bind particular busses to particular instances of
drivers, or something.

-jim
