Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 06 Oct 2004 16:28:16 +0100 (BST)
Received: from mx1.redhat.com ([IPv6:::ffff:66.187.233.31]:32698 "EHLO
	mx1.redhat.com") by linux-mips.org with ESMTP id <S8225221AbUJFP2L>;
	Wed, 6 Oct 2004 16:28:11 +0100
Received: from int-mx1.corp.redhat.com (int-mx1.corp.redhat.com [172.16.52.254])
	by mx1.redhat.com (8.12.11/8.12.10) with ESMTP id i96FS9gs020274;
	Wed, 6 Oct 2004 11:28:09 -0400
Received: from pobox.hsv.redhat.com (pobox.hsv.redhat.com [172.16.16.12])
	by int-mx1.corp.redhat.com (8.11.6/8.11.6) with ESMTP id i96FS9r09325;
	Wed, 6 Oct 2004 11:28:09 -0400
Received: from [172.16.16.120] (riff.hsv.redhat.com [172.16.16.120])
	by pobox.hsv.redhat.com (8.12.8/8.12.8) with ESMTP id i96FS74f010340;
	Wed, 6 Oct 2004 11:28:08 -0400
Subject: Asm hack for GCC 3.4 changes
From: Clark Williams <williams@redhat.com>
To: Ralf Baechle <ralf@linux-mips.org>
Cc: MIPS Linux List <linux-mips@linux-mips.org>
Content-Type: multipart/mixed; boundary="=-tOhk/6yw0kseK7VOzIow"
Message-Id: <1097076486.3185.23.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Wed, 06 Oct 2004 10:28:06 -0500
Return-Path: <williams@redhat.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 5959
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: williams@redhat.com
Precedence: bulk
X-list: linux-mips


--=-tOhk/6yw0kseK7VOzIow
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Ralf,

This is a patch I use on MIPS trees to deal with the changes in the way
GCC 3.4 handles the 'accum' pseudo register in inline asms. I originally
just applied it to time.c, but then I noticed that cpu-bugs64.c had an
inline asm that referenced 'accum', so I lifted the conditional macro
def to cpu.h, which was the only common header between time.c and
cpu-bugs64.c. Not really sure it's appropriate for cpu.h, but I didn't
want to create a new header.

Hope it's useful.

Clark


--=-tOhk/6yw0kseK7VOzIow
Content-Disposition: attachment; filename=mips_gcc34.patch
Content-Type: text/x-patch; name=mips_gcc34.patch; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

--- include/asm-mips/cpu.h.orig	2004-01-19 12:23:16.000000000 -0600
+++ include/asm-mips/cpu.h	2004-10-06 09:48:58.415989000 -0500
@@ -219,4 +219,14 @@
 #define MIPS_CPU_SUBSET_CACHES	0x00020000 /* P-cache subset enforced */
 #define MIPS_CPU_PREFETCH	0x00040000 /* CPU has usable prefetch */
 
+// hack for GCC 3.4 inline asm change
+
+#if __GNUC__ == 3 && __GNUC_MINOR__ < 4
+#define CLOBBER_LO "lo","accum"
+#define CLOBBER_HILO "hi", "lo", "accum"
+#else
+#define CLOBBER_LO "lo"
+#define CLOBBER_HILO "hi", "lo"
+#endif
+
 #endif /* _ASM_CPU_H */
--- arch/mips/kernel/time.c.orig	2004-09-19 07:30:04.000000000 -0500
+++ arch/mips/kernel/time.c	2004-10-06 09:49:13.360990000 -0500
@@ -277,7 +277,7 @@
 	__asm__("multu	%1,%2"
 		: "=h" (res)
 		: "r" (count), "r" (sll32_usecs_per_cycle)
-		: "lo", "accum");
+		: CLOBBER_LO);
 
 	/*
 	 * Due to possible jiffies inconsistencies, we need to check
@@ -332,7 +332,7 @@
 	__asm__("multu  %1,%2"
 		: "=h" (res)
 		: "r" (count), "r" (quotient)
-		: "lo", "accum");
+		: CLOBBER_LO);
 
 	/*
 	 * Due to possible jiffies inconsistencies, we need to check
@@ -374,7 +374,7 @@
 				: "r" (timerhi), "m" (timerlo),
 				  "r" (tmp), "r" (USECS_PER_JIFFY),
 				  "r" (USECS_PER_JIFFY_FRAC)
-				: "hi", "lo", "accum");
+				: CLOBBER_HILO);
 			cached_quotient = quotient;
 		}
 	}
@@ -388,7 +388,7 @@
 	__asm__("multu	%1,%2"
 		: "=h" (res)
 		: "r" (count), "r" (quotient)
-		: "lo", "accum");
+		: CLOBBER_LO);
 
 	/*
 	 * Due to possible jiffies inconsistencies, we need to check
--- arch/mips/kernel/cpu-bugs64.c.orig	2004-10-06 09:50:23.396989000 -0500
+++ arch/mips/kernel/cpu-bugs64.c	2004-10-06 09:50:41.006989000 -0500
@@ -82,7 +82,7 @@
 		".set	pop"
 		: "=&r" (lv1), "=r" (lw)
 		: "r" (m1), "r" (m2), "r" (s), "I" (0)
-		: "hi", "lo", "accum");
+		: CLOBBER_HILO);
 	/* We have to use single integers for m1 and m2 and a double
 	 * one for p to be sure the mulsidi3 gcc's RTL multiplication
 	 * instruction has the workaround applied.  Older versions of

--=-tOhk/6yw0kseK7VOzIow--
