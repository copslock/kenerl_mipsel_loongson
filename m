Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.3/8.11.3) id f4HIIbA19961
	for linux-mips-outgoing; Thu, 17 May 2001 11:18:37 -0700
Received: from mail.sonytel.be ([193.74.243.200])
	by oss.sgi.com (8.11.3/8.11.3) with ESMTP id f4HIIZF19958
	for <linux-mips@oss.sgi.com>; Thu, 17 May 2001 11:18:36 -0700
Received: from ginger.sonytel.be (ginger.sonytel.be [10.34.16.6])
	by mail.sonytel.be (8.9.0/8.8.6) with ESMTP id UAA27225
	for <linux-mips@oss.sgi.com>; Thu, 17 May 2001 20:18:32 +0200 (MET DST)
Received: (from tea@localhost)
	by ginger.sonytel.be (8.9.0/8.8.6) id UAA08020
	for linux-mips@oss.sgi.com; Thu, 17 May 2001 20:18:32 +0200 (MET DST)
Date: Thu, 17 May 2001 20:18:32 +0200
From: Tom Appermont <tea@sonycom.com>
To: linux-mips@oss.sgi.com
Subject: interrupt problem
Message-ID: <20010517201832.B2352@sonycom.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0i
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk


Howdy,

I named the subject "interrupt problem", although I am not
completely sure it is really a problem with interrupts I'm 
having. Anyway, the symptoms are the following:

- a ddb 5074 board with 3com boomerang ethernet pci card, boots   
  with initial ramdisk (ok)
- serial interrupts work (ok)
- ethernet card interrupts work when doing a "simple" ping
- flooding the card with network packets (ping -f) causes the 
  ddb board to hang/freeze/stall after an unpredictible amount of
  time, without producing any output on the serial console.
- the problem does not seem to exist when I use a realtek ethernet
  card (ne2k driver) in stead of the 3com card.

I've tried to remedy this by:
- replacing the low level interrupt handling code for ddb5074
  with the new irq.c and time.c in arch/mips/kernel (needs 
  CONFIG_NEW_TIME_C and CONFIG_NEW_IRQ). 
- replacing the timer interrupts with CPU timer interrupts. 
- getting the newest 3c59x driver (although I don't have any
  probs with this driver on pc).
- banging my head on the table.

No luck so far. I am a bit out of ideas on how to track down the 
cause of this problem, so it would be really helpful if somebody 
could either indicate a hint of a possible solution, or suggest
ways to debug this situation.

Greetz,

Tom
