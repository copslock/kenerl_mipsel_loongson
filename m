Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.5/8.12.5) with ESMTP id g6BMZcRw024942
	for <linux-mips-outgoing@oss.sgi.com>; Thu, 11 Jul 2002 15:35:38 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.5/8.12.3/Submit) id g6BMZct5024941
	for linux-mips-outgoing; Thu, 11 Jul 2002 15:35:38 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from laposte.enst-bretagne.fr (laposte.enst-bretagne.fr [192.108.115.3])
	by oss.sgi.com (8.12.5/8.12.5) with SMTP id g6BMZSRw024932;
	Thu, 11 Jul 2002 15:35:29 -0700
Received: from resel.enst-bretagne.fr (UNKNOWN@maisel-gw.enst-bretagne.fr [192.44.76.8])
	by laposte.enst-bretagne.fr (8.11.6/8.11.6) with ESMTP id g6BMdsC26624;
	Fri, 12 Jul 2002 00:39:54 +0200
Received: from melkor (mail@melkor.maisel.enst-bretagne.fr [172.16.20.65])
	by resel.enst-bretagne.fr (8.12.3/8.12.3/Debian -4) with ESMTP id g6BMdtTF015340;
	Fri, 12 Jul 2002 00:39:55 +0200
Received: from glaurung (helo=localhost)
	by melkor with local-esmtp (Exim 3.35 #1 (Debian))
	id 17SmbK-0001dQ-00; Fri, 12 Jul 2002 00:39:54 +0200
Date: Fri, 12 Jul 2002 00:39:54 +0200 (CEST)
From: Vivien Chappelier <vivien.chappelier@enst-bretagne.fr>
X-Sender: glaurung@melkor
To: Ralf Baechle <ralf@oss.sgi.com>
cc: linux-mips@oss.sgi.com
Subject: [2.5 PATCH] __ffs implementation
Message-ID: <Pine.LNX.4.21.0207120036500.6272-100000@melkor>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Virus-Scanned: by amavisd-milter (http://amavis.org/) at enst-bretagne.fr
X-Spam-Status: No, hits=-5.0 required=5.0 tests=UNIFIED_PATCH version=2.20
X-Spam-Level: 
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

Hi,

	Fixes __ffs(x) implementation for the 2.5.4 kernel on mips and
mips64 : ffz(~x) instead of ffz(x).

Vivien.

--- linux/include/asm-mips/bitops.h	Mon Jul  8 22:28:08 2002
+++ linux.patch/include/asm-mips/bitops.h	Fri Jul 12 00:04:26 2002
@@ -732,7 +732,7 @@
  */
 static __inline__ unsigned long __ffs(unsigned long word)
 {
-	return ffz(word);
+	return ffz(~word);
 }
 
 #ifdef __KERNEL__
--- linux/include/asm-mips64/bitops.h	Wed Jul 10 00:30:31 2002
+++ linux.patch/include/asm-mips64/bitops.h	Fri Jul 12 00:04:13 2002
@@ -444,7 +444,7 @@
  */
 static __inline__ unsigned long __ffs(unsigned long word)
 {
-	return ffz(word);
+	return ffz(~word);
 }
 
 /*
