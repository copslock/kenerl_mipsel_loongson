Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 10 Aug 2009 09:08:12 +0200 (CEST)
Received: from wf-out-1314.google.com ([209.85.200.173]:45551 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by ftp.linux-mips.org
	with ESMTP id S1492456AbZHJHIF (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Mon, 10 Aug 2009 09:08:05 +0200
Received: by wf-out-1314.google.com with SMTP id 28so1035970wfa.21
        for <multiple recipients>; Mon, 10 Aug 2009 00:08:03 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=Yaa6bBnjbRRMfxSmyp+JnNJwbPgoxYQMkFwc0jb83Pg=;
        b=wh1zdXj5GMI+qYcLXybwl9HLagb2QKF8LicP5DH+Ax5WACe0V33Bp4wk3E+e/7YKkM
         jL2OWhfIGoQhDSWOotUXyMjusqvBiKmGlvw+RSDMdVrZ6W8TyZIllQyFvCgnZz4T+VQl
         uBnccQ8iUhZPXdGaQuvkUdNomzz3MzPyjl3T4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=sarkCzAG506RnmS/CqXhX0jT5Q9gdqV1FUJLcBLM4N4/kXiMMLlGFKhrwvVsDzZLbA
         K0MjUUsVS2boK7R1p4m3bSb8Db+TgQhCQlDqnQZ3zI6Ra0Jv2NOWpDUvYsCHr9XLKPw0
         k4mw1XGf7b7CIAtyA0gKLE4Z2Cz0z6TpXjvM4=
Received: by 10.142.143.12 with SMTP id q12mr705220wfd.146.1249888083597;
        Mon, 10 Aug 2009 00:08:03 -0700 (PDT)
Received: from localhost.localdomain ([222.92.8.142])
        by mx.google.com with ESMTPS id 22sm11025543wfd.28.2009.08.10.00.08.00
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 10 Aug 2009 00:08:02 -0700 (PDT)
From:	Wu Zhangjin <wuzhangjin@gmail.com>
To:	linux-mips@linux-mips.org,
	Linux Kernel list <linux-kernel@vger.kernel.org>
Cc:	Nicolas Thill <nico@openwrt.org>,
	Ralf Baechle <ralf@linux-mips.org>,
	Enrik Berkhan <Enrik.Berkhan@akk.org>,
	Wu Zhangjin <wuzhangjin@gmail.com>
Subject: [PATCH] MIPS: AR7: fix wrong including path of rt7.h in ar7_wdt.c
Date:	Mon, 10 Aug 2009 15:07:54 +0800
Message-Id: <1249888074-20784-1-git-send-email-wuzhangjin@gmail.com>
X-Mailer: git-send-email 1.6.2.1
Return-Path: <wuzhangjin@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 23875
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wuzhangjin@gmail.com
Precedence: bulk
X-list: linux-mips

Signed-off-by: Wu Zhangjin <wuzhangjin@gmail.com>
---
 drivers/watchdog/ar7_wdt.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/watchdog/ar7_wdt.c b/drivers/watchdog/ar7_wdt.c
index 3fe9742..ec48e12 100644
--- a/drivers/watchdog/ar7_wdt.c
+++ b/drivers/watchdog/ar7_wdt.c
@@ -37,7 +37,7 @@
 #include <linux/uaccess.h>
 
 #include <asm/addrspace.h>
-#include <asm/ar7/ar7.h>
+#include <ar7.h>
 
 #define DRVNAME "ar7_wdt"
 #define LONGNAME "TI AR7 Watchdog Timer"
-- 
1.6.2.1
