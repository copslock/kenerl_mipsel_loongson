Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id fADEAsY13558
	for linux-mips-outgoing; Tue, 13 Nov 2001 06:10:54 -0800
Received: from faui02.informatik.uni-erlangen.de (root@faui02.informatik.uni-erlangen.de [131.188.30.102])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id fADEAo013554
	for <linux-mips@oss.sgi.com>; Tue, 13 Nov 2001 06:10:51 -0800
Received: from rz.de (root@faui02b.informatik.uni-erlangen.de [131.188.30.151])
	by faui02.informatik.uni-erlangen.de (8.9.1/8.1.16-FAU) with ESMTP id PAA07216; Tue, 13 Nov 2001 15:10:32 +0100 (MET)
Received: (from rz@localhost)
	by rz.de (8.8.8/8.8.8) id OAA00775;
	Tue, 13 Nov 2001 14:42:40 +0100
Date: Tue, 13 Nov 2001 14:42:40 +0100
From: Richard Zidlicky <rz@linux-m68k.org>
To: Roman Zippel <zippel@linux-m68k.org>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, Jun Sun <jsun@mvista.com>,
   "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>,
   Linux/MIPS Development <linux-mips@oss.sgi.com>,
   Linux/m68k <linux-m68k@lists.linux-m68k.org>,
   Linux/PPC Development <linuxppc-dev@lists.linuxppc.org>
Subject: Re: [RFC] generic MIPS RTC driver
Message-ID: <20011113144240.B669@linux-m68k.org>
References: <Pine.GSO.4.21.0111122055010.10720-100000@mullein.sonytel.be> <3BF0371F.8040575B@linux-m68k.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3BF0371F.8040575B@linux-m68k.org>; from zippel@linux-m68k.org on Mon, Nov 12, 2001 at 09:54:55PM +0100
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Mon, Nov 12, 2001 at 09:54:55PM +0100, Roman Zippel wrote:
> Hi,
> 
> Geert Uytterhoeven wrote:
> 
> > > Geert, what is the abstraction they used?
> > 
> > At first sight, we only use get_rtc_time() and mach_hwclk().
> 
> Over the weekend I changed it into set_rtc_time()/get_rtc_time(), which
> are now defined in <asm/rtc.h>, so mach_hwclk() is gone in the generic
> part.
> Another feature is the emulation of the timer interrupt, although I have
> no idea which program is using this.

hwclock and a bunch of less known porgrams like chrony. 
Where the interrupt can be generated its a clear win, otherwise
it might be more reasonable to return EINVAL instead of trying
to emulate it - presumably hwclock can use some fallback method.

Btw the interrupt need not to be hardware, for the Q40 I test 
a rtc register once per jiffie and generate a "soft interrupt".
It could be done generic at least for m68k.

Bye
Richard
