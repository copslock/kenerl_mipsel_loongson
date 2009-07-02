Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 02 Jul 2009 17:27:41 +0200 (CEST)
Received: from mail-ew0-f214.google.com ([209.85.219.214]:34570 "EHLO
	mail-ew0-f214.google.com" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S1492203AbZGBP1e (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Thu, 2 Jul 2009 17:27:34 +0200
Received: by ewy10 with SMTP id 10so2096185ewy.0
        for <multiple recipients>; Thu, 02 Jul 2009 08:21:43 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=pEMFXsJr7GfT+l3NzJoXOHTXJtdURRQ2gonPYj5lt8w=;
        b=mZQK8WE89rVHTG4aZLKxcb4Vu2Pr622910P5snAXtlWV8R2YVMGGCGSBVHSJYro/yE
         rZiZlW7PL+UsAj1P7Jya0d6L7JBReZU426IszpuEtDLBNm7rS/GIjVKnaNr2z2P5datb
         aXKj5TLhVOzdaCWposwHP5v/Hx8ZKlCON/bbs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=UMqnZ2tnsQKYc1hprwjEYKclJ7AlI5iustZkY2KIQvFGD0uxqju1G2XrXjKLjBybdE
         hrkQg+HJhBkyxdciNDqBjzYqqcir0u5B4t67+WKuJXjL7AqI0hmeFzQ5s2wYBaUXMBy1
         ml/MYisyvOk3+0T9N89zZ7YAQN4xBbgOHVNwM=
Received: by 10.210.67.4 with SMTP id p4mr224535eba.21.1246548102437;
        Thu, 02 Jul 2009 08:21:42 -0700 (PDT)
Received: from localhost.localdomain ([222.92.8.142])
        by mx.google.com with ESMTPS id 5sm2653799eyf.42.2009.07.02.08.21.35
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 02 Jul 2009 08:21:41 -0700 (PDT)
From:	Wu Zhangjin <wuzhangjin@gmail.com>
To:	linux-kernel@vger.kernel.org, linux-mips@linux-mips.org,
	ralf@linux-mips.org
Cc:	Wu Zhangjin <wuzj@lemote.com>, Yan Hua <yanh@lemote.com>,
	Philippe Vachon <philippe@cowpig.ca>,
	Zhang Le <r0bertz@gentoo.org>,
	Zhang Fuxin <zhangfx@lemote.com>,
	loongson-dev <loongson-dev@googlegroups.com>,
	Liu Junliang <liujl@lemote.com>,
	Erwan Lerale <erwan@thiscow.com>,
	Arnaud Patard <apatard@mandriva.com>
Subject: [PATCH v4 05/16] [loongson] pm: clean up the reboot support
Date:	Thu,  2 Jul 2009 23:21:27 +0800
Message-Id: <1ec9ff2c1bbb1d27824afed422c52e8d7af24c40.1246546684.git.wuzhangjin@gmail.com>
X-Mailer: git-send-email 1.6.2.1
In-Reply-To: <cover.1246546684.git.wuzhangjin@gmail.com>
References: <cover.1246546684.git.wuzhangjin@gmail.com>
Return-Path: <wuzhangjin@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 23617
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wuzhangjin@gmail.com
Precedence: bulk
X-list: linux-mips

From: Wu Zhangjin <wuzj@lemote.com>

several magic numbers have been replaced by relative macros, which will
be more readable and understandable.

Signed-off-by: Wu Zhangjin <wuzj@lemote.com>
---
 arch/mips/lemote/lm2e/reset.c |   18 ++++++++++--------
 1 files changed, 10 insertions(+), 8 deletions(-)

diff --git a/arch/mips/lemote/lm2e/reset.c b/arch/mips/lemote/lm2e/reset.c
index 47ff506..7758093 100644
--- a/arch/mips/lemote/lm2e/reset.c
+++ b/arch/mips/lemote/lm2e/reset.c
@@ -6,21 +6,23 @@
  *
  * Copyright (C) 2007 Lemote, Inc. & Institute of Computing Technology
  * Author: Fuxin Zhang, zhangfx@lemote.com
+ * Copyright (C) 2009 Lemote, Inc. & Institute of Computing Technology
+ * Author: Zhangjin Wu, wuzj@lemote.com
  */
 #include <linux/pm.h>
+#include <linux/io.h>
 
 #include <asm/reboot.h>
+#include <asm/mips-boards/bonito64.h>
 
 static void loongson2e_restart(char *command)
 {
-#ifdef CONFIG_32BIT
-	*(unsigned long *)0xbfe00104 &= ~(1 << 2);
-	*(unsigned long *)0xbfe00104 |= (1 << 2);
-#else
-	*(unsigned long *)0xffffffffbfe00104 &= ~(1 << 2);
-	*(unsigned long *)0xffffffffbfe00104 |= (1 << 2);
-#endif
-	__asm__ __volatile__("jr\t%0"::"r"(0xbfc00000));
+	/* do preparation for reboot */
+	BONITO_BONGENCFG &= ~(1 << 2);
+	BONITO_BONGENCFG |= (1 << 2);
+
+	/* reboot via jumping to boot base address */
+	((void (*)(void))ioremap_nocache(BONITO_BOOT_BASE, 4)) ();
 }
 
 static void loongson2e_halt(void)
-- 
1.6.2.1
