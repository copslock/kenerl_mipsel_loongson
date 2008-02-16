Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 16 Feb 2008 10:49:03 +0000 (GMT)
Received: from h155.mvista.com ([63.81.120.155]:56184 "EHLO imap.sh.mvista.com")
	by ftp.linux-mips.org with ESMTP id S20033291AbYBPKtA (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Sat, 16 Feb 2008 10:49:00 +0000
Received: from [192.168.1.234] (unknown [10.150.0.9])
	by imap.sh.mvista.com (Postfix) with ESMTP
	id C33A43EC9; Sat, 16 Feb 2008 02:48:57 -0800 (PST)
Message-ID: <47B6BFD4.5050404@ru.mvista.com>
Date:	Sat, 16 Feb 2008 13:49:56 +0300
From:	Sergei Shtylyov <sshtylyov@ru.mvista.com>
Organization: MontaVista Software Inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; rv:1.7.2) Gecko/20040803
X-Accept-Language: ru, en-us, en-gb
MIME-Version: 1.0
To:	Michael Buesch <mb@bu3sch.de>
Cc:	ralf@linux-mips.org, linux-mips@linux-mips.org
Subject: Re: Linux MIPS PCI resource sanity check
References: <200802161139.10791.mb@bu3sch.de>
In-Reply-To: <200802161139.10791.mb@bu3sch.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <sshtylyov@ru.mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 18229
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sshtylyov@ru.mvista.com
Precedence: bulk
X-list: linux-mips

Michael Buesch wrote:

> There's a sanity check in pcibios_enable_resources() that looks like this:

> 	r = &dev->resource[idx];
> 	if (!r->start && r->end) {
> 		printk(KERN_ERR "PCI: Device %s not available because of resource collisions\n", pci_name(dev));
> 		return -EINVAL;
> 	}
> 
> What is this check actually doing?

   It makes sure that a PCI resource is allocated (base of 0 means that it's 
unallocated due to previously detected resource conlict (or some other reason).

> It triggers for me on a BCM4318 device which is behind a BCM4710 PCI bridge.
> r->start is 0 and r->end is 0x1FFF when this triggers.
> If I simply comment out that check the device is detected correctly
> and seems to initialize just fine.

    No, that failnig resource should be relocated.

WBR, Sergei
