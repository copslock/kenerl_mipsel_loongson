Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 13 May 2008 12:44:21 +0100 (BST)
Received: from ti-out-0910.google.com ([209.85.142.190]:37947 "EHLO
	ti-out-0910.google.com") by ftp.linux-mips.org with ESMTP
	id S20026560AbYEMLoR (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 13 May 2008 12:44:17 +0100
Received: by ti-out-0910.google.com with SMTP id i7so1052929tid.20
        for <linux-mips@linux-mips.org>; Tue, 13 May 2008 04:44:07 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:references;
        bh=dn2BE7P+H+N4GeUsJqM2MsHuEmIVhBC5qPsXYyAjcxQ=;
        b=aNe6uNC04CCYwVvIX+ukd+x1AjH742A0h9Ec7cwU0NGOE6lwOOIiTGIqLGCKfcQL/tFuhKiNRMh5iEyxiuvMK4tFbirzgSCYYK3V0zlWbti6bfeei4yHAA/mOQmYhEd6vzWI8zfj8XJirYTpjrt5VfcYVSt8M5anwNLQlPhtoeo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:references;
        b=glIMajaW4mFdyasP1yxs1Vtyjur8A+kZUQwYy/Yyy4IeI2rcPg4YJneDQJcXl23EPX+a9HFqYIaGi8DuFxaiDhYf9CB86q4HoX3RcNXaJPj6eiXyahLC3qI2ltSXPXp+Z7YAkKLKTSIiclkwazZyxQBjisqFOHjD8NIyQjg1Onk=
Received: by 10.110.7.18 with SMTP id 18mr948994tig.39.1210679047035;
        Tue, 13 May 2008 04:44:07 -0700 (PDT)
Received: by 10.110.42.3 with HTTP; Tue, 13 May 2008 04:44:06 -0700 (PDT)
Message-ID: <50c9a2250805130444u4218654bw66f6158ba10b2b92@mail.gmail.com>
Date:	Tue, 13 May 2008 19:44:06 +0800
From:	zhuzhenhua <zzh.hust@gmail.com>
To:	"Ralf Baechle" <ralf@linux-mips.org>
Subject: Re: is remap_pfn_range should align to 2(n) * (page size) ?
Cc:	linux-mips <linux-mips@linux-mips.org>
In-Reply-To: <20080512112233.GA8843@linux-mips.org>
MIME-Version: 1.0
Content-Type: multipart/alternative; 
	boundary="----=_Part_11279_1669912.1210679047031"
References: <50c9a2250805082354x1edc1ecar89dcc3378b3bbe75@mail.gmail.com>
	 <20080509095605.GB14450@linux-mips.org>
	 <50c9a2250805111918r16913139obfc2982220636b3@mail.gmail.com>
	 <20080512112233.GA8843@linux-mips.org>
Return-Path: <zzh.hust@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 19248
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: zzh.hust@gmail.com
Precedence: bulk
X-list: linux-mips

------=_Part_11279_1669912.1210679047031
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On 5/12/08, Ralf Baechle <ralf@linux-mips.org> wrote:
>
> On Mon, May 12, 2008 at 10:18:27AM +0800, zhuzhenhua wrote:
>
> > > This has nothing to do with remap_pfn_range but with the power of two
> > > sized buckets used by the global free page pool.  Any allocation with
> > > get_free_pages will be rounded up to the next power of two.  If that's
> a
> > > real concern for you you could allocate a 4MB page then split the page
> > > into a 2MB and two 1MB pages and free the 1MB page again.
>
>
> > thanks for your reply , i see in get_frree_pages and free_pages there is
> a
> > get_order(size).
> > but i don't understand  " allocate a 4MB page then split the page
> > into a 2MB and two 1MB pages and free the 1MB page again."
> > is there any function to split it?
>
>
> No, you'd have to code that yourself.  Take a look at split_page() which
> splits an order n page into order 0 pages.  You'd want something similar
> but splitting for some non-zero order.
>
>
>   Ralf


thanks for your advice, i found in newest kernel version, in some arch , the
dma_alloc_coherent will call split_page.
because my kernel version is 2.6.14, so i first patch a split_page patch as
follow:
http://www.kernel.org/pub/linux/kernel/people/npiggin/patches/lockless/2.6.16-rc5/broken-out/mm-split-highorder.patch

but it seemes that there is still no split_page in
dma_alloc_coherent/dma_alloc_noncoherent
so i copy from other arch code to arch/mips/mm/dma-noncoherent.c (attach at
the end of mail)
and now my driver just use dma_alloc_coherent malloc 3M directly, and it
seemes ok.
i just wonder why mips arch dma_alloc_coherent/dma_alloc_nocoherent do not
call split_page while other arch calling.

thanks for any hints.

Best Regards

zzh






modify on dma-noncoherent.c
--- dma-noncoherent.c    2008-05-13 19:31:58.131375500 +0800
+++ dma-noncoherent-split.c    2008-05-13 19:31:51.039745500 +0800
@@ -16,27 +16,59 @@

 #include <asm/cache.h>
 #include <asm/io.h>
+
+static struct page *__dma_alloc(struct device *dev, size_t size,
+                dma_addr_t *handle, gfp_t gfp)
+{
+    struct page *page, *free, *end;
+    int order;
+
+    size = PAGE_ALIGN(size);
+    order = get_order(size);
+    page = alloc_pages(gfp, order);
+    if (!page)
+        return NULL;
+    split_page(page, order);
+
+    *handle = page_to_phys(page);
+    free = page + (size >> PAGE_SHIFT);
+    end = page + (1 << order);

-/*
- * Warning on the terminology - Linux calls an uncached area coherent;
- * MIPS terminology calls memory areas with hardware maintained coherency
- * coherent.
- */
+    /*
+     * Free any unused pages
+     */
+    while (free < end) {
+        __free_page(free);
+        free++;
+    }
+
+    return page;
+}
+
+static void __dma_free(struct device *dev, size_t size,
+               struct page *page, dma_addr_t handle)
+{
+    struct page *end = page + (PAGE_ALIGN(size) >> PAGE_SHIFT);

+    while (page < end)
+        __free_page(page++);
+}
 void *dma_alloc_noncoherent(struct device *dev, size_t size,
     dma_addr_t * dma_handle, unsigned int __nocast gfp)
 {
+    struct page *page;
     void *ret;
     /* ignore region specifiers */
     gfp &= ~(__GFP_DMA | __GFP_HIGHMEM);

     if (dev == NULL || (dev->coherent_dma_mask < 0xffffffff))
         gfp |= GFP_DMA;
-    ret = (void *) __get_free_pages(gfp, get_order(size));
-
+    page = __dma_alloc(dev, size, dma_handle, gfp);
+    if (page)
+        ret = KSEG1ADDR(page_to_phys(page));
+    printk("ret in dma_alloc_noncoherent = 0x%x\n",ret);
     if (ret != NULL) {
         memset(ret, 0, size);
-        *dma_handle = virt_to_phys(ret);
     }

     return ret;
@@ -63,19 +95,17 @@
 void dma_free_noncoherent(struct device *dev, size_t size, void *vaddr,
     dma_addr_t dma_handle)
 {
-    free_pages((unsigned long) vaddr, get_order(size));
+    void *addr = KSEG0ADDR(vaddr);
+    struct page *page;
+    BUG_ON(!virt_addr_valid(addr));
+    page = virt_to_page(addr);
+    __dma_free(dev, size, page, dma_handle);
 }

 EXPORT_SYMBOL(dma_free_noncoherent);

 void dma_free_coherent(struct device *dev, size_t size, void *vaddr,
-    dma_addr_t dma_handle)
-{
-    unsigned long addr = (unsigned long) vaddr;
-
-    addr = CAC_ADDR(addr);
-    free_pages(addr, get_order(size));
-}
+    dma_addr_t dma_handle) __attribute__((alias("dma_free_noncoherent")));

 EXPORT_SYMBOL(dma_free_coherent);

------=_Part_11279_1669912.1210679047031
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

<br><br><div><span class="gmail_quote">On 5/12/08, <b class="gmail_sendername">Ralf Baechle</b> &lt;<a href="mailto:ralf@linux-mips.org">ralf@linux-mips.org</a>&gt; wrote:</span><blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">
On Mon, May 12, 2008 at 10:18:27AM +0800, zhuzhenhua wrote:<br> <br> &gt; &gt; This has nothing to do with remap_pfn_range but with the power of two<br> &gt; &gt; sized buckets used by the global free page pool.&nbsp;&nbsp;Any allocation with<br>
 &gt; &gt; get_free_pages will be rounded up to the next power of two.&nbsp;&nbsp;If that&#39;s a<br> &gt; &gt; real concern for you you could allocate a 4MB page then split the page<br> &gt; &gt; into a 2MB and two 1MB pages and free the 1MB page again.<br>
 <br> <br>&gt; thanks for your reply , i see in get_frree_pages and free_pages there is a<br> &gt; get_order(size).<br> &gt; but i don&#39;t understand&nbsp;&nbsp;&quot; allocate a 4MB page then split the page<br> &gt; into a 2MB and two 1MB pages and free the 1MB page again.&quot;<br>
 &gt; is there any function to split it?<br> <br> <br>No, you&#39;d have to code that yourself.&nbsp;&nbsp;Take a look at split_page() which<br> splits an order n page into order 0 pages.&nbsp;&nbsp;You&#39;d want something similar<br> but splitting for some non-zero order.<br>
 <br><br>&nbsp;&nbsp;Ralf</blockquote><div><br>
thanks for your advice, i found in newest kernel version, in some arch , the dma_alloc_coherent will call split_page.<br>
because my kernel version is 2.6.14, so i first patch a split_page patch as follow:<br>
<a href="http://www.kernel.org/pub/linux/kernel/people/npiggin/patches/lockless/2.6.16-rc5/broken-out/mm-split-highorder.patch">http://www.kernel.org/pub/linux/kernel/people/npiggin/patches/lockless/2.6.16-rc5/broken-out/mm-split-highorder.patch</a><br>

<br>
but it seemes that there is still no split_page in dma_alloc_coherent/dma_alloc_noncoherent<br>
so i copy from other arch code to arch/mips/mm/dma-noncoherent.c (attach at the end of mail)<br>
and now my driver just use dma_alloc_coherent malloc 3M directly, and it seemes ok.<br>
i just wonder why mips arch dma_alloc_coherent/dma_alloc_nocoherent do not call split_page while other arch calling.<br>
<br>
thanks for any hints.<br>
<br>
Best Regards<br>
<br>
zzh<br>
<br>
<br>
<br>
<br>
<br>
<br>
modify on dma-noncoherent.c<br>
--- dma-noncoherent.c&nbsp;&nbsp;&nbsp; 2008-05-13 19:31:58.131375500 +0800<br>
+++ dma-noncoherent-split.c&nbsp;&nbsp;&nbsp; 2008-05-13 19:31:51.039745500 +0800<br>
@@ -16,27 +16,59 @@<br>
&nbsp;<br>
&nbsp;#include &lt;asm/cache.h&gt;<br>
&nbsp;#include &lt;asm/io.h&gt;<br>
+ <br>
+static struct page *__dma_alloc(struct device *dev, size_t size,<br>
+&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; dma_addr_t *handle, gfp_t gfp)<br>
+{<br>
+&nbsp;&nbsp;&nbsp; struct page *page, *free, *end;<br>
+&nbsp;&nbsp;&nbsp; int order;<br>
+<br>
+&nbsp;&nbsp;&nbsp; size = PAGE_ALIGN(size);<br>
+&nbsp;&nbsp;&nbsp; order = get_order(size);<br>
+&nbsp;&nbsp;&nbsp; page = alloc_pages(gfp, order);<br>
+&nbsp;&nbsp;&nbsp; if (!page)<br>
+&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; return NULL;<br>
+&nbsp;&nbsp;&nbsp; split_page(page, order);<br>
+<br>
+&nbsp;&nbsp;&nbsp; *handle = page_to_phys(page);<br>
+&nbsp;&nbsp;&nbsp; free = page + (size &gt;&gt; PAGE_SHIFT);<br>
+&nbsp;&nbsp;&nbsp; end = page + (1 &lt;&lt; order);<br>
&nbsp;<br>
-/*<br>
- * Warning on the terminology - Linux calls an uncached area coherent;<br>
- * MIPS terminology calls memory areas with hardware maintained coherency<br>
- * coherent.<br>
- */<br>
+&nbsp;&nbsp;&nbsp; /*<br>
+&nbsp;&nbsp;&nbsp; &nbsp;* Free any unused pages<br>
+&nbsp;&nbsp;&nbsp; &nbsp;*/<br>
+&nbsp;&nbsp;&nbsp; while (free &lt; end) {<br>
+&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; __free_page(free);<br>
+&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; free++;<br>
+&nbsp;&nbsp;&nbsp; }<br>
+<br>
+&nbsp;&nbsp;&nbsp; return page;<br>
+}<br>
+<br>
+static void __dma_free(struct device *dev, size_t size,<br>
+&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct page *page, dma_addr_t handle)<br>
+{<br>
+&nbsp;&nbsp;&nbsp; struct page *end = page + (PAGE_ALIGN(size) &gt;&gt; PAGE_SHIFT);<br>
&nbsp;<br>
+&nbsp;&nbsp;&nbsp; while (page &lt; end)<br>
+&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; __free_page(page++);<br>
+}&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
<br>
&nbsp;void *dma_alloc_noncoherent(struct device *dev, size_t size,<br>
&nbsp;&nbsp;&nbsp;&nbsp; dma_addr_t * dma_handle, unsigned int __nocast gfp)<br>
&nbsp;{<br>
+&nbsp;&nbsp;&nbsp; struct page *page;&nbsp; &nbsp;&nbsp;&nbsp; <br>
&nbsp;&nbsp;&nbsp;&nbsp; void *ret;<br>
&nbsp;&nbsp;&nbsp;&nbsp; /* ignore region specifiers */<br>
&nbsp;&nbsp;&nbsp;&nbsp; gfp &amp;= ~(__GFP_DMA | __GFP_HIGHMEM);<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp; if (dev == NULL || (dev-&gt;coherent_dma_mask &lt; 0xffffffff))<br>
&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; gfp |= GFP_DMA;<br>
-&nbsp;&nbsp;&nbsp; ret = (void *) __get_free_pages(gfp, get_order(size));<br>
-<br>
+&nbsp;&nbsp;&nbsp; page = __dma_alloc(dev, size, dma_handle, gfp);<br>
+&nbsp;&nbsp;&nbsp; if (page)<br>
+&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; ret = KSEG1ADDR(page_to_phys(page));<br>
+&nbsp;&nbsp;&nbsp; printk(&quot;ret in dma_alloc_noncoherent = 0x%x\n&quot;,ret);<br>
&nbsp;&nbsp;&nbsp;&nbsp; if (ret != NULL) {<br>
&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; memset(ret, 0, size);<br>
-&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; *dma_handle = virt_to_phys(ret);<br>
&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp; return ret;<br>
@@ -63,19 +95,17 @@<br>
&nbsp;void dma_free_noncoherent(struct device *dev, size_t size, void *vaddr,<br>
&nbsp;&nbsp;&nbsp;&nbsp; dma_addr_t dma_handle)<br>
&nbsp;{<br>
-&nbsp;&nbsp;&nbsp; free_pages((unsigned long) vaddr, get_order(size));<br>
+&nbsp;&nbsp;&nbsp; void *addr = KSEG0ADDR(vaddr);<br>
+&nbsp;&nbsp;&nbsp; struct page *page;<br>
+&nbsp;&nbsp;&nbsp; BUG_ON(!virt_addr_valid(addr));<br>
+&nbsp;&nbsp;&nbsp; page = virt_to_page(addr);<br>
+&nbsp;&nbsp;&nbsp; __dma_free(dev, size, page, dma_handle);&nbsp; <br>
&nbsp;}<br>
&nbsp;<br>
&nbsp;EXPORT_SYMBOL(dma_free_noncoherent);<br>
&nbsp;<br>
&nbsp;void dma_free_coherent(struct device *dev, size_t size, void *vaddr,<br>
-&nbsp;&nbsp;&nbsp; dma_addr_t dma_handle)<br>
-{<br>
-&nbsp;&nbsp;&nbsp; unsigned long addr = (unsigned long) vaddr;<br>
-<br>
-&nbsp;&nbsp;&nbsp; addr = CAC_ADDR(addr);<br>
-&nbsp;&nbsp;&nbsp; free_pages(addr, get_order(size));<br>
-}<br>
+&nbsp;&nbsp;&nbsp; dma_addr_t dma_handle) __attribute__((alias(&quot;dma_free_noncoherent&quot;)));<br>
&nbsp;<br>
&nbsp;EXPORT_SYMBOL(dma_free_coherent);<br>
&nbsp;<br>
<br>
&nbsp;</div><br></div><br>

------=_Part_11279_1669912.1210679047031--
