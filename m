Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.5/8.12.5) with ESMTP id g6GFwiRw000721
	for <linux-mips-outgoing@oss.sgi.com>; Tue, 16 Jul 2002 08:58:44 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.5/8.12.3/Submit) id g6GFwiUH000720
	for linux-mips-outgoing; Tue, 16 Jul 2002 08:58:44 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from hell (buserror-extern.convergence.de [212.84.236.66])
	by oss.sgi.com (8.12.5/8.12.5) with SMTP id g6GFwbRw000710
	for <linux-mips@oss.sgi.com>; Tue, 16 Jul 2002 08:58:38 -0700
Received: from js by hell with local (Exim 3.35 #1 (Debian))
	id 17UUnP-00039n-00
	for <linux-mips@oss.sgi.com>; Tue, 16 Jul 2002 18:03:27 +0200
Date: Tue, 16 Jul 2002 18:03:27 +0200
From: Johannes Stezenbach <js@convergence.de>
To: linux-mips@oss.sgi.com
Subject: PATCH: dma_addr_t 32/64bit mix-up
Message-ID: <20020716160327.GA12079@convergence.de>
Mail-Followup-To: Johannes Stezenbach <js@convergence.de>,
	linux-mips@oss.sgi.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
X-Spam-Status: No, hits=-5.0 required=5.0 tests=UNIFIED_PATCH version=2.20
X-Spam-Level: 
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

Hi,

the following patch applies to the linux_2_4 branch.

Index: linux/include/asm-mips/types.h
===================================================================
RCS file: /cvs/linux/include/asm-mips/types.h,v
retrieving revision 1.6.2.4
diff -u -r1.6.2.4 types.h
--- linux/include/asm-mips/types.h	2002/06/26 22:36:37	1.6.2.4
+++ linux/include/asm-mips/types.h	2002/07/16 15:48:06
@@ -72,9 +72,9 @@
 #define BITS_PER_LONG _MIPS_SZLONG
 
 #ifdef CONFIG_64BIT_PHYS_ADDR
-typedef u32 dma_addr_t;
-#else
 typedef u64 dma_addr_t;
+#else
+typedef u32 dma_addr_t;
 #endif
 typedef u64 dma64_addr_t;


Johannes
