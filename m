Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 09 Jan 2009 01:26:33 +0000 (GMT)
Received: from rtp-iport-2.cisco.com ([64.102.122.149]:21292 "EHLO
	rtp-iport-2.cisco.com") by ftp.linux-mips.org with ESMTP
	id S21102853AbZAIB0a (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 9 Jan 2009 01:26:30 +0000
X-IronPort-AV: E=Sophos;i="4.37,236,1231113600"; 
   d="scan'208";a="33239475"
Received: from rtp-dkim-2.cisco.com ([64.102.121.159])
  by rtp-iport-2.cisco.com with ESMTP; 09 Jan 2009 01:26:23 +0000
Received: from rtp-core-1.cisco.com (rtp-core-1.cisco.com [64.102.124.12])
	by rtp-dkim-2.cisco.com (8.12.11/8.12.11) with ESMTP id n091QNsk019718
	for <linux-mips@linux-mips.org>; Thu, 8 Jan 2009 20:26:23 -0500
Received: from sausatlsmtp1.sciatl.com (sausatlsmtp1.cisco.com [192.133.217.33])
	by rtp-core-1.cisco.com (8.13.8/8.13.8) with ESMTP id n091QNm1007894
	for <linux-mips@linux-mips.org>; Fri, 9 Jan 2009 01:26:23 GMT
Received: from default.com ([192.133.217.33]) by sausatlsmtp1.sciatl.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Thu, 8 Jan 2009 20:26:22 -0500
Received: from sausatlbhs02.corp.sa.net ([192.133.216.42]) by sausatlsmtp1.sciatl.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Thu, 8 Jan 2009 20:26:21 -0500
Received: from [64.101.20.155] ([64.101.20.155]) by sausatlbhs02.corp.sa.net with Microsoft SMTPSVC(6.0.3790.3959);
	 Thu, 8 Jan 2009 20:26:20 -0500
Subject: Re: [PATCH] MIPS: Add option for running kernel in mapped address
	space.
From:	David VomLehn <dvomlehn@cisco.com>
Reply-To: dvomlehn@cisco.com
To:	David Daney <ddaney@caviumnetworks.com>
Cc:	linux-mips@linux-mips.org
In-Reply-To: <1231378896-25925-1-git-send-email-ddaney@caviumnetworks.com>
References: <1231378896-25925-1-git-send-email-ddaney@caviumnetworks.com>
Content-Type: text/plain
Date:	Thu, 08 Jan 2009 17:26:11 -0800
Message-Id: <1231464371.32488.43.camel@cuplxvomd02.corp.sa.net>
Mime-Version: 1.0
X-Mailer: Evolution 2.12.3 (2.12.3-5.fc8)
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 09 Jan 2009 01:26:20.0801 (UTC) FILETIME=[46F4BF10:01C971F9]
X-ST-MF-Message-Resent:	1/8/2009 20:26
DKIM-Signature:	v=1; a=rsa-sha256; q=dns/txt; l=6974; t=1231464383; x=1232328383;
	c=relaxed/simple; s=rtpdkim2001;
	h=Content-Type:From:Subject:Content-Transfer-Encoding:MIME-Version;
	d=cisco.com; i=dvomlehn@cisco.com;
	z=From:=20David=20VomLehn=20<dvomlehn@cisco.com>
	|Subject:=20Re=3A=20[PATCH]=20MIPS=3A=20Add=20option=20for=
	20running=20kernel=20in=20mapped=20address=0A=09space.
	|Sender:=20
	|To:=20David=20Daney=20<ddaney@caviumnetworks.com>;
	bh=BoQGvfEzWVuJxy1PVrZYPFiNhBI8HffFM9YgteGpsv0=;
	b=IPV5hG3FRE3F2cjyhi0l/Nfni6tG6Y43/jlyGlbTbi3LrYHkrTEVsGGqis
	YM49BsiHqTl2XKd1/rw7ws52GBGs6dWpG0OtkD3x7r7p4Ae1g5wGfFO7ei4t
	D+FI1bFneb;
Authentication-Results:	rtp-dkim-2; header.From=dvomlehn@cisco.com; dkim=pass (
	sig from cisco.com/rtpdkim2001 verified; ); 
Return-Path: <dvomlehn@cisco.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 21705
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dvomlehn@cisco.com
Precedence: bulk
X-list: linux-mips


On Wed, 2009-01-07 at 17:41 -0800, David Daney wrote:
> This is a preliminary patch to allow the kernel to run in mapped
> address space via a wired TLB entry.  Probably in a future version I
> would factor out the OCTEON specific parts to a separate patch.

Yes, please do the factoring.

> diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
> index 780b520..d9c46a4 100644
> --- a/arch/mips/Kconfig
> +++ b/arch/mips/Kconfig
> @@ -1431,6 +1431,23 @@ config PAGE_SIZE_64KB
>  
>  endchoice
>  
> +config MAPPED_KERNEL
> +	bool "Mapped kernel"
> +	help
> +	  Select this option if you want the kernel's code and data to
> +	  be in mapped memory.  The kernel will be mapped using a
> +	  single wired TLB entry, thus reducing the number of
> +	  available TLB entries by one.  Kernel modules will be able
> +	  to use a more efficient calling convention.

This is currently only supported on 64-bit processors, so this should
depend on CONFIG_64BIT.
 
> diff --git a/arch/mips/Makefile b/arch/mips/Makefile
> index 0bc2120..5468f6d 100644
> --- a/arch/mips/Makefile
> +++ b/arch/mips/Makefile
...
> @@ -662,7 +670,7 @@ OBJCOPYFLAGS		+= --remove-section=.reginfo
>  
>  CPPFLAGS_vmlinux.lds := \
>  	$(KBUILD_CFLAGS) \
> -	-D"LOADADDR=$(load-y)" \
> +	-D"LOADADDR=$(load-y)" $(PHYS_LOAD_ADDRESS) \
>  	-D"JIFFIES=$(JIFFIES)" \
>  	-D"DATAOFFSET=$(if $(dataoffset-y),$(dataoffset-y),0)"

It seems more consistent to just eliminate PHYS_LOAD_ADDRESS entirely
and add a line here reading:
	-D"PHYSADDR=0x$(CONFIG_PHYS_LOAD_ADDRESS)" \

>  
> diff --git a/arch/mips/include/asm/mach-cavium-octeon/kernel-entry-init.h b/arch/mips/include/asm/mach-cavium-octeon/kernel-entry-init.h
> index 0b2b5eb..bf36d82 100644
> --- a/arch/mips/include/asm/mach-cavium-octeon/kernel-entry-init.h
> +++ b/arch/mips/include/asm/mach-cavium-octeon/kernel-entry-init.h
> @@ -27,6 +27,56 @@
>  	# a3 = address of boot descriptor block
>  	.set push
>  	.set arch=octeon
> +#ifdef CONFIG_MAPPED_KERNEL
> +	# Set up the TLB index 0 for wired access to kernel.
> +	# Assume we were loaded with sufficient alignment so that we
> +	# can cover the image with two pages.

This seems like a pretty big assumption. Possible ways to handle this:
o Generalize to handle n pages.
o Hang in a loop here if the assumption is not met
o Check later on whether the assumption was true and print a message.
I'm not really sure how to do this last one, though.

> +	dla	v0, _end
> +	dla	v1, _text
> +	dsubu	v0, v0, v1	# size of image
> +	move	v1, zero
> +	li	t1, -1		# shift count.
> +1:	dsrl	v0, v0, 1	# mask into v1
> +	dsll	v1, v1, 1
> +	daddiu	t1, t1, 1
> +	ori	v1, v1, 1
> +	bne	v0, zero, 1b
> +	daddiu	t2, t1, -6
> +	mtc0	v1, $5, 0	# PageMask
> +	dla	t3, 0xffffffffc0000000 # kernel address

I think this should be CKSSEG rather than a magic constant.

> +	dmtc0	t3, $10, 0	# EntryHi
> +	bal	1f
> +1:	dla	v0, 0x7fffffff

Another magic constant; don't know if there is already a define that
really applies, though. Perhaps add something to asm-mips/inst.h?

> diff --git a/arch/mips/kernel/traps.c b/arch/mips/kernel/traps.c
> index 1055348..b44bcf8 100644
> --- a/arch/mips/kernel/traps.c
> +++ b/arch/mips/kernel/traps.c
> @@ -49,6 +49,8 @@
>  #include <asm/stacktrace.h>
>  #include <asm/irq.h>
>  
> +#include "../mm/uasm.h"

This looks like it would be a good idea to consider moving uasm.h to
include/asm-mips, or possibly splitting it into two header files, one of
which would move to include/asm-mips.

> +
>  extern void check_wait(void);
>  extern asmlinkage void r4k_wait(void);
>  extern asmlinkage void rollback_handle_int(void);
> @@ -1295,9 +1297,18 @@ void *set_except_vector(int n, void *addr)
>  
>  	exception_handlers[n] = handler;
>  	if (n == 0 && cpu_has_divec) {
> -		*(u32 *)(ebase + 0x200) = 0x08000000 |
> -					  (0x03ffffff & (handler >> 2));
> -		local_flush_icache_range(ebase + 0x200, ebase + 0x204);
> +		unsigned long jump_mask = ~((1 << 28) - 1);

The 28 is a magic constant specifying the number of bits of the offset
in a jump instruction. Perhaps define jump_mask in asm-mips/inst.h since
it is related to the instruction format?

> +		u32 *buf = (u32 *)(ebase + 0x200);
> +		unsigned int k0 = 26;

You are using k0 as a constant by defining it as a variable. You could
just have a #define here, but my suggestion is that it would be better
to add defines to asm-mips/inst.h (something like "#define REG_K0 26"
might be suitable for meeting this particular need)

> +		if((handler & jump_mask) == ((ebase + 0x200) & jump_mask)) {
> +			uasm_i_j(&buf, handler & jump_mask);
> +			uasm_i_nop(&buf);
> +		} else {
> +			UASM_i_LA(&buf, k0, handler);
> +			uasm_i_jr(&buf, k0);
> +			uasm_i_nop(&buf);
> +		}
> +		local_flush_icache_range(ebase + 0x200, (unsigned long)buf);
>  	}
>  	return (void *)old_handler;
>  }
>  	/*
> @@ -1670,9 +1683,9 @@ void __init trap_init(void)
>  		return;	/* Already done */
>  #endif
>  
> -	if (cpu_has_veic || cpu_has_vint)
> +	if (cpu_has_veic || cpu_has_vint) {
>  		ebase = (unsigned long) alloc_bootmem_low_pages(0x200 + VECTORSPACING*64);
> -	else {
> +	} else {

Checkpatch will complain about this, and it doesn't really add value to
make the change.

> diff --git a/arch/mips/mm/page.c b/arch/mips/mm/page.c
> index 1417c64..0070aa0 100644
> --- a/arch/mips/mm/page.c
> +++ b/arch/mips/mm/page.c
> @@ -687,3 +687,9 @@ void copy_page(void *to, void *from)
>  }
>  
>  #endif /* CONFIG_SIBYTE_DMA_PAGEOPS */
> +
> +#ifdef CONFIG_MAPPED_KERNEL
> +/* Initialized so it is not clobbered when .bss is zeroed.  */
> +unsigned long phys_to_kernel_offset = 1;
> +unsigned long kernel_image_end = 1;
> +#endif

Clearly there is some magic happening here, but the such wizardry needs
more documentation. I can deduce that these must be overwritten before
we get to kernel_entry; who sets these?

I don't know for sure what kernel_image_end is, but I am guessing that
it is the physical address of the end of the kernel. If so, you can
eliminate it as a piece of magic by  calculating it at run time as the
sum of the address of the start of the kernel and the size.

-- 
David VomLehn, dvomlehn@cisco.com




     - - - - -                              Cisco                            - - - - -         
This e-mail and any attachments may contain information which is confidential, 
proprietary, privileged or otherwise protected by law. The information is solely 
intended for the named addressee (or a person responsible for delivering it to 
the addressee). If you are not the intended recipient of this message, you are 
not authorized to read, print, retain, copy or disseminate this message or any 
part of it. If you have received this e-mail in error, please notify the sender 
immediately by return e-mail and delete it from your computer.
