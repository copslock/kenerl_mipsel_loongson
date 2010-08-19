Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 20 Aug 2010 01:30:15 +0200 (CEST)
Received: from sj-iport-4.cisco.com ([171.68.10.86]:22336 "EHLO
        sj-iport-4.cisco.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S1491018Ab0HSXaL (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 20 Aug 2010 01:30:11 +0200
Authentication-Results: sj-iport-4.cisco.com; dkim=neutral (message not signed) header.i=none
X-IronPort-AV: E=Sophos;i="4.56,236,1280707200"; 
   d="scan'208";a="174372968"
Received: from sj-core-1.cisco.com ([171.71.177.237])
  by sj-iport-4.cisco.com with ESMTP; 19 Aug 2010 23:30:03 +0000
Received: from msundius-lnx1.corp.sa.net (dhcp-171-71-47-156.cisco.com [171.71.47.156])
        by sj-core-1.cisco.com (8.13.8/8.14.3) with ESMTP id o7JNU32N018509;
        Thu, 19 Aug 2010 23:30:03 GMT
Message-ID: <4C6DBE76.8050907@cisco.com>
Date:   Thu, 19 Aug 2010 16:29:58 -0700
From:   Michael Sundius <msundius@cisco.com>
User-Agent: Thunderbird 2.0.0.23 (X11/20090825)
MIME-Version: 1.0
To:     David VomLehn <dvomlehn@cisco.com>
CC:     naveen yadav <yad.naveen@gmail.com>,
        Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
        sshtylyov@mvista.com
Subject: Re: sparsemem support on MIPS
References: <AANLkTinURQyZgp7bzogjYGzLc5-CyDRGyGo9Hz=pUFFF@mail.gmail.com> <20100819230613.GA10992@dvomlehn-lnx2.corp.sa.net>
In-Reply-To: <20100819230613.GA10992@dvomlehn-lnx2.corp.sa.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <msundius@cisco.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 27653
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: msundius@cisco.com
Precedence: bulk
X-list: linux-mips

David VomLehn wrote:
> On Thu, Aug 19, 2010 at 09:04:21PM +0530, naveen yadav wrote:
>   
>>  Dear all,
>>
>> I build MIPS 32 with sparsemem support to take care of holes in
>> physical memory, this conserve memory but put overhead to speed
>> because of pointer redirection in pfn_to_page().
>>
>> To prevent this conversion I tried to use
>> CONFIG_SPARSEMEM_VMEMMAP_ENABLE on MIPS 32 but kernel build fails
>> becauase most of the supported functions related to vmemmap are
>> supported for 64 bit architectures only.
>>
>> I wish to compare memory and speed result with / without
>> CONFIG_SPARSEMEM_VMEMMAP_ENABLE in MIPS 32. I need your comment in it
>> ?
>>     
>
> We use sparse memory and submitted a patch some while ago to add support,
> but it died for lack of interest. The patch was relative to a kernel
> from several released ago; I don't know whether it would apply to
> the tip. I can see if I track it down.
>   
Please find my original patch below. Note that we also tried to use the 
virtually mapped
sparsemem but failed.

for the vmemmap sparse support, one thing I found was you need to do 
paging_init() before sparse_init(). I also made lots of changes
to arch/mips/mm/init.c (some specific to our own changes others generic) 
and moved a few things in header files around.

I can probably (tomorrow) create a patch of my changes that I made (that 
never worked) for the vmemmap support. I'd love to revisit this
one find day and get it to actually work, but I seemed at the time to 
get stuck without any clue how to move it forward.

some collaboration would be greatfully appreciated.

Mike


    Looks great to me.  I can't test it, of course, but I don't see any
    problems with it.

    Signed-off-by: Dave Hansen <dave@linux.vnet.ibm.com>

    -- Dave
     


 > Otherwise it looks good to me.  I see from the rest of the thread that
 > there is some discussion over the sizes of these, with that sorted.
 >
 > Acked-by: Andy Whitcroft <apw@shadowen.org>
 >
 > -apw
 >  
attached is my most recent patch with I *think* everyones requests for it.

------------------------------------------------------------------------

diff --git a/Documentation/sparsemem.txt b/Documentation/sparsemem.txt
new file mode 100644
index 0000000..0b36412
--- /dev/null
+++ b/Documentation/sparsemem.txt
@@ -0,0 +1,92 @@
+Sparsemem divides up physical memory in your system into N sections of M
+bytes. Page tables are created for only those sections that
+actually exist (as far as the sparsemem code is concerned). This allows
+for holes in the physical memory without having to waste space by
+creating page descriptors for those pages that do not exist.
+When page_to_pfn() or pfn_to_page() are called there is a bit of overhead to
+look up the proper memory section to get to the page_table, but this
+is small compared to the memory you are likely to save. So, it's not the
+default, but should be used if you have big holes in physical memory.
+
+Note that discontiguous memory is more closely related to NUMA machines
+and if you are a single CPU system use sparsemem and not discontig. 
+It's much simpler. 
+
+1) CALL MEMORY_PRESENT()
+Existing sections are recorded once the bootmem allocator is up and running by
+calling the sparsemem function "memory_present(node, pfn_start, pfn_end)" for each
+block of memory that exists in your physical address space. The
+memory_present() function records valid sections in a data structure called
+mem_section[].
+
+2) DETERMINE AND SET THE SIZE OF SECTIONS AND PHYSMEM
+The size of N and M above depend upon your architecture
+and your platform and are specified in the file:
+
+      include/asm-<your_arch>/sparsemem.h
+
+and you should create the following lines similar to below: 
+
+	#ifdef CONFIG_YOUR_PLATFORM
+	 #define SECTION_SIZE_BITS       27	/* 128 MiB */
+	#endif
+	#define MAX_PHYSMEM_BITS        31	/* 2 GiB   */
+
+if they don't already exist, where: 
+
+ * SECTION_SIZE_BITS            2^M: how big each section will be
+ * MAX_PHYSMEM_BITS             2^N: how much memory we can have in that
+                                     space
+
+3) INITIALIZE SPARSE MEMORY
+You should make sure that you initialize the sparse memory code by calling 
+
+	bootmem_init();
+  +	sparse_init();
+	paging_init();
+
+just before you call paging_init() and after the bootmem_allocator is
+turned on in your setup_arch() code.  
+
+4) ENABLE SPARSEMEM IN KCONFIG
+Add a line like this:
+
+	select ARCH_SPARSEMEM_ENABLE
+
+into the config for your platform in arch/<your_arch>/Kconfig. This will
+ensure that turning on sparsemem is enabled for your platform. 
+
+5) CONFIG
+Run make *config, as you like, and turn on the sparsemem
+memory model under the "Kernel Type" --> "Memory Model" and then build your
+kernel.
+
+
+6) Gotchas
+
+One trick that I encountered when I was turning this on for MIPS was that there
+was some code in mem_init() that set the "reserved" flag for pages that were not
+valid RAM. This caused my kernel to crash when I enabled sparsemem since those
+pages (and page descriptors) didn't actually exist. I changed my code by adding
+lines like below:
+
+
+	for (tmp = highstart_pfn; tmp < highend_pfn; tmp++) {
+		struct page *page = pfn_to_page(tmp);
+
+   +		if (!pfn_valid(tmp))
+   +			continue;
+   +
+		if (!page_is_ram(tmp)) {
+			SetPageReserved(page);
+			continue;
+		}
+		ClearPageReserved(page);
+		init_page_count(page);
+		__free_page(page);
+		physmem_record(PFN_PHYS(tmp), PAGE_SIZE, physmem_highmem);
+		totalhigh_pages++;
+	}
+
+
+Once I got that straight, it worked!!!! I saved 10MiB of memory.  
diff --git a/arch/mips/kernel/setup.c b/arch/mips/kernel/setup.c
index f8a535a..6ff0f72 100644
--- a/arch/mips/kernel/setup.c
+++ b/arch/mips/kernel/setup.c
@@ -405,7 +405,6 @@ static void __init bootmem_init(void)
 
 		/* Register lowmem ranges */
 		free_bootmem(PFN_PHYS(start), size << PAGE_SHIFT);
-		memory_present(0, start, end);
 	}
 
 	/*
@@ -417,6 +416,23 @@ static void __init bootmem_init(void)
 	 * Reserve initrd memory if needed.
 	 */
 	finalize_initrd();
+
+	/* call memory present for all the ram */
+	for (i = 0; i < boot_mem_map.nr_map; i++) {
+		unsigned long start, end;
+
+		/*
+ * 		 * memory present only usable memory.
+ * 		 		 */
+		if (boot_mem_map.map[i].type != BOOT_MEM_RAM)
+			continue;
+
+		start = PFN_UP(boot_mem_map.map[i].addr);
+		end   = PFN_DOWN(boot_mem_map.map[i].addr
+				    + boot_mem_map.map[i].size);
+
+		memory_present(0, start, end);
+	}
 }
 
 #endif	/* CONFIG_SGI_IP27 */
diff --git a/arch/mips/mm/init.c b/arch/mips/mm/init.c
index 480dec0..9bc6d35 100644
--- a/arch/mips/mm/init.c
+++ b/arch/mips/mm/init.c
@@ -417,6 +417,9 @@ void __init mem_init(void)
 	for (tmp = highstart_pfn; tmp < highend_pfn; tmp++) {
 		struct page *page = pfn_to_page(tmp);
 
+		if (!pfn_valid(tmp))
+			continue;
+
 		if (!page_is_ram(tmp)) {
 			SetPageReserved(page);
 			continue;
diff --git a/include/asm-mips/sparsemem.h b/include/asm-mips/sparsemem.h
index 795ac6c..67245cb 100644
--- a/include/asm-mips/sparsemem.h
+++ b/include/asm-mips/sparsemem.h
@@ -6,7 +6,7 @@
  * SECTION_SIZE_BITS		2^N: how big each section will be
  * MAX_PHYSMEM_BITS		2^N: how much memory we can have in that space
  */
-#define SECTION_SIZE_BITS       28
+#define SECTION_SIZE_BITS       27
 #define MAX_PHYSMEM_BITS        35
 
 #endif /* CONFIG_SPARSEMEM */
