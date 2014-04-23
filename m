Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 23 Apr 2014 03:19:37 +0200 (CEST)
Received: from mail-oa0-f41.google.com ([209.85.219.41]:63593 "EHLO
        mail-oa0-f41.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6834662AbaDWBS4th3Ys (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 23 Apr 2014 03:18:56 +0200
Received: by mail-oa0-f41.google.com with SMTP id j17so305321oag.0
        for <multiple recipients>; Tue, 22 Apr 2014 18:18:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=dSCgEF9kkQTelE+MPGydXXd1hf/yI18QJKh19H0/nsk=;
        b=HUpimh/BYK1W+5eioEZ9130VTmi5VT7Bjbo/ahk4Xu5YrxQqbkJDHkJO0YrLfRcmYM
         nMMWsqU9zDbatViHkKxiGqZkyjQrq5VOKE6Sk9jyvqljpiMyjL+2ZwWEy9t1hQfa3R4P
         6VikITk57xA18MpvjsAiz3nNRcn0TtU9jkLZJrW9Z1w3Mp7xZg4TDmdyyLVJx+DUh213
         YPhWjaPEk+/46XhJaBJ1zDRwkBzCFuVYnuKHZQzNq4icp3AkHYP0DNp7OQsKKOviN67p
         80FQN33vopKWIL5qPA2cEK//4iuxItVYe8XAGykujuvXd+dGeAI4Ytb+g+ibnJa4lpMm
         StDw==
X-Received: by 10.182.87.42 with SMTP id u10mr39446736obz.22.1398215930813;
        Tue, 22 Apr 2014 18:18:50 -0700 (PDT)
Received: from localhost.localdomain (72-48-77-163.dyn.grandenetworks.net. [72.48.77.163])
        by mx.google.com with ESMTPSA id f1sm184735295oej.5.2014.04.22.18.18.49
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 22 Apr 2014 18:18:50 -0700 (PDT)
From:   Rob Herring <robherring2@gmail.com>
To:     Grant Likely <grant.likely@linaro.org>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Cc:     Rob Herring <robh@kernel.org>, Ralf Baechle <ralf@linux-mips.org>,
        linux-mips@linux-mips.org
Subject: [PATCH v2 02/21] mips: lantiq: copy built-in DTB out of init section
Date:   Tue, 22 Apr 2014 20:18:02 -0500
Message-Id: <1398215901-25609-3-git-send-email-robherring2@gmail.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1398215901-25609-1-git-send-email-robherring2@gmail.com>
References: <1398215901-25609-1-git-send-email-robherring2@gmail.com>
Return-Path: <robherring2@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 39902
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: robherring2@gmail.com
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

From: Rob Herring <robh@kernel.org>

The existing code is buggy because built-in DTBs are in init memory.
Fix this by using the unflatten_and_copy_device_tree function.

This removes all accesses to FDT header data by the arch code.

Signed-off-by: Rob Herring <robh@kernel.org>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: linux-mips@linux-mips.org
---
v2: no change

 arch/mips/lantiq/prom.c | 13 +------------
 1 file changed, 1 insertion(+), 12 deletions(-)

diff --git a/arch/mips/lantiq/prom.c b/arch/mips/lantiq/prom.c
index 19686c5..cdea687 100644
--- a/arch/mips/lantiq/prom.c
+++ b/arch/mips/lantiq/prom.c
@@ -76,18 +76,7 @@ void __init plat_mem_setup(void)
 
 void __init device_tree_init(void)
 {
-	unsigned long base, size;
-
-	if (!initial_boot_params)
-		return;
-
-	base = virt_to_phys((void *)initial_boot_params);
-	size = be32_to_cpu(initial_boot_params->totalsize);
-
-	/* Before we do anything, lets reserve the dt blob */
-	reserve_bootmem(base, size, BOOTMEM_DEFAULT);
-
-	unflatten_device_tree();
+	unflatten_and_copy_device_tree();
 }
 
 void __init prom_init(void)
-- 
1.9.1
