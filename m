Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 08 Apr 2007 14:26:47 +0100 (BST)
Received: from rtsoft2.corbina.net ([85.21.88.2]:11402 "HELO
	mail.dev.rtsoft.ru") by ftp.linux-mips.org with SMTP
	id S20022316AbXDHN0p (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Sun, 8 Apr 2007 14:26:45 +0100
Received: (qmail 28393 invoked from network); 8 Apr 2007 13:25:44 -0000
Received: from wasted.dev.rtsoft.ru (HELO ?192.168.1.248?) (192.168.1.248)
  by mail.dev.rtsoft.ru with SMTP; 8 Apr 2007 13:25:44 -0000
Message-ID: <4618ED95.6040304@ru.mvista.com>
Date:	Sun, 08 Apr 2007 17:26:45 +0400
From:	Sergei Shtylyov <sshtylyov@ru.mvista.com>
Organization: MontaVista Software Inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; rv:1.7.2) Gecko/20040803
X-Accept-Language: ru, en-us, en-gb
MIME-Version: 1.0
To:	Thomas Bogendoerfer <tsbogend@alpha.franken.de>
CC:	linux-mips@linux-mips.org
Subject: Re: [PATCH] Register PCI host bridge resource earlier
References: <20070408112844.GA7553@alpha.franken.de> <4618DDF0.1020604@ru.mvista.com> <20070408131228.GA7819@alpha.franken.de>
In-Reply-To: <20070408131228.GA7819@alpha.franken.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <sshtylyov@ru.mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 14812
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sshtylyov@ru.mvista.com
Precedence: bulk
X-list: linux-mips

Hello.

Thomas Bogendoerfer wrote:

>>>PCI based SNI RM machines have their EISA bus behind an Intel PCI/EISA
>>>bridge. So the PCI IO range must start at 0x0000. Changing that will
>>>break the PCI bus, because i8259.c already has registered it's IO
>>>addresses before the PCI bus gets initialized. Below is a patch,
>>>which will register the PCI host bridge resources inside
>>>register_pci_controller(). It also changes i8259.c to use insert_region(),
>>>because request_resource() will fail, if the IO space of the PIT hanging
>>>of the PCI host bridge (maybe passing the resource parent to
>>>init_i8259_irqs() is a cleaner fix for that).

>>   First, I don't understand how PIT and PIC resources may intersect. Then, 

> oops, I meant PIC resources.

>>IIUC, using inert_resource() will cause PIT resource be the child of the 
>>PIC resource which doesn't make sense either.

> the insert_resource will make it child of the PCI resource, which makes
> perfect sense, because the ISA bus is behind the PCI host bridge.

    If you read the comment to insert_resource() you'll see that it works 
contrarywise, i. e. the inserted resource is made parent of the conflicting 
ones. I.e. it should't work as you're intending it to.

> Thomas.

WBR, Sergei
