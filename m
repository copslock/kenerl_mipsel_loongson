Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id fA6JK1407946
	for linux-mips-outgoing; Tue, 6 Nov 2001 11:20:01 -0800
Received: from www.transvirtual.com (root@www.transvirtual.com [206.14.214.140])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id fA6JJx007941
	for <linux-mips@oss.sgi.com>; Tue, 6 Nov 2001 11:19:59 -0800
Received: from www.transvirtual.com (jsimmons@localhost [127.0.0.1])
        by localhost (8.12.0.Beta7/8.12.0.Beta7/Debian 8.12.0.Beta7-1) with ESMTP id fA6JJtjV030200
        for <linux-mips@oss.sgi.com>; Tue, 6 Nov 2001 11:19:55 -0800
Received: from localhost (jsimmons@localhost)
        by www.transvirtual.com (8.12.0.Beta7/8.12.0.Beta7/Debian 8.12.0.Beta7-1) with ESMTP id fA6JJt3w030196
        for <linux-mips@oss.sgi.com>; Tue, 6 Nov 2001 11:19:55 -0800
X-Authentication-Warning: www.transvirtual.com: jsimmons owned process doing -bs
Date: Tue, 6 Nov 2001 11:19:54 -0800 (PST)
From: James Simmons <jsimmons@transvirtual.com>
To: linux-mips@oss.sgi.com
Subject: 1$ clobber bug
Message-ID: <Pine.LNX.4.10.10111061117360.24062-100000@transvirtual.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk



I believe the ITE generic time code has a 1$ clobber bug in it. Here is a
patch to fix this.

--- time.c	Fri Oct  5 10:01:22 2001
+++ /usr/src/linux/arch/mips/ite-boards/generic/time.c	Tue Nov  6 11:38:00 2001
@@ -303,7 +303,8 @@
 			:"r" (timerhi),
 			 "m" (timerlo),
 			 "r" (tmp),
-			 "r" (USECS_PER_JIFFY));
+			 "r" (USECS_PER_JIFFY)
+			:"$1");
 		cached_quotient = quotient;
 	}
 
