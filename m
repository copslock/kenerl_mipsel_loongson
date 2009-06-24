Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 25 Jun 2009 00:22:10 +0200 (CEST)
Received: from smtp.zeugmasystems.com ([70.79.96.174]:26353 "EHLO
	zeugmasystems.com" rhost-flags-OK-OK-OK-FAIL) by ftp.linux-mips.org
	with ESMTP id S1493227AbZFXWWD convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Thu, 25 Jun 2009 00:22:03 +0200
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: Broadcom Swarm support
Date:	Wed, 24 Jun 2009 15:18:24 -0700
Message-ID: <DDFD17CC94A9BD49A82147DDF7D545C501C3539B@exchange.ZeugmaSystems.local>
In-Reply-To: <20090624063453.GA16846@volta.aurel32.net>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Broadcom Swarm support
Thread-Index: Acn0lhh9LwS3qtpPRkGfCc/Y9v371wAW+1vg
From:	"Kaz Kylheku" <KKylheku@zeugmasystems.com>
To:	"Aurelien Jarno" <aurelien@aurel32.net>,
	<linux-mips@linux-mips.org>
Return-Path: <KKylheku@zeugmasystems.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 23493
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: KKylheku@zeugmasystems.com
Precedence: bulk
X-list: linux-mips

Aurelien Jarno wrote:
> Hi all,
> 
> I am still trying to get a Broadcom Swarm boot on a recent kernel. I
> have made some progress, but I am now stuck on another problem.
> 
> I am using a lmo 2.6.30 kernel, using the defconfig 

[ snip ]

> | Kernel panic - not syncing: Attempted to kill init!
> | Rebooting in 5 seconds..Passing control back to CFE...

What kernel were you running prior to trying 30?

When I migrated from 2.6.17 to 2.6.26, on a Broadcom
1480 based board, I discovered that there is some kind
of instruction cache problem, which causes userland to
fetch garbage instead of code from its mmap-ped executables.
I could not get init to execute successfully.

Sorry, I can no longer remember whether this problem was
SMP specific or not (like what you're experiencing);
it might have been.

At some point in the kernel history, Ralfie decided that
the flush_icache_page function is unnecessary and
turned it into a MIPS-wide noop. But the SB1 core, which has
a VIVT instruction cache, it appears that there
is some kind of issue whereby when it
is handling a fault for a not-present virtual page,
it somehow ends up with bad data in the instruction
cache---perhaps an inconsistent state due to not having
been able to complete the fetch, but having initiated
a cache update on the expectation that the fetch
will complete. It seems that the the fault handler
is expected to do a flush.

Anyway, see if you can work this patch (based on 2.6.26)
into your kernel, and report whether it makes any difference.

Index: include/asm-mips/cacheflush.h
===================================================================
--- include/asm-mips/cacheflush.h	(revision 2677)
+++ include/asm-mips/cacheflush.h	(revision 2678)
@@ -37,6 +37,7 @@
 	unsigned long start, unsigned long end);
 extern void (*flush_cache_page)(struct vm_area_struct *vma, unsigned
long page, unsigned long pfn);
 extern void __flush_dcache_page(struct page *page);
+extern void __flush_icache_page(struct vm_area_struct *vma, struct page
*page);
 
 static inline void flush_dcache_page(struct page *page)
 {
@@ -57,11 +58,6 @@
 		__flush_anon_page(page, vmaddr);
 }
 
-static inline void flush_icache_page(struct vm_area_struct *vma,
-	struct page *page)
-{
-}
-
 extern void (*flush_icache_range)(unsigned long start, unsigned long
end);
 
 extern void (*__flush_cache_vmap)(void);
@@ -93,6 +89,13 @@
 extern void (*local_flush_data_cache_page)(void * addr);
 extern void (*flush_data_cache_page)(unsigned long addr);
 
+static inline void flush_icache_page(struct vm_area_struct *vma,
+	struct page *page)
+{
+        __flush_icache_page(vma, page);
+}
+
+
 /*
  * This flag is used to indicate that the page pointed to by a pte
  * is dirty and requires cleaning before returning it to the user.
Index: arch/mips/mm/cache.c
===================================================================
--- arch/mips/mm/cache.c	(revision 2677)
+++ arch/mips/mm/cache.c	(revision 2678)
@@ -93,6 +93,14 @@
 
 EXPORT_SYMBOL(__flush_dcache_page);
 
+void __flush_icache_page(struct vm_area_struct *vma, struct page *page)
+{
+	if (vma->vm_flags & VM_EXEC)
+		flush_icache_range((unsigned long) page_address(page),
PAGE_SIZE); 
+}
+
+EXPORT_SYMBOL(__flush_icache_page);
+
 void __flush_anon_page(struct page *page, unsigned long vmaddr)
 {
 	unsigned long addr = (unsigned long) page_address(page);
