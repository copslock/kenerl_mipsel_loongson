Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 17 Mar 2008 10:07:06 +0000 (GMT)
Received: from host194-211-dynamic.20-79-r.retail.telecomitalia.it ([79.20.211.194]:41170
	"EHLO eppesuigoccas.homedns.org") by ftp.linux-mips.org with ESMTP
	id S28590715AbYCQKHE (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 17 Mar 2008 10:07:04 +0000
Received: from router-wag54gp2 ([192.168.1.33] helo=[192.168.2.7])
	by eppesuigoccas.homedns.org with esmtpsa (TLS-1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.63)
	(envelope-from <giuseppe@eppesuigoccas.homedns.org>)
	id 1JbCF5-00053M-NR
	for linux-mips@linux-mips.org; Mon, 17 Mar 2008 11:06:57 +0100
Subject: Re: unexpected irq 71 on ip32
From:	Giuseppe Sacco <giuseppe@eppesuigoccas.homedns.org>
To:	linux-mips@linux-mips.org
In-Reply-To: <20080317100109.GA10140@alpha.franken.de>
References: <1205746904.3515.37.camel@localhost>
	 <20080317100109.GA10140@alpha.franken.de>
Content-Type: text/plain
Date:	Mon, 17 Mar 2008 11:07:20 +0100
Message-Id: <1205748440.3515.56.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.12.3 
Content-Transfer-Encoding: 7bit
Return-Path: <giuseppe@eppesuigoccas.homedns.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 18412
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: giuseppe@eppesuigoccas.homedns.org
Precedence: bulk
X-list: linux-mips

Hi Thomas,

Il giorno lun, 17/03/2008 alle 11.01 +0100, Thomas Bogendoerfer ha
scritto:
> On Mon, Mar 17, 2008 at 10:41:44AM +0100, Giuseppe Sacco wrote:
> > from what I understand, this is an irq related to serial line ttyS1. On

my understanding is due to:

$ grep 71 arch/mips/sgi-ip32/*irq*
arch/mips/sgi-ip32/ip32-irq.c: * 26-31 -> 66-71 Serial 2 (28 E)

> not on my O2:
> 
> serial8250.0: ttyS0 at MMIO 0x1f390000 (irq = 60) is a 16550A
> console [ttyS0] enabled
> serial8250.0: ttyS1 at MMIO 0x1f398000 (irq = 66) is a 16550A
> 
> Is there something listed for irq 71 in /proc/interrupts ?

nope:
giuseppe@sgi:~$ cat /proc/interrupts 
           CPU0       
  7:    1949649            MIPS  timer
 11:     106073       IP32 MACE  SGI O2 Fast Ethernet
 15:          0       IP32 MACE  MACE PCI error
 16:     487646   IP32 MACE PCI  aic7xxx
 17:         15   IP32 MACE PCI  aic7xxx
 18:          0   IP32 MACE PCI  ohci_hcd:usb1
 21:          0   IP32 MACE PCI  ohci_hcd:usb2
 22:      62066   IP32 MACE PCI  ehci_hcd:usb3, eth100
 28:          0      IP32 CRIME  CRIME CPU error
 29:          1      IP32 CRIME  CRIME memory error
 48:          0   IP32 MACE ISA  rtc
 49:         10   IP32 MACE ISA  PS2 port
 51:        133   IP32 MACE ISA  PS2 port
 60:        133   IP32 MACE ISA  serial

ERR:          0

Bye,
Giuseppe
