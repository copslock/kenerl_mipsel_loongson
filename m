Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id fATLQN528782
	for linux-mips-outgoing; Thu, 29 Nov 2001 13:26:23 -0800
Received: from hermes.mvista.com (gateway-1237.mvista.com [12.44.186.158])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id fATLQJo28779
	for <linux-mips@oss.sgi.com>; Thu, 29 Nov 2001 13:26:19 -0800
Received: from zeus.mvista.com (zeus.mvista.com [10.0.0.112])
	by hermes.mvista.com (8.11.0/8.11.0) with ESMTP id fATKQsB08529;
	Thu, 29 Nov 2001 12:26:54 -0800
Subject: pcmcia
From: Pete Popov <ppopov@mvista.com>
To: linux-mips <linux-mips@oss.sgi.com>,
   sforge
	 <linux-mips-kernel@lists.sourceforge.net>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/0.99.1+cvs.2001.11.14.08.58 (Preview Release)
Date: 29 Nov 2001 12:32:01 -0800
Message-Id: <1007065921.13095.110.camel@zeus>
Mime-Version: 1.0
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

The pcmcia variable ioaddr_t should be a 32 bit type for my socket
driver.  Is there any harm to other mips pcmcia socket drivers if we
apply the patch below?  If not, it would make it so much easier if I
don't have to debug this problem with each new kernel (having forgotten
about the need for this patch)...


--- linux-orig/include/pcmcia/cs_types.h	Mon Nov  5 16:55:31 2001
+++ linux/include/pcmcia/cs_types.h	Thu Nov 29 12:27:42 2001
@@ -36,7 +36,7 @@
 #include <sys/types.h>
 #endif
 
-#ifdef __arm__
+#if defined(__arm__) || defined(__mips__)
 typedef u_int   ioaddr_t;
 #else
 typedef u_short	ioaddr_t;
