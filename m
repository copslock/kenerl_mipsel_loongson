Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 18 Dec 2002 01:36:11 +0000 (GMT)
Received: from cm19173.red.mundo-r.com ([IPv6:::ffff:213.60.19.173]:48100 "EHLO
	demo.mitica") by linux-mips.org with ESMTP id <S8225304AbSLRBgK>;
	Wed, 18 Dec 2002 01:36:10 +0000
Received: by demo.mitica (Postfix, from userid 501)
	id 1071BD657; Wed, 18 Dec 2002 02:42:05 +0100 (CET)
To: linux mips mailing list <linux-mips@linux-mips.org>,
	Ralf Baechle <ralf@linux-mips.org>
Subject: [PATCH]: protect includes from re-included them
X-Url: http://people.mandrakesoft.com/~quintela
From: Juan Quintela <quintela@mandrakesoft.com>
Date: 18 Dec 2002 02:42:05 +0100
Message-ID: <m2vg1sqf0y.fsf@demo.mitica>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-Path: <quintela@mandrakesoft.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 929
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: quintela@mandrakesoft.com
Precedence: bulk
X-list: linux-mips


Hi
        this included don't have the standard protection :(

Later, Juan.

Index: drivers/sgi/char/gconsole.h
===================================================================
RCS file: /home/cvs/linux/drivers/sgi/char/gconsole.h,v
retrieving revision 1.5
diff -u -r1.5 gconsole.h
--- drivers/sgi/char/gconsole.h	3 Mar 1998 16:57:28 -0000	1.5
+++ drivers/sgi/char/gconsole.h	18 Dec 2002 00:49:22 -0000
@@ -1,3 +1,7 @@
+#ifndef _SGI_GCONSOLE_H
+#define _SGI_GCONSOLE_H
+
+
 /*
  * This is a temporary measure, we should eventually migrate to
  * Gert's generic graphic console code.
@@ -31,3 +35,5 @@
 
 extern void disable_gconsole (void);
 extern void enable_gconsole (void);
+
+#endif /* _SGI_GCONSOLE */
Index: drivers/sgi/char/graphics.h
===================================================================
RCS file: /home/cvs/linux/drivers/sgi/char/graphics.h,v
retrieving revision 1.9.6.1
diff -u -r1.9.6.1 graphics.h
--- drivers/sgi/char/graphics.h	5 Aug 2002 23:53:40 -0000	1.9.6.1
+++ drivers/sgi/char/graphics.h	18 Dec 2002 01:28:49 -0000
@@ -1,3 +1,6 @@
+#ifndef _SGI_GRAPHICS_H
+#define _SGI_GRAPHICS_H
+
 #define MAXCARDS 4
 
 struct graphics_ops {
@@ -25,3 +28,5 @@
 
 void shmiq_init (void);
 void streamable_init (void);
+
+#endif /* _SGI_GRAPHICS_H */



-- 
In theory, practice and theory are the same, but in practice they 
are different -- Larry McVoy
