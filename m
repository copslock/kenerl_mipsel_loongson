Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 18 Oct 2004 13:03:05 +0100 (BST)
Received: from bay15-f3.bay15.hotmail.com ([IPv6:::ffff:65.54.185.3]:8667 "EHLO
	hotmail.com") by linux-mips.org with ESMTP id <S8224787AbUJRMCx>;
	Mon, 18 Oct 2004 13:02:53 +0100
Received: from mail pickup service by hotmail.com with Microsoft SMTPSVC;
	 Mon, 18 Oct 2004 05:02:02 -0700
Received: from 82.200.0.252 by by15fd.bay15.hotmail.msn.com with HTTP;
	Mon, 18 Oct 2004 12:01:30 GMT
X-Originating-IP: [82.200.0.252]
X-Originating-Email: [alexshinkin@hotmail.com]
X-Sender: alexshinkin@hotmail.com
From: "Alexey Shinkin" <alexshinkin@hotmail.com>
To: linux-mips@linux-mips.org
Subject: Question on Au1550 ...
Date: Mon, 18 Oct 2004 19:01:30 +0700
Mime-Version: 1.0
Content-Type: text/plain; format=flowed
Message-ID: <BAY15-F37yRLVbNDN4C0000d65e@hotmail.com>
X-OriginalArrivalTime: 18 Oct 2004 12:02:02.0160 (UTC) FILETIME=[472C4300:01C4B50A]
Return-Path: <alexshinkin@hotmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 6082
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: alexshinkin@hotmail.com
Precedence: bulk
X-list: linux-mips

Hi , All !

I am porting a linux driver for PCI device and some applications form x86 
platform to  AMD Au1550 MIPS , running MontaVista Linux 2.4.20-mvl31.1550.

I got the  following  problem :

The driver allocates some memory (SharedMemory)  for communication with  PCI 
card , using  function pci_alloc_consistent().  PCI card can write to this 
memory using DMA .  On  kernel level  driver correctly reads values, written 
by the board , and the board  correctly reads values, written by driver.

The goal is to make this memoty visible from user level application. The 
following approach is used on õ86 and works :
1. Application calls  mmap( 0, Size, PROT_READ|PROT_WRITE, MAP_SHARED, fd, 0 
) ;

2.  driver implements mmap() function  that just  prepares some vma 
structure fields for nopage operetions :
	vma->vm_flags |= VM_RESERVED;	// no swapping
	vma->vm_ops	= &device_vmops; // contains nopage func
	vma->vm_file   = filp;

3. Application  gets pointer and accesses all mapped pages (reads a byte 
from each page) - this  causes call of nopage function in driver .
The nopage function calculates VirtualAddress from SharedMemory address 
(received after pci_alloc_consistent()),
then  does   KernelPage= virt_to_page(VirtualAddress)   ,
   	get_page(KernelPage)
   and returns KernelPage.

4. Now Application  reads  from SharedMemory , using a pointer , given by 
mmap()  .
This works fine on x86 platform , but on MIPS  application cannot see 
expected contents of the memory - it reads garbage .

What I have  tried :
     - to insert   vma->vm_page_prot = pgprot_noncached(vma->vm_page_prot)  
in driver’s implementation of mmap() ;
   -  to use  remap_page_range() instead of vm_ops .

Result is the same – application reads garbage . If application write  some 
values into the memory - it reads garbage . The values written by 
application are not seen from kernel level .


I am new to MIPS so maybe I missed  something obvious ? Is this right 
approach on this platform at all ?

Thank you in advance!

_________________________________________________________________
Express yourself instantly with MSN Messenger! Download today it's FREE! 
http://messenger.msn.com/
