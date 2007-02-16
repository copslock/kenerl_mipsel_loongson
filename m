Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 16 Feb 2007 15:34:17 +0000 (GMT)
Received: from hu-out-0506.google.com ([72.14.214.236]:26284 "EHLO
	hu-out-0506.google.com") by ftp.linux-mips.org with ESMTP
	id S20038963AbXBPPeM (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 16 Feb 2007 15:34:12 +0000
Received: by hu-out-0506.google.com with SMTP id 27so428049hub
        for <linux-mips@linux-mips.org>; Fri, 16 Feb 2007 07:33:39 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:reply-to:user-agent:mime-version:to:cc:subject:content-type:content-transfer-encoding:from;
        b=Ltd+Q01BiwMNtXF5wdmQHqn9xGvOQqiLfUStHvrEzdnqLIGW5TkiXHoK1+W7dJFHGtldcgYISTG8Qldk4/P1vHknVJtJFCahKiZWdmiOHerBnI50ARcX3VWcxBPvYIOazJKMcTGBRrZ87aGo2InH8utItuFISOu6WDs6NsCXU18=
Received: by 10.67.22.7 with SMTP id z7mr3068467ugi.1171640019187;
        Fri, 16 Feb 2007 07:33:39 -0800 (PST)
Received: from ?192.168.0.24? ( [81.252.61.1])
        by mx.google.com with ESMTP id c25sm3895691ika.2007.02.16.07.33.37;
        Fri, 16 Feb 2007 07:33:38 -0800 (PST)
Message-ID: <45D5CEA5.3050604@innova-card.com>
Date:	Fri, 16 Feb 2007 16:32:53 +0100
Reply-To: Franck <vagabon.xyz@gmail.com>
User-Agent: Thunderbird 1.5.0.4 (X11/20060614)
MIME-Version: 1.0
To:	Ralf Baechle <ralf@linux-mips.org>
CC:	linux-mips <linux-mips@linux-mips.org>
Subject: [PATCH] Fix __copy_{to,from}_user_inatomic
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
From:	Franck Bui-Huu <vagabon.xyz@gmail.com>
Return-Path: <vagabon.xyz@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 14119
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: vagabon.xyz@gmail.com
Precedence: bulk
X-list: linux-mips

From: Franck Bui-Huu <fbuihuu@gmail.com>

These functions are aliases to __copy_{to,from}_user resp but they
are not allowed to sleep. Therefore might_sleep() must not be used
by their implementions.

Signed-off-by: Franck Bui-Huu <fbuihuu@gmail.com>
---
 include/asm-mips/uaccess.h |    6 ++----
 1 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/include/asm-mips/uaccess.h b/include/asm-mips/uaccess.h
index 825fcbd..fd01939 100644
--- a/include/asm-mips/uaccess.h
+++ b/include/asm-mips/uaccess.h
@@ -407,7 +407,7 @@ extern size_t __copy_user(void *__to, const void *__from, size_t __n);
  * @from: Source address, in kernel space.
  * @n:    Number of bytes to copy.
  *
- * Context: User context only.  This function may sleep.
+ * Context: User context only.
  *
  * Copy data from kernel space to user space.  Caller must check
  * the specified block with access_ok() before calling this function.
@@ -421,7 +421,6 @@ extern size_t __copy_user(void *__to, const void *__from, size_t __n);
 	const void *__cu_from;						\
 	long __cu_len;							\
 									\
-	might_sleep();							\
 	__cu_to = (to);							\
 	__cu_from = (from);						\
 	__cu_len = (n);							\
@@ -490,7 +489,7 @@ extern size_t __copy_user(void *__to, const void *__from, size_t __n);
  * @from: Source address, in user space.
  * @n:    Number of bytes to copy.
  *
- * Context: User context only.  This function may sleep.
+ * Context: User context only.
  *
  * Copy data from user space to kernel space.  Caller must check
  * the specified block with access_ok() before calling this function.
@@ -507,7 +506,6 @@ extern size_t __copy_user(void *__to, const void *__from, size_t __n);
 	const void __user *__cu_from;					\
 	long __cu_len;							\
 									\
-	might_sleep();							\
 	__cu_to = (to);							\
 	__cu_from = (from);						\
 	__cu_len = (n);							\
-- 
1.4.4.3.ge6d4
