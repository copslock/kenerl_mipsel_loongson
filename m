Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 28 Jun 2006 17:40:29 +0100 (BST)
Received: from father.pmc-sierra.com ([216.241.224.13]:29626 "HELO
	father.pmc-sierra.bc.ca") by ftp.linux-mips.org with SMTP
	id S8133367AbWF1QkT (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 28 Jun 2006 17:40:19 +0100
Received: (qmail 15120 invoked by uid 101); 28 Jun 2006 16:40:08 -0000
Received: from unknown (HELO ogyruan.pmc-sierra.bc.ca) (216.241.226.236)
  by father.pmc-sierra.com with SMTP; 28 Jun 2006 16:40:08 -0000
Received: from girvin.pmc-sierra.bc.ca (girvin.pmc-sierra.bc.ca [134.87.183.37])
	by ogyruan.pmc-sierra.bc.ca (8.13.3/8.12.7) with ESMTP id k5SGe7pU016953
	for <linux-mips@linux-mips.org>; Wed, 28 Jun 2006 09:40:07 -0700
Subject: errno value for EDQUOT on MIPS
From:	Erik Frederiksen <erik_frederiksen@pmc-sierra.com>
To:	linux-mips@linux-mips.org
Content-Type: text/plain
Organization: PMC-Sierra
Message-Id: <1151512806.3901.1082.camel@girvin.pmc-sierra.bc.ca>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-17) 
Date:	Wed, 28 Jun 2006 10:40:07 -0600
Content-Transfer-Encoding: 7bit
Return-Path: <erik_frederiksen@pmc-sierra.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 11880
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: erik_frederiksen@pmc-sierra.com
Precedence: bulk
X-list: linux-mips

from include/asm-mips/errno.h
#define EDQUOT      1133    /* Quota exceeded */

Hi everyone.  I'm kind of confused as to why the value for EDQUOT is so
large on MIPS.  It seems like no other architectures have errnos that go
that high.

The reason I'm interested is that functions that use ERR_PTR() to return
error codes in pointers cannot return this error code without IS_ERR()
thinking that the pointer is valid.  In my case, it caused an alignment
exception in the XFS open call when quota has been exceeded.  This takes
place in the linux-mips 2.6.14 kernel.  

I think that the XFS code has changed enough that this bug isn't in
newer versions, though I'm not sure about that.  I've supplied a patch
that addresses this situation by changing the threshold used by IS_ERR
if EMAXERRNO is defined and greater than 1000.  Looking forward to your
feedback.

Erik Frederiksen
Firmware Design Engineer Co-op
PMC-Sierra Saskatoon




diff -Nau [ab]/include/linux/err.h
--- a/include/linux/err.h       2005-10-30 13:14:22.000000000 -0600
+++ b/include/linux/err.h       2006-06-28 10:38:43.000000000 -0600
@@ -12,8 +12,23 @@
  *
  * This should be a per-architecture thing, to allow different
  * error and pointer decisions.
+ *
+ * Updated by Erik Frederiksen (erik_frederiksen@pmc-sierra.com)
+ * errno values on MIPS go up to 1133 for EDQUOT.  The threshold
+ * is adjusted so that returning large errnos in a pointer
+ * does not result in a valid pointer according to IS_ERR.
  */
-#define IS_ERR_VALUE(x) unlikely((x) > (unsigned long)-1000L)
+
+#define ERR_PTR_THRESHOLD 1000
+#define IS_ERR_VALUE(x) \
+       unlikely((x) > (unsigned long)-(long)ERR_PTR_THRESHOLD )
+#ifdef EMAXERRNO
+# if EMAXERRNO >= ERR_PTR_THRESHOLD
+#  undef IS_ERR_VALUE
+#  define IS_ERR_VALUE(x) \
+       unlikely((x) >= (unsigned long)-(long)EMAXERRNO )
+# endif
+#endif
  
 static inline void *ERR_PTR(long error)
 {
