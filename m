Received:  by oss.sgi.com id <S305171AbQDSSeE>;
	Wed, 19 Apr 2000 11:34:04 -0700
Received: from deliverator.sgi.com ([204.94.214.10]:30745 "EHLO
        deliverator.sgi.com") by oss.sgi.com with ESMTP id <S305163AbQDSSdu>;
	Wed, 19 Apr 2000 11:33:50 -0700
Received: from cthulhu.engr.sgi.com (gate3-relay.engr.sgi.com [130.62.1.234]) by deliverator.sgi.com (980309.SGI.8.8.8-aspam-6.2/980310.SGI-aspam) via ESMTP id LAA19055; Wed, 19 Apr 2000 11:29:06 -0700 (PDT)
	mail_from (owner-linux@cthulhu.engr.sgi.com)
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id LAA14786
	for linux-list;
	Wed, 19 Apr 2000 11:24:22 -0700 (PDT)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id LAA84795
	for <linux@cthulhu.engr.sgi.com>;
	Wed, 19 Apr 2000 11:24:20 -0700 (PDT)
	mail_from (flo@rfc822.org)
Received: from noose.gt.owl.de (noose.gt.owl.de [62.52.19.4]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id LAA08813
	for <linux@cthulhu.engr.sgi.com>; Wed, 19 Apr 2000 11:24:19 -0700 (PDT)
	mail_from (flo@rfc822.org)
Received: by noose.gt.owl.de (Postfix, from userid 10)
	id 23A237FB; Wed, 19 Apr 2000 20:24:21 +0200 (CEST)
Received: by paradigm.rfc822.org (Postfix, from userid 1000)
	id 07FB48FC4; Wed, 19 Apr 2000 20:19:39 +0200 (CEST)
Date:   Wed, 19 Apr 2000 20:19:39 +0200
From:   Florian Lohoff <flo@rfc822.org>
To:     linux@cthulhu.engr.sgi.com, linux-kernel@vger.rutgers.edu
Subject: include/linux/serial.h
Message-ID: <20000419201939.B276@paradigm.rfc822.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.95.3i
Organization: rfc822 - pure communication
Sender: owner-linuxmips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linuxmips@oss.sgi.com>
X-Orcpt: rfc822;linuxmips-outgoing

Hi,
shouldnt include/linux/serial.h include asm/types.h ?

It uses __u32 which causes a bomb out when i am trying to 
compile util-linux.

Otherwise ifdef __KERNEL__ around struct async_icount

Index: serial.h
===================================================================
RCS file: /cvs/linux/include/linux/serial.h,v
retrieving revision 1.12
diff -u -r1.12 serial.h
--- serial.h    2000/03/27 23:54:41     1.12
+++ serial.h    2000/04/19 18:21:01
@@ -11,6 +11,7 @@
 #define _LINUX_SERIAL_H
 
 #include <asm/page.h>
+#include <asm/types.h>
 
 /*
  * Counters of the input lines (CTS, DSR, RI, CD) interrupts

Flo
-- 
Florian Lohoff		flo@rfc822.org		      	+49-subject-2-change
"Technology is a constant battle between manufacturers producing bigger and
more idiot-proof systems and nature producing bigger and better idiots."
