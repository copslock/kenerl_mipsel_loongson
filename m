Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 12 Apr 2005 16:23:33 +0100 (BST)
Received: from embeddededge.com ([IPv6:::ffff:209.113.146.155]:58629 "EHLO
	penguin.netx4.com") by linux-mips.org with ESMTP
	id <S8225009AbVDLPWl>; Tue, 12 Apr 2005 16:22:41 +0100
Received: from [192.168.2.27] (h69-21-252-132.69-21.unk.tds.net [69.21.252.132])
	by penguin.netx4.com (8.12.8/8.12.9) with ESMTP id j3CFIUtU008064;
	Tue, 12 Apr 2005 11:18:31 -0400
In-Reply-To: <ecb4efd10504101516482a9785@mail.gmail.com>
References: <ecb4efd10504101516482a9785@mail.gmail.com>
Mime-Version: 1.0 (Apple Message framework v619.2)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <479d91035fe1567525659393491e7ab9@embeddedalley.com>
Content-Transfer-Encoding: 7bit
Cc:	linux-mips@linux-mips.org
From:	Dan Malek <dan@embeddedalley.com>
Subject: Re: troubles mmaping PCI device on Au1550
Date:	Tue, 12 Apr 2005 11:22:24 -0400
To:	Clem Taylor <clem.taylor@gmail.com>
X-Mailer: Apple Mail (2.619.2)
Return-Path: <dan@embeddedalley.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 7707
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dan@embeddedalley.com
Precedence: bulk
X-list: linux-mips


On Apr 10, 2005, at 6:16 PM, Clem Taylor wrote:

> My driver code has something like:
> remap_pfn_range ( vma, vma->vm_start,
>      ( pci_resource_start ( pdev, BAR ) >> PAGE_SHIFT ) + vma->pgoff,
>      vma->vm_end - vma->vm_start, vma->vm_page_prot );

The Au15xx uses 36-bit addressing for the PCI (among other) physical
addresses.  The mmap() in your driver is the right thing, but you need
to use io_remap_page_range() where the 2nd parameter is a phys_t.
Your offset should be a phys_t type, and pci_resource_start() also
returns a phys_t.

> I tried a similar test using /dev/mem and the address the linear
> framebuffer on my desktop machine (as returned by lspci).

You can't use /dev/mem for this on Au15xx because it doesn't have
provisions for more than 32-bit addresses.  Be careful with lspci,
as it only returns the 32-bit BAR, not the 36-bit Au15xx address nor
the 32-bit ioremapped address.

Thanks.


	-- Dan
