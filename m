Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 20 Feb 2003 20:47:05 +0000 (GMT)
Received: from gateway-1237.mvista.com ([IPv6:::ffff:12.44.186.158]:52217 "EHLO
	orion.mvista.com") by linux-mips.org with ESMTP id <S8225198AbTBTUrE>;
	Thu, 20 Feb 2003 20:47:04 +0000
Received: (from jsun@localhost)
	by orion.mvista.com (8.11.6/8.11.6) id h1KKl3Y26145;
	Thu, 20 Feb 2003 12:47:03 -0800
Date: Thu, 20 Feb 2003 12:47:03 -0800
From: Jun Sun <jsun@mvista.com>
To: linux-mips@linux-mips.org
Cc: jsun@mvista.com
Subject: [PATCH] allow CROSS_COMPILE override
Message-ID: <20030220124703.H7466@mvista.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="ULyIDA2m8JTe+TiX"
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Return-Path: <jsun@orion.mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 1486
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jsun@mvista.com
Precedence: bulk
X-list: linux-mips


--ULyIDA2m8JTe+TiX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Anybody would object this?  It allows one to override
CROSS_COMPILE from command line or top-level Makefile.

Jun


--ULyIDA2m8JTe+TiX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="030220.b-2.4-allow-CROSS_COMPILE-override.patch"

diff -Nru linux/arch/mips/Makefile.orig linux/arch/mips/Makefile
--- linux/arch/mips/Makefile.orig	Thu Feb 20 10:49:18 2003
+++ linux/arch/mips/Makefile	Thu Feb 20 12:18:53 2003
@@ -23,7 +23,9 @@
 endif
 
 ifdef CONFIG_CROSSCOMPILE
-CROSS_COMPILE	= $(tool-prefix)
+  ifndef CROSS_COMPILE
+    CROSS_COMPILE	= $(tool-prefix)
+  endif
 endif
 
 #

--ULyIDA2m8JTe+TiX--
