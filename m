Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 09 Sep 2010 19:24:57 +0200 (CEST)
Received: from mail3.caviumnetworks.com ([12.108.191.235]:5407 "EHLO
        mail3.caviumnetworks.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491106Ab0IIRYx (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 9 Sep 2010 19:24:53 +0200
Received: from caexch01.caveonetworks.com (Not Verified[192.168.16.9]) by mail3.caviumnetworks.com with MailMarshal (v6,7,2,8378)
        id <B4c8918860000>; Thu, 09 Sep 2010 10:25:26 -0700
Received: from caexch01.caveonetworks.com ([192.168.16.9]) by caexch01.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.4675);
         Thu, 9 Sep 2010 10:24:52 -0700
Received: from dd1.caveonetworks.com ([12.108.191.236]) by caexch01.caveonetworks.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.4675);
         Thu, 9 Sep 2010 10:24:52 -0700
Message-ID: <4C891863.1080602@caviumnetworks.com>
Date:   Thu, 09 Sep 2010 10:24:51 -0700
From:   David Daney <ddaney@caviumnetworks.com>
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.11) Gecko/20100720 Fedora/3.0.6-1.fc12 Thunderbird/3.0.6
MIME-Version: 1.0
To:     Greg Ungerer <gerg@snapgear.com>
CC:     linux-mips@linux-mips.org, gerg@uclinux.org
Subject: Re: [PATCH] mips: fix start of free memory when using initrd
References: <201009080550.o885ohjD014188@goober.internal.moreton.com.au>
In-Reply-To: <201009080550.o885ohjD014188@goober.internal.moreton.com.au>
Content-Type: multipart/mixed;
 boundary="------------090501000204010407060404"
X-OriginalArrivalTime: 09 Sep 2010 17:24:52.0040 (UTC) FILETIME=[E97B6480:01CB5043]
X-archive-position: 27739
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@caviumnetworks.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                 
X-UID: 7433

This is a multi-part message in MIME format.
--------------090501000204010407060404
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

On 09/07/2010 10:50 PM, Greg Ungerer wrote:
>
> Hi All,
>
> I have a typical Cavium/Octeon (5010) based system, that I sometimes
> use a kernel and traditional initrd setup on. In a typical layout the
> kernel is loaded into low physical RAM (via boot loader) and the initrd
> is loaded somewhere above it. Everything runs fine, but the region
> occupied by the initrd is effectively lost from usable RAM.
>
> For example, with these boot args "rd_start=0x84000000 rd_size=0x00206000"
> where the initrd is loaded at 64MB (and is just over 2MB in size) I end
> up with:
>
> Memory: 59620k/127152k available (2193k kernel code, 67532k reserved, 563k data, 192k init, 0k highmem)
>
> Ouch!  A lot of RAM not usable.
>
> It looks to me that the logic of setting the bootmem is not quite right
> for the initrd case. If I patch arch/mips/kernel/setup.c with the patch
> below I get all that memory back, and everything seems to work:
>
> Memory: 121044k/127152k available (2193k kernel code, 6108k reserved, 563k data, 192k init, 0k highmem)
>
> The patch just sets the bootmem map to always be the end of the kernel.
> Then the bootmem reserve initrd logic does its work as expected.
> (A little more cleaning up could be done I guess, but I want to know
> the approach is correct first :-)
>
> Am I mis-understanding how this is supposed to work?
> Other architectures seem to set the bootmem to the end of the kernel.
> Sparc has some extra checks to make sure that the bootmem setup data
> doesn't overwrite the initrd, but otherwise is similar.
>
> Regards
> Greg
>
>
>
> mips: fix start of free memory when using initrd
>
> Currently when using an initrd on a MIPS system the start of the bootmem
> region of memory is set to the larger of the end of the kernel bss region
> (_end) or the end of the initrd. In a typical memory layout where the
> initrd is at some address above the kernel image this means that the
> start of the bootmem region will be the end of the initrd. But when
> we are done processing/loading the initrd we have no way to reclaim the
> memory region it occupied, and we lose a large chunk of now otherwise
> empty RAM from our final running system.
>
> The bootmem code is designed to allow this initrd to be reserved (and
> the code in finalize_initrd() currently does this). When the initrd is
> finally processed/loaded its reserved memory is freed.
>
> Fix the setting of the start of the bootmem map to be the end of the
> kernel.
>
> Signed-off-by: Greg Ungerer<gerg@uclinux.org>
> ---
>   arch/mips/kernel/setup.c |   11 ++++++-----
>   1 files changed, 6 insertions(+), 5 deletions(-)
>
> diff --git a/arch/mips/kernel/setup.c b/arch/mips/kernel/setup.c
> index 85aef3f..df8ed83 100644
> --- a/arch/mips/kernel/setup.c
> +++ b/arch/mips/kernel/setup.c
> @@ -259,12 +259,13 @@ static void __init bootmem_init(void)
>   	int i;
>
>   	/*
> -	 * Init any data related to initrd. It's a nop if INITRD is
> -	 * not selected. Once that done we can determine the low bound
> -	 * of usable memory.
> +	 * Sanity check any INITRD first. We don't take it into account
> +	 * for bootmem setup initially, rely on the end-of-kernel-code
> +	 * as our memory range starting point. Once bootmem is inited we
> +	 * will reserve the area used for the initrd.
>   	 */
> -	reserved_end = max(init_initrd(),
> -			   (unsigned long) PFN_UP(__pa_symbol(&_end)));
> +	init_initrd();
> +	reserved_end = (unsigned long) PFN_UP(__pa_symbol(&_end));
>
>   	/*
>   	 * max_low_pfn is not a number of pages. The number of pages
>
>

We have the attached patch (plus a few more hacks), I don't think it is 
universally safe to change the calculation of reserved_end.  Although 
the patch has some code formatting problems you might consider using it 
as a starting point.

David Daney




--------------090501000204010407060404
Content-Type: text/plain;
 name="initrd.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="initrd.patch"

commit 465b46e1f44e95c01e9a848ec061a6e6385cac4c
Author: Chandrakala Chavva <cchavva@caviumnetworks.com>
Date:   Fri May 14 14:57:41 2010 -0700

    MIPS: Octeon: Add Initrd from named memory block
    
    Boot rootfs from 'linux.initrd' named memory block if it is present.
    
    Signed-off-by: Chandrakala Chavva <cchavva@caviumnetworks.com>

diff --git a/arch/mips/cavium-octeon/setup.c b/arch/mips/cavium-octeon/setup.c
index 2cfe38b..c0bc62b 100644
--- a/arch/mips/cavium-octeon/setup.c
+++ b/arch/mips/cavium-octeon/setup.c
@@ -20,6 +20,9 @@
 #include <linux/platform_device.h>
 #include <linux/serial_core.h>
 #include <linux/serial_8250.h>
+#ifdef CONFIG_BLK_DEV_INITRD
+#include <linux/initrd.h>
+#endif
 
 #include <asm/processor.h>
 #include <asm/reboot.h>
@@ -769,10 +772,22 @@ void __init prom_init(void)
 void __init plat_mem_setup(void)
 {
 	uint64_t mem_alloc_size;
-	uint64_t total;
+	uint64_t total = 0;
 	int64_t memory;
 
-	total = 0;
+#ifdef CONFIG_BLK_DEV_INITRD
+	const cvmx_bootmem_named_block_desc_t *initrd_block;
+
+	initrd_block = cvmx_bootmem_find_named_block("linux.initrd");
+	if (initrd_block) {
+		initrd_start = initrd_block->base_addr + PAGE_OFFSET;
+		initrd_end = initrd_start + initrd_block->size;
+		add_memory_region(initrd_block->base_addr, initrd_block->size, 
+			BOOT_MEM_INIT_RAM);
+		initrd_in_reserved = 1;
+		total += initrd_block->size;
+	}
+#endif
 
 	/* First add the init memory we will be returning.  */
 	memory = __pa_symbol(&__init_begin) & PAGE_MASK;
diff --git a/arch/mips/include/asm/bootinfo.h b/arch/mips/include/asm/bootinfo.h
index f5dfaf6..2bd1e75 100644
--- a/arch/mips/include/asm/bootinfo.h
+++ b/arch/mips/include/asm/bootinfo.h
@@ -80,6 +80,7 @@ extern unsigned long mips_machtype;
 #define BOOT_MEM_RAM		1
 #define BOOT_MEM_ROM_DATA	2
 #define BOOT_MEM_RESERVED	3
+#define BOOT_MEM_INIT_RAM	4
 
 /*
  * A memory map that's built upon what was determined
@@ -95,6 +96,7 @@ struct boot_mem_map {
 };
 
 extern struct boot_mem_map boot_mem_map;
+extern int initrd_in_reserved;
 
 extern void add_memory_region(phys_t start, phys_t size, long type);
 
diff --git a/arch/mips/kernel/setup.c b/arch/mips/kernel/setup.c
index 2b290d7..dc41417 100644
--- a/arch/mips/kernel/setup.c
+++ b/arch/mips/kernel/setup.c
@@ -57,6 +57,7 @@ unsigned long mips_machtype __read_mostly = MACH_UNKNOWN;
 EXPORT_SYMBOL(mips_machtype);
 
 struct boot_mem_map boot_mem_map;
+int initrd_in_reserved;
 
 static char command_line[CL_SIZE];
        char arcs_cmdline[CL_SIZE]=CONFIG_CMDLINE;
@@ -116,6 +117,9 @@ static void __init print_memory_map(void)
 		case BOOT_MEM_RAM:
 			printk(KERN_CONT "(usable)\n");
 			break;
+		case BOOT_MEM_INIT_RAM:
+			printk("(usable after init)\n");
+			break;
 		case BOOT_MEM_ROM_DATA:
 			printk(KERN_CONT "(ROM data)\n");
 			break;
@@ -277,8 +281,13 @@ static void __init bootmem_init(void)
 	 * not selected. Once that done we can determine the low bound
 	 * of usable memory.
 	 */
-	reserved_end = max(init_initrd(),
-			   (unsigned long) PFN_UP(__pa_symbol(&_end)));
+	if (initrd_in_reserved) {
+		init_initrd();
+		reserved_end = PFN_UP(__pa_symbol(&_end));
+	} else {	
+		reserved_end = max(init_initrd(), 
+				(unsigned long) PFN_UP(__pa_symbol(&_end)));
+	}
 
 	/*
 	 * max_low_pfn is not a number of pages. The number of pages
@@ -293,8 +302,14 @@ static void __init bootmem_init(void)
 	for (i = 0; i < boot_mem_map.nr_map; i++) {
 		unsigned long start, end;
 
-		if (boot_mem_map.map[i].type != BOOT_MEM_RAM)
+		switch (boot_mem_map.map[i].type) {
+		case BOOT_MEM_RAM:
+		case BOOT_MEM_INIT_RAM:
+			break;
+		default:
+			/* Not usable memory */
 			continue;
+		}
 
 		start = PFN_UP(boot_mem_map.map[i].addr);
 		end = PFN_DOWN(boot_mem_map.map[i].addr
@@ -522,6 +537,7 @@ static void __init resource_init(void)
 		res = alloc_bootmem(sizeof(struct resource));
 		switch (boot_mem_map.map[i].type) {
 		case BOOT_MEM_RAM:
+		case BOOT_MEM_INIT_RAM:
 		case BOOT_MEM_ROM_DATA:
 			res->name = "System RAM";
 			break;
diff --git a/arch/mips/mm/init.c b/arch/mips/mm/init.c
index 3d90ccc..67fc152 100644
--- a/arch/mips/mm/init.c
+++ b/arch/mips/mm/init.c
@@ -305,9 +305,14 @@ static int __init page_is_ram(unsigned long pagenr)
 	for (i = 0; i < boot_mem_map.nr_map; i++) {
 		unsigned long addr, end;
 
-		if (boot_mem_map.map[i].type != BOOT_MEM_RAM)
+		switch (boot_mem_map.map[i].type) { 
+		case BOOT_MEM_RAM:
+		case BOOT_MEM_INIT_RAM:
+			break;
+		default:
 			/* not usable memory */
 			continue;
+		}
 
 		addr = PFN_UP(boot_mem_map.map[i].addr);
 		end = PFN_DOWN(boot_mem_map.map[i].addr +

--------------090501000204010407060404--
