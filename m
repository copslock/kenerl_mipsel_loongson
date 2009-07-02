Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 03 Jul 2009 01:28:20 +0200 (CEST)
Received: from h5.dl5rb.org.uk ([81.2.74.5]:53072 "EHLO h5.dl5rb.org.uk"
	rhost-flags-OK-OK-OK-OK) by ftp.linux-mips.org with ESMTP
	id S1492302AbZGBX2N (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 3 Jul 2009 01:28:13 +0200
Received: from h5.dl5rb.org.uk (localhost.localdomain [127.0.0.1])
	by h5.dl5rb.org.uk (8.14.3/8.14.3) with ESMTP id n62NM7PN017769;
	Fri, 3 Jul 2009 00:22:07 +0100
Received: (from ralf@localhost)
	by h5.dl5rb.org.uk (8.14.3/8.14.3/Submit) id n62NM5qJ017767;
	Fri, 3 Jul 2009 00:22:05 +0100
Date:	Fri, 3 Jul 2009 00:22:05 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Wu Zhangjin <wuzhangjin@gmail.com>
Cc:	LKML <linux-kernel@vger.kernel.org>, linux-mips@linux-mips.org,
	Pavel Machek <pavel@ucw.cz>, Wu Zhangjin <wuzj@lemote.com>
Subject: Re: [PATCH] [MIPS] Hibernation: only save pages in system ram
Message-ID: <20090702232205.GE14804@linux-mips.org>
References: <1246373570-21090-1-git-send-email-wuzhangjin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1246373570-21090-1-git-send-email-wuzhangjin@gmail.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
Return-Path: <ralf@h5.dl5rb.org.uk>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 23635
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Tue, Jun 30, 2009 at 10:52:50PM +0800, Wu Zhangjin wrote:

> From: Wu Zhangjin <wuzj@lemote.com>
> 
> when using hibernation(STD) with CONFIG_FLATMEM in linux-mips-64bit, it
> fails for the current mips-specific hibernation implementation save the
> pages in all of the memory space(except the nosave section) and make
> there will be not enough memory left to the STD task itself, and then
> fail. in reality, we only need to save the pages in system rams.
> 
> here is the reason why it fail:
> 
> kernel/power/snapshot.c:
> 
> static void mark_nosave_pages(struct memory_bitmap *bm)
> {
> 		...
> 		if (pfn_valid(pfn)) {
> 			...
> 		}
> }
> 
> arch/mips/include/asm/page.h:
> 
> 	...
> 	#ifdef CONFIG_FLATMEM
> 
> 	#define pfn_valid(pfn)		((pfn) >= ARCH_PFN_OFFSET && (pfn) < max_mapnr)
> 
> 	#elif defined(CONFIG_SPARSEMEM)
> 
> 	/* pfn_valid is defined in linux/mmzone.h */
> 	...
> 
> we can rewrite pfn_valid(pfn) to fix this problem, but I really do not
> want to touch such a widely-used macro, so, I used another solution:
> 
> static struct page *saveable_page(struct zone *zone, unsigned long pfn)
> {
> 	...
> 	if ( .... pfn_is_nosave(pfn)
> 		return NULL;
> 	...
> }
> 
> and pfn_is_nosave is implemented in arch/mips/power/cpu.c, so, hacking
> this one is better.

No - pfn_valid() is broken, so it should be fixed.  Commit
752fbeb2e3555c0d236e992f1195fd7ce30e728d introduced the breakage.  It
seemed to assume that the valid range for PFNs doesn't start at 0 but
some higher number but got that entirely wrong..

#define ARCH_PFN_OFFSET         PFN_UP(PHYS_OFFSET)
#define pfn_valid(pfn)         ((pfn) >= ARCH_PFN_OFFSET && (pfn) < max_mapnr)

works nicely when PHYS_OFFSET is 0 - as for most MIPS systems and goes
horribly wrong otherwise.  So I suggest below patch.

  Ralf

Signed-off-by: Ralf Baechle <ralf@linux-mips.org>

 arch/mips/include/asm/page.h |    9 ++++++++-
 1 files changed, 8 insertions(+), 1 deletions(-)

diff --git a/arch/mips/include/asm/page.h b/arch/mips/include/asm/page.h
index dc0eaa7..96a14a4 100644
--- a/arch/mips/include/asm/page.h
+++ b/arch/mips/include/asm/page.h
@@ -165,7 +165,14 @@ typedef struct { unsigned long pgprot; } pgprot_t;
 
 #ifdef CONFIG_FLATMEM
 
-#define pfn_valid(pfn)		((pfn) >= ARCH_PFN_OFFSET && (pfn) < max_mapnr)
+#define pfn_valid(pfn)							\
+({									\
+	unsigned long __pfn = (pfn);					\
+	/* avoid <linux/bootmem.h> include hell */			\
+	extern unsigned long min_low_pfn;				\
+									\
+	__pfn >= min_low_pfn && __pfn < max_mapnr;			\
+})
 
 #elif defined(CONFIG_SPARSEMEM)
 
