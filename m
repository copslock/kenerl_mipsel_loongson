Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.3/8.11.3) id f44BoLx05566
	for linux-mips-outgoing; Fri, 4 May 2001 04:50:21 -0700
Received: from noose.gt.owl.de (postfix@noose.gt.owl.de [62.52.19.4])
	by oss.sgi.com (8.11.3/8.11.3) with ESMTP id f44BoKF05562
	for <linux-mips@oss.sgi.com>; Fri, 4 May 2001 04:50:20 -0700
Received: by noose.gt.owl.de (Postfix, from userid 10)
	id 1E6267F4; Fri,  4 May 2001 13:50:18 +0200 (CEST)
Received: by paradigm.rfc822.org (Postfix, from userid 1000)
	id 81416F38C; Fri,  4 May 2001 13:49:58 +0200 (CEST)
Date: Fri, 4 May 2001 13:49:58 +0200
From: Florian Lohoff <flo@rfc822.org>
To: linux-mips@oss.sgi.com
Subject: drivers/chat/vt.c - keyboard click
Message-ID: <20010504134958.A513@paradigm.rfc822.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.15i
Organization: rfc822 - pure communication
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk


Hi,
i found this snippet:

drivers/char/vt.c:

     85 /*
     86  * Generates sound of some frequency for some number of clock ticks
     87  *
     88  * If freq is 0, will turn off sound, else will turn it on for that time.
     89  * If msec is 0, will return immediately, else will sleep for msec time, then
     90  * turn sound off.
     91  *
     92  * We also return immediately, which is what was implied within the X
     93  * comments - KDMKTONE doesn't put the process to sleep.
     94  */
     95
     96 #if defined(__i386__) || defined(__alpha__) || defined(__powerpc__) \
     97     || (defined(__mips__) && defined(CONFIG_ISA)) \
     98     || (defined(__arm__) && defined(CONFIG_HOST_FOOTBRIDGE))


Does any of the currently supported mips architectures actually support
this ? I guess the RM200 could but i dont think that tree will actually work.

I suggest to apply this:

Index: drivers/char/vt.c
===================================================================
RCS file: /cvs/linux/drivers/char/vt.c,v
retrieving revision 1.30
diff -u -r1.30 vt.c
--- drivers/char/vt.c	2001/03/09 20:33:59	1.30
+++ drivers/char/vt.c	2001/05/04 11:44:13
@@ -94,7 +94,7 @@
  */
 
 #if defined(__i386__) || defined(__alpha__) || defined(__powerpc__) \
-    || (defined(__mips__) && defined(CONFIG_ISA)) \
+    || !defined(__mips__) \
     || (defined(__arm__) && defined(CONFIG_HOST_FOOTBRIDGE))
 
 static void


As most mips architectures having ISA dont support this - Any the ones
who actually want it may enable it instead of the 10-20 subarchs which
dont support it do disable this.

Flo
-- 
Florian Lohoff                  flo@rfc822.org             +49-5201-669912
     Why is it called "common sense" when nobody seems to have any?
