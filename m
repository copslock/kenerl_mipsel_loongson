Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f93LMLQ25201
	for linux-mips-outgoing; Wed, 3 Oct 2001 14:22:21 -0700
Received: from hermes.mvista.com (gateway-1237.mvista.com [12.44.186.158])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f93LMHD25190;
	Wed, 3 Oct 2001 14:22:17 -0700
Received: from mvista.com (IDENT:jsun@orion.mvista.com [10.0.0.75])
	by hermes.mvista.com (8.11.0/8.11.0) with ESMTP id f93LP3B32108;
	Wed, 3 Oct 2001 14:25:03 -0700
Message-ID: <3BBB7F7A.7AB0411@mvista.com>
Date: Wed, 03 Oct 2001 14:13:30 -0700
From: Jun Sun <jsun@mvista.com>
X-Mailer: Mozilla 4.72 [en] (X11; U; Linux 2.2.18 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Ralf Baechle <ralf@oss.sgi.com>
CC: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>, linux-mips@oss.sgi.com
Subject: Re: CVS Update@oss.sgi.com: linux
References: <200109300029.f8U0TZv12410@oss.sgi.com> <Pine.GSO.3.96.1011003125730.15867A-100000@delta.ds2.pg.gda.pl> <20011003195059.A28205@dea.linux-mips.net>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

Ralf Baechle wrote:
> 
> On Wed, Oct 03, 2001 at 01:02:56PM +0200, Maciej W. Rozycki wrote:
> 
> > > Modified files:
> > >     arch/mips/kernel: scall_o32.S sysmips.c
> > >
> > > Log message:
> > >     Barf.
> >
> >  The new mips_atomic_set() doesn't mask interrupts in the non-ll/sc case.
> > Thus it may fail to keep coherency.  Is it intentional?
> 
> Yes.  Assuming do_page_fault did it's job successfully the address which
> has been passed as argument to sysmips() is now writable and thus we
> won't take any pagefaults.
> 
> There are two remaining failure scenarios which probably are't very
> interesting for practical usage.  It's when an interrupt is accessing
> the same address.  This could be fixed by disabling interrupts.
> The other case is missaligned words.
> 

And a third one - when you enable kernel preemption with the preemptable
kernel patch. :-)


Jun
