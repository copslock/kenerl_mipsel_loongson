Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id fADI0Kk14525
	for linux-mips-outgoing; Tue, 13 Nov 2001 10:00:20 -0800
Received: from hermes.mvista.com (gateway-1237.mvista.com [12.44.186.158])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id fADI0H014521
	for <linux-mips@oss.sgi.com>; Tue, 13 Nov 2001 10:00:17 -0800
Received: from mvista.com (IDENT:jsun@orion.mvista.com [10.0.0.75])
	by hermes.mvista.com (8.11.0/8.11.0) with ESMTP id fADI05B08683;
	Tue, 13 Nov 2001 10:00:05 -0800
Message-ID: <3BF15F55.AABB383C@mvista.com>
Date: Tue, 13 Nov 2001 09:58:45 -0800
From: Jun Sun <jsun@mvista.com>
X-Mailer: Mozilla 4.72 [en] (X11; U; Linux 2.2.18 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Richard Zidlicky <rz@linux-m68k.org>
CC: Roman Zippel <zippel@linux-m68k.org>,
   Geert Uytterhoeven <geert@linux-m68k.org>,
   "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>,
   Linux/MIPS Development <linux-mips@oss.sgi.com>,
   Linux/m68k <linux-m68k@lists.linux-m68k.org>,
   Linux/PPC Development <linuxppc-dev@lists.linuxppc.org>
Subject: Re: [RFC] generic MIPS RTC driver
References: <Pine.GSO.4.21.0111122055010.10720-100000@mullein.sonytel.be> <3BF0371F.8040575B@linux-m68k.org> <20011113144240.B669@linux-m68k.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

Richard Zidlicky wrote:

> Btw the interrupt need not to be hardware, for the Q40 I test
> a rtc register once per jiffie and generate a "soft interrupt".
> It could be done generic at least for m68k.
> 

I have written an experiemntal ptimer driver to do just this and potential
more.  Such a device is useful for real-time programming (e.g., when you try
to implement a periodic user task).

See http://linux.junsun.net/realtime-linux/preemption-test

The driver is architecture independent (i.e., linux-common code)

Due to the different programming needs behind periodic timers (or user-level
timer) and RTC operations, my vote for future work is to leave them as two
separate drivers.  To me, RTC is really just to read/write RTC clock.

Jun
