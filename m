Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 22 Aug 2007 19:08:30 +0100 (BST)
Received: from localhost.localdomain ([127.0.0.1]:31376 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S20022875AbXHVSI2 (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 22 Aug 2007 19:08:28 +0100
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.14.1/8.13.8) with ESMTP id l7MI8RkD004155;
	Wed, 22 Aug 2007 19:08:27 +0100
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.14.1/8.14.1/Submit) id l7MI8R8S004154;
	Wed, 22 Aug 2007 19:08:27 +0100
Date:	Wed, 22 Aug 2007 19:08:27 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Alex Gonzalez <langabe@gmail.com>
Cc:	linux-mips <linux-mips@linux-mips.org>
Subject: Re: Bus error after successful mmap of physical address
Message-ID: <20070822180827.GA3362@linux-mips.org>
References: <c58a7a270708221031g3fba98d5u8507c2aafd4e16b4@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c58a7a270708221031g3fba98d5u8507c2aafd4e16b4@mail.gmail.com>
User-Agent: Mutt/1.5.14 (2007-02-12)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 16246
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Wed, Aug 22, 2007 at 06:31:22PM +0100, Alex Gonzalez wrote:

> I am sure there is a basic reason why this is not working but I just
> can't see it.
> 
> I am booting with mem=512MB and trying to access a memory region at
> 0xC0000000 mapped by a fixed TLB entry.

Is 0xC0000000 a physical or virtual address.  If it's a virtual address
your mapping will conflict with other mappings generated by the kernel and
you will need additional hacks to protect the address space from being
used by the kernel for other purposes.

> My driver does,
> 
> vma->vm_flags = vma->vm_flags | VM_IO | VM_RESERVED ;
> vma->vm_page_prot = pgprot_noncached(vma->vm_page_prot) ;
>
> // open device
> 	vadr = mmap( NULL , 1024*1024 ,
> PROT_WRITE|PROT_READ,MAP_NORESERVE|MAP_SHARED,device,0xC0000000);
                                                       ^^^^^^^^^^

This is the reason why I was asking if 0xC0000000 was a physical address.
mmap needs a physical address.

> 	if(vadr == MAP_FAILED)
> 	{
> 		perror("mmap failed.\n");
> 		exit(-1);
> 	}
> 
> 
> That goes OK, but then if I try to read or write from vadr I get a "Bus error".

Assuming device is a /dev/mem descriptor that is looking ok.  However - you
will be getting an uncached mapping from mmap so the performance will suck
rocks through a straw.

Anyway, you have 64-bit hardware, use it.  On a 64-bit kernel you can just
address all your memory through XKPHYS without the need for any TLB entries.

  Ralf
