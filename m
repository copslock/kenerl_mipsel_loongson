Received:  by oss.sgi.com id <S305157AbQANNzn>;
	Fri, 14 Jan 2000 05:55:43 -0800
Received: from sgi.SGI.COM ([192.48.153.1]:60015 "EHLO sgi.com")
	by oss.sgi.com with ESMTP id <S305155AbQANNz0>;
	Fri, 14 Jan 2000 05:55:26 -0800
Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id FAA03729; Fri, 14 Jan 2000 05:56:20 -0800 (PST)
	mail_from (owner-linux@cthulhu.engr.sgi.com)
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id FAA36784
	for linux-list;
	Fri, 14 Jan 2000 05:45:17 -0800 (PST)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id FAA02346
	for <linux@cthulhu.engr.sgi.com>;
	Fri, 14 Jan 2000 05:45:14 -0800 (PST)
	mail_from (weave@eng.umd.edu)
Received: from po3.glue.umd.edu (po3.glue.umd.edu [128.8.10.123]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id FAA06781
	for <linux@cthulhu.engr.sgi.com>; Fri, 14 Jan 2000 05:45:12 -0800 (PST)
	mail_from (weave@eng.umd.edu)
Received: from z.glue.umd.edu (root@z.glue.umd.edu [128.8.10.71])
	by po3.glue.umd.edu (8.9.3/8.9.3) with ESMTP id IAA18565
	for <linux@cthulhu.engr.sgi.com>; Fri, 14 Jan 2000 08:45:11 -0500 (EST)
Received: from z.glue.umd.edu (sendmail@localhost [127.0.0.1])
	by z.glue.umd.edu (8.9.3/8.9.3) with SMTP id IAA04628
	for <linux@cthulhu.engr.sgi.com>; Fri, 14 Jan 2000 08:45:10 -0500 (EST)
Received: from localhost (weave@localhost)
	by z.glue.umd.edu (8.9.3/8.9.3) with ESMTP id IAA04620
	for <linux@cthulhu.engr.sgi.com>; Fri, 14 Jan 2000 08:45:09 -0500 (EST)
X-Authentication-Warning: z.glue.umd.edu: weave owned process doing -bs
Date:   Fri, 14 Jan 2000 08:45:09 -0500 (EST)
From:   Vince Weaver <weave@eng.umd.edu>
X-Sender: weave@z.glue.umd.edu
To:     linux@cthulhu.engr.sgi.com
Subject: Re: patch to make /proc/cpuinfo show Indigo2
In-Reply-To: <Pine.GSO.4.21.0001140738030.2245-100000@z.glue.umd.edu>
Message-ID: <Pine.GSO.4.21.0001140838320.4332-100000@z.glue.umd.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxmips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linuxmips@oss.sgi.com>
X-Orcpt: rfc822;linuxmips-outgoing

Ugh, just realized that ./linux/arch/mips/arc/identify.c is used by more
than just SGI machines.

Here is an updated patch, that should handle things correctly.

Vince

[P.S. (shameless plug)  If there is anoyone out there looking for a
 college student summer intern with some sgi/linux experience, let me
know]

[-------------]

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
--- ./linux/arch/mips/arc/identify.c.old	Fri Jan 14 08:01:53 2000
+++ ./linux/arch/mips/arc/identify.c	Fri Jan 14 08:21:07 2000
@@ -17,6 +17,7 @@
 #include <asm/sgi/sgi.h>
 #include <asm/sgialib.h>
 #include <asm/bootinfo.h>
+#include <asm/sgi/sgihpc.h>
 
 struct smatch {
     char *name;
@@ -59,10 +60,16 @@
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
+    if (mips_machgroup==MACH_GROUP_SGI) mips_machtype=!sgi_guiness;
+    else mips_machtype=mach->type;
+    
     prom_flags = mach->flags;
 }
 
