Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 08 Mar 2004 21:46:49 +0000 (GMT)
Received: from nevyn.them.org ([IPv6:::ffff:66.93.172.17]:44709 "EHLO
	nevyn.them.org") by linux-mips.org with ESMTP id <S8225206AbUCHVqe>;
	Mon, 8 Mar 2004 21:46:34 +0000
Received: from drow by nevyn.them.org with local (Exim 4.30 #1 (Debian))
	id 1B0SZy-0000fp-1f; Mon, 08 Mar 2004 16:46:30 -0500
Date: Mon, 8 Mar 2004 16:46:30 -0500
From: Daniel Jacobowitz <dan@debian.org>
To: ralf@linux-mips.org
Cc: linux-mips@linux-mips.org
Subject: Patch for o32/n32 mmap on 64-bit kernel
Message-ID: <20040308214629.GA2568@nevyn.them.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.1i
Return-Path: <drow@crack.them.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 4503
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dan@debian.org
Precedence: bulk
X-list: linux-mips

As discussed.  Applies to linux-2.4 cleanly, to linux-2.6 also but you'll
need to add:

#if CONFIG_MIPS32
	task_size = TASK_SIZE;
#else


Index: syscall.c
===================================================================
RCS file: /cvsdev/mvl-kernel/linux/arch/mips64/kernel/syscall.c,v
retrieving revision 1.4.8.1
diff -u -p -r1.4.8.1 syscall.c
--- syscall.c	17 Nov 2003 16:29:20 -0000	1.4.8.1
+++ syscall.c	8 Mar 2004 21:43:06 -0000
@@ -61,6 +61,9 @@ unsigned long arch_get_unmapped_area(str
 {
 	struct vm_area_struct * vmm;
 	int do_color_align;
+	unsigned long task_size;
+	
+	task_size = (current->thread.mflags & MF_32BIT_ADDR) ? TASK_SIZE32 : TASK_SIZE;
 
 	if (flags & MAP_FIXED) {
 		/*
@@ -72,7 +75,7 @@ unsigned long arch_get_unmapped_area(str
 		return addr;
 	}
 
-	if (len > TASK_SIZE)
+	if (len > task_size)
 		return -ENOMEM;
 	do_color_align = 0;
 	if (filp || (flags & MAP_SHARED))
@@ -83,7 +86,7 @@ unsigned long arch_get_unmapped_area(str
 		else
 			addr = PAGE_ALIGN(addr);
 		vmm = find_vma(current->mm, addr);
-		if (TASK_SIZE - len >= addr &&
+		if (task_size - len >= addr &&
 		    (!vmm || addr + len <= vmm->vm_start))
 			return addr;
 	}
@@ -95,7 +98,7 @@ unsigned long arch_get_unmapped_area(str
 
 	for (vmm = find_vma(current->mm, addr); ; vmm = vmm->vm_next) {
 		/* At this point:  (!vmm || addr < vmm->vm_end). */
-		if (TASK_SIZE - len < addr)
+		if (task_size - len < addr)
 			return -ENOMEM;
 		if (!vmm || addr + len <= vmm->vm_start)
 			return addr;


-- 
Daniel Jacobowitz
MontaVista Software                         Debian GNU/Linux Developer
