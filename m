Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 03 Aug 2007 13:25:29 +0100 (BST)
Received: from localhost.localdomain ([127.0.0.1]:39589 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S20023875AbXHCMZ1 (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 3 Aug 2007 13:25:27 +0100
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.14.1/8.13.8) with ESMTP id l73CPQ5E018576;
	Fri, 3 Aug 2007 13:25:26 +0100
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.14.1/8.14.1/Submit) id l72MN7jI015704;
	Thu, 2 Aug 2007 23:23:07 +0100
Date:	Thu, 2 Aug 2007 23:23:07 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Alex Gonzalez <langabe@gmail.com>
Cc:	linux-mips <linux-mips@linux-mips.org>
Subject: Re: Kernel space access to 2GB of physical memory
Message-ID: <20070802222307.GA12056@linux-mips.org>
References: <c58a7a270708020647q7a0c55f4l6904e864609c7304@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c58a7a270708020647q7a0c55f4l6904e864609c7304@mail.gmail.com>
User-Agent: Mutt/1.5.14 (2007-02-12)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 16048
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Thu, Aug 02, 2007 at 02:47:37PM +0100, Alex Gonzalez wrote:

> I have a system booting the 2.6.12-rc3 32bits kernel on an RM9000
> processor and I am trying to get my head around how to access up to
> 2GB of physical memory with a mem=256MB command line booting
> parameter. I read that on the MIPS kernel this is split 2GB/2GB
> between kernel and user space, so the kernel should be able to access
> directly 2GB of physical memory.

No.  You assume there is nothing else in the 2GB of kernel address space.

> Kernel drivers will access the memory above 256MB using ioremaps. I
> need it this way as the memory above 256MB will be used in special
> ways.
>
> What I struggle to understand is whether it would be possible to
> access all the memory up to 2GB using the ioremap method.

Ioremap is meant to be used for MMIO regions only.

> The only way I can think of achieving this would be to use ksseg and
> dynamic TLB entries to access it in 256MB chunks. The fact that I can
> access ksseg must mean that the kernel is not clearing the TLB entries
> that the bootloader sets up before launching the kernel, so I would
> expect to be able to add/remove TLB entries dynamically without
> affecting the kernel's own memory management.
> 
> 1) Is there a simpler mechanism to achieve this?

It's called 64-bit kernel.

> 2) Any ill effect on the kernel from the method described above?

You're basically reinventing high memory in an application optimized
variant and that probably includes a similar set of problems.

  Ralf
