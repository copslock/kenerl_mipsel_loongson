Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 09 Dec 2004 14:36:21 +0000 (GMT)
Received: from embeddededge.com ([IPv6:::ffff:209.113.146.155]:26888 "EHLO
	penguin.netx4.com") by linux-mips.org with ESMTP
	id <S8225238AbULIOgQ>; Thu, 9 Dec 2004 14:36:16 +0000
Received: from [192.168.253.28] (tibook.embeddededge.com [192.168.253.28])
	by penguin.netx4.com (8.12.8/8.12.9) with ESMTP id iB9EN39f017816;
	Thu, 9 Dec 2004 09:23:03 -0500
In-Reply-To: <20041209161207.39140f0d.toch@dfpost.ru>
References: <20041209161207.39140f0d.toch@dfpost.ru>
Mime-Version: 1.0 (Apple Message framework v619)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <AC350838-49EF-11D9-A745-003065F9B7DC@embeddededge.com>
Content-Transfer-Encoding: 7bit
Cc: linux-mips@linux-mips.org
From: Dan Malek <dan@embeddededge.com>
Subject: Re: mmap problem another :)
Date: Thu, 9 Dec 2004 09:36:11 -0500
To: Dmitriy Tochansky <toch@dfpost.ru>
X-Mailer: Apple Mail (2.619)
Return-Path: <dan@embeddededge.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 6617
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dan@embeddededge.com
Precedence: bulk
X-list: linux-mips


On Dec 9, 2004, at 8:12 AM, Dmitriy Tochansky wrote:

> Look ret = io_remap_page_range(start, offset, size, 
> vma->vm_page_prot); remaps
> from "offset" which I got from pci_resource_start (curdev, IOMEM0); 
> its ok
> from first board where it eq 0x40000000 but on second it 0x40002040

Read the memory mapping docuemntation and understand the APIs.
All of the Linux mapping functions, whether mmap() from an application
or in the kernel are going to align on page boundaries.

The address of 0x40002040 is going to be aligned to a page boundary,
so you have to consider the offset into that page to the base of the
device, plus the register offset.  The kernel mapping functions,
like remap_page_range, are going to force the alignment because
that is what we expect in the kernel.  An mmap() with an unaligned
address will generate an error.


	-- Dan
