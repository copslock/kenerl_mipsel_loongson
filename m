Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id g1L2aHd04887
	for linux-mips-outgoing; Wed, 20 Feb 2002 18:36:17 -0800
Received: from host099.momenco.com (IDENT:root@www.momenco.com [64.169.228.99])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id g1L2a9904884
	for <linux-mips@oss.sgi.com>; Wed, 20 Feb 2002 18:36:09 -0800
Received: from beagle (beagle.internal.momenco.com [192.168.0.115])
	by host099.momenco.com (8.11.6/8.11.6) with SMTP id g1L1a5R26771
	for <linux-mips@oss.sgi.com>; Wed, 20 Feb 2002 17:36:05 -0800
From: "Matthew Dharm" <mdharm@momenco.com>
To: "Linux-MIPS" <linux-mips@oss.sgi.com>
Subject: set_io_port_base()?
Date: Wed, 20 Feb 2002 17:36:05 -0800
Message-ID: <NEBBLJGMNKKEEMNLHGAIOEKBCFAA.mdharm@momenco.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2910.0)
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4133.2400
Importance: Normal
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

So, what's the proper usage for set_io_port_base()?

I'm trying to bring up Linux on our newest board (the Ocelot-G -- see
www.momenco.com for more information).  I think I'm pretty far along,
but I can't get a plug-in PCI ethernet device to work.  What I get is:

eepro100.c:v1.09j-t 9/29/99 Donald Becker
http://cesdis.gsfc.nasa.gov/linux/drivers/eepro100.html
eepro100.c: $Revision: 1.36 $ 2000/11/17 Modified by Andrey V.
Savochkin <saw@saw.sw.com.sg> and others
PCI setting cache line size to 8 from 0
eth0: Invalid EEPROM checksum 0x0000, check settings before activating
this device!
eth0: Intel Corp. 82559ER, 00:00:00:00:00:00, IRQ 9.
  Receiver lock-up bug exists -- enabling work-around.
  Board assembly 000000-000, Physical connectors present:
  Primary interface chip None PHY #0.
  General self-test: passed.
  Serial sub-system self-test: passed.
  Internal registers self-test: passed.
  ROM checksum self-test: passed (0x1d68d8db).
  Receiver lock-up workaround activated.

Now, I'm pretty sure this has something to do with the initcall to
set_io_port_base() and ioremap(), which are in my setup.c (copied from
linux/arch/mips/gt64120/momenco_ocelot/setup.c and modified).  Without
that bit of code at the bottom of that function, I don't even get
this -- it just crashes.  So I know I need this code, but I'm just not
certain what/how I should be using it...

My initial guess is that it's used to map some virtual address space
onto the physical addresses needed to actually generate PCI I/O
transactions, but that's just a guess.  If that's right, then the code
I'm using _should_ work... I call ioremap() with the physical base and
size, and then set_io_port_base() using the result of ioremap().

Anyone have any thoughts?

Matt

--
Matthew D. Dharm                            Senior Software Designer
Momentum Computer Inc.                      1815 Aston Ave.  Suite 107
(760) 431-8663 X-115                        Carlsbad, CA 92008-7310
Momentum Works For You                      www.momenco.com
