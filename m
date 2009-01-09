Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 09 Jan 2009 02:34:33 +0000 (GMT)
Received: from mail3.caviumnetworks.com ([12.108.191.235]:65437 "EHLO
	mail3.caviumnetworks.com") by ftp.linux-mips.org with ESMTP
	id S21365019AbZAICeb (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 9 Jan 2009 02:34:31 +0000
Received: from exch4.caveonetworks.com (Not Verified[192.168.16.23]) by mail3.caviumnetworks.com with MailMarshal (v6,2,2,3503)
	id <B4966b7a30000>; Thu, 08 Jan 2009 21:34:11 -0500
Received: from exch4.caveonetworks.com ([192.168.16.23]) by exch4.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Thu, 8 Jan 2009 18:33:12 -0800
Received: from dd1.caveonetworks.com ([64.169.86.201]) by exch4.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Thu, 8 Jan 2009 18:33:12 -0800
Message-ID: <4966B768.9050909@caviumnetworks.com>
Date:	Thu, 08 Jan 2009 18:33:12 -0800
From:	David Daney <ddaney@caviumnetworks.com>
User-Agent: Thunderbird 2.0.0.19 (X11/20090105)
MIME-Version: 1.0
To:	dvomlehn@cisco.com
CC:	linux-mips@linux-mips.org
Subject: Re: [PATCH] MIPS: Add option for running kernel in mapped address
 space.
References: <1231378896-25925-1-git-send-email-ddaney@caviumnetworks.com> <1231464371.32488.43.camel@cuplxvomd02.corp.sa.net>
In-Reply-To: <1231464371.32488.43.camel@cuplxvomd02.corp.sa.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 09 Jan 2009 02:33:12.0093 (UTC) FILETIME=[9DDF54D0:01C97202]
Return-Path: <David.Daney@caviumnetworks.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 21706
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@caviumnetworks.com
Precedence: bulk
X-list: linux-mips

David VomLehn wrote:
> On Wed, 2009-01-07 at 17:41 -0800, David Daney wrote:
>> This is a preliminary patch to allow the kernel to run in mapped
>> address space via a wired TLB entry.  Probably in a future version I
>> would factor out the OCTEON specific parts to a separate patch.
> 
> Yes, please do the factoring.

Everything in good time.  My real intent was to generate feedback about 
the general ideas.

> 
>> diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
>> index 780b520..d9c46a4 100644
>> --- a/arch/mips/Kconfig
>> +++ b/arch/mips/Kconfig
>> @@ -1431,6 +1431,23 @@ config PAGE_SIZE_64KB
>>  
>>  endchoice
>>  
>> +config MAPPED_KERNEL
>> +	bool "Mapped kernel"
>> +	help
>> +	  Select this option if you want the kernel's code and data to
>> +	  be in mapped memory.  The kernel will be mapped using a
>> +	  single wired TLB entry, thus reducing the number of
>> +	  available TLB entries by one.  Kernel modules will be able
>> +	  to use a more efficient calling convention.
> 
> This is currently only supported on 64-bit processors, so this should
> depend on CONFIG_64BIT.

It should be trivial to extend to 32-bit kernels as well.  I may try it 
on the mips32 based STB I have at home.  But as it currently stands, you 
are correct.

>  
>> diff --git a/arch/mips/Makefile b/arch/mips/Makefile
>> index 0bc2120..5468f6d 100644
>> --- a/arch/mips/Makefile
>> +++ b/arch/mips/Makefile
> ...
>> @@ -662,7 +670,7 @@ OBJCOPYFLAGS		+= --remove-section=.reginfo
>>  
>>  CPPFLAGS_vmlinux.lds := \
>>  	$(KBUILD_CFLAGS) \
>> -	-D"LOADADDR=$(load-y)" \
>> +	-D"LOADADDR=$(load-y)" $(PHYS_LOAD_ADDRESS) \
>>  	-D"JIFFIES=$(JIFFIES)" \
>>  	-D"DATAOFFSET=$(if $(dataoffset-y),$(dataoffset-y),0)"
> 
> It seems more consistent to just eliminate PHYS_LOAD_ADDRESS entirely
> and add a line here reading:
> 	-D"PHYSADDR=0x$(CONFIG_PHYS_LOAD_ADDRESS)" \

There is some macro trickery in vmlinux.lds.S that checks to see if it 
is defined, so I cannot unconditionally define it.

> 
>>  
>> diff --git a/arch/mips/include/asm/mach-cavium-octeon/kernel-entry-init.h b/arch/mips/include/asm/mach-cavium-octeon/kernel-entry-init.h
>> index 0b2b5eb..bf36d82 100644
>> --- a/arch/mips/include/asm/mach-cavium-octeon/kernel-entry-init.h
>> +++ b/arch/mips/include/asm/mach-cavium-octeon/kernel-entry-init.h
>> @@ -27,6 +27,56 @@
>>  	# a3 = address of boot descriptor block
>>  	.set push
>>  	.set arch=octeon
>> +#ifdef CONFIG_MAPPED_KERNEL
>> +	# Set up the TLB index 0 for wired access to kernel.
>> +	# Assume we were loaded with sufficient alignment so that we
>> +	# can cover the image with two pages.
> 
> This seems like a pretty big assumption. Possible ways to handle this:
> o Generalize to handle n pages.

This is an optimization, burning through TLB entries is not going to 
help things.

> o Hang in a loop here if the assumption is not met

Possible.

> o Check later on whether the assumption was true and print a message.
> I'm not really sure how to do this last one, though.

Also possible.

This is all very low-level board code, if you want the optimization, you 
need to load at a suitable physical address.

> 
>> +	dla	v0, _end
>> +	dla	v1, _text
>> +	dsubu	v0, v0, v1	# size of image
>> +	move	v1, zero
>> +	li	t1, -1		# shift count.
>> +1:	dsrl	v0, v0, 1	# mask into v1
>> +	dsll	v1, v1, 1
>> +	daddiu	t1, t1, 1
>> +	ori	v1, v1, 1
>> +	bne	v0, zero, 1b
>> +	daddiu	t2, t1, -6
>> +	mtc0	v1, $5, 0	# PageMask
>> +	dla	t3, 0xffffffffc0000000 # kernel address
> 
> I think this should be CKSSEG rather than a magic constant.
> 
>> +	dmtc0	t3, $10, 0	# EntryHi
>> +	bal	1f
>> +1:	dla	v0, 0x7fffffff
> 
> Another magic constant; don't know if there is already a define that
> really applies, though. Perhaps add something to asm-mips/inst.h?
> 

Both are worth investigating.  Each board could (and may have to) do it 
differently.

>> diff --git a/arch/mips/kernel/traps.c b/arch/mips/kernel/traps.c
>> index 1055348..b44bcf8 100644
>> --- a/arch/mips/kernel/traps.c
>> +++ b/arch/mips/kernel/traps.c
>> @@ -49,6 +49,8 @@
>>  #include <asm/stacktrace.h>
>>  #include <asm/irq.h>
>>  
>> +#include "../mm/uasm.h"
> 
> This looks like it would be a good idea to consider moving uasm.h to
> include/asm-mips, or possibly splitting it into two header files, one of
> which would move to include/asm-mips.
> 

That was my thought as well.  This being a quick-and-dirty hack, I took 
the low road and did it this way.

>> +
>>  extern void check_wait(void);
>>  extern asmlinkage void r4k_wait(void);
>>  extern asmlinkage void rollback_handle_int(void);
>> @@ -1295,9 +1297,18 @@ void *set_except_vector(int n, void *addr)
>>  
>>  	exception_handlers[n] = handler;
>>  	if (n == 0 && cpu_has_divec) {
>> -		*(u32 *)(ebase + 0x200) = 0x08000000 |
>> -					  (0x03ffffff & (handler >> 2));
>> -		local_flush_icache_range(ebase + 0x200, ebase + 0x204);
>> +		unsigned long jump_mask = ~((1 << 28) - 1);
> 
> The 28 is a magic constant specifying the number of bits of the offset
> in a jump instruction. Perhaps define jump_mask in asm-mips/inst.h since
> it is related to the instruction format?

Correct.

> 
>> +		u32 *buf = (u32 *)(ebase + 0x200);
>> +		unsigned int k0 = 26;
> 
> You are using k0 as a constant by defining it as a variable. You could
> just have a #define here, but my suggestion is that it would be better
> to add defines to asm-mips/inst.h (something like "#define REG_K0 26"
> might be suitable for meeting this particular need)

Yes, the constants should probably be factored out of the TLB and page 
code.  Then they could be used here as well.

[...]
>>  
>> -	if (cpu_has_veic || cpu_has_vint)
>> +	if (cpu_has_veic || cpu_has_vint) {
>>  		ebase = (unsigned long) alloc_bootmem_low_pages(0x200 + VECTORSPACING*64);
>> -	else {
>> +	} else {
> 
> Checkpatch will complain about this, and it doesn't really add value to
> make the change.
> 

IANACPL (I am not a checkpatch lawyer), but I think it is correct.  If 
one clause of an if has braces they both should.  However that was left 
over from my debugging and if it were to be changed, should be part of a 
code cleanup patch.

>> diff --git a/arch/mips/mm/page.c b/arch/mips/mm/page.c
>> index 1417c64..0070aa0 100644
>> --- a/arch/mips/mm/page.c
>> +++ b/arch/mips/mm/page.c
>> @@ -687,3 +687,9 @@ void copy_page(void *to, void *from)
>>  }
>>  
>>  #endif /* CONFIG_SIBYTE_DMA_PAGEOPS */
>> +
>> +#ifdef CONFIG_MAPPED_KERNEL
>> +/* Initialized so it is not clobbered when .bss is zeroed.  */
>> +unsigned long phys_to_kernel_offset = 1;
>> +unsigned long kernel_image_end = 1;
>> +#endif
> 
> Clearly there is some magic happening here, but the such wizardry needs
> more documentation.

Clearly.

> I can deduce that these must be overwritten before
> we get to kernel_entry;

One of the first things done at kernel_entry is to zero out .bss, if you 
want to communicate with things that happen before kernel_entry, you 
cannot use .bss.

> who sets these?

The code in kernel-entry-init.h

> I don't know for sure what kernel_image_end is, but I am guessing that
> it is the physical address of the end of the kernel.

It is the virtual address of the first page past the kernel's virtual 
mapping.  This is where we can start mapping modules.

David Daney
