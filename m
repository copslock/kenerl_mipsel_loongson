Received:  by oss.sgi.com id <S305160AbQANMtX>;
	Fri, 14 Jan 2000 04:49:23 -0800
Received: from deliverator.sgi.com ([204.94.214.10]:25214 "EHLO
        deliverator.sgi.com") by oss.sgi.com with ESMTP id <S305157AbQANMtG>;
	Fri, 14 Jan 2000 04:49:06 -0800
Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by deliverator.sgi.com (980309.SGI.8.8.8-aspam-6.2/980310.SGI-aspam) via ESMTP id EAA22703; Fri, 14 Jan 2000 04:46:12 -0800 (PST)
	mail_from (owner-linux@cthulhu.engr.sgi.com)
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id EAA39469
	for linux-list;
	Fri, 14 Jan 2000 04:42:59 -0800 (PST)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id EAA74798
	for <linux@cthulhu.engr.sgi.com>;
	Fri, 14 Jan 2000 04:42:55 -0800 (PST)
	mail_from (weave@eng.umd.edu)
Received: from po4.glue.umd.edu (po4.glue.umd.edu [128.8.10.124]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id EAA08357
	for <linux@cthulhu.engr.sgi.com>; Fri, 14 Jan 2000 04:42:53 -0800 (PST)
	mail_from (weave@eng.umd.edu)
Received: from z.glue.umd.edu (root@z.glue.umd.edu [128.8.10.71])
	by po4.glue.umd.edu (8.9.3/8.9.3) with ESMTP id HAA09787
	for <linux@cthulhu.engr.sgi.com>; Fri, 14 Jan 2000 07:42:41 -0500 (EST)
Received: from z.glue.umd.edu (sendmail@localhost [127.0.0.1])
	by z.glue.umd.edu (8.9.3/8.9.3) with SMTP id HAA02534
	for <linux@cthulhu.engr.sgi.com>; Fri, 14 Jan 2000 07:42:41 -0500 (EST)
Received: from localhost (weave@localhost)
	by z.glue.umd.edu (8.9.3/8.9.3) with ESMTP id HAA02530
	for <linux@cthulhu.engr.sgi.com>; Fri, 14 Jan 2000 07:42:40 -0500 (EST)
X-Authentication-Warning: z.glue.umd.edu: weave owned process doing -bs
Date:   Fri, 14 Jan 2000 07:42:40 -0500 (EST)
From:   Vince Weaver <weave@eng.umd.edu>
X-Sender: weave@z.glue.umd.edu
To:     linux@cthulhu.engr.sgi.com
Subject: patch to make /proc/cpuinfo show Indigo2
Message-ID: <Pine.GSO.4.21.0001140738030.2245-100000@z.glue.umd.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxmips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linuxmips@oss.sgi.com>
X-Orcpt: rfc822;linuxmips-outgoing

Hello,
Here is an improved version of my patch that properly implements
Indy/Indigo2 machine type in /proc/cpuinfo using the sgi_guiness flag.
I'd like whoever has the power to commit it please ;)

For example, my indigo2 now shows

bash# cat /proc/cpuinfo
cpu                     : MIPS
cpu model               : R4000SC V3.0
system type             : SGI Indigo2
BogoMIPS                : 49.87
byteorder               : big endian
unaligned accesses      : 0
wait instruction        : no
microsecond timers      : no
extra interrupt vector  : no
hardware watchpoint     : yes
VCED exceptions         : 38
VCEI exceptions         : 56

The patch follows....

[-----------------------------]


--- ./linux/include/asm-mips/bootinfo.old.h	Thu Jan 13 12:29:17 2000
+++ ./linux/include/asm-mips/bootinfo.h	Fri Jan 14 07:28:13 2000
@@ -91,8 +91,9 @@
  * Valid machtype for group SGI
  */
 #define MACH_SGI_INDY		0	/* R4?K and R5K Indy workstaions */
+#define MACH_SGI_INDIGO2	1
 
-#define GROUP_SGI_NAMES { "Indy" }
+#define GROUP_SGI_NAMES { "Indy", "Indigo2" }
 
 /*
  * Valid machtype for group COBALT
--- ./linux/arch/mips/arc/identify.old.c	Thu Jan 13 12:45:18 2000
+++ ./linux/arch/mips/arc/identify.c	Fri Jan 14 07:29:48 2000
@@ -17,6 +17,7 @@
 #include <asm/sgi/sgi.h>
 #include <asm/sgialib.h>
 #include <asm/bootinfo.h>
+#include <asm/sgi/sgihpc.h>
 
 struct smatch {
     char *name;
@@ -59,10 +60,14 @@
      */
     p = prom_getchild(PROM_NULL_COMPONENT);
     printk("ARCH: %s\n", p->iname);
-    mach = string_to_mach(p->iname);
 
+    mach = string_to_mach(p->iname);
     mips_machgroup = mach->group;
-    mips_machtype = mach->type;
+   
+     /* sgi_guiness=1 implies an indy, sgi_guiness=0 implies an Indigo2.
+      * We'll need to fix this if more SGI arch's get added.  --vmw
+      */
+    mips_machtype = !sgi_guiness;
     prom_flags = mach->flags;
 }
 
