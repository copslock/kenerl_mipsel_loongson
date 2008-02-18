Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 18 Feb 2008 13:54:43 +0000 (GMT)
Received: from h155.mvista.com ([63.81.120.155]:14542 "EHLO imap.sh.mvista.com")
	by ftp.linux-mips.org with ESMTP id S28573929AbYBRNyl (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Mon, 18 Feb 2008 13:54:41 +0000
Received: from [192.168.1.234] (unknown [10.150.0.9])
	by imap.sh.mvista.com (Postfix) with ESMTP
	id 2EC303EC9; Mon, 18 Feb 2008 05:54:38 -0800 (PST)
Message-ID: <47B98E5D.2030301@ru.mvista.com>
Date:	Mon, 18 Feb 2008 16:55:41 +0300
From:	Sergei Shtylyov <sshtylyov@ru.mvista.com>
Organization: MontaVista Software Inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; rv:1.7.2) Gecko/20040803
X-Accept-Language: ru, en-us, en-gb
MIME-Version: 1.0
To:	Andrew Sharp <andy.sharp@onstor.com>
Cc:	Michael Buesch <mb@bu3sch.de>, ralf@linux-mips.org,
	linux-mips@linux-mips.org
Subject: Re: Linux MIPS PCI resource sanity check
References: <200802161139.10791.mb@bu3sch.de>	<47B6BFD4.5050404@ru.mvista.com> <20080216153530.7a426a73@ripper.onstor.net>
In-Reply-To: <20080216153530.7a426a73@ripper.onstor.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <sshtylyov@ru.mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 18253
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sshtylyov@ru.mvista.com
Precedence: bulk
X-list: linux-mips

Andrew Sharp wrote:

>>>There's a sanity check in pcibios_enable_resources() that looks
>>>like this:

>>>	r = &dev->resource[idx];
>>>	if (!r->start && r->end) {
>>>		printk(KERN_ERR "PCI: Device %s not available
>>>because of resource collisions\n", pci_name(dev)); return -EINVAL;
>>>	}

>>>What is this check actually doing?

>>   It makes sure that a PCI resource is allocated (base of 0 means
>>that it's unallocated due to previously detected resource conlict (or
>>some other reason).

> Actually, IIRC, resources are based on what the device requested, so a
> device behind a bridge could request a resource starting at 0.  I had

    Zero value in BAR was considered unallocated resource in the PCI 2.2 spec...

> to change this for a system as well.  I changed it to

> if (!r->start && !r->end) {

    r->end can't be 0.

WBR, Sergei
