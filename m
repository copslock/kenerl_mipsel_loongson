Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id fACKtT707085
	for linux-mips-outgoing; Mon, 12 Nov 2001 12:55:29 -0800
Received: from smtpzilla2.xs4all.nl (smtpzilla2.xs4all.nl [194.109.127.138])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id fACKtR007082
	for <linux-mips@oss.sgi.com>; Mon, 12 Nov 2001 12:55:27 -0800
Received: from scrub.xs4all.nl (scrub.xs4all.nl [194.109.195.176])
	by smtpzilla2.xs4all.nl (8.12.0/8.12.0) with ESMTP id fACKsuWK005696;
	Mon, 12 Nov 2001 21:54:56 +0100 (CET)
Received: from spit.local ([192.168.3.2] ident=mail)
	by scrub.xs4all.nl with esmtp (Exim 3.12 #1 (Debian))
	id 163O6Z-0008JY-00; Mon, 12 Nov 2001 21:54:55 +0100
Received: from localhost
	([127.0.0.1] helo=linux-m68k.org ident=roman)
	by spit.local with esmtp (Exim 3.32 #1 (Debian))
	id 163O6Z-0000J0-00; Mon, 12 Nov 2001 21:54:55 +0100
Message-ID: <3BF0371F.8040575B@linux-m68k.org>
Date: Mon, 12 Nov 2001 21:54:55 +0100
From: Roman Zippel <zippel@linux-m68k.org>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.14 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Geert Uytterhoeven <geert@linux-m68k.org>
CC: Jun Sun <jsun@mvista.com>, "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>,
   Linux/MIPS Development <linux-mips@oss.sgi.com>,
   Linux/m68k <linux-m68k@lists.linux-m68k.org>,
   Linux/PPC Development <linuxppc-dev@lists.linuxppc.org>, rz@linux-m68k.org
Subject: Re: [RFC] generic MIPS RTC driver
References: <Pine.GSO.4.21.0111122055010.10720-100000@mullein.sonytel.be>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

Hi,

Geert Uytterhoeven wrote:

> > Geert, what is the abstraction they used?
> 
> At first sight, we only use get_rtc_time() and mach_hwclk().

Over the weekend I changed it into set_rtc_time()/get_rtc_time(), which
are now defined in <asm/rtc.h>, so mach_hwclk() is gone in the generic
part.
Another feature is the emulation of the timer interrupt, although I have
no idea which program is using this. Richard?

bye, Roman
