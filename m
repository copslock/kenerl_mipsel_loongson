Received:  by oss.sgi.com id <S553936AbQKMTDN>;
	Mon, 13 Nov 2000 11:03:13 -0800
Received: from delta.ds2.pg.gda.pl ([153.19.144.1]:54970 "EHLO
        delta.ds2.pg.gda.pl") by oss.sgi.com with ESMTP id <S553897AbQKMTCt>;
	Mon, 13 Nov 2000 11:02:49 -0800
Received: from localhost by delta.ds2.pg.gda.pl (8.9.3/8.9.3) with SMTP id UAA14948;
	Mon, 13 Nov 2000 20:02:48 +0100 (MET)
Date:   Mon, 13 Nov 2000 20:02:48 +0100 (MET)
From:   "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To:     Ralf Baechle <ralf@oss.sgi.com>
cc:     Ian Chilton <ian@ichilton.co.uk>, linux-mips@oss.sgi.com,
        lfs-discuss@linuxfromscratch.org
Subject: Re: User/Group Problem
In-Reply-To: <20001108050158.B12999@bacchus.dhis.org>
Message-ID: <Pine.GSO.3.96.1001113195048.12211C-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

On Wed, 8 Nov 2000, Ralf Baechle wrote:

>  - your chown / chgrp binaries are statically linked.  In that case nss
>    won't work on MIPS until it's fixed ...

 That's actually not a MIPS-specific problem.  This happens due to a bogus
error from mmap() (when called by ld.so) which cannot handle certain valid
requests -- when there is a non-zero suggested VM address, but the area
and all space above it is already occupied or unavailable for other
reasons.  It can sometimes appear for other ports, as well (I have an i386
test case, for example), but it bites MIPS specifically, because of a
non-zero initial VMA set for our shared objects.

 Here is a patch I use since July successfully.  We need to wait until
2.4.1 or so (or maybe even 2.5) is released for it to be applied as
2.4.0-test* are currently code-frozen.  Maybe we could apply it to our CVS
for now?  Ralf, what do you think? 

  Maciej

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +

diff -u --recursive --new-file linux-2.4.0-test4.macro/mm/mmap.c linux-2.4.0-test4/mm/mmap.c
--- linux-2.4.0-test4.macro/mm/mmap.c	Sun Jul 16 22:27:29 2000
+++ linux-2.4.0-test4/mm/mmap.c	Tue Jul 25 05:06:21 2000
@@ -175,7 +175,7 @@
 	if ((len = PAGE_ALIGN(len)) == 0)
 		return addr;
 
-	if (len > TASK_SIZE || addr > TASK_SIZE-len)
+	if (len > TASK_SIZE || ((flags & MAP_FIXED) && (addr > TASK_SIZE - len)))
 		return -EINVAL;
 
 	/* offset overflow? */
@@ -356,20 +356,31 @@
 unsigned long get_unmapped_area(unsigned long addr, unsigned long len)
 {
 	struct vm_area_struct * vmm;
+	int pass = 0;
 
 	if (len > TASK_SIZE)
 		return 0;
-	if (!addr)
-		addr = TASK_UNMAPPED_BASE;
-	addr = PAGE_ALIGN(addr);
-
-	for (vmm = find_vma(current->mm, addr); ; vmm = vmm->vm_next) {
-		/* At this point:  (!vmm || addr < vmm->vm_end). */
-		if (TASK_SIZE - len < addr)
-			return 0;
-		if (!vmm || addr + len <= vmm->vm_start)
-			return addr;
-		addr = vmm->vm_end;
+
+	while (1) {
+		if (!addr)
+			addr = TASK_UNMAPPED_BASE;
+		addr = PAGE_ALIGN(addr);
+
+		for (vmm = find_vma(current->mm, addr); ; vmm = vmm->vm_next) {
+			/* At this point:  (!vmm || addr < vmm->vm_end). */
+			if (TASK_SIZE - len < addr) {
+				if (pass > 0)
+					return 0;
+				else {
+					pass = 1;
+					addr = 0;
+					break;
+				}
+			}
+			if (!vmm || addr + len <= vmm->vm_start)
+				return addr;
+			addr = vmm->vm_end;
+		}
 	}
 }
 #endif
