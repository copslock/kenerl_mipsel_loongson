Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 12 Nov 2005 23:36:53 +0000 (GMT)
Received: from smtp5-g19.free.fr ([212.27.42.35]:17132 "EHLO smtp5-g19.free.fr")
	by ftp.linux-mips.org with ESMTP id S8133893AbVKLXgf (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Sat, 12 Nov 2005 23:36:35 +0000
Received: from groumpf (str90-1-82-238-123-182.fbx.proxad.net [82.238.123.182])
	by smtp5-g19.free.fr (Postfix) with ESMTP id 119E19631;
	Sun, 13 Nov 2005 00:38:19 +0100 (CET)
Received: from jekyll.groumpf.homeip.net ([192.168.1.1] helo=jekyll)
	by groumpf with esmtp (Exim 4.50)
	id 1Eb4ws-0003IS-Fk; Sun, 13 Nov 2005 00:38:18 +0100
Received: from arnaud by jekyll with local (Exim 4.50)
	id 1Eb4ws-000071-0L; Sun, 13 Nov 2005 00:38:18 +0100
To:	ralf@linux-mips.org
Subject: [PATCH] Export IP32 mace symbol
Cc:	linux-mips@linux-mips.org
Message-Id: <E1Eb4ws-000071-0L@jekyll>
From:	Arnaud Giersch <arnaud.giersch@free.fr>
Date:	Sun, 13 Nov 2005 00:38:18 +0100
Return-Path: <arnaud.giersch@free.fr>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 9475
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: arnaud.giersch@free.fr
Precedence: bulk
X-list: linux-mips

Export mace symbol so that it can be used in modules.

Signed-off-by: Arnaud Giersch <arnaud.giersch@free.fr>
---

 Ralf, you told me that this was OK but you did not committed it.

 crime.c |    3 +++
 1 files changed, 3 insertions(+)

diff --git a/arch/mips/sgi-ip32/crime.c b/arch/mips/sgi-ip32/crime.c
--- a/arch/mips/sgi-ip32/crime.c
+++ b/arch/mips/sgi-ip32/crime.c
@@ -10,6 +10,7 @@
 #include <linux/init.h>
 #include <linux/kernel.h>
 #include <linux/interrupt.h>
+#include <linux/module.h>
 #include <asm/bootinfo.h>
 #include <asm/io.h>
 #include <asm/mipsregs.h>
@@ -21,6 +22,8 @@
 struct sgi_crime *crime;
 struct sgi_mace *mace;
 
+EXPORT_SYMBOL_GPL(mace);
+
 void __init crime_init(void)
 {
 	unsigned int id, rev;
