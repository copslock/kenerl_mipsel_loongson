Received: (from majordomo@localhost)
	by linux-xfs.sgi.com (8.12.0.Beta5/8.12.0.Beta5) id f59HFUsA028344
	for linux-mips-outgoing; Sat, 9 Jun 2001 10:15:30 -0700
X-Authentication-Warning: linux-xfs.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from noose.gt.owl.de (postfix@noose.gt.owl.de [62.52.19.4])
	by linux-xfs.sgi.com (8.12.0.Beta5/8.12.0.Beta5) with SMTP id f59HFS3D028337
	for <linux-mips@oss.sgi.com>; Sat, 9 Jun 2001 10:15:29 -0700
Received: by noose.gt.owl.de (Postfix, from userid 10)
	id 418187F9; Sat,  9 Jun 2001 19:15:26 +0200 (CEST)
Received: by paradigm.rfc822.org (Postfix, from userid 1000)
	id 4B7FB42D0; Sat,  9 Jun 2001 19:15:36 +0200 (CEST)
Date: Sat, 9 Jun 2001 19:15:36 +0200
From: Florian Lohoff <flo@rfc822.org>
To: linux-mips@oss.sgi.com
Subject: Current cvs does not compile
Message-ID: <20010609191535.A6407@paradigm.rfc822.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.15i
Organization: rfc822 - pure communication
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk


Hi,
it seems the current cvs doesnt compile - It seems some include strategies
are broken.

asm-mips/io.h needs _CACHE_UNCACHED which is defined in pgtable.h
pgtable.h needs mm_struct which is defined in shed.h


Index: include/asm-mips/io.h
===================================================================
RCS file: /cvs/linux/include/asm-mips/io.h,v
retrieving revision 1.19
diff -u -r1.19 io.h
--- include/asm-mips/io.h	2001/06/06 23:46:17	1.19
+++ include/asm-mips/io.h	2001/06/09 17:12:48
@@ -14,6 +14,7 @@
 #include <linux/config.h>
 #include <asm/addrspace.h>
 #include <asm/byteorder.h>
+#include <asm/pgtable.h>
 
 /*
  * Slowdown I/O port space accesses for antique hardware.
Index: include/asm-mips/pgtable.h
===================================================================
RCS file: /cvs/linux/include/asm-mips/pgtable.h,v
retrieving revision 1.54
diff -u -r1.54 pgtable.h
--- include/asm-mips/pgtable.h	2001/06/05 23:24:07	1.54
+++ include/asm-mips/pgtable.h	2001/06/09 17:12:50
@@ -17,6 +17,7 @@
 #include <linux/linkage.h>
 #include <asm/cachectl.h>
 #include <linux/config.h>
+#include <linux/sched.h>
 
 /* Cache flushing:
  *

Now it fails for me in pgtable.h as it needs "high_memory" which should
be defined as extern (from mm/memory.c"

Flo
-- 
Florian Lohoff                  flo@rfc822.org             +49-5201-669912
     Why is it called "common sense" when nobody seems to have any?
