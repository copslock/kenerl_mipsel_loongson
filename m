Received:  by oss.sgi.com id <S305200AbQC3Myk>;
	Thu, 30 Mar 2000 04:54:40 -0800
Received: from deliverator.sgi.com ([204.94.214.10]:17458 "EHLO
        deliverator.sgi.com") by oss.sgi.com with ESMTP id <S305168AbQC3MyT>;
	Thu, 30 Mar 2000 04:54:19 -0800
Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by deliverator.sgi.com (980309.SGI.8.8.8-aspam-6.2/980310.SGI-aspam) via ESMTP id EAA27979; Thu, 30 Mar 2000 04:49:38 -0800 (PST)
	mail_from (owner-linux@cthulhu.engr.sgi.com)
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id EAA90979
	for linux-list;
	Thu, 30 Mar 2000 04:36:05 -0800 (PST)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id EAA14888
	for <linux@cthulhu.engr.sgi.com>;
	Thu, 30 Mar 2000 04:35:59 -0800 (PST)
	mail_from (flo@rfc822.org)
Received: from noose.gt.owl.de (noose.gt.owl.de [62.52.19.4]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id EAA00308
	for <linux@cthulhu.engr.sgi.com>; Thu, 30 Mar 2000 04:35:57 -0800 (PST)
	mail_from (flo@rfc822.org)
Received: by noose.gt.owl.de (Postfix, from userid 10)
	id 5B0967F4; Thu, 30 Mar 2000 14:35:56 +0200 (CEST)
Received: by paradigm.rfc822.org (Postfix, from userid 1000)
	id E85448FC3; Thu, 30 Mar 2000 14:22:56 +0200 (CEST)
Date:   Thu, 30 Mar 2000 14:22:56 +0200
From:   Florian Lohoff <flo@rfc822.org>
To:     linux@cthulhu.engr.sgi.com
Subject: timex.h patch / CP0 undefined
Message-ID: <20000330142256.A3530@paradigm.rfc822.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.95.3i
Organization: rfc822 - pure communication
Sender: owner-linuxmips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linuxmips@oss.sgi.com>
X-Orcpt: rfc822;linuxmips-outgoing


Hi,
could someone apply this patch to the cvs archive.
This bites me everytime i am trying to build "ntp" or "xntp".

Index: timex.h
===================================================================
RCS file: /cvs/linux/include/asm-mips/timex.h,v
retrieving revision 1.2
diff -u -r1.2 timex.h
--- timex.h	1999/02/15 02:22:14	1.2
+++ timex.h	2000/03/30 12:16:47
@@ -17,6 +17,8 @@
 	(1000000/CLOCK_TICK_FACTOR) / (CLOCK_TICK_RATE/CLOCK_TICK_FACTOR)) \
 		<< (SHIFT_SCALE-SHIFT_HZ)) / HZ)
 
+#ifdef __KERNEL__
+
 /*
  * Standard way to access the cycle counter.
  * Currently only used on SMP for scheduling.
@@ -36,4 +38,5 @@
 	return read_32bit_cp0_register(CP0_COUNT);
 }
 
+#endif /* __KERNEL__ */
 #endif /*  __ASM_MIPS_TIMEX_H */

Flo
-- 
Florian Lohoff		flo@rfc822.org		      	+49-5241-470566
"Technology is a constant battle between manufacturers producing bigger and
more idiot-proof systems and nature producing bigger and better idiots."
