Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 28 Mar 2018 03:14:50 +0200 (CEST)
Received: from mail-ot0-f194.google.com ([74.125.82.194]:38506 "EHLO
        mail-ot0-f194.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23993928AbeC1BOnf0lMv (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 28 Mar 2018 03:14:43 +0200
Received: by mail-ot0-f194.google.com with SMTP id o9-v6so893294otj.5;
        Tue, 27 Mar 2018 18:14:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=SUQLHL66pH6btyCEjbd+nFypxi48HUBoAY1xDeQLBAE=;
        b=FFZu7DKe3bBeL2+lqwgccej4DOnVRHtmyuunYpYvcUZ5I34lhM20DZZ0JyPkjfK86G
         CoSZBcevm+yBXW1OM/XDJX/dMicMM3MoeY+O+SEm8LmDnmKob79yay7CSfXcqIKxx2BV
         z+zfPg0SUcKscj9kCmQ7hlpJMFL4QXRhN+j+EpRmZTf49UJ6PAZ8AqJv8mSntnbpQx8c
         G3h02UHSlUs67c2loai4zjeOMHBvokEM+R3vjX7gktVf4yRI3wH67zN9KqUgRmcwrmvS
         16e6sCy37Om7NehK9NOJuYRdXP9LDvaqnJyup7scHUjR2A3e/2ISrY+oAfD3RbSUOgGe
         jNyQ==
X-Gm-Message-State: ALQs6tAlDduF1zMuBbQ+cAC1cb7tGy7Agk3C4icOR9osfhK/ChhpIzFX
        JLHOyE4GBOIu0zVs5SiItw==
X-Google-Smtp-Source: AIpwx4+JH8vtdiFN3aK0YueADVhrb76JMwXc/Rb8K3cjq7ApQLFAzkXGAlDgI0fSfQAzm42ms8suvw==
X-Received: by 2002:a9d:4c06:: with SMTP id l6-v6mr930164otf.143.1522199677430;
        Tue, 27 Mar 2018 18:14:37 -0700 (PDT)
Received: from xps15.herring.priv (216-188-254-6.dyn.grandenetworks.net. [216.188.254.6])
        by smtp.googlemail.com with ESMTPSA id o39-v6sm1584509oto.10.2018.03.27.18.14.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 27 Mar 2018 18:14:36 -0700 (PDT)
From:   Rob Herring <robh@kernel.org>
To:     James Hogan <jhogan@kernel.org>
Cc:     John Crispin <john@phrozen.org>,
        Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org
Subject: [PATCH] MIPS: ralink: use memblock instead of rescanning the FDT
Date:   Tue, 27 Mar 2018 20:14:35 -0500
Message-Id: <20180328011435.29776-1-robh@kernel.org>
X-Mailer: git-send-email 2.14.1
Return-Path: <robherring2@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 63272
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: robh@kernel.org
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

There's no need to scan /memory nodes twice. The DT core code scans
nodes and adds memblocks already, so we can just use
memblock_phys_mem_size() to see if we have any memory already setup.

Signed-off-by: Rob Herring <robh@kernel.org>
Cc: John Crispin <john@phrozen.org>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: James Hogan <jhogan@kernel.org>
Cc: linux-mips@linux-mips.org
---
 arch/mips/ralink/of.c | 21 +++++----------------
 1 file changed, 5 insertions(+), 16 deletions(-)

diff --git a/arch/mips/ralink/of.c b/arch/mips/ralink/of.c
index 1ada8492733b..cf3b01b5c624 100644
--- a/arch/mips/ralink/of.c
+++ b/arch/mips/ralink/of.c
@@ -14,7 +14,7 @@
 #include <linux/sizes.h>
 #include <linux/of_fdt.h>
 #include <linux/kernel.h>
-#include <linux/bootmem.h>
+#include <linux/memblock.h>
 #include <linux/of_platform.h>
 #include <linux/of_address.h>
 
@@ -53,17 +53,6 @@ void __init device_tree_init(void)
 	unflatten_and_copy_device_tree();
 }
 
-static int memory_dtb;
-
-static int __init early_init_dt_find_memory(unsigned long node,
-				const char *uname, int depth, void *data)
-{
-	if (depth == 1 && !strcmp(uname, "memory@0"))
-		memory_dtb = 1;
-
-	return 0;
-}
-
 void __init plat_mem_setup(void)
 {
 	void *dtb = NULL;
@@ -82,10 +71,10 @@ void __init plat_mem_setup(void)
 
 	__dt_setup_arch(dtb);
 
-	of_scan_flat_dt(early_init_dt_find_memory, NULL);
-	if (memory_dtb)
-		of_scan_flat_dt(early_init_dt_scan_memory, NULL);
-	else if (soc_info.mem_size)
+	if (memblock_phys_mem_size())
+		return;
+
+	if (soc_info.mem_size)
 		add_memory_region(soc_info.mem_base, soc_info.mem_size * SZ_1M,
 				  BOOT_MEM_RAM);
 	else
-- 
2.14.1
