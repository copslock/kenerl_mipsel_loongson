Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 11 Aug 2006 00:21:22 +0100 (BST)
Received: from [69.90.147.196] ([69.90.147.196]:16038 "EHLO mail.kenati.com")
	by ftp.linux-mips.org with ESMTP id S20044394AbWHJXVU (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Fri, 11 Aug 2006 00:21:20 +0100
Received: from [192.168.1.169] (adsl-71-130-109-177.dsl.snfc21.pacbell.net [71.130.109.177])
	by mail.kenati.com (Postfix) with ESMTP id 54DB7E404D
	for <linux-mips@linux-mips.org>; Thu, 10 Aug 2006 16:37:50 -0700 (PDT)
Subject: IDE routines for the ENCM3 in 2.6
From:	Ashlesha Shintre <ashlesha@kenati.com>
Reply-To: ashlesha@kenati.com
To:	linux-mips@linux-mips.org
Content-Type: text/plain
Date:	Thu, 10 Aug 2006 16:27:20 -0700
Message-Id: <1155252440.7684.20.camel@sandbar.kenati.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.2.1 
Content-Transfer-Encoding: 7bit
Return-Path: <ashlesha@kenati.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 12275
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ashlesha@kenati.com
Precedence: bulk
X-list: linux-mips

Hi,

I m trying to modify the 2.4 kernel board support files for the Encore
M3 board with the AU 1500 MIPS processor, so that they will compile for
the 2.6 kernel.  

Now, the Encore M3 has a compact flash IDE device on the VIA
Southbridge, which in turn is on a PCI bus.  

In the ide.c file in the /mips/au1000/encm3/ directory, there are the
following IDE routines:

1) encm3_ide_probe
2) encm3_ide_default_irq
3) encm3_ide_ops 
etc.

Basically, all of these routines check if a base register has been
assigned to the IDE device and if not, 
i) call the encm3_ide_probe routine to probe for the device on the PCI
bus using the pci_find_device function.
ii)assign an interrupt number and a base address to the device:

 regbase = pdev->resource[0].start;
 irq = pdev->irq;


I read the Documentation/pci.txt file which says that the
pci_find_device is an obsolete function and has been superseded by the
pci_get_device function.

Also, it says that probing for the device is taken care of during the
execution of the pci_register_driver function.  Am I confusing two
things? 

I dont think that just replacing the pci_find_device with the
pci_get_device will work, as I m not still aware of the changed version
of ide routines and interfaces in the 2.6 kernel.

Any pointers?

I m a linux newbie and apologise if my questions sound unclear -- please
ask for clarification in that case.

Thank you,
Ashlesha.
