Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id fA8NbBv18480
	for linux-mips-outgoing; Thu, 8 Nov 2001 15:37:11 -0800
Received: from hermes.mvista.com (gateway-1237.mvista.com [12.44.186.158])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id fA8Nb5018473;
	Thu, 8 Nov 2001 15:37:05 -0800
Received: from mvista.com (IDENT:jsun@orion.mvista.com [10.0.0.75])
	by hermes.mvista.com (8.11.0/8.11.0) with ESMTP id fA8NcVB21430;
	Thu, 8 Nov 2001 15:38:31 -0800
Message-ID: <3BEB171C.CF7949C2@mvista.com>
Date: Thu, 08 Nov 2001 15:37:00 -0800
From: Jun Sun <jsun@mvista.com>
X-Mailer: Mozilla 4.72 [en] (X11; U; Linux 2.2.18 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: ralf@oss.sgi.com, linux-mips@oss.sgi.com
Subject: [PATCH] wrong EF_CP0_CAUSE offset
Content-Type: multipart/mixed;
 boundary="------------E011AD610D9DDDF09FF10D0F"
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

This is a multi-part message in MIME format.
--------------E011AD610D9DDDF09FF10D0F
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit


reg.h has the wrong offset EF_CP0_CAUSE and the wrong pt_regs size.

This seems to be a problem only for mips (32bit) tree.

Drow found this bug, BTW.

Jun
--------------E011AD610D9DDDF09FF10D0F
Content-Type: text/plain; charset=us-ascii;
 name="wrong-EF_CP0_CAUSE-offset.011108.011108.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="wrong-EF_CP0_CAUSE-offset.011108.011108.patch"

diff -Nru linux/include/asm-mips/reg.h.orig linux/include/asm-mips/reg.h
--- linux/include/asm-mips/reg.h.orig	Wed Aug 18 16:37:49 1999
+++ linux/include/asm-mips/reg.h	Thu Nov  8 15:23:32 2001
@@ -59,8 +59,8 @@
 #define EF_CP0_EPC		40
 #define EF_CP0_BADVADDR		41
 #define EF_CP0_STATUS		42
-#define EF_CP0_CAUSE		44
+#define EF_CP0_CAUSE		43
 
-#define EF_SIZE			180	/* size in bytes */
+#define EF_SIZE			176	/* size in bytes */
 
 #endif /* __ASM_MIPS_REG_H */

--------------E011AD610D9DDDF09FF10D0F--
