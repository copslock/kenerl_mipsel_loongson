Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 20 Mar 2003 01:25:48 +0000 (GMT)
Received: from mta10-0.mail.adelphia.net ([IPv6:::ffff:64.8.50.202]:24253 "EHLO
	mta10.adelphia.net") by linux-mips.org with ESMTP
	id <S8225221AbTCTBZr>; Thu, 20 Mar 2003 01:25:47 +0000
Received: from there ([24.51.54.5]) by mta3.adelphia.net
          (InterMail vM.5.01.05.27 201-253-122-126-127-20021220) with SMTP
          id <20030319222337.LNDN8997.mta3.adelphia.net@there>
          for <linux-mips@linux-mips.org>; Wed, 19 Mar 2003 17:23:37 -0500
Content-Type: text/plain;
  charset="iso-8859-1"
From: Neurophyre <listbox@evernex.com>
To: linux-mips@linux-mips.org
Subject: Re: 2.4.20 SCSI problems on NASRaQ
Date: Wed, 19 Mar 2003 17:23:29 -0500
X-Mailer: KMail [version 1.3.2]
References: <20030318172414.MLZJ7686.mta6.adelphia.net@there>
In-Reply-To: <20030318172414.MLZJ7686.mta6.adelphia.net@there>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-Id: <20030319222337.LNDN8997.mta3.adelphia.net@there>
Return-Path: <listbox@evernex.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 1778
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: listbox@evernex.com
Precedence: bulk
X-list: linux-mips

A little update on the problems with none of the 3 drivers initializing 
the 53c860 SCSI controller on the Seagate (Cobalt) NASRaQ:

I've built the 2.5.47 CVS snapshot kernel from linux-mips.org, but even 
with just about everything modularized, the kernel is just over 100K 
too big for the NASRaQ's boot loader.  So, it would seem without 
getting very creative that 2.4.x is the end of the road for this 
hardware.. this means I can't test to see if any of the drivers now 
work in the linux-mips source tree.

I also thought it might be good to include /proc/pci, since someone 
off-list mentioned to me that perhaps some other device is reserving 
the controller's address space (?)..  again, here's what the message 
from all three drivers looks like (using the newest one as an example):

sym.0.8.0: IO region 0x10102000[0..127] is in use

here is /proc/pci.  The SCSI controller is device 8.

PCI devices found:
  Bus  0, device   0, function  0:
    Class 0580: PCI device 11ab:4146 (rev 17).
      Master Capable.  Latency=64.
      Non-prefetchable 32 bit memory at 0x0 [0x3ffffff].
      Non-prefetchable 32 bit memory at 0x4000000 [0x4000fff].
      Non-prefetchable 32 bit memory at 0x1c000000 [0x1dffffff].
      Non-prefetchable 32 bit memory at 0x1f000000 [0x1fffffff].
      Non-prefetchable 32 bit memory at 0x14000000 [0x14000fff].
      I/O at 0x14000000 [0x14000fff].
  Bus  0, device   7, function  0:
    Class 0200: PCI device 1011:0019 (rev 65).
      IRQ 4.
      Master Capable.  Latency=64.  Min Gnt=20.Max Lat=40.
      I/O at 0x100000 [0x10007f].
      Non-prefetchable 32 bit memory at 0x12000000 [0x120003ff].
  Bus  0, device   8, function  0:
    Class 0100: PCI device 1000:0006 (rev 2).
      IRQ 4.
      Master Capable.  No bursts.  Min Gnt=8.Max Lat=64.
      I/O at 0x10102000 [0x101020ff].
      Non-prefetchable 32 bit memory at 0x2000 [0x20ff].
  Bus  0, device   9, function  0:
    Class 0601: PCI device 1106:0586 (rev 39).
  Bus  0, device   9, function  1:
    Class 0101: PCI device 1106:0571 (rev 6).
      Master Capable.  Latency=64.
      I/O at 0xcc00 [0xcc0f].
  Bus  0, device   9, function  2:
    Class 0c03: PCI device 1106:3038 (rev 2).
      Master Capable.  Latency=22.
      I/O at 0x300 [0x31f].


If anybody has any suggestions of what I might be able to do to get the 
SCSI controller working, I'd love to hear it.  Also if there are any 
other things you would like to see besides what I've shown.  I'm not a 
kernel hacker.  :-(

As it stands now, anybody with a MIPS-based NASRaQ is out in the cold 
when it comes to upgrading their system.

Finally, since the SCSI controller obviously worked with Cobalt's 
(patched) 2.0 kernel, maybe an older kernel might work?  Does anybody 
have any snapshots of the 2.2.x source tree with MIPS patches applied?  
Or access to Cobalt's old patches even?
