Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f767etY29272
	for linux-mips-outgoing; Mon, 6 Aug 2001 00:40:55 -0700
Received: from topsns.toshiba-tops.co.jp (topsns.toshiba-tops.co.jp [202.230.225.5])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f767eoV29269
	for <linux-mips@oss.sgi.com>; Mon, 6 Aug 2001 00:40:51 -0700
Received: from inside-ms1.toshiba-tops.co.jp by topsns.toshiba-tops.co.jp
          via smtpd (for [216.32.174.27]) with SMTP; 6 Aug 2001 07:40:50 UT
Received: from srd2sd.toshiba-tops.co.jp (gw-chiba7.toshiba-tops.co.jp [172.17.244.27])
	by topsms.toshiba-tops.co.jp (8.9.3/3.7W-MailExchenger) with ESMTP id QAA77377;
	Mon, 6 Aug 2001 16:40:22 +0900 (JST)
Received: by srd2sd.toshiba-tops.co.jp (8.9.3/3.5Wbeta-srd2sd) with ESMTP
	id QAA46216; Mon, 6 Aug 2001 16:40:22 +0900 (JST)
X-Fingerprint: EC 9D B9 17 2E 89 D2 25  CE F5 5D 3D 12 29 2A AD
X-Pgp-Public-Key: http://pgp.nic.ad.jp/cgi-bin/pgpsearchkey.pl?op=get&search=0xB6D728B1
Subject: SysV IPC shared memory and virtual alising
From: Atsushi Nemoto <nemoto@toshiba-tops.co.jp>
To: linux-mips@oss.sgi.com, linux-mips@fnet.fr
X-Mailer: Mew version 1.94.2 on Emacs 20.7 / Mule 4.1 (AOI)
Organization: TOSHIBA Personal Computer System Corporation
Mime-Version: 1.0
Content-Type: Multipart/Mixed;
 boundary="--Next_Part(Mon_Aug__6_16:44:05_2001_756)--"
Content-Transfer-Encoding: 7bit
Message-Id: <20010806164452D.nemoto@toshiba-tops.co.jp>
Date: Mon, 06 Aug 2001 16:44:52 +0900
X-Dispatcher: imput version 20000228(IM140)
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

----Next_Part(Mon_Aug__6_16:44:05_2001_756)--
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Here is an patch to fix virtual aliasing problem with SysV IPC shared
memory.  I tested this patch on a r4k cpu with 32Kb D-cache.

If D-cache is smaller than PAGE_SIZE this patch is not needed at all,
but I think it is not so bad unconditionally forcing alignment to
SHMLBA.

---
Atsushi Nemoto


----Next_Part(Mon_Aug__6_16:44:05_2001_756)--
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="unmapped_area.patch"

diff -ur linux.sgi/arch/mips/kernel/syscall.c linux/arch/mips/kernel/syscall.c
--- linux.sgi/arch/mips/kernel/syscall.c	Thu Apr  5 13:56:09 2001
+++ linux/arch/mips/kernel/syscall.c	Mon Aug  6 16:16:36 2001
@@ -30,6 +30,7 @@
 #include <asm/signal.h>
 #include <asm/stackframe.h>
 #include <asm/uaccess.h>
+#include <asm/shmparam.h>
 
 extern asmlinkage void syscall_trace(void);
 typedef asmlinkage int (*syscall_t)(void *a0,...);
@@ -91,6 +92,47 @@
 {
 	return do_mmap2(addr, len, prot, flags, fd, pgoff);
 }
+
+#ifdef HAVE_ARCH_UNMAPPED_AREA
+/* solve cache aliasing problem (see Documentation/cache.txt and
+   arch/sparc64/kernel/sys_sparc.c */
+#define COLOUR_ALIGN(addr)	(((addr)+SHMLBA-1)&~(SHMLBA-1))
+
+unsigned long arch_get_unmapped_area(struct file *filp, unsigned long addr, unsigned long len, unsigned long pgoff, unsigned long flags)
+{
+	struct vm_area_struct * vmm;
+
+	if (flags & MAP_FIXED) {
+		/* We do not accept a shared mapping if it would violate
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
+	for (vmm = find_vma(current->mm, addr); ; vmm = vmm->vm_next) {
+		/* At this point:  (!vmm || addr < vmm->vm_end). */
+		if (TASK_SIZE - len < addr)
+			return -ENOMEM;
+		if (!vmm || addr + len <= vmm->vm_start)
+			return addr;
+		addr = vmm->vm_end;
+		if (flags & MAP_SHARED)
+			addr = COLOUR_ALIGN(addr);
+	}
+}
+#endif /* HAVE_ARCH_UNMAPPED_AREA */
 
 save_static_function(sys_fork);
 static_unused int _sys_fork(struct pt_regs regs)
diff -ur linux.sgi/include/asm-mips/pgtable.h linux/include/asm-mips/pgtable.h
--- linux.sgi/include/asm-mips/pgtable.h	Sun Aug  5 23:41:28 2001
+++ linux/include/asm-mips/pgtable.h	Mon Aug  6 16:17:11 2001
@@ -740,6 +740,9 @@
 
 #include <asm-generic/pgtable.h>
 
+/* We provide our own get_unmapped_area to cope with VA holes for userland */
+#define HAVE_ARCH_UNMAPPED_AREA
+
 #endif /* !defined (_LANGUAGE_ASSEMBLY) */
 
 #define io_remap_page_range remap_page_range

----Next_Part(Mon_Aug__6_16:44:05_2001_756)----
