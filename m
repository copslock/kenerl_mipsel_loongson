Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 27 Oct 2007 01:03:06 +0100 (BST)
Received: from smtp-out1.tiscali.nl ([195.241.79.176]:4286 "EHLO
	smtp-out1.tiscali.nl") by ftp.linux-mips.org with ESMTP
	id S20025958AbXJ0AC5 (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Sat, 27 Oct 2007 01:02:57 +0100
Received: from [82.171.216.234] (helo=[192.168.1.2])
	by smtp-out1.tiscali.nl with esmtp (Tiscali http://www.tiscali.nl)
	id 1IlZ8O-0001B1-6W
	for <linux-mips@linux-mips.org>; Sat, 27 Oct 2007 02:02:36 +0200
Message-ID: <47228018.8020202@tiscali.nl>
Date:	Sat, 27 Oct 2007 02:02:32 +0200
From:	Roel Kluin <12o3l@tiscali.nl>
User-Agent: Thunderbird 2.0.0.6 (X11/20070728)
MIME-Version: 1.0
To:	linux-mips@linux-mips.org
Subject: [PATCH] fix post-fence error
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-Path: <12o3l@tiscali.nl>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 17249
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: 12o3l@tiscali.nl
Precedence: bulk
X-list: linux-mips

In the same file:

typedef struct {
        unsigned long sig[4];
} irix_sigset_t;
---
diff --git a/arch/mips/kernel/irixsig.c b/arch/mips/kernel/irixsig.c
index a0a9105..d65c51c 100644
--- a/arch/mips/kernel/irixsig.c
+++ b/arch/mips/kernel/irixsig.c
@@ -527,7 +527,7 @@ asmlinkage int irix_sigpoll_sys(unsigned long __user *set,
 
 		expire = schedule_timeout_interruptible(expire);
 
-		for (i=0; i<=4; i++)
+		for (i=0; i<4; i++)
 			tmp |= (current->pending.signal.sig[i] & kset.sig[i]);
 
 		if (tmp)
