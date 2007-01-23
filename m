Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 23 Jan 2007 13:29:12 +0000 (GMT)
Received: from mba.ocn.ne.jp ([210.190.142.172]:22002 "HELO smtp.mba.ocn.ne.jp")
	by ftp.linux-mips.org with SMTP id S20040239AbXAWN3L (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 23 Jan 2007 13:29:11 +0000
Received: from localhost (p2057-ipad205funabasi.chiba.ocn.ne.jp [222.146.97.57])
	by smtp.mba.ocn.ne.jp (Postfix) with ESMTP
	id 5FF49B6DF; Tue, 23 Jan 2007 22:29:06 +0900 (JST)
Date:	Tue, 23 Jan 2007 22:29:06 +0900 (JST)
Message-Id: <20070123.222906.41198626.anemo@mba.ocn.ne.jp>
To:	linux-mips@linux-mips.org
Cc:	ralf@linux-mips.org
Subject: [PATCH] Remove _fdata from asm-mips/sections.h
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
X-Fingerprint: 6ACA 1623 39BD 9A94 9B1A  B746 CA77 FE94 2874 D52F
X-Pgp-Public-Key: http://wwwkeys.pgp.net/pks/lookup?op=get&search=0x2874D52F
X-Mailer: Mew version 3.3 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-Path: <anemo@mba.ocn.ne.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 13745
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

There is no _fdata symbol in kernel.

Signed-off-by: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
---
diff --git a/include/asm-mips/sections.h b/include/asm-mips/sections.h
index f701627..b7e3726 100644
--- a/include/asm-mips/sections.h
+++ b/include/asm-mips/sections.h
@@ -3,6 +3,4 @@
 
 #include <asm-generic/sections.h>
 
-extern char _fdata;
-
 #endif /* _ASM_SECTIONS_H */
