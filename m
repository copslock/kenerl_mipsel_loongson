Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f93Hqtc20158
	for linux-mips-outgoing; Wed, 3 Oct 2001 10:52:55 -0700
Received: from dea.linux-mips.net (a1as01-p32.stg.tli.de [195.252.185.32])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f93HqoD20155
	for <linux-mips@oss.sgi.com>; Wed, 3 Oct 2001 10:52:51 -0700
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.11.1/8.11.1) id f93Hoxv28341;
	Wed, 3 Oct 2001 19:50:59 +0200
Date: Wed, 3 Oct 2001 19:50:59 +0200
From: Ralf Baechle <ralf@oss.sgi.com>
To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
Cc: linux-mips@oss.sgi.com
Subject: Re: CVS Update@oss.sgi.com: linux
Message-ID: <20011003195059.A28205@dea.linux-mips.net>
References: <200109300029.f8U0TZv12410@oss.sgi.com> <Pine.GSO.3.96.1011003125730.15867A-100000@delta.ds2.pg.gda.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.GSO.3.96.1011003125730.15867A-100000@delta.ds2.pg.gda.pl>; from macro@ds2.pg.gda.pl on Wed, Oct 03, 2001 at 01:02:56PM +0200
X-Accept-Language: de,en,fr
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Wed, Oct 03, 2001 at 01:02:56PM +0200, Maciej W. Rozycki wrote:

> > Modified files:
> > 	arch/mips/kernel: scall_o32.S sysmips.c 
> > 
> > Log message:
> > 	Barf.
> 
>  The new mips_atomic_set() doesn't mask interrupts in the non-ll/sc case. 
> Thus it may fail to keep coherency.  Is it intentional? 

Yes.  Assuming do_page_fault did it's job successfully the address which
has been passed as argument to sysmips() is now writable and thus we
won't take any pagefaults.

There are two remaining failure scenarios which probably are't very
interesting for practical usage.  It's when an interrupt is accessing
the same address.  This could be fixed by disabling interrupts.
The other case is missaligned words.

>  Also the bad_stack exit point for the ll/sc case looks suspicient to me.

Indeed, the symbol deserves a better name.  Cut'n'paste happens ;-)

  Ralf
