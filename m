Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 07 Dec 2004 15:57:29 +0000 (GMT)
Received: from embeddededge.com ([IPv6:::ffff:209.113.146.155]:14351 "EHLO
	penguin.netx4.com") by linux-mips.org with ESMTP
	id <S8225242AbULGP5Z>; Tue, 7 Dec 2004 15:57:25 +0000
Received: from [192.168.253.28] (tibook.embeddededge.com [192.168.253.28])
	by penguin.netx4.com (8.12.8/8.12.9) with ESMTP id iB7FiN9f011188;
	Tue, 7 Dec 2004 10:44:23 -0500
In-Reply-To: <20041207184258.071bf401.toch@dfpost.ru>
References: <20041207184258.071bf401.toch@dfpost.ru>
Mime-Version: 1.0 (Apple Message framework v619)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <AD0D6ED2-4868-11D9-BB64-003065F9B7DC@embeddededge.com>
Content-Transfer-Encoding: 7bit
Cc: linux-mips@linux-mips.org
From: Dan Malek <dan@embeddededge.com>
Subject: Re: mmap problem
Date: Tue, 7 Dec 2004 10:57:20 -0500
To: Dmitriy Tochansky <toch@dfpost.ru>
X-Mailer: Apple Mail (2.619)
Return-Path: <dan@embeddededge.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 6584
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dan@embeddededge.com
Precedence: bulk
X-list: linux-mips


On Dec 7, 2004, at 10:42 AM, Dmitriy Tochansky wrote:

>   ret = remap_page_range( start, 0x40000000, size, vma->vm_page_prot 
> ); //

Use io_remap_page_range, it has the same parameters, and is
designed to work with > 32-bit physical addresses.

Also, you should really use pci_resource_* functions to get
information about the pci address, size, etc.  Don't hardcode this,
even for testing.


	-- Dan
