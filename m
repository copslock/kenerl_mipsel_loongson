Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 20 Mar 2003 10:16:28 +0000 (GMT)
Received: from p508B6F73.dip.t-dialin.net ([IPv6:::ffff:80.139.111.115]:10404
	"EHLO dea.linux-mips.net") by linux-mips.org with ESMTP
	id <S8225073AbTCTKQ1>; Thu, 20 Mar 2003 10:16:27 +0000
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.11.6/8.11.6) id h2KAGPa14049
	for linux-mips@linux-mips.org; Thu, 20 Mar 2003 11:16:25 +0100
Date: Thu, 20 Mar 2003 11:16:25 +0100
From: Ralf Baechle <ralf@linux-mips.org>
To: linux-mips@linux-mips.org
Subject: Cache code changes
Message-ID: <20030320111625.A13219@linux-mips.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Return-Path: <ralf@linux-mips.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 1779
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

Thought I should drop a note about the recent cache code changes in the
Linux 2.4 and 2.5 code in CVS to explain what's going on.

flush_page_to_ram() has long been a deprecated interface and been scheduled
to be removed for years.  It's considered a inefficient, badly designed
interface.  It's use it for dealing with virtual aliases in the primary
cache.  That is whenever the memory managment code creates or modifies
a page that is mapped to userspace it has to writeback and invalidate the
kernel mapping of this page to avoid virtual aliases.

flush_page_to_ram() turned out to be a rather ad-hoc interface; the
obvious but inefficient interface approach.  It's also not capable of
fully dealing with all types of cache aliases like aliases between the
page cache and user mappings.  Which may lead to silent data corruption
and that's the reason why I'm doing such intrusive kernel surgery for a
supposedly stable kernel.  So there now is an alternative interface
available in the kernel, flush_dcache_page().  flush_dcache_page() is
implements a two stage approach.  It marks pages which are in the page
cache and therefore could possibly alias with userspace as possibly
residing in cache if it doesn't flush them immediately.  This allows
delaying cache flushes - possibly infinitely.  Which quite obviously is
a performance gain.

Side effect - some implementations of flush_icache_page() knew that it's
invocations are always preceeded by flush_page_to_ram() so the D-cache
flush can be omitted.  This is no longer there case.  Another bug fixed
along the way (but not yet for all processors) was flush_cache_page() not
flushing the instruction cache ...

Along with that I've also cleaned the cache code for R4000 and R4400 CPUs.
Continuing the mess seemed to be plain unmaintainable and at the same
time huge.  The heavily changed code (for your amusement now using a few
new code constructs :-) is now over 40% smaller meassure in LOCs and about
2/3 smaller in code size and should make it fairly easy to add support for
strange beasts such as TX39, TX49 or R5432 style caches caches.

Why is it still not working?  Well, below a kludge that will get the
latest 2.4 code to work again for all processors that are suffering from
cache aliases.  It's an inefficient solution but good enough for now.

  Ralf

Index: include/asm-mips/page.h
===================================================================
RCS file: /home/cvs/linux/include/asm-mips/page.h,v
retrieving revision 1.14.2.11
diff -u -r1.14.2.11 page.h
--- include/asm-mips/page.h	20 Dec 2002 02:34:17 -0000	1.14.2.11
+++ include/asm-mips/page.h	19 Mar 2003 13:21:32 -0000
@@ -64,8 +64,10 @@
 
 #define clear_page(page)	_clear_page(page)
 #define copy_page(to, from)	_copy_page(to, from)
-#define clear_user_page(page, vaddr)	clear_page(page)
-#define copy_user_page(to, from, vaddr)	copy_page(to, from)
+#define clear_user_page(page, vaddr) \
+	do { clear_page(page); flush_cache_all(); } while (0)
+#define copy_user_page(to, from, vaddr)	\
+	do { copy_page(to, from); flush_cache_all(); } while (0)
 
 /*
  * These are used to make use of C type-checking..
