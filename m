Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 23 Apr 2007 15:15:45 +0100 (BST)
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:61393 "EHLO
	the-village.bc.nu") by ftp.linux-mips.org with ESMTP
	id S20021689AbXDWOPn (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 23 Apr 2007 15:15:43 +0100
Received: from the-village.bc.nu (localhost.localdomain [127.0.0.1])
	by the-village.bc.nu (8.13.8/8.13.8) with ESMTP id l3NEJICR007921;
	Mon, 23 Apr 2007 15:19:18 +0100
Date:	Mon, 23 Apr 2007 15:19:18 +0100
From:	Alan Cox <alan@lxorguk.ukuu.org.uk>
To:	Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc:	ralf@linux-mips.org, linux-mips@linux-mips.org
Subject: Re: [PATCH] IOC3: Switch to pci refcounting safe APIs
Message-ID: <20070423151918.477ffb6a@the-village.bc.nu>
In-Reply-To: <462CBE33.2060208@ru.mvista.com>
References: <20070423150640.1faf693f@the-village.bc.nu>
	<462CBE33.2060208@ru.mvista.com>
X-Mailer: Claws Mail 2.9.1 (GTK+ 2.10.8; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-Path: <alan@lxorguk.ukuu.org.uk>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 14899
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: alan@lxorguk.ukuu.org.uk
Precedence: bulk
X-list: linux-mips

> > +static int ioc3_adjacent_is_ioc3(struct pci_dev *pdev, int dev)
> > +{
> > +	struct pci_dev *dev = pci_get_bus_and_slot(pdev->bus->number, 
> > +							PCI_DEVFN(dev, 0));
> 
>    The same question: isn't pci_get_bus() better in this case?

Makes no real difference, but if you know the MIPS tree never ends up
with pdev->bus = NULL for the root bus then its a trivial change

>    I don't see the point of using refcounting API in such cases but well...

Two reasons

1.	It makes the entire system more consistent
2.	It means we can remove the (usually) unsafe pci_find_slot API

(and #3 sort of... it means the pci fake hotplug testing works with this
device too)
