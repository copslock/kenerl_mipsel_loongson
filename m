Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 12 Jun 2003 18:11:59 +0100 (BST)
Received: from gateway-1237.mvista.com ([IPv6:::ffff:12.44.186.158]:34545 "EHLO
	av.mvista.com") by linux-mips.org with ESMTP id <S8225275AbTFLRL5>;
	Thu, 12 Jun 2003 18:11:57 +0100
Received: from zeus.mvista.com (av [127.0.0.1])
	by av.mvista.com (8.9.3/8.9.3) with ESMTP id KAA07950;
	Thu, 12 Jun 2003 10:11:51 -0700
Subject: Re: FW: Db1500 PCI Auto Scan Question, bus master operation
From: Pete Popov <ppopov@mvista.com>
To: fpga dsp <fpga_dsp@yahoo.com.au>
Cc: Tom Cernius <tcernius@correlant.com>,
	Linux MIPS mailing list <linux-mips@linux-mips.org>
In-Reply-To: <20030612021517.42227.qmail@web41202.mail.yahoo.com>
References: <20030612021517.42227.qmail@web41202.mail.yahoo.com>
Content-Type: text/plain
Organization: MontaVista Software
Message-Id: <1055437921.9969.729.camel@zeus.mvista.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4 
Date: 12 Jun 2003 10:12:01 -0700
Content-Transfer-Encoding: 7bit
Return-Path: <ppopov@mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 2614
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ppopov@mvista.com
Precedence: bulk
X-list: linux-mips

On Wed, 2003-06-11 at 19:15, fpga dsp wrote:
> Hi,
> 
> I am using kernel 2.4.20-pre6 version on db1500 and
> having problem with PCI card as bus master. Basicly,
> the kernel can recognize the card and assign into
> 0x40000000 address region, irq is 1. Now that is
> really strange, stty1 using irq 1 as well. Are they
> the same or different. 

There's no UART1 on the Au1500 so you don't have to worry about that
interrupt, even though it's defined in the .h file for the Au1000.


> However ,the problem is that
> after setup the device and trigger it, it should go
> and fetch the descriptor and will fetch the content
> pointed by that descriptor afterward but it only fetch
> the descriptor and quiet. I am even try to trigger it
> again by write into it register mapped on PCI memory
> region but after the first trigger, the second trigger
> doesn't appear on pci bus analyzer at all. 

> Another issues, it when I look at au1000_eth.c device
> driver , dma_alloc() function allocate a DMAable
> buffer in KSEG0 region but pci_alloc_consistent return
> in KSEG1 region. So which one is right?

Right for what? KSEG0 works because the cache is coherent. But due to a
pci coherency bug, I think for a new device driver that's a pci bus
master you need to use kseg1 for now.

Pete
