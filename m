Received:  by oss.sgi.com id <S305176AbQC3MsB>;
	Thu, 30 Mar 2000 04:48:01 -0800
Received: from deliverator.sgi.com ([204.94.214.10]:46641 "EHLO
        deliverator.sgi.com") by oss.sgi.com with ESMTP id <S305168AbQC3Mro>;
	Thu, 30 Mar 2000 04:47:44 -0800
Received: from nodin.corp.sgi.com (fddi-nodin.corp.sgi.com [198.29.75.193]) by deliverator.sgi.com (980309.SGI.8.8.8-aspam-6.2/980310.SGI-aspam) via ESMTP id EAA27678; Thu, 30 Mar 2000 04:43:03 -0800 (PST)
	mail_from (owner-linux@cthulhu.engr.sgi.com)
Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by nodin.corp.sgi.com (980427.SGI.8.8.8/980728.SGI.AUTOCF) via ESMTP id EAA54718; Thu, 30 Mar 2000 04:47:13 -0800 (PST)
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id EAA63179
	for linux-list;
	Thu, 30 Mar 2000 04:36:01 -0800 (PST)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id EAA62401
	for <linux@cthulhu.engr.sgi.com>;
	Thu, 30 Mar 2000 04:35:59 -0800 (PST)
	mail_from (flo@rfc822.org)
Received: from noose.gt.owl.de (noose.gt.owl.de [62.52.19.4]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id EAA05757
	for <linux@cthulhu.engr.sgi.com>; Thu, 30 Mar 2000 04:35:57 -0800 (PST)
	mail_from (flo@rfc822.org)
Received: by noose.gt.owl.de (Postfix, from userid 10)
	id D14E67F6; Thu, 30 Mar 2000 14:35:56 +0200 (CEST)
Received: by paradigm.rfc822.org (Postfix, from userid 1000)
	id 51E3B8FC3; Thu, 30 Mar 2000 14:27:05 +0200 (CEST)
Date:   Thu, 30 Mar 2000 14:27:05 +0200
From:   Florian Lohoff <flo@rfc822.org>
To:     linux@cthulhu.engr.sgi.com
Subject: resources.h patch / RLIM_INFINITY __KERNEL__ depend ?
Message-ID: <20000330142705.B3530@paradigm.rfc822.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.95.3i
Organization: rfc822 - pure communication
Sender: owner-linuxmips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linuxmips@oss.sgi.com>
X-Orcpt: rfc822;linuxmips-outgoing


Hi,
again - short patch - RLIM_INFINITY - This is also defined in
both glibc 2.0 and glibc 2.1 headers so it should be __KERNEL__
dependend - Shouldnt it ?


Index: resource.h
===================================================================
RCS file: /cvs/linux/include/asm-mips/resource.h,v
retrieving revision 1.5
diff -u -r1.5 resource.h
--- resource.h	2000/02/04 07:40:53	1.5
+++ resource.h	2000/03/30 12:19:42
@@ -25,13 +25,13 @@
 
 #define RLIM_NLIMITS 10			/* Number of limit flavors.  */
 
+#ifdef __KERNEL__
+
 /*
  * SuS says limits have to be unsigned.
  * Which makes a ton more sense anyway.
  */
 #define RLIM_INFINITY	0x7fffffffUL
-
-#ifdef __KERNEL__
 
 #define INIT_RLIMITS					\
 {							\



Flo
-- 
Florian Lohoff		flo@rfc822.org		      	+49-5241-470566
"Technology is a constant battle between manufacturers producing bigger and
more idiot-proof systems and nature producing bigger and better idiots."
