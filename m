Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.3/8.11.3) id f4B0J6520236
	for linux-mips-outgoing; Thu, 10 May 2001 17:19:06 -0700
Received: from web11901.mail.yahoo.com (web11901.mail.yahoo.com [216.136.172.185])
	by oss.sgi.com (8.11.3/8.11.3) with SMTP id f4B0J5F20233
	for <linux-mips@oss.sgi.com>; Thu, 10 May 2001 17:19:05 -0700
Message-ID: <20010511001905.41656.qmail@web11901.mail.yahoo.com>
Received: from [209.243.184.191] by web11901.mail.yahoo.com; Thu, 10 May 2001 17:19:05 PDT
Date: Thu, 10 May 2001 17:19:05 -0700 (PDT)
From: Wayne Gowcher <wgowcher@yahoo.com>
Subject: Re: Configuration of PCI Video card on a BIOS-less board
To: Jun Sun <jsun@mvista.com>, Keith M Wesolowski <wesolows@foobazco.org>
Cc: Pete Popov <ppopov@mvista.com>, Wayne Gowcher <wgowcher@yahoo.com>,
   Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>, linux-mips@oss.sgi.com
In-Reply-To: <3AFB0FF6.D84A491E@mvista.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

Guys,

Sorry for all the confusion, and subsequent traffic as
a result of my mistakes.

I'm still feeling my way with regards to programming
the PCI and have mixed up terms and addresses.

Just for the record :

In actual fact the PCI code is writing physical
addresses to the Base Address Register, eg 0x02000000.
Then later on when the driver is initialising itself
it reads the BAR and adds on KSEG1 :

dev->base_addr = KSEG1ADDR(base_addr);

It is this "dev->base_addr" that gets reported to me
on boot up ( 0xA2000000 ) as being the base address of
the device. The 0xC000 0000 I wrote in my first mail
was from another problem I had been working and was
somehow burned into my brain.

There is nothing like someone questioning one's
assumptions to make one re-evaluate those assumptions.
For this I am grateful to those people, for spotting
the gaping whole of my mistake and bringing it to my
attention. For me at least it has been very useful in
that respect.

I still would like to understand PCI issues more
particularly with respect to so called "legacy PCi
devices" VGA, sound card etc. So if anyone would like
to mail me off the list with tips / reading they have
found useful, it would be most appreciated.

Wayne

__________________________________________________
Do You Yahoo!?
Yahoo! Auctions - buy the things you want at great prices
http://auctions.yahoo.com/
