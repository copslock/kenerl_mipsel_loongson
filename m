Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 18 Apr 2005 10:46:27 +0100 (BST)
Received: from moutng.kundenserver.de ([IPv6:::ffff:212.227.126.176]:41466
	"EHLO moutng.kundenserver.de") by linux-mips.org with ESMTP
	id <S8225474AbVDRJpg>; Mon, 18 Apr 2005 10:45:36 +0100
Received: from [212.227.126.208] (helo=mrelayng.kundenserver.de)
	by moutng.kundenserver.de with esmtp (Exim 3.35 #1)
	id 1DNSox-0004du-00; Mon, 18 Apr 2005 11:45:35 +0200
Received: from [213.39.254.66] (helo=tuxator.satorlaser-intern.com)
	by mrelayng.kundenserver.de with asmtp (TLSv1:RC4-MD5:128)
	(Exim 3.35 #1)
	id 1DNSox-00073V-00; Mon, 18 Apr 2005 11:45:35 +0200
From:	Ulrich Eckhardt <eckhardt@satorlaser.com>
Organization: Sator Laser GmbH
To:	linux-mips@linux-mips.org
Subject: [patch] add missing declaration of smp_processor_id
Date:	Mon, 18 Apr 2005 11:46:26 +0200
User-Agent: KMail/1.7.2
Cc:	ralf@linux-mips.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200504181146.26588.eckhardt@satorlaser.com>
X-Provags-ID: kundenserver.de abuse@kundenserver.de auth:e35cee35a663f5c944b9750a965814ae
Return-Path: <eckhardt@satorlaser.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 7743
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: eckhardt@satorlaser.com
Precedence: bulk
X-list: linux-mips

The missing declaration leads to warnings during compilation for Alchemy 
boards.

Changes
 * include <linux/smp.h> because udelay() needs smp_processor_id

cheers

Uli
---

Index: include/asm-mips/delay.h
===================================================================
RCS file: /home/cvs/linux/include/asm-mips/delay.h,v
retrieving revision 1.17
diff -u -w -r1.17 delay.h
--- include/asm-mips/delay.h	13 Apr 2005 13:37:32 -0000	1.17
+++ include/asm-mips/delay.h	18 Apr 2005 09:38:25 -0000
@@ -12,7 +12,7 @@
 
 #include <linux/config.h>
 #include <linux/param.h>
-
+#include <linux/smp.h>
 #include <asm/compiler.h>
 
 static inline void __delay(unsigned long loops)
