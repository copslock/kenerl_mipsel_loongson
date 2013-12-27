Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 27 Dec 2013 20:20:58 +0100 (CET)
Received: from mga09.intel.com ([134.134.136.24]:43332 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6824763Ab3L0TUw0ZADk (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 27 Dec 2013 20:20:52 +0100
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga102.jf.intel.com with ESMTP; 27 Dec 2013 11:16:50 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.95,562,1384329600"; 
   d="scan'208";a="430782225"
Received: from unknown (HELO rizzo.int.wil.cx) ([10.255.12.21])
  by orsmga001.jf.intel.com with ESMTP; 27 Dec 2013 11:20:41 -0800
Received: by rizzo.int.wil.cx (Postfix, from userid 1000)
        id 3838A172477; Fri, 27 Dec 2013 14:20:41 -0500 (EST)
Date:   Fri, 27 Dec 2013 14:20:41 -0500
From:   Matthew Wilcox <willy@linux.intel.com>
To:     David Miller <davem@davemloft.net>
Cc:     linux-mm@kvack.org, sparclinux@vger.kernel.org,
        linux-parisc@vger.kernel.org, linux-mips@linux-mips.org
Subject: Re: [PATCH] remap_file_pages needs to check for cache coherency
Message-ID: <20131227192041.GD4945@linux.intel.com>
References: <20131227180018.GC4945@linux.intel.com>
 <20131227.134814.345379118522548543.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20131227.134814.345379118522548543.davem@davemloft.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
Return-Path: <willy@linux.intel.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 38809
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: willy@linux.intel.com
Precedence: bulk
List-help: <mailto:ecartis@linux-mips.org?Subject=help>
List-unsubscribe: <mailto:ecartis@linux-mips.org?subject=unsubscribe%20linux-mips>
List-software: Ecartis version 1.0.0
List-Id: linux-mips <linux-mips.eddie.linux-mips.org>
X-List-ID: linux-mips <linux-mips.eddie.linux-mips.org>
List-subscribe: <mailto:ecartis@linux-mips.org?subject=subscribe%20linux-mips>
List-owner: <mailto:ralf@linux-mips.org>
List-post: <mailto:linux-mips@linux-mips.org>
List-archive: <http://www.linux-mips.org/archives/linux-mips/>
X-list: linux-mips

On Fri, Dec 27, 2013 at 01:48:14PM -0500, David Miller wrote:
> From: Matthew Wilcox <willy@linux.intel.com>
> Date: Fri, 27 Dec 2013 13:00:18 -0500
> 
> > It seems to me that while (for example) on SPARC, it's not possible to
> > create a non-coherent mapping with mmap(), after we've done an mmap,
> > we can then use remap_file_pages() to create a mapping that no longer
> > aliases in the D-cache.
> > 
> > I have only compile-tested this patch.  I don't have any SPARC hardware,
> > and my PA-RISC hardware hasn't been turned on in six years ... I noticed
> > this while wandering around looking at some other stuff.
> 
> I suppose this is needed, but only in the case where the mapping is
> shared and writable, right?  I don't see you testing those conditions,
> but with them I'd be OK with this change.

VM_SHARED is checked a few lines above; too far to be visible in the
original context diff:

        if (!vma || !(vma->vm_flags & VM_SHARED))
                goto out;
 
        if (!vma->vm_ops || !vma->vm_ops->remap_pages)
                goto out;
 
        if (start < vma->vm_start || start + size > vma->vm_end)
                goto out;
 
+#ifdef __ARCH_FORCE_SHMLBA
+       /* Is the mapping cache-coherent? */
+       if ((pgoff ^ linear_page_index(vma, start)) &
+           ((SHMLBA-1) >> PAGE_SHIFT))
+               goto out;
+#endif

I don't understand why we need to check for writable here.  We don't
seem to check VM_WRITE in arch_get_unmapped_area(), so I don't see why
we should be checking it here.  Put it another way; if I mmap() a file
with PROT_READ only, should I be able to see stale data after another
thread has written to it?
