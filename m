Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 29 Sep 2006 15:45:22 +0100 (BST)
Received: from wr-out-0506.google.com ([64.233.184.230]:46135 "EHLO
	wr-out-0506.google.com") by ftp.linux-mips.org with ESMTP
	id S20039235AbWI2OpT (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 29 Sep 2006 15:45:19 +0100
Received: by wr-out-0506.google.com with SMTP id i20so296003wra
        for <linux-mips@linux-mips.org>; Fri, 29 Sep 2006 07:45:18 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:in-reply-to:references:mime-version:content-type:message-id:cc:from:subject:date:to:x-mailer;
        b=dxU9cjMjBdhim4j/32+a0qwmbCEJy32JAMJsHRwGJx+q4JPQ4yRQvXi6piYw4Zm49H3E4GnskRNtA9fpW541W4W7jQvAbPdZ4XA/1bK2bnluvG7nRS0JT86YBt51mfifsmU9VObasnTM6FSgN3OZ/Su/cR6BQtmJhh3+Nc1hMs8=
Received: by 10.90.34.9 with SMTP id h9mr1543737agh;
        Fri, 29 Sep 2006 07:45:18 -0700 (PDT)
Received: from ?192.168.1.3? ( [61.125.212.22])
        by mx.gmail.com with ESMTP id 36sm1362631nza.2006.09.29.07.45.16;
        Fri, 29 Sep 2006 07:45:17 -0700 (PDT)
In-Reply-To: <20060928232956.GE3394@linux-mips.org>
References: <20060928.003542.21929658.anemo@mba.ocn.ne.jp> <C140DCAC.7A1C%girishvg@gmail.com> <20060928232956.GE3394@linux-mips.org>
Mime-Version: 1.0 (Apple Message framework v749)
Content-Type: multipart/mixed; boundary=Apple-Mail-1-845285869
Message-Id: <B3C723F6-A2B3-4A0E-88BB-FF36AB58FFB4@gmail.com>
Cc:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>,
	Ralf Baechle <ralf@linux-mips.org>
From:	girish <girishvg@gmail.com>
Subject: Re: PATCH] cleanup hardcoding __pa/__va macros etc. (take-5)
Date:	Fri, 29 Sep 2006 23:45:12 +0900
To:	linux-mips@linux-mips.org
X-Mailer: Apple Mail (2.749)
Return-Path: <girishvg@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 12741
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: girishvg@gmail.com
Precedence: bulk
X-list: linux-mips


--Apple-Mail-1-845285869
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	charset=US-ASCII;
	delsp=yes;
	format=flowed


On Sep 29, 2006, at 8:29 AM, Ralf Baechle wrote:

> On Thu, Sep 28, 2006 at 01:58:02AM +0900, girish wrote:
>> Date:	Thu, 28 Sep 2006 01:58:02 +0900
>> Subject: PATCH] cleanup hardcoding __pa/__va macros etc. (take-4)
>> From:	girish <girishvg@gmail.com>
>> To:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
>> CC:	"linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
>> 	girish <girishvg@gmail.com>
>> Content-type: multipart/mixed;
>> 	boundary="B_3242253489_7379959"
>>
>>
>>> Using just plain text and adding Signed-off-by line would be  
>>> preferred.
>>> Also your patch seems against neither latest lmo nor kernel.org  
>>> tree...
>>
>> The kernel sources I was referring to were 2.6.17-rc6.
>>
>>
>>>> In the meantime, I couldn't find the changes suggested for  
>>>> SPARSEMEM support
>>>> in the main source tree. Especially the ones reviewed during  
>>>> month of August
>>>> ([PATCH] do not count pages in holes with sparsemem ...). Could  
>>>> you please
>>>> resend the consolidated patch to the list? Thanks.
>>>
>>> August?  I sent the patch with that title in July and applied  
>>> already.
>>>
>>> http://www.linux-mips.org/git?p=linux.git;a=commit;h=239367b4
>>
>> Again, I was referring to older sources, that is 2.6.17-rc6. I  
>> have just
>> upgraded reference sources to 2.6.18 as mentioned above & now I  
>> see the
>> changes. Thanks. In fact I am experimenting on highmem/sparsemem with
>> 2.6.16.16 kernel sources.
>>
>>
>> Please find attached patch created from 2.6.18 (kernel.org) tree.  
>> Let me
>> know if this is alright.
>>
>> Signed-off-by: Girish V. Gulawani <girishvg@gmail.com>
>
> -#ifdef CONFIG_ISA
> -	if (low < max_dma)
> +	if (low < max_dma) }
>
> This doesn't quite compile.
>

Stupid mistake. Fixed & resending.

Signed-off-by: Girish V. Gulawani <girishvg@gmail.com>


--Apple-Mail-1-845285869
Content-Transfer-Encoding: 7bit
Content-Type: application/octet-stream;
	x-unix-mode=0644;
	name="patch-pavafix-20060929"
Content-Disposition: attachment;
	filename=patch-pavafix-20060929

diff -uprN -X linux-vanilla/Documentation/dontdiff linux-vanilla/arch/mips/mm/dma-noncoherent.c linux/arch/mips/mm/dma-noncoherent.c
--- linux-vanilla/arch/mips/mm/dma-noncoherent.c	2006-09-20 12:42:06.000000000 +0900
+++ linux/arch/mips/mm/dma-noncoherent.c	2006-09-28 01:14:01.000000000 +0900
@@ -333,7 +333,7 @@ EXPORT_SYMBOL(pci_dac_page_to_dma);
 struct page *pci_dac_dma_to_page(struct pci_dev *pdev,
 	dma64_addr_t dma_addr)
 {
-	return mem_map + (dma_addr >> PAGE_SHIFT);
+	return pfn_to_page (dma_addr >> PAGE_SHIFT);
 }
 
 EXPORT_SYMBOL(pci_dac_dma_to_page);
diff -uprN -X linux-vanilla/Documentation/dontdiff linux-vanilla/arch/mips/mm/init.c linux/arch/mips/mm/init.c
--- linux-vanilla/arch/mips/mm/init.c	2006-09-20 12:42:06.000000000 +0900
+++ linux/arch/mips/mm/init.c	2006-09-29 23:38:04.000000000 +0900
@@ -180,24 +180,22 @@ void __init paging_init(void)
 	low = max_low_pfn;
 	high = highend_pfn;
 
-#ifdef CONFIG_ISA
-	if (low < max_dma)
+	if (low < max_dma) {
 		zones_size[ZONE_DMA] = low;
-	else {
+	} else {
 		zones_size[ZONE_DMA] = max_dma;
 		zones_size[ZONE_NORMAL] = low - max_dma;
 	}
-#else
-	zones_size[ZONE_DMA] = low;
-#endif
+
 #ifdef CONFIG_HIGHMEM
 	if (cpu_has_dc_aliases) {
 		printk(KERN_WARNING "This processor doesn't support highmem.");
 		if (high - low)
 			printk(" %ldk highmem ignored", high - low);
 		printk("\n");
-	} else
-		zones_size[ZONE_HIGHMEM] = high - low;
+	} else {
+		zones_size[ZONE_HIGHMEM] = high - highstart_pfn;
+	}
 #endif
 
 #ifdef CONFIG_FLATMEM
@@ -246,7 +244,7 @@ void __init mem_init(void)
 
 #ifdef CONFIG_HIGHMEM
 	for (tmp = highstart_pfn; tmp < highend_pfn; tmp++) {
-		struct page *page = mem_map + tmp;
+		struct page *page = pfn_to_page (tmp);
 
 		if (!page_is_ram(tmp)) {
 			SetPageReserved(page);
diff -uprN -X linux-vanilla/Documentation/dontdiff linux-vanilla/include/asm-mips/dma.h linux/include/asm-mips/dma.h
--- linux-vanilla/include/asm-mips/dma.h	2006-09-20 12:42:06.000000000 +0900
+++ linux/include/asm-mips/dma.h	2006-09-28 01:18:31.000000000 +0900
@@ -86,8 +86,13 @@
 /* Horrible hack to have a correct DMA window on IP22 */
 #include <asm/sgi/mc.h>
 #define MAX_DMA_ADDRESS		(PAGE_OFFSET + SGIMC_SEG0_BADDR + 0x01000000)
-#else
+#elif defined(CONFIG_ISA)
 #define MAX_DMA_ADDRESS		(PAGE_OFFSET + 0x01000000)
+#else
+#ifndef PLAT_MAX_DMA_SIZE
+#define PLAT_MAX_DMA_SIZE	0x10000000	/* 256MB: true on most of the MIPS32 systems */
+#endif
+#define MAX_DMA_ADDRESS		(PAGE_OFFSET + PLAT_MAX_DMA_SIZE)
 #endif
 
 /* 8237 DMA controllers */
diff -uprN -X linux-vanilla/Documentation/dontdiff linux-vanilla/include/asm-mips/io.h linux/include/asm-mips/io.h
--- linux-vanilla/include/asm-mips/io.h	2006-09-20 12:42:06.000000000 +0900
+++ linux/include/asm-mips/io.h	2006-09-28 01:20:22.000000000 +0900
@@ -115,7 +115,7 @@ static inline void set_io_port_base(unsi
  */
 static inline unsigned long virt_to_phys(volatile void * address)
 {
-	return (unsigned long)address - PAGE_OFFSET;
+	return __pa(address);
 }
 
 /*
@@ -132,7 +132,7 @@ static inline unsigned long virt_to_phys
  */
 static inline void * phys_to_virt(unsigned long address)
 {
-	return (void *)(address + PAGE_OFFSET);
+	return __va(address);
 }
 
 /*
@@ -140,12 +140,12 @@ static inline void * phys_to_virt(unsign
  */
 static inline unsigned long isa_virt_to_bus(volatile void * address)
 {
-	return (unsigned long)address - PAGE_OFFSET;
+	return __pa(address);
 }
 
 static inline void * isa_bus_to_virt(unsigned long address)
 {
-	return (void *)(address + PAGE_OFFSET);
+	return __va(address);
 }
 
 #define isa_page_to_bus page_to_phys
diff -uprN -X linux-vanilla/Documentation/dontdiff linux-vanilla/include/asm-mips/page.h linux/include/asm-mips/page.h
--- linux-vanilla/include/asm-mips/page.h	2006-09-20 12:42:06.000000000 +0900
+++ linux/include/asm-mips/page.h	2006-09-28 01:26:00.000000000 +0900
@@ -129,8 +129,15 @@ typedef struct { unsigned long pgprot; }
 /* to align the pointer to the (next) page boundary */
 #define PAGE_ALIGN(addr)	(((addr) + PAGE_SIZE - 1) & PAGE_MASK)
 
-#define __pa(x)			((unsigned long) (x) - PAGE_OFFSET)
-#define __va(x)			((void *)((unsigned long) (x) + PAGE_OFFSET))
+#ifdef CONFIG_32BIT
+#define ISMAPPED(x)		(KSEGX((x)) >= HIGHMEM_START && KSEGX((x)) < KSEG0)
+#else
+#define ISMAPPED(x)		(0)
+#endif
+#define ___pa(x)		((unsigned long) (x) - PAGE_OFFSET)
+#define __pa(x)			(ISMAPPED(x) ? (unsigned long)(x) : ___pa(x))
+#define ___va(x)		((void *)((unsigned long) (x) + PAGE_OFFSET))
+#define __va(x)			(ISMAPPED(x) ? (void*)(x) : ___va(x))
 
 #define pfn_to_kaddr(pfn)	__va((pfn) << PAGE_SHIFT)
 

--Apple-Mail-1-845285869
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	charset=US-ASCII;
	format=flowed




--Apple-Mail-1-845285869--
