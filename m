Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 07 May 2011 13:55:39 +0200 (CEST)
Received: from mail-ww0-f43.google.com ([74.125.82.43]:50522 "EHLO
        mail-ww0-f43.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491119Ab1EGLze (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 7 May 2011 13:55:34 +0200
Received: by wwb17 with SMTP id 17so3586054wwb.24
        for <multiple recipients>; Sat, 07 May 2011 04:55:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer;
        bh=zZF7hPuU7OmnsMqFzib2JJZR586yYS6AhuT11zMUwIw=;
        b=cSkdjoh0SGeJEN9SCwdYBCAfsyj8w568fyKqfHlFKE+HBBXv5un+R7uDtbU9iq5U56
         L5OGUT+C3OmdZmkANlC83WsLEPzc3dauZv5c9FgfYY87Uh9XPJRX4o+C88D96N/mXBex
         LQO/fL4OQEWPKTNzECl7zFbkkQvMky55Omh2w=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=u6Hd3O0Ca0RqKJJhvbrqlznYXyv3GqnIvOj2GGam7wkQ9v9eWpTVn22/+Ywz2ed4uz
         k58BS2EwWlIMirbxLTci6b67O6KRko29v8YFoOCdlTxPYUg25uF7/+jkQQ0lF+ZZt5OB
         Z3xSuBcfUdXy4cOnEVRdDbXKBLHK4NwCIbH4w=
Received: by 10.216.230.213 with SMTP id j63mr624120weq.20.1304769328751;
        Sat, 07 May 2011 04:55:28 -0700 (PDT)
Received: from localhost.localdomain (178-191-9-4.adsl.highway.telekom.at [178.191.9.4])
        by mx.google.com with ESMTPS id m84sm1240142weq.36.2011.05.07.04.55.27
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 07 May 2011 04:55:28 -0700 (PDT)
From:   Manuel Lauss <manuel.lauss@googlemail.com>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     Linux-MIPS <linux-mips@linux-mips.org>,
        Manuel Lauss <manuel.lauss@googlemail.com>
Subject: [PATCH] MIPS: Alchemy: fix xxs1500 build error
Date:   Sat,  7 May 2011 13:55:19 +0200
Message-Id: <1304769319-25167-1-git-send-email-manuel.lauss@googlemail.com>
X-Mailer: git-send-email 1.7.5.rc3
Return-Path: <manuel.lauss@googlemail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 29855
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: manuel.lauss@googlemail.com
Precedence: bulk
X-list: linux-mips

This fixes:
alchemy/xxs1500/init.c: In function 'prom_init':
alchemy/xxs1500/init.c:57:17: error: ignoring return value of 'kstrtoul', declared with attribute warn_unused_result

Signed-off-by: Manuel Lauss <manuel.lauss@googlemail.com>
---
 arch/mips/alchemy/xxs1500/init.c |    5 ++---
 1 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/arch/mips/alchemy/xxs1500/init.c b/arch/mips/alchemy/xxs1500/init.c
index 0bf768f..0ee02cf 100644
--- a/arch/mips/alchemy/xxs1500/init.c
+++ b/arch/mips/alchemy/xxs1500/init.c
@@ -51,10 +51,9 @@ void __init prom_init(void)
 	prom_init_cmdline();
 
 	memsize_str = prom_getenv("memsize");
-	if (!memsize_str)
+	if (!memsize_str || strict_strtoul(memsize_str, 0, &memsize))
 		memsize = 0x04000000;
-	else
-		strict_strtoul(memsize_str, 0, &memsize);
+
 	add_memory_region(0, memsize, BOOT_MEM_RAM);
 }
 
-- 
1.7.5.rc3
