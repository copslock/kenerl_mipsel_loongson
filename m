Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 20 Jul 2003 17:20:30 +0100 (BST)
Received: from postfix4-2.free.fr ([IPv6:::ffff:213.228.0.176]:25036 "EHLO
	postfix4-2.free.fr") by linux-mips.org with ESMTP
	id <S8225222AbTGTQU2>; Sun, 20 Jul 2003 17:20:28 +0100
Received: from free.fr (lns-th2-2-82-64-25-230.adsl.proxad.net [82.64.25.230])
	by postfix4-2.free.fr (Postfix) with ESMTP id C6AECC191
	for <linux-mips@linux-mips.org>; Sun, 20 Jul 2003 18:20:24 +0200 (CEST)
Message-ID: <3F1AC15A.6050604@free.fr>
Date: Sun, 20 Jul 2003 18:20:42 +0200
From: =?ISO-8859-1?Q?Vincent_Stehl=E9?= <vincent.stehle@free.fr>
User-Agent: Mozilla/5.0 (X11; U; Linux i586; en-US; rv:1.4) Gecko/20030714 Debian/1.4-2
X-Accept-Language: fr, en, de
MIME-Version: 1.0
To: linux-mips <linux-mips@linux-mips.org>
Subject: PATCH: time.c needs to export more funcs
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <vincent.stehle@free.fr>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 2830
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: vincent.stehle@free.fr
Precedence: bulk
X-list: linux-mips


Hi,

time.c needs to export some more functions for modules such as mips_rtc.

Regards,

---
diff -urN -X dontdiff linux/arch/mips/kernel/time.c 
linux-vs/arch/mips/kernel/time.c
--- linux/arch/mips/kernel/time.c       2003-07-18 03:30:14.000000000 +0200
+++ linux-vs/arch/mips/kernel/time.c    2003-07-18 03:41:19.000000000 +0200
@@ -585,3 +585,6 @@
  }

  EXPORT_SYMBOL(rtc_lock);
+EXPORT_SYMBOL(to_tm);
+EXPORT_SYMBOL(rtc_set_time);
+EXPORT_SYMBOL(rtc_get_time);

-- 
Vincent
