Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 21 May 2009 06:29:24 +0100 (BST)
Received: from rex.securecomputing.com ([203.24.151.4]:57065 "EHLO
	cyberguard.com.au" rhost-flags-OK-OK-OK-FAIL) by ftp.linux-mips.org
	with ESMTP id S20021890AbZEUF3R (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Thu, 21 May 2009 06:29:17 +0100
Received: from localhost (localhost.localdomain [127.0.0.1])
	by bne.snapgear.com (Postfix) with ESMTP id 53D9CEBBAF;
	Thu, 21 May 2009 15:29:09 +1000 (EST)
X-Virus-Scanned: amavisd-new at snapgear.com
Received: from bne.snapgear.com ([127.0.0.1])
	by localhost (bne.snapgear.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id wdqekw4vx1yL; Thu, 21 May 2009 15:29:08 +1000 (EST)
Received: from [10.46.12.2] (unknown [10.46.12.2])
	by bne.snapgear.com (Postfix) with ESMTP;
	Thu, 21 May 2009 15:29:08 +1000 (EST)
Message-ID: <4A14E6A1.4030700@snapgear.com>
Date:	Thu, 21 May 2009 15:29:05 +1000
From:	Greg Ungerer <gerg@snapgear.com>
User-Agent: Thunderbird 2.0.0.19 (X11/20090105)
MIME-Version: 1.0
To:	Ralf Baechle <ralf@linux-mips.org>
CC:	linux-mips@linux-mips.org
Subject: Re: system lockup with 2.6.29 on Cavium/Octeon
References: <4A139F50.7050409@snapgear.com> <20090520142604.GA29677@linux-mips.org>
In-Reply-To: <20090520142604.GA29677@linux-mips.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <gerg@snapgear.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 22901
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: gerg@snapgear.com
Precedence: bulk
X-list: linux-mips

Hi Ralf,

Ralf Baechle wrote:
> On Wed, May 20, 2009 at 04:12:32PM +1000, Greg Ungerer wrote:
> 
>> I have a system lockup problem that I have been looking at on a custom
>> Cavium/Octeon 5010 based design. I am running on linux-2.6.29 with
>> David Daney's latest round of PCI and ethernet patches (posted here
>> on this list).
>>
>> I have tracked the problem back to local_flush_tlb_kernel_range() in
>> arch/mips/mm/tlb-r4k.c. At the top of this function is:
>>
>>     void local_flush_tlb_kernel_range(unsigned long start, unsigned long 
>> end)
>>     {
>>         unsigned long flags;
>>         int size;
>>
>>         ENTER_CRITICAL(flags);
>>         size = (end - start + (PAGE_SIZE - 1)) >> PAGE_SHIFT;
>>         size = (size + 1) >> 1;
>>         if (size <= current_cpu_data.tlbsize / 2) {
>>
>> The problem is that typical example values I see passed in for start
>> and end are:
>>
>>     start = c000000000006000
>>     end   = ffffffffc01d8000
>>
>> Now the vmalloc area starts at 0xc000000000000000 and the kernel code
>> and data is all at 0xffffffff80000000 and above. I don't know if the
>> start and end are reasonable values, but I can see some logic as to
>> where they come from. The code path that leads to this is via
>> __vunmap() and __purge_vmap_area_lazy(). So it is not too difficult
>> to see how we end up with values like this.
> 
> Either start or end address is sensible but not the combination - both
> addresses should be in the same segment.  Start is in XKSEG, end in CKSEG2
> and in between there are vast wastelands of unused address space exabytes
> in size.

Yes, exactly, that looked odd to me too.

So I tracked it back to see how these both ended up being in there.
It turns out that MODULE_START, as defined in
arch/mips/include/asm/pgtable-64.h, is CKSSEG, so it is
0xffffffffc0000000 in my case. And VMALLOC_START/MAP_BASE is
defined to be 0xc000000000000000.

In module_alloc() there is a call to __get_vm_area() with MODULE_START
as the start address, and this is how the 0xfff... addresses end up in
the vmap_area table. The usual vmalloc() calls use VMALLOC_START and
that is how the 0xc000... addresses get into the vmap_area table.

Interestingly the definition of MODULE_START is like this:

#if defined(CONFIG_MODULES) && defined(KBUILD_64BIT_SYM32) && \
         VMALLOC_START != CKSSEG
/* Load modules into 32bit-compatible segment. */
#define MODULE_START    CKSSEG


If MODULE_START wasn't defined then the module_alloc() code would
have just called vmalloc() directly - and we wouldn't be in this
mess :-)


>> But the size calculation above with these types of values will result
>> in still a large number. Larger than the 32bit "int" that is "size".
>> I see large negative values fall out as size, and so the following
>> tlbsize check becomes true, and the code spins inside the loop inside
>> that if statement for a _very_ long time trying to flush tlb entries.
>>
>> This is of course easily fixed, by making that size "unsigned long".
>> The patch below trivially does this.
>>
>> But is this analysis correct?
> 
> Yes - but I think we have two issues here.  The one is the calculation
> overflowing int for the arguments you're seeing.  The other being that
> the arguments simply are looking wrong.
> 
> There are a few more instances of the same overflow issue which the patch
> below is fixing.

Indeed, looks good.

Regards
Greg



>   Ralf
> 
> 
>  arch/mips/mm/tlb-r3k.c |    6 ++----
>  arch/mips/mm/tlb-r4k.c |    6 ++----
>  arch/mips/mm/tlb-r8k.c |    3 +--
>  3 files changed, 5 insertions(+), 10 deletions(-)
> 
> diff --git a/arch/mips/mm/tlb-r3k.c b/arch/mips/mm/tlb-r3k.c
> index f0cf46a..1c0048a 100644
> --- a/arch/mips/mm/tlb-r3k.c
> +++ b/arch/mips/mm/tlb-r3k.c
> @@ -82,8 +82,7 @@ void local_flush_tlb_range(struct vm_area_struct *vma, unsigned long start,
>  	int cpu = smp_processor_id();
>  
>  	if (cpu_context(cpu, mm) != 0) {
> -		unsigned long flags;
> -		int size;
> +		unsigned long size, flags;
>  
>  #ifdef DEBUG_TLB
>  		printk("[tlbrange<%lu,0x%08lx,0x%08lx>]",
> @@ -121,8 +120,7 @@ void local_flush_tlb_range(struct vm_area_struct *vma, unsigned long start,
>  
>  void local_flush_tlb_kernel_range(unsigned long start, unsigned long end)
>  {
> -	unsigned long flags;
> -	int size;
> +	unsigned long size, flags;
>  
>  #ifdef DEBUG_TLB
>  	printk("[tlbrange<%lu,0x%08lx,0x%08lx>]", start, end);
> diff --git a/arch/mips/mm/tlb-r4k.c b/arch/mips/mm/tlb-r4k.c
> index 9619f66..892be42 100644
> --- a/arch/mips/mm/tlb-r4k.c
> +++ b/arch/mips/mm/tlb-r4k.c
> @@ -117,8 +117,7 @@ void local_flush_tlb_range(struct vm_area_struct *vma, unsigned long start,
>  	int cpu = smp_processor_id();
>  
>  	if (cpu_context(cpu, mm) != 0) {
> -		unsigned long flags;
> -		int size;
> +		unsigned long size, flags;
>  
>  		ENTER_CRITICAL(flags);
>  		size = (end - start + (PAGE_SIZE - 1)) >> PAGE_SHIFT;
> @@ -160,8 +159,7 @@ void local_flush_tlb_range(struct vm_area_struct *vma, unsigned long start,
>  
>  void local_flush_tlb_kernel_range(unsigned long start, unsigned long end)
>  {
> -	unsigned long flags;
> -	int size;
> +	unsigned long size, flags;
>  
>  	ENTER_CRITICAL(flags);
>  	size = (end - start + (PAGE_SIZE - 1)) >> PAGE_SHIFT;
> diff --git a/arch/mips/mm/tlb-r8k.c b/arch/mips/mm/tlb-r8k.c
> index 4f01a3b..4ec95cc 100644
> --- a/arch/mips/mm/tlb-r8k.c
> +++ b/arch/mips/mm/tlb-r8k.c
> @@ -111,8 +111,7 @@ out_restore:
>  /* Usable for KV1 addresses only! */
>  void local_flush_tlb_kernel_range(unsigned long start, unsigned long end)
>  {
> -	unsigned long flags;
> -	int size;
> +	unsigned long size, flags;
>  
>  	size = (end - start + (PAGE_SIZE - 1)) >> PAGE_SHIFT;
>  	size = (size + 1) >> 1;
> 

-- 
------------------------------------------------------------------------
Greg Ungerer  --  Principal Engineer        EMAIL:     gerg@snapgear.com
SnapGear Group, McAfee                      PHONE:       +61 7 3435 2888
825 Stanley St,                             FAX:         +61 7 3891 3630
Woolloongabba, QLD, 4102, Australia         WEB: http://www.SnapGear.com
