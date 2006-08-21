Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 21 Aug 2006 21:24:02 +0100 (BST)
Received: from [69.90.147.196] ([69.90.147.196]:18581 "EHLO mail.kenati.com")
	by ftp.linux-mips.org with ESMTP id S20037591AbWHUUX7 (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Mon, 21 Aug 2006 21:23:59 +0100
Received: from [192.168.1.169] (adsl-71-130-109-177.dsl.snfc21.pacbell.net [71.130.109.177])
	by mail.kenati.com (Postfix) with ESMTP id DA803E404D
	for <linux-mips@linux-mips.org>; Mon, 21 Aug 2006 13:41:46 -0700 (PDT)
Subject: IRQ mapping in 2.6 for the Ampro M3 board.
From:	Ashlesha Shintre <ashlesha@kenati.com>
Reply-To: ashlesha@kenati.com
To:	linux-mips@linux-mips.org
Content-Type: text/plain
Date:	Mon, 21 Aug 2006 13:30:29 -0700
Message-Id: <1156192229.7258.7.camel@sandbar.kenati.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.2.1 
Content-Transfer-Encoding: 7bit
Return-Path: <ashlesha@kenati.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 12391
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ashlesha@kenati.com
Precedence: bulk
X-list: linux-mips

Hi,

After issuing the make -f Makefile.linux command, to build a 2.6 kernel
image for the Ampro M3 board (AU1500 processor), I get the following
error with respect to the interrupt definitions:


arch/mips/au1000/encm3/irqmap.c:78: error: `AU1000_MAC0_DMA_INT' undeclared here (not in a function)
arch/mips/au1000/encm3/irqmap.c:78: error: initializer element is not constant

This is how I define interrupt mappings in the irqmap.c file:

au1xxx_irq_map_t au1xxx_irq_map[] = {
        { AU1000_UART0_INT, INTC_INT_HIGH_LEVEL, 0},
        { AU1000_PCI_INTA, INTC_INT_LOW_LEVEL, 0 },
        { AU1000_PCI_INTB, INTC_INT_LOW_LEVEL, 0 },          etc......

I looked at how the irq map is defined for the existing board support for the DB1500 board, and it looks the same.  However I do not get the same
error while compiling the 2.6 kernel for the same!

Should the irq_map be defined differently?

Thanks,
Ashlesha.
