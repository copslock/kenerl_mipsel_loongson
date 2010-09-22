Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 22 Sep 2010 07:59:31 +0200 (CEST)
Received: from mail-px0-f177.google.com ([209.85.212.177]:50480 "EHLO
        mail-px0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491110Ab0IVF72 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 22 Sep 2010 07:59:28 +0200
Received: by pxi4 with SMTP id 4so56066pxi.36
        for <multiple recipients>; Tue, 21 Sep 2010 22:59:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=ssRZFJeCCsp93LN6oHwpYBERanbTUUzmIn8qmqrdT9k=;
        b=GNTYnrfnL9D3Ep1LK/scxy1vtzNK+2UUVv3bihN+ICOviYoEFWVD/+8OfFj3ieTX9X
         r9zCR/RhoQ1zBJHwL0opEiQZH285HAnV3x1GIbGZzS/69PEREsMWttJ+ZYvxg9eKUEdH
         XtteFSaZdvGTu5Ts3wz2w81kk+Cb3BNtYWTA8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=B0sb9qn03o+/3SD3iBrYnEAmfsy+k/pUTetWbM6GjSrxsmPe5zSxUWKCTnpOH7kJaO
         C73WGu9GGomUwD0eGOk/t/hiXuoLC0FtFV9lIm0UQQ+Kh2kyUAC5vNQde7Ft89Gsmn1y
         d4AYu5cqzVuFg6ZwaB36BjMbKin+2nKfwpbNY=
Received: by 10.142.9.22 with SMTP id 22mr3525279wfi.170.1285135162159;
        Tue, 21 Sep 2010 22:59:22 -0700 (PDT)
Received: from localhost.localdomain ([61.48.59.181])
        by mx.google.com with ESMTPS id v3sm9945139wfv.11.2010.09.21.22.59.18
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 21 Sep 2010 22:59:20 -0700 (PDT)
From:   wuzhangjin@gmail.com
To:     linux-mips@linux-mips.org, ralf@linux-mips.org
Cc:     Wu Zhangjin <wuzhangjin@gmail.com>
Subject: [PATCH] MIPS: Make EARLY_PRINTK selectable for !EMBEDDED
Date:   Wed, 22 Sep 2010 13:59:10 +0800
Message-Id: <1285135150-14772-1-git-send-email-wuzhangjin@gmail.com>
X-Mailer: git-send-email 1.7.1
X-archive-position: 27784
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wuzhangjin@gmail.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                 
X-UID: 16940

From: Wu Zhangjin <wuzhangjin@gmail.com>

When EMBEDDED is disabled, the EARLY_PRINTK option will be hiden and we
have no way to disable it.

For EARLY_PRINTK is not necessary for !EMBEDDED, we should make it
selectable and only enable it by default for EMBEDDED.

Signed-off-by: Wu Zhangjin <wuzhangjin@gmail.com>
---
 arch/mips/Kconfig.debug |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/mips/Kconfig.debug b/arch/mips/Kconfig.debug
index 43dc279..77eba81 100644
--- a/arch/mips/Kconfig.debug
+++ b/arch/mips/Kconfig.debug
@@ -7,9 +7,9 @@ config TRACE_IRQFLAGS_SUPPORT
 source "lib/Kconfig.debug"
 
 config EARLY_PRINTK
-	bool "Early printk" if EMBEDDED
+	bool "Early printk"
 	depends on SYS_HAS_EARLY_PRINTK
-	default y
+	default y if EMBEDDED
 	help
 	  This option enables special console drivers which allow the kernel
 	  to print messages very early in the bootup process.
-- 
1.7.1
