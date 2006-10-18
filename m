Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 18 Oct 2006 15:31:17 +0100 (BST)
Received: from localhost.localdomain ([127.0.0.1]:22175 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S20038517AbWJRObP (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 18 Oct 2006 15:31:15 +0100
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.13.7/8.13.7) with ESMTP id k9IEVTBT007391;
	Wed, 18 Oct 2006 15:31:29 +0100
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.13.7/8.13.7/Submit) id k9IEVTGW007390;
	Wed, 18 Oct 2006 15:31:29 +0100
Date:	Wed, 18 Oct 2006 15:31:29 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Nicolas Schichan <nschichan@freebox.fr>
Cc:	linux-mips@linux-mips.org
Subject: Re: [patch] [RFC] Kexec on MIPS
Message-ID: <20061018143129.GB3498@linux-mips.org>
References: <200610181514.56081.nschichan@freebox.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200610181514.56081.nschichan@freebox.fr>
User-Agent: Mutt/1.4.2.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 12986
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Wed, Oct 18, 2006 at 03:14:55PM +0200, Nicolas Schichan wrote:

> I have implemented kexec support for the mips architecture, the code is 
> available in the attached patch (for 2.6.18 kernel). This code works fine on 
> the mips boards I use at work (one in big endian and one in little endian) and 
> on qemu.

Cool!

> However it has not been tested on 64 bit mips and it may not work on
> those architectures.

Aside of a nit in a 32-bit specific comment the code is looking good.  See
below.

> It may also not work on machines with more than 512 megabytes as the kexec 
> generic code may fill the page list with adresses over the 512 megabytes 
> limit (the mips boards I use only have 16mbytes and 32mbytes ram).

This is only an issue with 32-bit software anyway.  On these you can solve
the problem by manually setting up TLB mappings.  You may want to take a
look at kmap_coherent in arch/mips/mm/init.c for how to create such
temporary mappings.

> A tiny userland application loading the kernel and invoking kexec_load for 
> mips is available here:
> 
> http://chac.le-poulpe.net/~nico/kexec/kexec-2006-10-18.tar.gz
> 
> Do not hesitate to comment on this patch,

Without having tested this, this actually looks quite fine for the first
cut.  My nits are these:

+       /*
+        * The generic kexec code builds a page list with physical
+        * addresses. they are directly accessible through KSEG0,
+        * hence the pys_to_virt() call.
+        */

On a 64-bit system this could actually be either an XKPHY or CKSEG address,
depending on PAGE_OFFSET.

+       /*
+        * we do not want to be bothered.
+        */
+       local_irq_disable();
+
+       flush_icache_range(reboot_code_buffer,
+                          reboot_code_buffer + KEXEC_CONTROL_CODE_SIZE);
+
+       printk("Will call new kernel at %08x\n", image->start);
+       printk("Bye ...\n");
+       flush_cache_all();
+       ((void (*)(void))reboot_code_buffer)();

On SMP systems cache flushes may invoke smp_call_function which will barf
when called with interrupts disabled.  So you may want to move the
local_irq_disable further down to somewhere after the last flush.

Your code does not try to deal with SMP at all.  The strategy used by
Linux to get hold of processors 1 and up on bootup relies on the
firmware.  Generally firmware breaks because Linux tramples over it and
even if it would survive that, it does not regain control over non-boot
processors, so starting of those processors would fail.

The solution I have in mind would be something like:

 * The trampoline that transfers control between the old and new kernel
   needs to be modified to keep all additional processors in some sort of
   spinlock.
 * A kernel needs a way to know if it has been executed via kexec or a
   normal bootup.  It uses this knowledge to release one non-boot
   processor after another during SMP initialization.

  Ralf

PS: If you have to send patches as attachments, then please as text/plain.
