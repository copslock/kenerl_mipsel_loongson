Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 20 Feb 2014 14:37:51 +0100 (CET)
Received: from mail-ea0-f180.google.com ([209.85.215.180]:33466 "EHLO
        mail-ea0-f180.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6871399AbaBTNht0wdWK (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 20 Feb 2014 14:37:49 +0100
Received: by mail-ea0-f180.google.com with SMTP id o10so898047eaj.25
        for <linux-mips@linux-mips.org>; Thu, 20 Feb 2014 05:37:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=p7gfcSQIjo1jiolpAgs/tkfXLsRmd6bvpZjewg+4/5s=;
        b=mF2O3XS6mri/o5UYY5re3Yr0aql60i3GcUoPtGgYfy/vdDwrHqr2vLD9vVaIaiFAI5
         HOp+YoShW+qJeyq2gzI7uWR6hm39GX3eJv82gq+SQZDn+Gxpu5aG5ycHa0n6e19kH54G
         iSxqKEyuGbFOhEMgq2NAcx/bgNPHyqsVhh6MqQkPlYjzgVQqvJk+uMv5m+N+j2v/mxtw
         z9QFkwwdsxyCJ/LjKTsOXKQDGu2oggR8vh69cDjALK52kYJtVsVni4CrUUA6cB00Fu2v
         ZpCHvjs5soFTd7IjI5EFNwMMcYAsVQIk2E/nJYpDRwu9gAdFJfOrVSs6yco1b7qpEuNu
         oG0Q==
X-Received: by 10.14.119.197 with SMTP id n45mr1847894eeh.93.1392903464126;
        Thu, 20 Feb 2014 05:37:44 -0800 (PST)
Received: from localhost.localdomain (p54B231AB.dip0.t-ipconnect.de. [84.178.49.171])
        by mx.google.com with ESMTPSA id d9sm13909753eei.9.2014.02.20.05.37.43
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 20 Feb 2014 05:37:43 -0800 (PST)
From:   Manuel Lauss <manuel.lauss@gmail.com>
To:     Linux-MIPS <linux-mips@linux-mips.org>
Cc:     Manuel Lauss <manuel.lauss@gmail.com>
Subject: [PATCH] MIPS: Alchemy: fix unchecked kstrtoul return value
Date:   Thu, 20 Feb 2014 14:37:40 +0100
Message-Id: <1392903460-19986-1-git-send-email-manuel.lauss@gmail.com>
X-Mailer: git-send-email 1.8.5.5
Return-Path: <manuel.lauss@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 39352
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: manuel.lauss@gmail.com
Precedence: bulk
List-help: <mailto:ecartis@linux-mips.org?Subject=help>
List-unsubscribe: <mailto:ecartis@linux-mips.org?subject=unsubscribe%20linux-mips>
List-software: Ecartis version 1.0.0
List-Id: linux-mips <linux-mips.eddie.linux-mips.org>
X-List-ID: linux-mips <linux-mips.eddie.linux-mips.org>
List-subscribe: <mailto:ecartis@linux-mips.org?subject=subscribe%20linux-mips>
List-owner: <mailto:ralf@linux-mips.org>
List-post: <mailto:linux-mips@linux-mips.org>
List-archive: <http://www.linux-mips.org/archives/linux-mips/>
X-list: linux-mips

enabled __must_check logic triggers a build error for mtx1 and gpr
in the prom init code.  Fix by checking the kstrtoul() return value.

Signed-off-by: Manuel Lauss <manuel.lauss@gmail.com>
---
 arch/mips/alchemy/board-gpr.c  | 4 +---
 arch/mips/alchemy/board-mtx1.c | 4 +---
 2 files changed, 2 insertions(+), 6 deletions(-)

diff --git a/arch/mips/alchemy/board-gpr.c b/arch/mips/alchemy/board-gpr.c
index 9edc35f..acf9a2a 100644
--- a/arch/mips/alchemy/board-gpr.c
+++ b/arch/mips/alchemy/board-gpr.c
@@ -53,10 +53,8 @@ void __init prom_init(void)
 	prom_init_cmdline();
 
 	memsize_str = prom_getenv("memsize");
-	if (!memsize_str)
+	if (!memsize_str || kstrtoul(memsize_str, 0, &memsize))
 		memsize = 0x04000000;
-	else
-		strict_strtoul(memsize_str, 0, &memsize);
 	add_memory_region(0, memsize, BOOT_MEM_RAM);
 }
 
diff --git a/arch/mips/alchemy/board-mtx1.c b/arch/mips/alchemy/board-mtx1.c
index 9969dba..25a59a2 100644
--- a/arch/mips/alchemy/board-mtx1.c
+++ b/arch/mips/alchemy/board-mtx1.c
@@ -52,10 +52,8 @@ void __init prom_init(void)
 	prom_init_cmdline();
 
 	memsize_str = prom_getenv("memsize");
-	if (!memsize_str)
+	if (!memsize_str || kstrtoul(memsize_str, 0, &memsize))
 		memsize = 0x04000000;
-	else
-		strict_strtoul(memsize_str, 0, &memsize);
 	add_memory_region(0, memsize, BOOT_MEM_RAM);
 }
 
-- 
1.8.5.5
