Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 02 May 2003 02:47:18 +0100 (BST)
Received: from il-la.la.idealab.com ([IPv6:::ffff:63.251.211.5]:7622 "HELO
	idealab.com") by linux-mips.org with SMTP id <S8225196AbTEBBrP>;
	Fri, 2 May 2003 02:47:15 +0100
Received: (qmail 20312 invoked by uid 6180); 2 May 2003 01:47:11 -0000
Date: Thu, 1 May 2003 18:47:11 -0700
From: Jeff Baitis <baitisj@evolution.com>
To: linux-mips@linux-mips.org
Subject: Yenta: probing ISA IRQs on a non-ISA machine and sometimes locking up!  ;)
Message-ID: <20030501184711.D30468@luca.pas.lab>
Reply-To: baitisj@evolution.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Return-Path: <baitisj@idealab.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-Spam-Checker-Version: SpamAssassin 2.50 (1.173-2003-02-20-exp)
X-archive-position: 2248
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: baitisj@evolution.com
Precedence: bulk
X-list: linux-mips

Delving further into the PCI->CardBus bridge, I noticed that my system locks up
under certain conditions when the yenta_socket driver is trying to probe
for PCMCIA ISA interrupts.

yenta_get_socket_capabilities() calls probe_irq_on() in arch/mips/kernel/irq.c.
The lock up happens when the probe performs the first iteration over the IRQ
descriptors, looking for longstanding IRQs. I added some debugging output, and
it get down to IRQ 34, and then stopped. (AU1000 GPIO pin 2? this pin isn't
connected on our board... )

Anyhow, when the probe *does* succeed, the IRQ poll returns 0x0000. I guess my
question is, why even bother with this polling on a machine without an ISA bus?
I believe that the CardBus bridge PCI configuration registers route socket
events to the PCI INTA pin anyway...

My happy hack is to have yenta_get_socket_capabilities always return 0x0. But
I'm still concerned that probe_irq_on() intermittently fails...

Thanks for letting me interrupt you with this question.

Regards,
Jeff

-- 
         Jeffrey Baitis - Associate Software Engineer

                    Evolution Robotics, Inc.
                     130 West Union Street
                       Pasadena CA 91103

 tel: 626.535.2776  |  fax: 626.535.2777  |  baitisj@evolution.com 
