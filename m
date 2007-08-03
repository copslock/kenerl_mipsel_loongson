Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 03 Aug 2007 14:51:55 +0100 (BST)
Received: from [222.92.8.141] ([222.92.8.141]:50068 "HELO lemote.com")
	by ftp.linux-mips.org with SMTP id S20023907AbXHCNvx (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Fri, 3 Aug 2007 14:51:53 +0100
Received: (qmail 28992 invoked by uid 511); 3 Aug 2007 13:56:31 -0000
Received: from unknown (HELO ?192.168.2.233?) (192.168.2.233)
  by lemote.com with SMTP; 3 Aug 2007 13:56:31 -0000
Message-ID: <46B332AC.8020403@lemote.com>
Date:	Fri, 03 Aug 2007 21:50:36 +0800
From:	Songmao Tian <tiansm@lemote.com>
User-Agent: Icedove 1.5.0.8 (X11/20061116)
MIME-Version: 1.0
To:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
CC:	alsa-devel@alsa-project.org, linux-mips@linux-mips.org,
	greg@kroah.com, Dajie Tan <jiankemeng@gmail.com>
Subject: Re: ALSA on MIPS platform
References: <46B03CC0.3090000@lemote.com> <20070802.235606.122255120.anemo@mba.ocn.ne.jp>
In-Reply-To: <20070802.235606.122255120.anemo@mba.ocn.ne.jp>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <tiansm@lemote.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 16053
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: tiansm@lemote.com
Precedence: bulk
X-list: linux-mips

Atsushi Nemoto wrote:
> On Wed, 01 Aug 2007 15:56:48 +0800, Songmao Tian <tiansm@lemote.com> wrote:
>   
>>     The problem is clear:
>> 1. dma_alloc_noncoherent() return a non-cached address, and 
>> virt_to_page() need a cached logical addr (Have I named it right?)
>> 2. mmaped dam buffer should be non-cached.
>>
>> We have a ugly patch, but we want to solve the problem cleanly, so can 
>> anyone show me the way?
>>     
>
> virt_to_page() is used in many place in mm so making it robust might
> affect performance.  IMHO virt_to_page() seems too low-level as DMA
> API.
>
> If something like dma_virt_to_page(dev, cpu_addr) which can take a cpu
> address returned by dma_xxx APIs was defined, MIPS can implement it
> appropriately.
>
> And then pgprot_noncached issues still exist...
>
> ---
> Atsushi Nemoto
>
>
>
>   

I agree, and I am investigating to implement a dma_map_coherent, but It 
seems dma_map_coherent doesn't solve all the problem and will change a 
lot of code:(


dma_virt_to_page can be something like this.

diff --git a/include/asm-mips/page.h b/include/asm-mips/page.h
index b92dd8c..d2ead8a 100644
--- a/include/asm-mips/page.h
+++ b/include/asm-mips/page.h
@@ -181,6 +181,8 @@ typedef struct { unsigned long pgprot; } pgprot_t;
 #define virt_to_page(kaddr)    pfn_to_page(PFN_DOWN(virt_to_phys(kaddr)))
 #define virt_addr_valid(kaddr)    pfn_valid(PFN_DOWN(virt_to_phys(kaddr)))
 
+#define dma_virt_to_page(dma_addr) 
pfn_to_page(PFN_DOWN(virt_to_phys(CAC_ADDR(kaddr))))
+
 #define VM_DATA_DEFAULT_FLAGS    (VM_READ | VM_WRITE | VM_EXEC | \
                  VM_MAYREAD | VM_MAYWRITE | VM_MAYEXEC)
 
diff --git a/include/linux/mm.h b/include/linux/mm.h
index 655094d..5e694dd 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -39,6 +39,10 @@ extern int sysctl_legacy_va_layout;
 #include <asm/pgtable.h>
 #include <asm/processor.h>
 
+#ifndef dma_virt_to_page
+#define dma_virt_to_page virt_to_page
+#endif
+
 #define nth_page(page,n) pfn_to_page(page_to_pfn((page)) + (n))
 
 /*
diff --git a/sound/core/sgbuf.c b/sound/core/sgbuf.c
index cefd228..8b29bfd 100644
--- a/sound/core/sgbuf.c
+++ b/sound/core/sgbuf.c
@@ -91,7 +91,7 @@ void *snd_malloc_sgbuf_pages(struct device *device,
         }
         sgbuf->table[i].buf = tmpb.area;
         sgbuf->table[i].addr = tmpb.addr;
-        sgbuf->page_table[i] = virt_to_page(tmpb.area);
+        sgbuf->page_table[i] = dma_virt_to_page(tmpb.area);
         sgbuf->pages++;
     }
 
