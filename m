Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 22 Jan 2006 23:46:55 +0000 (GMT)
Received: from i-83-67-53-76.freedom2surf.net ([83.67.53.76]:20866 "EHLO
	nephila.localnet") by ftp.linux-mips.org with ESMTP
	id S8133491AbWAVXqe (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Sun, 22 Jan 2006 23:46:34 +0000
Received: from pdh by nephila.localnet with local (Exim 4.50)
	id 1F0oyk-0000v1-4v; Sun, 22 Jan 2006 23:50:38 +0000
Date:	Sun, 22 Jan 2006 23:50:38 +0000
To:	linux-mips@linux-mips.org
Cc:	ralf@linux-mips.org
Subject: Cobalt IDE fix
Message-ID: <20060122235038.GA3501@colonel-panic.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
From:	Peter Horton <pdh@colonel-panic.org>
Return-Path: <pdh@colonel-panic.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 10042
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: pdh@colonel-panic.org
Precedence: bulk
X-list: linux-mips

Fix long IDE detection delay by not scanning non-existent channels.

P.

Index: linux.git/include/asm-mips/mach-cobalt/ide.h
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux.git/include/asm-mips/mach-cobalt/ide.h	2006-01-22 23:17:03.000000000 +0000
@@ -0,0 +1,8 @@
+#ifndef __ASM_COBALT_IDE_H
+#define __ASM_COBALT_IDE_H
+
+#define MAX_HWIFS		2
+
+#include <asm/mach-generic/ide.h>
+
+#endif
