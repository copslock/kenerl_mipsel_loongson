Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 10 Oct 2004 18:12:05 +0100 (BST)
Received: from adsl-68-124-224-226.dsl.snfc21.pacbell.net ([IPv6:::ffff:68.124.224.226]:17419
	"EHLO goobz.com") by linux-mips.org with ESMTP id <S8224986AbUJJRMB>;
	Sun, 10 Oct 2004 18:12:01 +0100
Received: from [10.2.2.20] (adsl-63-194-214-47.dsl.snfc21.pacbell.net [63.194.214.47])
	by goobz.com (8.10.1/8.10.1) with ESMTP id i9AHBwu14483
	for <linux-mips@linux-mips.org>; Sun, 10 Oct 2004 10:11:58 -0700
Subject: PATCH
From: Pete Popov <ppopov@embeddedalley.com>
To: "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>
Content-Type: text/plain
Organization: 
Message-Id: <1097428659.4627.10.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-4) 
Date: 10 Oct 2004 10:17:39 -0700
Content-Transfer-Encoding: 7bit
Return-Path: <ppopov@embeddedalley.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 5996
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ppopov@embeddedalley.com
Precedence: bulk
X-list: linux-mips

Ralf, or anyone else, any suggestions on how to get a patch like the one
below accepted in 2.6? It's needed due to the 36 bit address of the
pcmcia controller on the Au1x CPUs.

diff -Naur --exclude=CVS linux-2.6-orig/include/pcmcia/cs_types.h linux-2.6-dev/include/pcmcia/cs_types.h
--- linux-2.6-orig/include/pcmcia/cs_types.h	2004-02-24 18:09:31.000000000 -0800
+++ linux-2.6-dev/include/pcmcia/cs_types.h	2004-09-25 19:57:11.000000000 -0700
@@ -36,8 +36,10 @@
 #include <sys/types.h>
 #endif
 
-#if defined(__arm__) || defined(__mips__)
-typedef u_int   ioaddr_t;
+#if defined(__arm__)
+typedef u_int ioaddr_t;
+#elif defined(__mips__)
+typedef phys_t ioaddr_t;
 #else
 typedef u_short	ioaddr_t;
 #endif
diff -Naur --exclude=CVS linux-2.6-orig/include/pcmcia/ss.h linux-2.6-dev/include/pcmcia/ss.h
--- linux-2.6-orig/include/pcmcia/ss.h	2004-09-22 23:20:17.000000000 -0700
+++ linux-2.6-dev/include/pcmcia/ss.h	2004-09-25 19:57:47.000000000 -0700
@@ -103,7 +103,7 @@
     u_char	map;
     u_char	flags;
     u_short	speed;
-    u_long	static_start;
+    ioaddr_t	static_start;
     u_int	card_start;
     struct resource *res;
 } pccard_mem_map;
