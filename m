Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 12 Dec 2014 16:27:34 +0100 (CET)
Received: from mail-pa0-f43.google.com ([209.85.220.43]:57211 "EHLO
        mail-pa0-f43.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27008090AbaLLP10glMHc (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 12 Dec 2014 16:27:26 +0100
Received: by mail-pa0-f43.google.com with SMTP id kx10so7463402pab.2
        for <multiple recipients>; Fri, 12 Dec 2014 07:27:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=8f7nMBDuFMsWcn95hjqNY1UHgIO0/odcYFnXy6EBdak=;
        b=Nfc30FaZfwABv71sYlOKuqZT+rJiutPv0dSB99WEcxWXwiWdxjR80wtc+BX5/9eOzq
         RexgaIsW95NWAWdTsgs+HQRegE/9JDEKgJAx0k47XA9n+IZxnuZ0sPY2r9ZTL9eYAsRS
         bgtPAFcZRXLnvEhGzCFEXnqdIDbKabw4be5hwSpSGdqOP2E4vsWYWo1Rje8x14MhJipG
         9Agk+AHqvsTzOu6eoag6mOM6vrqOEpSvczM9NWam8tuf2sQRL1FkZ0QPtivXRBYw3S6G
         N1BozdiRzKYGPMZkFkZLHh+DHom3CQd76LBwibj1/n9gYY5RI3og+xW1B4TouEIjBwK7
         NOhA==
X-Received: by 10.70.124.200 with SMTP id mk8mr1850708pdb.147.1418398039809;
        Fri, 12 Dec 2014 07:27:19 -0800 (PST)
Received: from localhost.localdomain ([59.12.167.210])
        by mx.google.com with ESMTPSA id wv1sm1860993pab.37.2014.12.12.07.27.17
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 12 Dec 2014 07:27:19 -0800 (PST)
From:   Jaedon Shin <jaedon.shin@gmail.com>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     linux-mips@linux-mips.org, Jaedon Shin <jaedon.shin@gmail.com>
Subject: [PATCH] MIPS: use phys_addr_t instead of phy_t
Date:   Sat, 13 Dec 2014 00:26:43 +0900
Message-Id: <1418398003-1098-1-git-send-email-jaedon.shin@gmail.com>
X-Mailer: git-send-email 1.9.3 (Apple Git-50)
Return-Path: <jaedon.shin@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 44631
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jaedon.shin@gmail.com
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

add missing patch of commit "MIPS: Replace use of phys_t with phys_addr_t".

Signed-off-by: Jaedon Shin <jaedon.shin@gmail.com>
---
 arch/mips/kernel/setup.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/mips/kernel/setup.c b/arch/mips/kernel/setup.c
index a8c20af..0589290 100644
--- a/arch/mips/kernel/setup.c
+++ b/arch/mips/kernel/setup.c
@@ -493,7 +493,7 @@ static int usermem __initdata;
 
 static int __init early_parse_mem(char *p)
 {
-	phys_t start, size;
+	phys_addr_t start, size;
 
 	/*
 	 * If a user specifies memory size, we
-- 
1.9.3
