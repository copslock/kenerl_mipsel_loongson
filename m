Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 14 Aug 2007 10:56:57 +0100 (BST)
Received: from localhost.localdomain ([127.0.0.1]:38326 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S20022215AbXHNJ4y (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 14 Aug 2007 10:56:54 +0100
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.14.1/8.13.8) with ESMTP id l7E9ld2J018892;
	Tue, 14 Aug 2007 10:47:39 +0100
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.14.1/8.14.1/Submit) id l7E9lcqg018891;
	Tue, 14 Aug 2007 10:47:38 +0100
Date:	Tue, 14 Aug 2007 10:47:38 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Nicolas Schichan <nschichan@freebox.fr>
Cc:	Andrew Sharp <andy.sharp@onstor.com>, linux-mips@linux-mips.org
Subject: Re: kexec - not happening on mipsel?
Message-ID: <20070814094738.GC16958@linux-mips.org>
References: <20070808170846.7d395891@ripper.onstor.net> <20070808184120.40b6b5d5@ripper.onstor.net> <20070809123530.GA14183@linux-mips.org> <200708101857.15567.nschichan@freebox.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200708101857.15567.nschichan@freebox.fr>
User-Agent: Mutt/1.5.14 (2007-02-12)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 16167
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Fri, Aug 10, 2007 at 06:57:15PM +0200, Nicolas Schichan wrote:

> I now use __flush_cache_all(), since flush_cache_all() is mostly a noop on r4k 
> if cpu_has_dc_aliases evaluates to 0 (and it is the case on the MIPS cpu I 
> have access to). To avoid caching problem in the relocation code, I disable 
> the cache in KSEG0 (using the K0 field in CP0 CONFIG register) before jumping 
> to the relocation code. I don't know how clean this solution is, but this 
> avoids having to add non-portable cache flush code to relocate_kernel.S.


> 
> Regards,
> 
> Signed-off-by: Nicolas Schichan <nschichan@freebox.fr>
> 
> --- linux/arch/mips/kernel/machine_kexec.c	(revision 5939)
> +++ linux/arch/mips/kernel/machine_kexec.c	(revision 5941)
> @@ -50,8 +50,10 @@
>  	reboot_code_buffer =
>  	  (unsigned long)page_address(image->control_code_page);
>  
> +	printk(KERN_INFO "reboot code is at %08lx\n", reboot_code_buffer);
> +
>  	kexec_start_address = image->start;
> -	kexec_indirection_page = phys_to_virt(image->head & PAGE_MASK);
> +	kexec_indirection_page = (long)phys_to_virt(image->head & PAGE_MASK);
>  
>  	memcpy((void*)reboot_code_buffer, relocate_new_kernel,
>  	       relocate_new_kernel_size);
> @@ -75,11 +77,17 @@
>  	 */
>  	local_irq_disable();
>  
> -	flush_icache_range(reboot_code_buffer,
> -			   reboot_code_buffer + KEXEC_CONTROL_CODE_SIZE);
> +	__flush_cache_all();
> +	flush_icache_all();

flush_icache_all() is a nop except on VIVT caches.  Anyway, following a
__flush_cache_all it's pointless unless you want to flush caches a little
harder.

> -	printk("Will call new kernel at %08x\n", image->start);
> -	printk("Bye ...\n");
> -	flush_cache_all();
> +	/*
> +	 * avoid cache operation related headache in
> +	 * relocate_kernel.S: disable caches in kseg0, the new kernel
> +	 * will take care to re-enable cache in kseg0.
> +	 */
> +	change_c0_config(CONF_CM_CMASK, CONF_CM_UNCACHED);

And that line is the kernel's one way ticket to hell on some platforms.

There is a hazard barrier missing here.

Only KSEG0 (or CKSEG0 in 64-bit parlance) is affected by changing Config.K0
field.  But 64-bit kernels do not necessarily run in one of the 32-bit
compatibility segments (R8000 doesn't but that's an academic counter
example) - if they exist at all there is no guarantee that there is any RAM
mapped in them (IP30 and others).

On IP27 the kernel will run in CKSEG0 and if you switch that to 0 it'll mean
BRIDGE ASIC will start looking at the uncached attribute which will be
defaulted to 0 meaning that in CKSEG0 the CPU will no longer address RAM but
the ECC and Backdoor Directory information.

Basically it boils down to be very, very careful about cache modes
on MIPS.  What the kernel does on bootup only happens to work because for
all the platforms that have potencial issues with the change of the CCA
for KSEG0 we know that Linux will set the CCA to the same value that is
already in that field.  So that mode switch is sort of useless for most
platforms except a few where firmware doesn't initialize Config0.K0.

  Ralf
