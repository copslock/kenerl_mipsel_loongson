Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 16 Dec 2004 11:06:20 +0000 (GMT)
Received: from topsns.toshiba-tops.co.jp ([IPv6:::ffff:202.230.225.5]:49167
	"HELO topsns.toshiba-tops.co.jp") by linux-mips.org with SMTP
	id <S8224990AbULPLGL>; Thu, 16 Dec 2004 11:06:11 +0000
Received: from newms.toshiba-tops.co.jp by topsns.toshiba-tops.co.jp
          via smtpd (for mail.linux-mips.org [62.254.210.162]) with SMTP; 16 Dec 2004 11:06:09 UT
Received: from srd2sd.toshiba-tops.co.jp (gw-chiba7.toshiba-tops.co.jp [172.17.244.27])
	by newms.toshiba-tops.co.jp (Postfix) with ESMTP
	id 2333F239E3B; Thu, 16 Dec 2004 19:38:00 +0900 (JST)
Received: from localhost (fragile [172.17.28.65])
	by srd2sd.toshiba-tops.co.jp (8.12.10/8.12.10) with ESMTP id iBGAbxdD011927;
	Thu, 16 Dec 2004 19:37:59 +0900 (JST)
	(envelope-from anemo@mba.ocn.ne.jp)
Date: Thu, 16 Dec 2004 19:37:58 +0900 (JST)
Message-Id: <20041216.193758.130241219.nemoto@toshiba-tops.co.jp>
To: linux-mips@linux-mips.org
Cc: ralf@linux-mips.org
Subject: minor asm-mips/sigcontext.h fix
From: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
X-Fingerprint: 6ACA 1623 39BD 9A94 9B1A  B746 CA77 FE94 2874 D52F
X-Pgp-Public-Key: http://wwwkeys.pgp.net/pks/lookup?op=get&search=0x2874D52F
X-Mailer: Mew version 3.3 on Emacs 21.3 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-Path: <anemo@mba.ocn.ne.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 6696
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

The asm-mips/sigcontext.h uses '#ifdef __KERNEL__' to not export
sigcontext32 to userland.  It includes linux/types.h but it is needed
just for sigcontext32, so it would be better to hide from userland
too.

Here is a patch.  Could you apply?

--- linux-mips/include/asm-mips/sigcontext.h	2004-08-14 19:56:24.000000000 +0900
+++ linux/include/asm-mips/sigcontext.h	2004-12-16 19:02:43.922237317 +0900
@@ -41,8 +41,6 @@
                                                                                 
 #if _MIPS_SIM == _MIPS_SIM_ABI64 || _MIPS_SIM == _MIPS_SIM_NABI32
 
-#include <linux/types.h>
-
 /*
  * Keep this struct definition in sync with the sigcontext fragment
  * in arch/mips/tools/offset.c
@@ -66,6 +64,8 @@
 };
 
 #ifdef __KERNEL__
+#include <linux/types.h>
+
 struct sigcontext32 {
 	__u32	sc_regmask;		/* Unused */
 	__u32	sc_status;

---
Atsushi Nemoto
