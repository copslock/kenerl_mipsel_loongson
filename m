Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.3/8.11.3) id f4A5tDI21988
	for linux-mips-outgoing; Wed, 9 May 2001 22:55:13 -0700
Received: from web11902.mail.yahoo.com (web11902.mail.yahoo.com [216.136.172.186])
	by oss.sgi.com (8.11.3/8.11.3) with SMTP id f4A5tCF21985
	for <linux-mips@oss.sgi.com>; Wed, 9 May 2001 22:55:12 -0700
Message-ID: <20010510055512.96321.qmail@web11902.mail.yahoo.com>
Received: from [209.243.184.191] by web11902.mail.yahoo.com; Wed, 09 May 2001 22:55:12 PDT
Date: Wed, 9 May 2001 22:55:12 -0700 (PDT)
From: Wayne Gowcher <wgowcher@yahoo.com>
Subject: Configuration of PCI Video card on a BIOS-less board
To: linux-mips@oss.sgi.com
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

Dear All,

I was wondering if anyone has any experience in
configuring the PCI registers in a PCI Video Card on a
MIPS board that has no BIOS like in a PC.

At the moment when I have some "home grown" PCI
probing routines based on my best interpretation of
the PCI spec. But it's not working.

I can probe the Base Address Register successfully,
determine the cards memory requirement and that it is
memory rather than mapped IO. But when I try to write
the address I have allocated to the PCI card ( eg
0xC000 0000 ) the address will not latch in the base
address register.

The card is designed for x86 PCs and when the PC bios
configures the card, the base address register has the
value 0xF200 0000.

Any comments from anybody with any insight into what
is happening here / or how I might fix my probelm,
would be greatly appreciated.

Does anyone know of any code that carries out PCI
probing similar to that found on x86 PC's ?

TIA 

Wayne

__________________________________________________
Do You Yahoo!?
Yahoo! Auctions - buy the things you want at great prices
http://auctions.yahoo.com/
