Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id fACIKiL01878
	for linux-mips-outgoing; Mon, 12 Nov 2001 10:20:44 -0800
Received: from hermes.mvista.com (gateway-1237.mvista.com [12.44.186.158])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id fACIKe001874
	for <linux-mips@oss.sgi.com>; Mon, 12 Nov 2001 10:20:40 -0800
Received: from mvista.com (IDENT:jsun@orion.mvista.com [10.0.0.75])
	by hermes.mvista.com (8.11.0/8.11.0) with ESMTP id fACILGB11153;
	Mon, 12 Nov 2001 10:21:16 -0800
Message-ID: <3BF012CA.287A76A@mvista.com>
Date: Mon, 12 Nov 2001 10:19:54 -0800
From: Jun Sun <jsun@mvista.com>
X-Mailer: Mozilla 4.72 [en] (X11; U; Linux 2.2.18 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Geert Uytterhoeven <geert@linux-m68k.org>
CC: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>,
   Linux/MIPS Development <linux-mips@oss.sgi.com>,
   Linux/m68k <linux-m68k@lists.linux-m68k.org>,
   Linux/PPC Development <linuxppc-dev@lists.linuxppc.org>
Subject: Re: [RFC] generic MIPS RTC driver
References: <Pine.GSO.4.21.0111121410230.11251-100000@mullein.sonytel.be>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

Geert Uytterhoeven wrote:
> 
> On Mon, 12 Nov 2001, Maciej W. Rozycki wrote:
> > On Sun, 11 Nov 2001, Geert Uytterhoeven wrote:
> > > > In other words, with such a driver, once you implemented rtc_get_time()
> > > > and rtc_set_time(), which is required by the kernel anyway, you will
> > > > automatically get a free /dev/rtc/ driver.
> > > >
> > > > This is the idea behind the generic MIPS rtc driver.  See the patch below.
> > >
> > > Oh no, don't tell me we now have (at least) _three_ of these floating around
> > > :-)
> > >
> > >   - On m68k, we have drivers/char/genrtc.c (not yet merged, check out CVS, see
> > >     http://linux-m68k-cvs.apia.dhs.org/).
> > >   - On PPC, we have drivers/macintosh/rtc.c.
> > >   - On MIPS, we now have your drivers/char/mips_rtc.c.
> >
> >  Agreed, what's wrong with drivers/char/rtc.c?  It even works for the
> 
> It's for MC146818 RTCs only.
> 
> > DECstation which maps its RTC in an unusual (but nice) way -- it's just a
> > matter of initializing rtc_ops appropriately.  See arch/mips/dec/rtc-dec.c
> > for an example.
> >
> >  Unless you use a non-MC146818 RTC, which you need to write a separate
> > driver for anyway.
> 
> Yep, so that's why both m68k and PPC have common routines to read/write the
> RTC, with a /dev/rtc-compatible abstraction on top of it.
> 

Geert, what is the abstraction they used?

The /dev/rtc interface is highly influenced by MC146818 chip, which not all
RTC devices are alike.  The only fundamental thing in the driver is really the
read and write time.

If their abstraction is reasonable, perhaps they can all converge to a better,
more generic rtc interface.

Jun
