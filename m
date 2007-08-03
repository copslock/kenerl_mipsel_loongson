Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 03 Aug 2007 16:57:29 +0100 (BST)
Received: from [222.92.8.141] ([222.92.8.141]:17564 "HELO lemote.com")
	by ftp.linux-mips.org with SMTP id S20023929AbXHCP51 (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Fri, 3 Aug 2007 16:57:27 +0100
Received: (qmail 16074 invoked by uid 511); 3 Aug 2007 16:03:03 -0000
Received: from unknown (HELO ?192.168.2.233?) (192.168.2.233)
  by lemote.com with SMTP; 3 Aug 2007 16:03:03 -0000
Message-ID: <46B35053.8050307@lemote.com>
Date:	Fri, 03 Aug 2007 23:57:07 +0800
From:	Songmao Tian <tiansm@lemote.com>
User-Agent: Icedove 1.5.0.8 (X11/20061116)
MIME-Version: 1.0
To:	Takashi Iwai <tiwai@suse.de>
CC:	linux-mips@linux-mips.org, Atsushi Nemoto <anemo@mba.ocn.ne.jp>,
	alsa-devel@alsa-project.org, Dajie Tan <jiankemeng@gmail.com>,
	greg@kroah.com
Subject: Re: [alsa-devel] ALSA on MIPS platform
References: <46B03CC0.3090000@lemote.com>	<20070802.235606.122255120.anemo@mba.ocn.ne.jp>	<46B332AC.8020403@lemote.com> <s5habt8ra5l.wl%tiwai@suse.de>
In-Reply-To: <s5habt8ra5l.wl%tiwai@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <tiansm@lemote.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 16058
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: tiansm@lemote.com
Precedence: bulk
X-list: linux-mips

Takashi Iwai wrote:
> At Fri, 03 Aug 2007 21:50:36 +0800,
> Songmao Tian wrote:
>   
>> Atsushi Nemoto wrote:
>>     
>>> On Wed, 01 Aug 2007 15:56:48 +0800, Songmao Tian <tiansm@lemote.com> wrote:
>>>   
>>>       
>>>>     The problem is clear:
>>>> 1. dma_alloc_noncoherent() return a non-cached address, and 
>>>> virt_to_page() need a cached logical addr (Have I named it right?)
>>>> 2. mmaped dam buffer should be non-cached.
>>>>
>>>> We have a ugly patch, but we want to solve the problem cleanly, so can 
>>>> anyone show me the way?
>>>>     
>>>>         
>>> virt_to_page() is used in many place in mm so making it robust might
>>> affect performance.  IMHO virt_to_page() seems too low-level as DMA
>>> API.
>>>
>>> If something like dma_virt_to_page(dev, cpu_addr) which can take a cpu
>>> address returned by dma_xxx APIs was defined, MIPS can implement it
>>> appropriately.
>>>
>>> And then pgprot_noncached issues still exist...
>>>
>>> ---
>>> Atsushi Nemoto
>>>
>>>
>>>
>>>   
>>>       
>> I agree, and I am investigating to implement a dma_map_coherent, but It 
>> seems dma_map_coherent doesn't solve all the problem and will change a 
>> lot of code:(
>>     
>
> It won't be that much.  You'll need to change snd_pcm_default_mmap()
> in sound/core/pcm_native.c to call dma_mmap_coherent() directly
> instead of nopage ops.  But, this won't work with SG-buffers, which
> requires some more additional works.
>
>
> Takashi
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
>
>
>   
I have no idea if the patch can work, the idea is not very clear now.
And I use vt686b ac97 sound driver, the driver use sgbuf, so I will 
write a test program tomorrow. Good sleep...:)

And if any of you can take some time look into the patch, and give some 
review will be appreciated:)

diff --git a/arch/mips/mm/dma-default.c b/arch/mips/mm/dma-default.c
index 76903c7..f088a6b 100644
--- a/arch/mips/mm/dma-default.c
+++ b/arch/mips/mm/dma-default.c
@@ -369,3 +369,23 @@ void dma_cache_sync(struct device *dev, void 
*vaddr, size_t size,
 }
 
 EXPORT_SYMBOL(dma_cache_sync);
+
+static int dma_mmap(struct device *dev, struct vm_area_struct *vma,
+            void *cpu_addr, dma_addr_t dma_addr, size_t size)
+{
+    if (remap_pfn_range(vma, vma->vm_start,
+                  PFN_DOWN(virt_to_phys(CAC_ADDR(cpu_addr))) + 
vma->vm_pgoff,
+                  vma->vm_end - vma->vm_start,
+                  vma->vm_page_prot))
+        return -EAGAIN;
+    return 0;
+}
+
+int dma_mmap_coherent(struct device *dev, struct vm_area_struct *vma,
+              void *cpu_addr, dma_addr_t dma_addr, size_t size)
+{
+    vma->vm_page_prot = pgprot_noncached(vma->vm_page_prot);
+    return dma_mmap(dev, vma, cpu_addr, dma_addr, size);
+}
+EXPORT_SYMBOL(dma_mmap_coherent);
+
diff --git a/sound/core/pcm_native.c b/sound/core/pcm_native.c
index 59b29cd..af82a3b 100644
--- a/sound/core/pcm_native.c
+++ b/sound/core/pcm_native.c
@@ -3152,6 +3152,8 @@ static struct vm_operations_struct 
snd_pcm_vm_ops_data =
     .close =    snd_pcm_mmap_data_close,
     .nopage =    snd_pcm_mmap_data_nopage,
 };
+int dma_mmap_coherent(struct device *dev, struct vm_area_struct *vma,
+              void *cpu_addr, dma_addr_t dma_addr, size_t size);
 
 /*
  * mmap the DMA buffer on RAM
@@ -3159,9 +3161,10 @@ static struct vm_operations_struct 
snd_pcm_vm_ops_data =
 static int snd_pcm_default_mmap(struct snd_pcm_substream *substream,
                 struct vm_area_struct *area)
 {
-    area->vm_ops = &snd_pcm_vm_ops_data;
+    struct snd_pcm_runtime *runtime = substream->runtime;
     area->vm_private_data = substream;
-    area->vm_flags |= VM_RESERVED;
+    dma_mmap_coherent(NULL, area, runtime->dma_area,
+            runtime->dma_addr, runtime->dma_bytes);
     atomic_inc(&substream->mmap_count);
     return 0;
 }
