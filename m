Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.3/8.12.3) with ESMTP id g3OMIrwJ022879
	for <linux-mips-outgoing@oss.sgi.com>; Wed, 24 Apr 2002 15:18:53 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.3/8.12.3/Submit) id g3OMIq60022878
	for linux-mips-outgoing; Wed, 24 Apr 2002 15:18:52 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from sgi.com (sgi-too.SGI.COM [204.94.211.39])
	by oss.sgi.com (8.12.3/8.12.3) with SMTP id g3OMIbwJ022867
	for <linux-mips@oss.sgi.com>; Wed, 24 Apr 2002 15:18:37 -0700
Received: from av.mvista.com (gateway-1237.mvista.com [12.44.186.158]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id PAA08674
	for <linux-mips@oss.sgi.com>; Wed, 24 Apr 2002 15:18:45 -0700 (PDT)
	mail_from (jsun@mvista.com)
Received: from mvista.com (av [127.0.0.1])
	by av.mvista.com (8.9.3/8.9.3) with ESMTP id PAA23171;
	Wed, 24 Apr 2002 15:02:37 -0700
Message-ID: <3CC72BA3.90600@mvista.com>
Date: Wed, 24 Apr 2002 15:03:15 -0700
From: Jun Sun <jsun@mvista.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.2.1) Gecko/20010901
X-Accept-Language: en-us
MIME-Version: 1.0
To: turcotte@broadcom.com
CC: linux-mips@oss.sgi.com, Maurice Turcotte <mturc@broadcom.com>
Subject: Re: Linux Shared Memory Issue
References: <NDBBKEAAOJECIDBJKLIHOEDDCDAA.turcotte@broadcom.com>
Content-Type: multipart/mixed;
 boundary="------------050506030600070802060007"
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk


This is a multi-part message in MIME format.
--------------050506030600070802060007
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit


Looks like the infamous cache aliasing problem.  Steve Longerbeam had a patch 
which may help.  Please try it and let me know the results.

Thanks.

Jun


Maurice Turcotte wrote:

> Greetings:
> 
> I am having a problem with Linux Kernel 2.4.5 on a mips.
> 
> I have two processes using share memory for IPC. This same
> code works fine with Kernel 2.4.7 on a x86. The problem is 
> that the second process reads old data out of the shared
> memory.
> 
> The executive summary->
> 
> Process #1 writes "A" to shared memory at 0x2aac7210
> Process #2 reads 0 from shared memory at address 0x2aaca210
> Process #1 writes "B" to shared memory at 0x2aac7210
> Process #2 read "A" from shared memory at address 0x2aaca210
> Process #1 writes "C" to shared memory at 0x2aac7210
> Process #2 read "B" from shared memory at address 0x2aaca210
> 
> It is interesting that the processes get different addresses
> associated with the same shmId. I assume this is because of 
> some user-space mapping that is going on.
> 
> I left out the semaphore diddling, but I believe that part of
> the code is correct because it works flawlessly on the 2.4.7 x86.
> 
> Any tips on debugging this would be greatly appreciated. If this
> is not the proper forum for questions like this, please point me
> in the right direction.
> 
> Thanks,
> 
> mturc
> 
> 


--------------050506030600070802060007
Content-Type: text/plain;
 name="cache-alias.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="cache-alias.patch"

diff -Nuar -X /home/stevel/dontdiff linux-2.4.17.orig/arch/mips/kernel/syscall.c linux-2.4.17/arch/mips/kernel/syscall.c
--- linux-2.4.17.orig/arch/mips/kernel/syscall.c	Sun Sep 16 16:29:10 2001
+++ linux-2.4.17/arch/mips/kernel/syscall.c	Thu Jan 24 15:02:18 2002
@@ -24,6 +24,7 @@
 #include <linux/slab.h>
 #include <linux/utsname.h>
 #include <linux/unistd.h>
+#include <linux/shm.h>
 #include <asm/branch.h>
 #include <asm/offset.h>
 #include <asm/ptrace.h>
@@ -53,6 +54,50 @@
 out:
 	return res;
 }
+
+/*
+ * To avoid cache aliases, we map the shard page with same color.
+ */
+#define COLOUR_ALIGN(addr)    (((addr)+SHMLBA-1)&~(SHMLBA-1))
+
+unsigned long arch_get_unmapped_area(struct file *filp, unsigned long addr,
+				     unsigned long len, unsigned long pgoff,
+				     unsigned long flags)
+{
+	struct vm_area_struct *vma;
+
+	if (flags & MAP_FIXED) {
+		/*
+		 * We do not accept a shared mapping if it would violate
+		 * cache aliasing constraints.
+		 */
+		if ((flags & MAP_SHARED) && (addr & (SHMLBA - 1)))
+			return -EINVAL;
+		return addr;
+	}
+
+	if (len > TASK_SIZE)
+		return -ENOMEM;
+	if (!addr)
+		addr = TASK_UNMAPPED_BASE;
+
+	if (flags & MAP_SHARED)
+		addr = COLOUR_ALIGN(addr);
+	else
+		addr = PAGE_ALIGN(addr);
+
+	for (vma = find_vma(current->mm, addr); ; vma = vma->vm_next) {
+		/* At this point:  (!vma || addr < vma->vm_end). */
+		if (TASK_SIZE - len < addr)
+			return -ENOMEM;
+		if (!vma || addr + len <= vma->vm_start)
+			return addr;
+		addr = vma->vm_end;
+		if (flags & MAP_SHARED)
+			addr = COLOUR_ALIGN(addr);
+	}
+}
+
 
 /* common code for old and new mmaps */
 static inline long
diff -Nuar -X /home/stevel/dontdiff linux-2.4.17.orig/include/asm-mips/pgtable.h linux-2.4.17/include/asm-mips/pgtable.h
--- linux-2.4.17.orig/include/asm-mips/pgtable.h	Thu Jan 24 14:35:06 2002
+++ linux-2.4.17/include/asm-mips/pgtable.h	Thu Jan 24 14:56:52 2002
@@ -64,6 +64,9 @@
 #define flush_icache_all()		do { } while(0)
 #endif
 
+/* We provide our own get_unmapped_area to avoid cache aliasing */
+#define HAVE_ARCH_UNMAPPED_AREA
+
 /*
  * - add_wired_entry() add a fixed TLB entry, and move wired register
  */

--------------050506030600070802060007--
