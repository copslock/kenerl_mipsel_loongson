Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.3/8.12.3) with ESMTP id g4HCelnC032702
	for <linux-mips-outgoing@oss.sgi.com>; Fri, 17 May 2002 05:40:47 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.3/8.12.3/Submit) id g4HCelpE032701
	for linux-mips-outgoing; Fri, 17 May 2002 05:40:47 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from mx2.mips.com (mx2.mips.com [206.31.31.227])
	by oss.sgi.com (8.12.3/8.12.3) with SMTP id g4HCeenC032698
	for <linux-mips@oss.sgi.com>; Fri, 17 May 2002 05:40:40 -0700
Received: from newman.mips.com (ns-dmz [206.31.31.225])
	by mx2.mips.com (8.9.3/8.9.0) with ESMTP id FAA25524
	for <linux-mips@oss.sgi.com>; Fri, 17 May 2002 05:40:52 -0700 (PDT)
Received: from copfs01.mips.com (copfs01 [192.168.205.101])
	by newman.mips.com (8.9.3/8.9.0) with ESMTP id EAA18961
	for <linux-mips@oss.sgi.com>; Fri, 17 May 2002 04:50:32 -0700 (PDT)
Received: from mips.com (copsun17 [192.168.205.27])
	by copfs01.mips.com (8.11.4/8.9.0) with ESMTP id g4HBoVb00900
	for <linux-mips@oss.sgi.com>; Fri, 17 May 2002 13:50:31 +0200 (MEST)
Message-ID: <3CE4EE87.EF515C92@mips.com>
Date: Fri, 17 May 2002 13:50:31 +0200
From: Carsten Langgaard <carstenl@mips.com>
X-Mailer: Mozilla 4.77 [en] (X11; U; SunOS 5.7 sun4u)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-mips@oss.sgi.com
Subject: Hazard problem in tlb-r4k.c
Content-Type: multipart/mixed;
 boundary="------------8694013FE14C5535C2FAF4F3"
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

This is a multi-part message in MIME format.
--------------8694013FE14C5535C2FAF4F3
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: 7bit

There seems to be a hazard problem in the local_flush_tlb_range function
in tlb-r4k.c, which the patch below will fix.
It could hit anyone, but it probably only a problem on CPUs, which
doesn't allow matching entries in the TLB.

/Carsten


--
_    _ ____  ___   Carsten Langgaard   Mailto:carstenl@mips.com
|\  /|||___)(___   MIPS Denmark        Direct: +45 4486 5527
| \/ |||    ____)  Lautrupvang 4B      Switch: +45 4486 5555
  TECHNOLOGIES     2750 Ballerup       Fax...: +45 4486 5556
                   Denmark             http://www.mips.com



--------------8694013FE14C5535C2FAF4F3
Content-Type: text/plain; charset=iso-8859-15;
 name="tlb-r4k.c.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="tlb-r4k.c.patch"

Index: arch/mips/mm/tlb-r4k.c
===================================================================
RCS file: /cvs/linux/arch/mips/mm/tlb-r4k.c,v
retrieving revision 1.6.2.3
diff -u -r1.6.2.3 tlb-r4k.c
--- arch/mips/mm/tlb-r4k.c	2002/01/18 03:16:24	1.6.2.3
+++ arch/mips/mm/tlb-r4k.c	2002/05/17 11:36:58
@@ -119,12 +119,11 @@
 				idx = get_index();
 				set_entrylo0(0);
 				set_entrylo1(0);
-				set_entryhi(KSEG0);
 				if (idx < 0)
 					continue;
-				BARRIER;
 				/* Make sure all entries differ. */
 				set_entryhi(KSEG0+idx*0x2000);
+				BARRIER;
 				tlb_write_indexed();
 				BARRIER;
 			}

--------------8694013FE14C5535C2FAF4F3--
