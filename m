Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 30 Jul 2007 16:38:29 +0100 (BST)
Received: from [222.92.8.141] ([222.92.8.141]:38795 "HELO lemote.com")
	by ftp.linux-mips.org with SMTP id S20022988AbXG3PiY (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Mon, 30 Jul 2007 16:38:24 +0100
Received: (qmail 13762 invoked by uid 511); 30 Jul 2007 15:43:05 -0000
Received: from unknown (HELO ?192.168.2.233?) (192.168.2.233)
  by lemote.com with SMTP; 30 Jul 2007 15:43:05 -0000
Message-ID: <46AE05DE.1020109@lemote.com>
Date:	Mon, 30 Jul 2007 23:38:06 +0800
From:	Songmao Tian <tiansm@lemote.com>
User-Agent: Icedove 1.5.0.8 (X11/20061116)
MIME-Version: 1.0
To:	linux-mips@linux-mips.org
Subject: Add errno definition to pm.h
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <tiansm@lemote.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 15950
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: tiansm@lemote.com
Precedence: bulk
X-list: linux-mips

commit 296699de6bdc717189a331ab6bbe90e05c94db06 add
static inline int pm_suspend(suspend_state_t state) { return -ENOSYS; }
which need errno definition

Signed-off-by: Songmao Tian <tiansm@lemote.com>

diff --git a/include/linux/pm.h b/include/linux/pm.h
index e52f6f8..48b71ba 100644
--- a/include/linux/pm.h
+++ b/include/linux/pm.h
@@ -25,6 +25,7 @@
 
 #include <linux/list.h>
 #include <asm/atomic.h>
+#include <asm/errno.h>
 
 /*
  * Power management requests... these are passed to pm_send_all() and 
friends.
