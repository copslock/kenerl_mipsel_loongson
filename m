Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.5/8.12.5) with ESMTP id g635iRRw015258
	for <linux-mips-outgoing@oss.sgi.com>; Tue, 2 Jul 2002 22:44:27 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.5/8.12.3/Submit) id g635iRS7015257
	for linux-mips-outgoing; Tue, 2 Jul 2002 22:44:27 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from r-bu.iij4u.or.jp (r-bu.iij4u.or.jp [210.130.0.89])
	by oss.sgi.com (8.12.5/8.12.5) with SMTP id g635iMRw015248
	for <linux-mips@oss.sgi.com>; Tue, 2 Jul 2002 22:44:23 -0700
Received: from pudding ([202.216.29.50])
	by r-bu.iij4u.or.jp (8.11.6+IIJ/8.11.6) with SMTP id g635mJG24727
	for <linux-mips@oss.sgi.com>; Wed, 3 Jul 2002 14:48:19 +0900 (JST)
Date: Wed, 3 Jul 2002 14:44:04 +0900
From: Yoichi Yuasa <yoichi_yuasa@montavista.co.jp>
To: linux-mips@oss.sgi.com
Subject: Small correction for fault.c
Message-Id: <20020703144404.4d349037.yoichi_yuasa@montavista.co.jp>
Organization: MontaVista Software Japan Inc.
X-Mailer: Sylpheed version 0.7.8 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, hits=-5.0 required=5.0 tests=UNIFIED_PATCH version=2.20
X-Spam-Level: 
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

Hi,

I found a include file required for "arch/mips/mm/fault.c".
This is for unblank_screen().

--- linux.orig/arch/mips/mm/fault.c     Thu Jun 27 14:14:14 2002
+++ linux/arch/mips/mm/fault.c  Wed Jul  3 14:37:03 2002
@@ -19,6 +19,7 @@
 #include <linux/smp.h>
 #include <linux/smp_lock.h>
 #include <linux/version.h>
+#include <linux/vt_kern.h>

 #include <asm/branch.h>
 #include <asm/hardirq.h>


-Yoichi
