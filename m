Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 18 Oct 2004 17:07:25 +0100 (BST)
Received: from embeddededge.com ([IPv6:::ffff:209.113.146.155]:57868 "EHLO
	penguin.netx4.com") by linux-mips.org with ESMTP
	id <S8224859AbUJRQHT> convert rfc822-to-8bit; Mon, 18 Oct 2004 17:07:19 +0100
Received: from [192.168.86.100] (pool-151-203-220-64.bos.east.verizon.net [151.203.220.64])
	by penguin.netx4.com (8.12.8/8.12.9) with ESMTP id i9IFxOQi010000;
	Mon, 18 Oct 2004 11:59:25 -0400
In-Reply-To: <BAY15-F37yRLVbNDN4C0000d65e@hotmail.com>
References: <BAY15-F37yRLVbNDN4C0000d65e@hotmail.com>
Mime-Version: 1.0 (Apple Message framework v619)
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Message-Id: <10F61ABF-2120-11D9-8079-003065F9B7DC@embeddededge.com>
Content-Transfer-Encoding: 8BIT
Cc: linux-mips@linux-mips.org
From: Dan Malek <dan@embeddededge.com>
Subject: Re: Question on Au1550 ...
Date: Mon, 18 Oct 2004 12:09:19 -0400
To: "Alexey Shinkin" <alexshinkin@hotmail.com>
X-Mailer: Apple Mail (2.619)
Return-Path: <dan@embeddededge.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 6086
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dan@embeddededge.com
Precedence: bulk
X-list: linux-mips


On Oct 18, 2004, at 8:01 AM, Alexey Shinkin wrote:

> The goal is to make this memoty visible from user level application. 
> The following approach is used on õ86 and works :

I'm kinda surprised it works anywhere.  You have taken a rather complex
approach to achieving your results.

>   -  to use  remap_page_range() instead of vm_ops .

This is all you should have to do.  Use the physical (dma_addr_t) 
address
returned from pci_alloc_consistent() as the 'offset' parameter, use the 
VMA
allocated and provided to you, call remap_page_range() and you are done.

An alternative is to have an ioctl() in your driver that returns the 
physical
address of the buffer (as provided by pci_alloc_consistent()), then use
/dev/mem to do the mmap().  The only problem with this is coordination
with your driver, you have to ensure you release the /dev/mem mmap
in your application when the driver also does the same for the dma
buffer space.


	-- Dan
