Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id fACIU9U02261
	for linux-mips-outgoing; Mon, 12 Nov 2001 10:30:09 -0800
Received: from sgi.com (sgi.SGI.COM [192.48.153.1])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id fACIU5002258
	for <linux-mips@oss.sgi.com>; Mon, 12 Nov 2001 10:30:05 -0800
Received: from hermes.mvista.com (gateway-1237.mvista.com [12.44.186.158]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id KAA09529
	for <linux-mips@oss.sgi.com>; Mon, 12 Nov 2001 10:30:05 -0800 (PST)
	mail_from (jsun@mvista.com)
Received: from mvista.com (IDENT:jsun@orion.mvista.com [10.0.0.75])
	by hermes.mvista.com (8.11.0/8.11.0) with ESMTP id fACIPvB11448;
	Mon, 12 Nov 2001 10:25:57 -0800
Message-ID: <3BF013E3.52F45AE9@mvista.com>
Date: Mon, 12 Nov 2001 10:24:35 -0800
From: Jun Sun <jsun@mvista.com>
X-Mailer: Mozilla 4.72 [en] (X11; U; Linux 2.2.18 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
CC: Geert Uytterhoeven <geert@linux-m68k.org>,
   Linux/MIPS Development <linux-mips@oss.sgi.com>,
   Linux/m68k <linux-m68k@lists.linux-m68k.org>,
   Linux/PPC Development <linuxppc-dev@lists.linuxppc.org>
Subject: Re: [RFC] generic MIPS RTC driver
References: <Pine.GSO.3.96.1011112142501.24771K-100000@delta.ds2.pg.gda.pl>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

"Maciej W. Rozycki" wrote:
> 
> On Mon, 12 Nov 2001, Geert Uytterhoeven wrote:
> 
> > >  Unless you use a non-MC146818 RTC, which you need to write a separate
> > > driver for anyway.
> >
> > Yep, so that's why both m68k and PPC have common routines to read/write the
> > RTC, with a /dev/rtc-compatible abstraction on top of it.
> 
>  OK, then you need an RTC chipset-specific driver and not a CPU
> architecture-specific one. 

You *can* write a chip specific driver in addition to this generic one if you
want.  Presumably the chip-specific one provides more operations than just
read/write date.

> Otherwise we'll end with a zillion of similar
> RTC drivers like we already have for LANCE and SCC chips.
>

Don't quite understand this statement.

If everybody uses the generic rtc driver, there will be only one copy of it. 
It will prevent zillions copies of similar thing.

Note that hardware specifics are already abstracted by rtc_set_time() and
rtc_get_time() routines.  The generic RTC driver makes use of them and has no
RTC chip or machine dependent code.

Jun
