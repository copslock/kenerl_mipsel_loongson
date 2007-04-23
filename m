Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 23 Apr 2007 15:35:16 +0100 (BST)
Received: from localhost.localdomain ([127.0.0.1]:33747 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S20021740AbXDWOfO (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 23 Apr 2007 15:35:14 +0100
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.13.8/8.13.8) with ESMTP id l3NEZ8fu009766;
	Mon, 23 Apr 2007 15:35:08 +0100
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.13.8/8.13.8/Submit) id l3NEZ79x009765;
	Mon, 23 Apr 2007 15:35:07 +0100
Date:	Mon, 23 Apr 2007 15:35:07 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc:	Sergei Shtylyov <sshtylyov@ru.mvista.com>,
	linux-mips@linux-mips.org
Subject: Re: [PATCH] IOC3: Switch to pci refcounting safe APIs
Message-ID: <20070423143507.GA8877@linux-mips.org>
References: <20070423150640.1faf693f@the-village.bc.nu> <462CBE33.2060208@ru.mvista.com> <20070423151918.477ffb6a@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20070423151918.477ffb6a@the-village.bc.nu>
User-Agent: Mutt/1.4.2.2i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 14901
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Mon, Apr 23, 2007 at 03:19:18PM +0100, Alan Cox wrote:

> > > +static int ioc3_adjacent_is_ioc3(struct pci_dev *pdev, int dev)
> > > +{
> > > +	struct pci_dev *dev = pci_get_bus_and_slot(pdev->bus->number, 
> > > +							PCI_DEVFN(dev, 0));
> > 
> >    The same question: isn't pci_get_bus() better in this case?
> 
> Makes no real difference, but if you know the MIPS tree never ends up
> with pdev->bus = NULL for the root bus then its a trivial change

That's the case on MIPS.

> >    I don't see the point of using refcounting API in such cases but well...
> 
> Two reasons
> 
> 1.	It makes the entire system more consistent
> 2.	It means we can remove the (usually) unsafe pci_find_slot API
> 
> (and #3 sort of... it means the pci fake hotplug testing works with this
> device too)

The patch looks ok to me:

Acked-by: Ralf Baechle <ralf@linux-mips.org>

Longer term MENET should be handled differently but this patch certainly
doesn't make things worse.

  Ralf
