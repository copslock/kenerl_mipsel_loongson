Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 08 Feb 2010 15:01:57 +0100 (CET)
Received: from localhost.localdomain ([127.0.0.1]:55307 "EHLO h5.dl5rb.org.uk"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S1491915Ab0BHOBx (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 8 Feb 2010 15:01:53 +0100
Received: from h5.dl5rb.org.uk (localhost.localdomain [127.0.0.1])
        by h5.dl5rb.org.uk (8.14.3/8.14.3) with ESMTP id o18E2Epv016089;
        Mon, 8 Feb 2010 15:02:15 +0100
Received: (from ralf@localhost)
        by h5.dl5rb.org.uk (8.14.3/8.14.3/Submit) id o18E2E7k016087;
        Mon, 8 Feb 2010 15:02:14 +0100
Date:   Mon, 8 Feb 2010 15:02:14 +0100
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Guenter Roeck <guenter.roeck@ericsson.com>
Cc:     linux-mips@linux-mips.org
Subject: Re: VMALLOC_END, TASK_SIZE and FIXADDR_START for 64 bit MIPS kernels
Message-ID: <20100208140213.GB11334@linux-mips.org>
References: <20100203222250.GA21139@ericsson.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20100203222250.GA21139@ericsson.com>
User-Agent: Mutt/1.5.20 (2009-08-17)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 25898
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Wed, Feb 03, 2010 at 02:22:50PM -0800, Guenter Roeck wrote:

> since it came up during the review of the patch for virtual memory detection
> on 64 bit mips kernels, I looked further into making vmalloc_end
> a variable and TASK_SIZE dependent on the virtual memory size.
>  
> That turned out to be relatively straightforward, and I have a working patch.
> 
> The one question I still have is about FIXADDR_START.  It is currently
> set to one of 0xff000000, 0xfffe0000, or (0xff000000 - 0x20000),
> depending on the target CPU.
> 
> Quoting from one of the comments during the review,
> 	" ... ensure the value of vmalloc_end is <= FIXADDR_START".
> 
> Obviously that is currently not the case. Is that a concern, or is it good as it is ?

Now with allocations potencially happening top-down this is potencially a
serious problem.  Details would depend on details of platform, processor and
kernel configuration.

I said vmalloc_end is <= FIXADDR_START" but more accurately we simply
need to avoid a conflict between the different virtual address space users.

Some CPUs have fixed mappings in their hardware in the KSEG2/KSEG3 range;
those mappings can't be overriden by a TLB mapping.  To deal with that
sort of architectural candy I think a call into the address space allocator
for kernel virtual memory is probably nicest thing but something simplier
than that would probable have to do for 2.6.34.

  Ralf
