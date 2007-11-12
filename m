Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 12 Nov 2007 17:31:42 +0000 (GMT)
Received: from cerber.ds.pg.gda.pl ([153.19.208.18]:44207 "EHLO
	cerber.ds.pg.gda.pl") by ftp.linux-mips.org with ESMTP
	id S28577229AbXKLRbe (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 12 Nov 2007 17:31:34 +0000
Received: from localhost (unknown [127.0.0.17])
	by cerber.ds.pg.gda.pl (Postfix) with ESMTP id EB6F64008C;
	Mon, 12 Nov 2007 18:31:04 +0100 (CET)
X-Virus-Scanned: amavisd-new at cerber.ds.pg.gda.pl
Received: from cerber.ds.pg.gda.pl ([153.19.208.18])
	by localhost (cerber.ds.pg.gda.pl [153.19.208.18]) (amavisd-new, port 10024)
	with ESMTP id P823hnEXYEEr; Mon, 12 Nov 2007 18:30:59 +0100 (CET)
Received: from piorun.ds.pg.gda.pl (piorun.ds.pg.gda.pl [153.19.208.8])
	by cerber.ds.pg.gda.pl (Postfix) with ESMTP id A61E0400CE;
	Mon, 12 Nov 2007 18:30:59 +0100 (CET)
Received: from blysk.ds.pg.gda.pl (macro@blysk.ds.pg.gda.pl [153.19.208.6])
	by piorun.ds.pg.gda.pl (8.13.8/8.13.8) with ESMTP id lACHV4a0009743;
	Mon, 12 Nov 2007 18:31:04 +0100
Date:	Mon, 12 Nov 2007 17:30:52 +0000 (GMT)
From:	"Maciej W. Rozycki" <macro@linux-mips.org>
To:	Ralf Baechle <ralf@linux-mips.org>
cc:	linux-mips@linux-mips.org
Subject: [PATCH] arch/mips/Makefile: Fix canonical system names
Message-ID: <Pine.LNX.4.64N.0711121727000.30102@blysk.ds.pg.gda.pl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Virus-Scanned: ClamAV 0.91.2/4755/Mon Nov 12 15:41:11 2007 on piorun.ds.pg.gda.pl
X-Virus-Status:	Clean
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 17471
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@linux-mips.org
Precedence: bulk
X-list: linux-mips

 The GNU `config.guess' uses "linux-gnu" as the canonical system name.  
Fix the list of compiler prefixes checked to spell it correctly.

Signed-off-by: Maciej W. Rozycki <macro@linux-mips.org>
---
 I am assuming the current names are a result of a typo and that the extra 
spaces used here are for readability, so I have not removed them.

 Please apply.

  Maciej

patch-mips-2.6.23-20071023-mips-linux-gnu-0
diff -up --recursive --new-file linux-mips-2.6.23-20071023.macro/arch/mips/Makefile linux-mips-2.6.23-20071023/arch/mips/Makefile
--- linux-mips-2.6.23-20071023.macro/arch/mips/Makefile	2007-10-23 04:57:23.000000000 +0000
+++ linux-mips-2.6.23-20071023/arch/mips/Makefile	2007-11-11 19:04:39.000000000 +0000
@@ -44,7 +44,7 @@ endif
 
 ifneq ($(SUBARCH),$(ARCH))
   ifeq ($(CROSS_COMPILE),)
-    CROSS_COMPILE := $(call cc-cross-prefix, $(tool-archpref)-linux-  $(tool-archpref)-gnu-linux-  $(tool-archpref)-unknown-gnu-linux-)
+    CROSS_COMPILE := $(call cc-cross-prefix, $(tool-archpref)-linux-  $(tool-archpref)-linux-gnu-  $(tool-archpref)-unknown-linux-gnu-)
   endif
 endif
 
