Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 20 Mar 2003 11:08:55 +0000 (GMT)
Received: from [IPv6:::ffff:159.226.39.4] ([IPv6:::ffff:159.226.39.4]:32952
	"HELO mail.ict.ac.cn") by linux-mips.org with SMTP
	id <S8225073AbTCTLIq>; Thu, 20 Mar 2003 11:08:46 +0000
Received: (qmail 28210 invoked from network); 20 Mar 2003 10:51:43 -0000
Received: from unknown (HELO ict.ac.cn) (159.226.40.150)
  by 159.226.39.4 with SMTP; 20 Mar 2003 10:51:43 -0000
Message-ID: <3E79A121.6000409@ict.ac.cn>
Date: Thu, 20 Mar 2003 19:08:17 +0800
From: Fuxin Zhang <fxzhang@ict.ac.cn>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20030206
X-Accept-Language: zh-cn, en-us, en
MIME-Version: 1.0
To: Ralf Baechle <ralf@linux-mips.org>
CC: linux-mips@linux-mips.org
Subject: Re: Cache code changes
References: <20030320111625.A13219@linux-mips.org>
In-Reply-To: <20030320111625.A13219@linux-mips.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <fxzhang@ict.ac.cn>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 1780
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: fxzhang@ict.ac.cn
Precedence: bulk
X-list: linux-mips

I am very glad to see this happens:)

Currently linux/mips is really far from efficient,I've some data for 
this declaration:
   For most SPEC CPU 2000 programs we run on a 4-way superscalar CPU 
simulator
,we get <0.20 IPC in kernel mode,while the IPCs for the whole execution 
are often much
higher(0.5-1.5). We believe this has something to do with the overly 
used cache flushes.

BTW, for 2.4.17,it seems this path is still not safe for cache aliases:
    copy_cow_page for newly forked process, we use kernel virtual address
to do the copy,but without flush first.
add a flush_page_to_ram before the copy fix the errors.

but i am not sure whether i am missing something
 

Ralf Baechle wrote:

>Thought I should drop a note about the recent cache code changes in the
>Linux 2.4 and 2.5 code in CVS to explain what's going on.
>
>flush_page_to_ram() has long been a deprecated interface and been scheduled
>to be removed for years.  It's considered a inefficient, badly designed
>interface.  It's use it for dealing with virtual aliases in the primary
>cache.  That is whenever the memory managment code creates or modifies
>a page that is mapped to userspace it has to writeback and invalidate the
>kernel mapping of this page to avoid virtual aliases.
>
>flush_page_to_ram() turned out to be a rather ad-hoc interface; the
>obvious but inefficient interface approach.  It's also not capable of
>fully dealing with all types of cache aliases like aliases between the
>page cache and user mappings.  Which may lead to silent data corruption
>and that's the reason why I'm doing such intrusive kernel surgery for a
>supposedly stable kernel.  So there now is an alternative interface
>available in the kernel, flush_dcache_page().  flush_dcache_page() is
>implements a two stage approach.  It marks pages which are in the page
>cache and therefore could possibly alias with userspace as possibly
>residing in cache if it doesn't flush them immediately.  This allows
>delaying cache flushes - possibly infinitely.  Which quite obviously is
>a performance gain.
>
>Side effect - some implementations of flush_icache_page() knew that it's
>invocations are always preceeded by flush_page_to_ram() so the D-cache
>flush can be omitted.  This is no longer there case.  Another bug fixed
>along the way (but not yet for all processors) was flush_cache_page() not
>flushing the instruction cache ...
>
>Along with that I've also cleaned the cache code for R4000 and R4400 CPUs.
>Continuing the mess seemed to be plain unmaintainable and at the same
>time huge.  The heavily changed code (for your amusement now using a few
>new code constructs :-) is now over 40% smaller meassure in LOCs and about
>2/3 smaller in code size and should make it fairly easy to add support for
>strange beasts such as TX39, TX49 or R5432 style caches caches.
>
>Why is it still not working?  Well, below a kludge that will get the
>latest 2.4 code to work again for all processors that are suffering from
>cache aliases.  It's an inefficient solution but good enough for now.
>
>  Ralf
>
>Index: include/asm-mips/page.h
>===================================================================
>RCS file: /home/cvs/linux/include/asm-mips/page.h,v
>retrieving revision 1.14.2.11
>diff -u -r1.14.2.11 page.h
>--- include/asm-mips/page.h	20 Dec 2002 02:34:17 -0000	1.14.2.11
>+++ include/asm-mips/page.h	19 Mar 2003 13:21:32 -0000
>@@ -64,8 +64,10 @@
> 
> #define clear_page(page)	_clear_page(page)
> #define copy_page(to, from)	_copy_page(to, from)
>-#define clear_user_page(page, vaddr)	clear_page(page)
>-#define copy_user_page(to, from, vaddr)	copy_page(to, from)
>+#define clear_user_page(page, vaddr) \
>+	do { clear_page(page); flush_cache_all(); } while (0)
>+#define copy_user_page(to, from, vaddr)	\
>+	do { copy_page(to, from); flush_cache_all(); } while (0)
> 
> /*
>  * These are used to make use of C type-checking..
>
>
>
>  
>
