Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 23 Jan 2006 22:30:04 +0000 (GMT)
Received: from i-83-67-53-76.freedom2surf.net ([83.67.53.76]:30148 "EHLO
	nephila.localnet") by ftp.linux-mips.org with ESMTP
	id S3458400AbWAWW3q (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 23 Jan 2006 22:29:46 +0000
Received: from pdh by nephila.localnet with local (Exim 4.50)
	id 1F1AG2-0000hg-VB; Mon, 23 Jan 2006 22:33:54 +0000
Date:	Mon, 23 Jan 2006 22:33:54 +0000
To:	linux-mips@linux-mips.org
Cc:	ralf@linux-mips.org
Subject: [PATCH 2.6.x] Cobalt IDE fix, take 2
Message-ID: <20060123223354.GA2698@colonel-panic.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
From:	Peter Horton <pdh@colonel-panic.org>
Return-Path: <pdh@colonel-panic.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 10082
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: pdh@colonel-panic.org
Precedence: bulk
X-list: linux-mips

Fix long boot delay on Cobalt scanning non-existent IDE interfaces.

P.

Index: linux.git/include/asm-mips/mach-cobalt/ide.h
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux.git/include/asm-mips/mach-cobalt/ide.h	2006-01-23 22:04:15.000000000 +0000
@@ -0,0 +1,8 @@
+#ifndef __ASM_COBALT_IDE_H
+#define __ASM_COBALT_IDE_H
+
+#define MAX_LEGACY_HWIFS	2
+
+#include <asm/mach-generic/ide.h>
+
+#endif
Index: linux.git/include/asm-mips/mach-generic/ide.h
===================================================================
--- linux.git.orig/include/asm-mips/mach-generic/ide.h	2006-01-23 22:04:10.000000000 +0000
+++ linux.git/include/asm-mips/mach-generic/ide.h	2006-01-23 22:30:38.000000000 +0000
@@ -28,6 +28,10 @@
 # endif
 #endif
 
+#ifndef MAX_LEGACY_HWIFS
+# define MAX_LEGACY_HWIFS	6
+#endif
+
 #define IDE_ARCH_OBSOLETE_DEFAULTS
 
 static __inline__ int ide_probe_legacy(void)
@@ -73,7 +77,7 @@
 
 static __inline__ unsigned long ide_default_io_base(int index)
 {
-	if (ide_probe_legacy())
+	if (index < MAX_LEGACY_HWIFS && ide_probe_legacy())
 		switch (index) {
 		case 0:
 			return 0x1f0;
