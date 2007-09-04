Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 04 Sep 2007 16:10:25 +0100 (BST)
Received: from phoenix.bawue.net ([193.7.176.60]:23528 "EHLO mail.bawue.net")
	by ftp.linux-mips.org with ESMTP id S20022650AbXIDPKQ (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 4 Sep 2007 16:10:16 +0100
Received: from lagash (intrt.mips-uk.com [194.74.144.130])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.bawue.net (Postfix) with ESMTP id 1A67687027
	for <linux-mips@linux-mips.org>; Tue,  4 Sep 2007 16:55:45 +0200 (CEST)
Received: from ths by lagash with local (Exim 4.67)
	(envelope-from <ths@networkno.de>)
	id 1ISZod-0004pT-9Y
	for linux-mips@linux-mips.org; Tue, 04 Sep 2007 15:55:43 +0100
Date:	Tue, 4 Sep 2007 15:55:43 +0100
From:	Thiemo Seufer <ths@networkno.de>
To:	linux-mips@linux-mips.org
Subject: [PATCH] Define known MIPS ISA overrides for sibyte and excite
	boards.
Message-ID: <20070904145543.GA9977@networkno.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.16 (2007-06-11)
Return-Path: <ths@networkno.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 16385
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ths@networkno.de
Precedence: bulk
X-list: linux-mips

Hello All,

the appended patch adds ISA overrides for excite and sibyte boards
(and fixes a mis-spelled comment).


Thiemo


diff --git a/include/asm-mips/mach-excite/cpu-feature-overrides.h b/include/asm-mips/mach-excite/cpu-feature-overrides.h
index 07f4322..107104c 100644
--- a/include/asm-mips/mach-excite/cpu-feature-overrides.h
+++ b/include/asm-mips/mach-excite/cpu-feature-overrides.h
@@ -34,6 +34,11 @@
 #define cpu_has_nofpuex		0
 #define cpu_has_64bits		1
 
+#define cpu_has_mips32r1	0
+#define cpu_has_mips32r2	0
+#define cpu_has_mips64r1	0
+#define cpu_has_mips64r2	0
+
 #define cpu_has_inclusive_pcaches	0
 
 #define cpu_dcache_line_size()	32
diff --git a/include/asm-mips/mach-sibyte/cpu-feature-overrides.h b/include/asm-mips/mach-sibyte/cpu-feature-overrides.h
index 63d5bf6..1c1f924 100644
--- a/include/asm-mips/mach-sibyte/cpu-feature-overrides.h
+++ b/include/asm-mips/mach-sibyte/cpu-feature-overrides.h
@@ -9,7 +9,7 @@
 #define __ASM_MACH_SIBYTE_CPU_FEATURE_OVERRIDES_H
 
 /*
- * Sibyte are MIPS64 processors weired to a specific configuration
+ * Sibyte are MIPS64 processors wired to a specific configuration
  */
 #define cpu_has_watch		1
 #define cpu_has_mips16		0
@@ -33,6 +33,11 @@
 #define cpu_has_nofpuex		0
 #define cpu_has_64bits		1
 
+#define cpu_has_mips32r1	1
+#define cpu_has_mips32r2	0
+#define cpu_has_mips64r1	1
+#define cpu_has_mips64r2	0
+
 #define cpu_has_inclusive_pcaches	0
 
 #define cpu_dcache_line_size()	32
