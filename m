Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id fACJ3kt03543
	for linux-mips-outgoing; Mon, 12 Nov 2001 11:03:46 -0800
Received: from sgi.com (sgi.SGI.COM [192.48.153.1])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id fACJ2h003467
	for <linux-mips@oss.sgi.com>; Mon, 12 Nov 2001 11:02:43 -0800
Received: from hermes.mvista.com (gateway-1237.mvista.com [12.44.186.158]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id LAA05691
	for <linux-mips@oss.sgi.com>; Mon, 12 Nov 2001 11:02:43 -0800 (PST)
	mail_from (jsun@mvista.com)
Received: from mvista.com (IDENT:jsun@orion.mvista.com [10.0.0.75])
	by hermes.mvista.com (8.11.0/8.11.0) with ESMTP id fACIw7B13253;
	Mon, 12 Nov 2001 10:58:07 -0800
Message-ID: <3BF01B6C.496179@mvista.com>
Date: Mon, 12 Nov 2001 10:56:44 -0800
From: Jun Sun <jsun@mvista.com>
X-Mailer: Mozilla 4.72 [en] (X11; U; Linux 2.2.18 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Pete Popov <ppopov@mvista.com>, "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>,
   Geert Uytterhoeven <geert@linux-m68k.org>,
   Linux/MIPS Development <linux-mips@oss.sgi.com>,
   Linux/m68k <linux-m68k@lists.linux-m68k.org>,
   Linux/PPC Development <linuxppc-dev@lists.linuxppc.org>
Subject: Re: [RFC] generic MIPS RTC driver
References: <Pine.GSO.3.96.1011112142501.24771K-100000@delta.ds2.pg.gda.pl> <1005581679.459.4.camel@zeus> <3BF0145C.9795C8CC@mvista.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

Jun Sun wrote:
> 
> Pete Popov wrote:
> >
> > On Mon, 2001-11-12 at 05:29, Maciej W. Rozycki wrote:
> > > On Mon, 12 Nov 2001, Geert Uytterhoeven wrote:
> > >
> > > > >  Unless you use a non-MC146818 RTC, which you need to write a separate
> > > > > driver for anyway.
> > > >
> > > > Yep, so that's why both m68k and PPC have common routines to read/write the
> > > > RTC, with a /dev/rtc-compatible abstraction on top of it.
> > >
> > >  OK, then you need an RTC chipset-specific driver and not a CPU
> > > architecture-specific one.  Otherwise we'll end with a zillion of similar
> > > RTC drivers like we already have for LANCE and SCC chips.
> >
> > I agree.  We don't have arch specific network drivers so why have arch
> > specific rtc drivers.
> >
> 
> Because we can have a free RTC driver working once you get kernel working.
> 

Actually there is a longer answer with a little bit of the background info.

Kernel needs to know about the real calendar time when it boots up.  And
optionally it may write to RTC (based on the assumption that kernel timer is
more accurate than RTC clock).  So it already has abstraction, one form or
another, to do RTC read/write.

Based on these abstractons you can provide a hardware-independent RTC driver,
with RTC read/write operations.

Before CONFIG_NEW_TIME_C is introduced, each MIPS board has its own time
service routine, which means, even if RTC driver wants to utilize the
abstraction, it will be only for that board only.

After CONFIG_NEW_TIME_C is introduced, that RTC abstract becomes MIPS-common. 
Therefore, we can afford a MIPS-common generic RTC driver.

If that abstraction ever becomes Linux-common code, then the generic RTC
driver will essentially be a Linux-common, device-indpendent driver.

For most MIPS machine, we need /dev/rtc to merely set time and read time.  The
generic driver should suffice.  Otherwire, you can wirte a complete one for a
specific board or a specific chip.

Jun
