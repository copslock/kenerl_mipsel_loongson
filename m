Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 05 May 2005 19:07:16 +0100 (BST)
Received: from clock-tower.bc.nu ([IPv6:::ffff:81.2.110.250]:29589 "EHLO
	lxorguk.ukuu.org.uk") by linux-mips.org with ESMTP
	id <S8225009AbVEESHB>; Thu, 5 May 2005 19:07:01 +0100
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by lxorguk.ukuu.org.uk (8.12.11/8.12.11) with ESMTP id j45I5fGA023909;
	Thu, 5 May 2005 19:05:41 +0100
Received: (from alan@localhost)
	by localhost.localdomain (8.12.11/8.12.11/Submit) id j45I5e9F023908;
	Thu, 5 May 2005 19:05:40 +0100
X-Authentication-Warning: localhost.localdomain: alan set sender to alan@lxorguk.ukuu.org.uk using -f
Subject: Re: ATA devices attached to arbitary busses
From:	Alan Cox <alan@lxorguk.ukuu.org.uk>
To:	Bryan Althouse <bryan.althouse@3phoenix.com>
Cc:	owner-linux-mips@oss.sgi.com, linux-mips@linux-mips.org
In-Reply-To: <20050505175716Z8225009-1340+6570@linux-mips.org>
References: <20050505175716Z8225009-1340+6570@linux-mips.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1115316338.19844.100.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date:	Thu, 05 May 2005 19:05:39 +0100
Return-Path: <alan@lxorguk.ukuu.org.uk>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 7866
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: alan@lxorguk.ukuu.org.uk
Precedence: bulk
X-list: linux-mips

> FPGA.  Right now, I'm a bit clueless as to how to get the linux kernel to
> support this.  Could someone please point me in the right direction?  What
> kernel source files should I be looking at?  Is there any documentation?
> Many thanks!

It really depends on the complexity of your controller. If you are just
doing PIO with generic IDE interfacing then its simply a matter of
telling Linux that there is an interface at these addresses with these
port operations and it'll just do the rest for you, except hotplug.

Basically for the standard port layouts.

	hw_regs_t hw;
	ide_hwif_t *hwif;

	memset(&hw, 0, sizeof(hw));
	ide_std_init_ports(&hw, base_port_num, ctrl_port);
	hw.irq = IRQ_LINE;
	hw.dma = NO_DMA;

	index = ide_register_hw(&hw, &hwif);

If the port layout is non standard and you use mmio etc then you need to
set hw up by hand. drivers/ide/legacy/macide.c is a good example of
interfacing a non standard controller.

Alan
