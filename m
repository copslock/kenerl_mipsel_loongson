Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.3/8.11.3) id f2SEEPw04473
	for linux-mips-outgoing; Wed, 28 Mar 2001 06:14:25 -0800
Received: from delta.ds2.pg.gda.pl (delta.ds2.pg.gda.pl [213.192.72.1])
	by oss.sgi.com (8.11.3/8.11.3) with ESMTP id f2SE9PM04360
	for <linux-mips@oss.sgi.com>; Wed, 28 Mar 2001 06:09:38 -0800
Received: from localhost by delta.ds2.pg.gda.pl (8.9.3/8.9.3) with SMTP id PAA25740;
	Wed, 28 Mar 2001 15:50:34 +0200 (MET DST)
Date: Wed, 28 Mar 2001 15:50:34 +0200 (MET DST)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Carsten Langgaard <carstenl@mips.com>
cc: Keith M Wesolowski <wesolows@foobazco.org>, David Jez <dave.jez@seznam.cz>,
   Karel van Houten <K.H.C.vanHouten@kpn.com>, linux-mips@oss.sgi.com
Subject: Re: rpm crashing on RH 7.0 indy
In-Reply-To: <3AC18D89.A2A4386A@mips.com>
Message-ID: <Pine.GSO.3.96.1010328154420.24847A-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Wed, 28 Mar 2001, Carsten Langgaard wrote:

> Have the kernel fix made it into the CVS.
> If not, could you please resent it.

 I do not consider it clean enough for inclusion into the official kernel
at this stage.  It works, though.

 When appropriately cleaned up, I'll submit it to Linus as it's not
MIPS-specific and affects all systems -- mmap() fails equally badly on an
i386, for example.  No time to work on the patch at the moment, sorry.

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +

patch-2.4.0-test4-mmap-3
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
