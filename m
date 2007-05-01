Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 01 May 2007 19:14:05 +0100 (BST)
Received: from phoenix.bawue.net ([193.7.176.60]:22764 "EHLO mail.bawue.net")
	by ftp.linux-mips.org with ESMTP id S20022838AbXEASOD (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 1 May 2007 19:14:03 +0100
Received: from lagash (intrt.mips-uk.com [194.74.144.130])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.bawue.net (Postfix) with ESMTP id 7A86CB8C56;
	Tue,  1 May 2007 20:13:28 +0200 (CEST)
Received: from ths by lagash with local (Exim 4.67)
	(envelope-from <ths@networkno.de>)
	id 1Hiwrg-0004MI-Un; Tue, 01 May 2007 19:14:16 +0100
Date:	Tue, 1 May 2007 19:14:16 +0100
To:	linux-mips@linux-mips.org
Cc:	ralf@linux-mips.org
Subject: [PATCH] Add a __ucmpdi2 implementation
Message-ID: <20070501181416.GD30083@networkno.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
From:	Thiemo Seufer <ths@networkno.de>
Return-Path: <ths@networkno.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 14959
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ths@networkno.de
Precedence: bulk
X-list: linux-mips

Hello All,

this patch adds a __ucmpdi2 implementation, recent GCC SVN versions
generate calls to it from some of the FPU emulator functions.

Tested by building and booting a little endian qemu MIPS kernel.


Thiemo


Signed-off-by: Thiemo Seufer <ths@networkno.de>

diff --git a/arch/mips/lib/Makefile b/arch/mips/lib/Makefile
index d7d3b14..5dad13e 100644
--- a/arch/mips/lib/Makefile
+++ b/arch/mips/lib/Makefile
@@ -9,4 +9,4 @@ obj-y			+= iomap.o
 obj-$(CONFIG_PCI)	+= iomap-pci.o
 
 # libgcc-style stuff needed in the kernel
-lib-y += ashldi3.o ashrdi3.o lshrdi3.o
+lib-y += ashldi3.o ashrdi3.o lshrdi3.o ucmpdi2.o
diff --git a/arch/mips/lib/ucmpdi2.c b/arch/mips/lib/ucmpdi2.c
new file mode 100644
index 0000000..e9ff258
--- /dev/null
+++ b/arch/mips/lib/ucmpdi2.c
@@ -0,0 +1,19 @@
+#include <linux/module.h>
+
+#include "libgcc.h"
+
+word_type __ucmpdi2 (unsigned long a, unsigned long b)
+{
+	const DWunion au = {.ll = a};
+	const DWunion bu = {.ll = b};
+
+	if ((unsigned int) au.s.high < (unsigned int) bu.s.high)
+		return 0;
+	else if ((unsigned int) au.s.high > (unsigned int) bu.s.high)
+		return 2;
+	if ((unsigned int) au.s.low < (unsigned int) bu.s.low)
+		return 0;
+	else if ((unsigned int) au.s.low > (unsigned int) bu.s.low)
+		return 2;
+	return 1;
+}
