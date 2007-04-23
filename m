Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 23 Apr 2007 15:20:39 +0100 (BST)
Received: from h155.mvista.com ([63.81.120.155]:13559 "EHLO imap.sh.mvista.com")
	by ftp.linux-mips.org with ESMTP id S20021703AbXDWOUh (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Mon, 23 Apr 2007 15:20:37 +0100
Received: from [192.168.1.248] (unknown [10.150.0.9])
	by imap.sh.mvista.com (Postfix) with ESMTP
	id 8D67D3ECA; Mon, 23 Apr 2007 07:20:35 -0700 (PDT)
Message-ID: <462CC0EC.6010600@ru.mvista.com>
Date:	Mon, 23 Apr 2007 18:21:32 +0400
From:	Sergei Shtylyov <sshtylyov@ru.mvista.com>
Organization: MontaVista Software Inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; rv:1.7.2) Gecko/20040803
X-Accept-Language: ru, en-us, en-gb
MIME-Version: 1.0
To:	Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc:	ralf@linux-mips.org, linux-mips@linux-mips.org
Subject: Re: [PATCH] IOC3: Switch to pci refcounting safe APIs
References: <20070423150640.1faf693f@the-village.bc.nu>	<462CBE33.2060208@ru.mvista.com> <20070423151918.477ffb6a@the-village.bc.nu>
In-Reply-To: <20070423151918.477ffb6a@the-village.bc.nu>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <sshtylyov@ru.mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 14900
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sshtylyov@ru.mvista.com
Precedence: bulk
X-list: linux-mips

Alan Cox wrote:
>>>+static int ioc3_adjacent_is_ioc3(struct pci_dev *pdev, int dev)
>>>+{
>>>+	struct pci_dev *dev = pci_get_bus_and_slot(pdev->bus->number, 
>>>+							PCI_DEVFN(dev, 0));
>>
>>   The same question: isn't pci_get_bus() better in this case?
 
> Makes no real difference, but if you know the MIPS tree never ends up

   pci_get_bus_and_slot() walks all device tree, pci_get_bus() walks only one bus.

> with pdev->bus = NULL for the root bus then its a trivial change

   You'll get kernel oops in this case anyway as you're dereferencing pdev->bus.
 
>>   I don't see the point of using refcounting API in such cases but well...
 
> Two reasons
> 
> 1.	It makes the entire system more consistent
> 2.	It means we can remove the (usually) unsafe pci_find_slot API

> (and #3 sort of... it means the pci fake hotplug testing works with this
> device too)

   Ah... Thanks for the explanation.

WBR, Sergei
