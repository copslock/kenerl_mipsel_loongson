Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id fAS562R02190
	for linux-mips-outgoing; Tue, 27 Nov 2001 21:06:02 -0800
Received: from dea.linux-mips.net (localhost [127.0.0.1])
	by oss.sgi.com (8.11.2/8.11.3) with ESMTP id fAS55uo02187
	for <linux-mips@oss.sgi.com>; Tue, 27 Nov 2001 21:05:57 -0800
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.11.1/8.11.1) id fAS45qn28101;
	Wed, 28 Nov 2001 15:05:52 +1100
Date: Wed, 28 Nov 2001 15:05:52 +1100
From: Ralf Baechle <ralf@oss.sgi.com>
To: Krishna Kondaka <krishna@Sanera.net>
Cc: linux-mips@oss.sgi.com
Subject: Re: Memory leaks in SMP MIPS linux 2.4.9?
Message-ID: <20011128150552.A27925@dea.linux-mips.net>
References: <200111280109.RAA17976@exceed2.sanera.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <200111280109.RAA17976@exceed2.sanera.net>; from krishna@Sanera.net on Tue, Nov 27, 2001 at 05:09:00PM -0800
X-Accept-Language: de,en,fr
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Tue, Nov 27, 2001 at 05:09:00PM -0800, Krishna Kondaka wrote:

> I suspect that there are some memory leaks in the SMP MIPS linux 2.4.9.
> I would like to know if any one found the root cause and fixed them.

See patch below for fix.

> 	I just ran the script for 3 hours are here is the diff between
> 	the out put of /proc/meminfo and /proc/slabinfo before and
> 	after the test run ( lines with "<" are before the test and
> 	lines with ">" are after the test)

(Try diff -u which generates much more human readable output.)

> 	When I did some investigation, it looked like d_lookup() is
> 	not finding /proc/meminfo and /proc/slabinfo in the dcache and
> 	it is doing d_alloc() to add these to the cache every time
> 	cat /proc/meminfo or cat /proc/slabinfo is done. This looked odd
> 	and I ran the same script on x86 based linux (running 2.4.2) and
> 	I did not see MemFree (or any other caches) changing after the
> 	test was run for an hour. I am not sure how this is architecture
> 	dependent.

These caches essentially keep growing until you run out of memory which
is when they'll be freed.

  Ralf

--- linux.orig/include/asm-mips/mmu_context.h.orig	Wed Nov 28 14:45:19 2001
+++ linux/include/asm-mips/mmu_context.h	Wed Nov 28 14:47:37 2001
@@ -109,7 +109,10 @@
  */
 extern inline void destroy_context(struct mm_struct *mm)
 {
-	/* Nothing to do.  */
+#ifdef CONFIG_SMP
+	if (mm->context)
+		kfree((void *)mm->context);
+#endif
 }
 
 /*
