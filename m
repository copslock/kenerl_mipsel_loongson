Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 20 Aug 2004 13:59:48 +0100 (BST)
Received: from lakecmmtao02.coxmail.com ([IPv6:::ffff:68.99.120.69]:12488 "EHLO
	lakecmmtao02.coxmail.com") by linux-mips.org with ESMTP
	id <S8224911AbUHTM7o>; Fri, 20 Aug 2004 13:59:44 +0100
Received: from mike_desktop.cogcomp.com ([68.15.41.55])
          by lakecmmtao02.coxmail.com
          (InterMail vM.5.01.06.08 201-253-122-130-108-20031117) with ESMTP
          id <20040820125935.ZULV6960.lakecmmtao02.coxmail.com@mike_desktop.cogcomp.com>;
          Fri, 20 Aug 2004 08:59:35 -0400
Message-Id: <6.0.3.0.2.20040820085527.066ee1c0@pop3.cedata.com>
X-Sender: cogent@cogcomp.com@pop3.cedata.com (Unverified)
X-Mailer: QUALCOMM Windows Eudora Version 6.0.3.0
Date: Fri, 20 Aug 2004 08:59:12 -0400
To: "safiudeen Ts" <safiudeen@hotmail.com>
From: Michael Kelly <mike@cogcomp.com>
Subject: Re: PCMCIA genric sreail or modem support for db1100 bord
Cc: michael.stickel@4g-systems.biz, linux-mips@linux-mips.org
In-Reply-To: <BAY15-F253abTd9QkTD0002f560@hotmail.com>
References: <BAY15-F253abTd9QkTD0002f560@hotmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Return-Path: <mike@cogcomp.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 5699
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mike@cogcomp.com
Precedence: bulk
X-list: linux-mips

Safiudeen,

There is a known problem with some 8-bit cards and the Au1xxx family.
The following is from the FAQ for Linux that comes with the DB1100 CD:

============================================================

25) Which PCMCIA cards work with Au1x00/Pb1x00 Linux?

The Au1x00/Pb1x00 Linux PCMCIA cardmgr has been tested and known to
work with the following PC Cards.  The Linux PCMCIA driver module is
listed to the left:

   ide_cs.o Ritek Corporation, ATA DISK drive (3.3V Compact Flash Adapter)
   ide_cs.o Butterfly Group 64M ATA disk drive (3.3V)
   ide_cs.o SanDisk 192MB FlashDisk ATA (3.3/5V)
   ide_cs.o SanDisk 10MB FlashDisk ATA (5V)
   ide_cs.o Hitach 64MB flash card (3.3/5V)
   ide_cs.o IO Data 256MB flash card (3.3/5V)
   ide_cs.o Toshiba 2GB hard drive (actual tiny drive, like the IBM 
MicroDrive) (3.3V/5V)
   ide_cs.o IBM Microdrive
   3c589.o  3COM 589 Ethernet card (5V)
   pcnet_cs.o Linksys Network Everywhere NP10T
   pcnet_cs.o Corega Ether PCC-TD
   pcnet_cs.o Corega FEther PCC-TXD
   pcnet_cs.o Laneed LD-CDL/T
   axnet_cs.o Buffalo Tough Connect LPC3-CLX

NOTE: The Au1000 and Au1500 require an 8-bit PCMCIA HBA work around
be implemented on the board in order for 8-bit cards (i.e. pcnet_cs.o)
to work properly. See app note "Au1000 8-bit PCMCIA HBA".

============================================================\

IIRC most serial cards are 8-bit.

Hope this helps,

Michael

At 04:51 AM 8/20/2004, safiudeen Ts wrote:
>built in serial ports are working fine in DB1100 with linux-2.4.20 kernel
>When we use a pcmcia serial card or modem, for most of the card, 
>cardmaneger load serial_cs.o (actualy it uses the serial.o  fetures for 
>registering the module).
>This method work fine in my laptop.
>same think hepens in db1100 bord also. I gues serial.o in bord db110 
>does'nt support well for serial_cs
>.
>If there is a stand alon serial_cs.o module for this board It may work 
>without any problem.
>if it is os where  can I get the seria_cs or any generic serial pcmcia 
>driver for db1100 bord, or  otherwise is any serial.c available for db1100 
>that can support pcmcia and inbuild serial as it works in labtop.
>
>There is important think, when we connected in the laptop this pcmcia 
>serial card detect is detected as 65550A but in the board it detected as 
>65550. I checked the serial.c code of db1100 there is no entry for this 65550A.
>
>if any one worked with this DB1100 please help me to solve this problem
>
>
>thanx
>safiudeen
>
>&gt;From: Michael Stickel &lt;michael.stickel@4g-systems.biz&gt;
>&gt;To: &quot;safiudeen Ts&quot; &lt;safiudeen@hotmail.com&gt;
>&gt;Subject: Re: PCMCIA genric sreail or modem support for db1100 bord
>&gt;Date: Fri, 20 Aug 2004 10:07:40 +0200
>&gt;
>&gt;
>&gt;Do you use the buildin serial ports?
>&gt;
>&gt;My last information is that the au1x00-serial module does not work
>&gt;in parallel with the serial module because au1x00-serial.c is just a
>&gt;modified copy of serial.c.
>&gt;
>&gt;Michael
>&gt;
>
>_________________________________________________________________
>Add photos to your messages with MSN 8. Get 2 months FREE*. 
>http://join.msn.com/?page=features/featuredemail
>

Michael J. Kelly
VP Engineering/Marketing
Cogent Computer Systems, Inc.
1130 Ten Rod Road
Suite A-201
North Kingstown, RI 02852
tel:401-295-6505 fax:401-295-6507
www.cogcomp.com
alternate email: mkelly6505@hotmail.com
