Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 27 Jun 2013 11:39:36 +0200 (CEST)
Received: from localhost.localdomain ([127.0.0.1]:51816 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S6824769Ab3F0JjehpwIj (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 27 Jun 2013 11:39:34 +0200
Received: from scotty.linux-mips.net (localhost.localdomain [127.0.0.1])
        by scotty.linux-mips.net (8.14.5/8.14.4) with ESMTP id r5R9dORn000547;
        Thu, 27 Jun 2013 11:39:24 +0200
Received: (from ralf@localhost)
        by scotty.linux-mips.net (8.14.5/8.14.5/Submit) id r5R9dH9S000546;
        Thu, 27 Jun 2013 11:39:17 +0200
Date:   Thu, 27 Jun 2013 11:39:17 +0200
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Veli-Pekka Peltola <veli-pekka.peltola@bluegiga.com>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mips@linux-mips.org, Russell King <linux@arm.linux.org.uk>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Rusty Russell <rusty@rustcorp.com.au>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH v2] mm: module_alloc: check if size is 0
Message-ID: <20130627093917.GQ7171@linux-mips.org>
References: <1330631119-10059-1-git-send-email-veli-pekka.peltola@bluegiga.com>
 <1331125768-25454-1-git-send-email-veli-pekka.peltola@bluegiga.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1331125768-25454-1-git-send-email-veli-pekka.peltola@bluegiga.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 37164
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
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

Warming up an ancient thread because the discussion seems to have just
stalled at some point and I still have this patch bitrotting in patchwork.

The original thread can be found at:

  http://www.linux-mips.org/archives/linux-mips/2012-03/msg00006.html
  http://www.linux-mips.org/archives/linux-mips/2012-03/msg00028.html

On Wed, Mar 07, 2012 at 03:09:28PM +0200, Veli-Pekka Peltola wrote:

> After commit de7d2b567d040e3b67fe7121945982f14343213d (mm/vmalloc.c: report
> more vmalloc failures) users will get a warning if vmalloc_node_range() is
> called with size 0. This happens if module's init size equals to 0. This
> patch changes ARM, MIPS and x86 module_alloc() to return NULL before calling
> vmalloc_node_range() that would also return NULL and print a warning.
> 
> Signed-off-by: Veli-Pekka Peltola <veli-pekka.peltola@bluegiga.com>
> Cc: Russell King <linux@arm.linux.org.uk>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: "H. Peter Anvin" <hpa@zytor.com>
> Cc: x86@kernel.org
> ---
> I found this with ARM but after checking out various implementations of
> module_alloc() I thought it would be better to fix all at once.
> 
> One way to replicate the warning:
> compile kernel with CONFIG_KALLSYMS=n
> insmod a module without init, I used usb-common.ko

I didn't try to reproduce the issue but the code in question doesn't seem
to have changed so the issue should still persist.

Imho de7d2b567d040e3b67fe7121945982f14343213d [mm/vmalloc.c: report more
vmalloc failures] is overly strict in that it also reports zero-sized
allocations.  I consider such allocations stupid but legitimiate and often
better preferrable over having to scatter checks for zero size all over
place.  So maybe something like below patch?

Thanks,

  Ralf
---

Signed-off-by: Ralf Baechle <ralf@linux-mips.org>

 mm/vmalloc.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/mm/vmalloc.c b/mm/vmalloc.c
index d365724..e58ca10 100644
--- a/mm/vmalloc.c
+++ b/mm/vmalloc.c
@@ -1679,7 +1679,10 @@ void *__vmalloc_node_range(unsigned long size, unsigned long align,
 	unsigned long real_size = size;
 
 	size = PAGE_ALIGN(size);
-	if (!size || (size >> PAGE_SHIFT) > totalram_pages)
+	if (unlikely(!size))
+		return NULL;
+
+	if ((size >> PAGE_SHIFT) > totalram_pages)
 		goto fail;
 
 	area = __get_vm_area_node(size, align, VM_ALLOC | VM_UNLIST,
@@ -1711,6 +1714,7 @@ fail:
 	warn_alloc_failed(gfp_mask, 0,
 			  "vmalloc: allocation failure: %lu bytes\n",
 			  real_size);
+
 	return NULL;
 }
 
