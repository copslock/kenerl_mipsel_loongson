Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 24 Nov 2009 14:49:00 +0100 (CET)
Received: from mail-pz0-f197.google.com ([209.85.222.197]:60333 "EHLO
	mail-pz0-f197.google.com" rhost-flags-OK-OK-OK-OK)
	by eddie.linux-mips.org with ESMTP id S1492387AbZKXNs4 (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 24 Nov 2009 14:48:56 +0100
Received: by pzk35 with SMTP id 35so4829151pzk.22
        for <multiple recipients>; Tue, 24 Nov 2009 05:48:48 -0800 (PST)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=GJDDN/uMPDywD9L6vmT+nwjHQ7tocY96zgQCgzzRUu0=;
        b=Hez7oCcprFvdv9IR0BPWYkRvrpZjnr5f9a4XmY7gVvlUpTCZgJZ39LqMyxAW4j5+66
         /sK4q8fROLJb4WmUAmshoXBYFwoNWvUcu7W2Y1vVN+Xl9MWKG+NVYJls0xXJ5DQ7RxTU
         4pZMnpvkkwUFYh3H4vnnx/srL6pqxr4KsSlmc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=psJY4puz9Ae3WcWomPz0c2oFVZC8vfB6WLn9IElHmxIKlrb5aeu2i1YpQrcuQqFTeJ
         epcX0RuGBA/sCJIIttQooboO4DzjGDQhsGvhp+vnFhRFQRHm9HnYLuQaoXX+5Gxf+dJW
         QoM5nfFJp/TBDn9NJZqaACa7NQxIoSQf2UrUQ=
Received: by 10.115.24.10 with SMTP id b10mr3923598waj.127.1259070528401;
        Tue, 24 Nov 2009 05:48:48 -0800 (PST)
Received: from localhost.localdomain ([222.92.8.142])
        by mx.google.com with ESMTPS id 21sm3234466pxi.0.2009.11.24.05.48.43
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 24 Nov 2009 05:48:48 -0800 (PST)
From:	Wu Zhangjin <wuzhangjin@gmail.com>
To:	Ralf Baechle <ralf@linux-mips.org>
Cc:	linux-mips@linux-mips.org, Wu Zhangjin <wuzhangjin@gmail.com>
Subject: [PATCH] [loongson] Lemote-2F: Suspend CS5536 MFGPT Timer
Date:	Tue, 24 Nov 2009 21:48:36 +0800
Message-Id: <1259070516-18546-1-git-send-email-wuzhangjin@gmail.com>
X-Mailer: git-send-email 1.6.2.1
Return-Path: <wuzhangjin@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 25093
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wuzhangjin@gmail.com
Precedence: bulk
X-list: linux-mips

From: Wu Zhangjin <wuzhangjin@gmail.com>

Before putting loongson2f into wait mode, suspend the MFGPT Timer, and
after wake-up, resume it. This may save some power.

Signed-off-by: Wu Zhangjin <wuzhangjin@gmail.com>
---
 arch/mips/loongson/lemote-2f/pm.c |   11 +++++++++++
 1 files changed, 11 insertions(+), 0 deletions(-)

diff --git a/arch/mips/loongson/lemote-2f/pm.c b/arch/mips/loongson/lemote-2f/pm.c
index 81c0641..d7af2e6 100644
--- a/arch/mips/loongson/lemote-2f/pm.c
+++ b/arch/mips/loongson/lemote-2f/pm.c
@@ -22,6 +22,7 @@
 
 #include <loongson.h>
 
+#include <cs5536/cs5536_mfgpt.h>
 #include "ec_kb3310b.h"
 
 #define I8042_KBD_IRQ		1
@@ -136,3 +137,13 @@ int wakeup_loongson(void)
 
 	return 0;
 }
+
+void __weak mach_suspend(void)
+{
+	disable_mfgpt0_counter();
+}
+
+void __weak mach_resume(void)
+{
+	enable_mfgpt0_counter();
+}
-- 
1.6.2.1
