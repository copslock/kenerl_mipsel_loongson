Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id fACDUxc20036
	for linux-mips-outgoing; Mon, 12 Nov 2001 05:30:59 -0800
Received: from delta.ds2.pg.gda.pl (delta.ds2.pg.gda.pl [213.192.72.1])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id fACDUr020033
	for <linux-mips@oss.sgi.com>; Mon, 12 Nov 2001 05:30:54 -0800
Received: from localhost by delta.ds2.pg.gda.pl (8.9.3/8.9.3) with SMTP id OAA00860;
	Mon, 12 Nov 2001 14:29:15 +0100 (MET)
Date: Mon, 12 Nov 2001 14:29:14 +0100 (MET)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Geert Uytterhoeven <geert@linux-m68k.org>
cc: Jun Sun <jsun@mvista.com>, Linux/MIPS Development <linux-mips@oss.sgi.com>,
   Linux/m68k <linux-m68k@lists.linux-m68k.org>,
   Linux/PPC Development <linuxppc-dev@lists.linuxppc.org>
Subject: Re: [RFC] generic MIPS RTC driver
In-Reply-To: <Pine.GSO.4.21.0111121410230.11251-100000@mullein.sonytel.be>
Message-ID: <Pine.GSO.3.96.1011112142501.24771K-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Mon, 12 Nov 2001, Geert Uytterhoeven wrote:

> >  Unless you use a non-MC146818 RTC, which you need to write a separate
> > driver for anyway.
> 
> Yep, so that's why both m68k and PPC have common routines to read/write the
> RTC, with a /dev/rtc-compatible abstraction on top of it.

 OK, then you need an RTC chipset-specific driver and not a CPU
architecture-specific one.  Otherwise we'll end with a zillion of similar
RTC drivers like we already have for LANCE and SCC chips. 

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +
