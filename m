Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 04 Apr 2014 00:19:08 +0200 (CEST)
Received: from mail-ob0-f176.google.com ([209.85.214.176]:39319 "EHLO
        mail-ob0-f176.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6822274AbaDCWRiQqTmr (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 4 Apr 2014 00:17:38 +0200
Received: by mail-ob0-f176.google.com with SMTP id wp18so2664736obc.35
        for <multiple recipients>; Thu, 03 Apr 2014 15:17:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=dXKhVBHug0ZVmxVM6lUaoz8HULnr+kFm7FmZ3KZTKFk=;
        b=O0PWUhoOuPFRgBbjI8JS7HlZixZlLqwapvKIKgy+nnTA28KSTTWlyQBYPmqE+KH96z
         buUGvRQU/m+ZN0XiHAU23H/puQxXFoDMapiznRFaTdxKRZOBxeRSxGR+94d/vdIszZ0Z
         fO/qs1vDbQbpfAhzFNmoi2KvrnddT1DBSwlDZK7deoHIffrFeFvBRs6PveJJUxlYIPh0
         irxjKMjA6T60ljr2FSl+XqAZLaL5VdzSrI35eX4vd70bcOPWvGdvdjfn9U8BlghRbzm0
         I9eKboFWM3R/AnEd9JnRZj+PSQIiYj7meUtwyGvHXo+wK6UMyclWh+uME/xMT8+rPryz
         Lx8w==
X-Received: by 10.60.48.106 with SMTP id k10mr12654607oen.20.1396563451899;
        Thu, 03 Apr 2014 15:17:31 -0700 (PDT)
Received: from localhost.localdomain (72-48-77-163.dyn.grandenetworks.net. [72.48.77.163])
        by mx.google.com with ESMTPSA id dh8sm27577997oeb.10.2014.04.03.15.17.30
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Thu, 03 Apr 2014 15:17:31 -0700 (PDT)
From:   Rob Herring <robherring2@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Grant Likely <grant.likely@linaro.org>,
        Rob Herring <robh@kernel.org>,
        Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org
Subject: [PATCH 04/20] mips: ralink: convert to use unflatten_and_copy_device_tree
Date:   Thu,  3 Apr 2014 17:16:47 -0500
Message-Id: <1396563423-30893-5-git-send-email-robherring2@gmail.com>
X-Mailer: git-send-email 1.8.3.2
In-Reply-To: <1396563423-30893-1-git-send-email-robherring2@gmail.com>
References: <1396563423-30893-1-git-send-email-robherring2@gmail.com>
Return-Path: <robherring2@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 39636
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

The ralink FDT code can be simplified by using
unflatten_and_copy_device_tree function. This removes all accesses to
FDT header data by the arch code.

Signed-off-by: Rob Herring <robh@kernel.org>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: linux-mips@linux-mips.org
---
 arch/mips/ralink/of.c | 25 +------------------------
 1 file changed, 1 insertion(+), 24 deletions(-)

diff --git a/arch/mips/ralink/of.c b/arch/mips/ralink/of.c
index eccc552..0170d82 100644
--- a/arch/mips/ralink/of.c
+++ b/arch/mips/ralink/of.c
@@ -52,30 +52,7 @@ __iomem void *plat_of_remap_node(const char *node)
 
 void __init device_tree_init(void)
 {
-	unsigned long base, size;
-	void *fdt_copy;
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
-	/* The strings in the flattened tree are referenced directly by the
-	 * device tree, so copy the flattened device tree from init memory
-	 * to regular memory.
-	 */
-	fdt_copy = alloc_bootmem(size);
-	memcpy(fdt_copy, initial_boot_params, size);
-	initial_boot_params = fdt_copy;
-
-	unflatten_device_tree();
-
-	/* free the space reserved for the dt blob */
-	free_bootmem(base, size);
+	unflatten_and_copy_device_tree();
 }
 
 void __init plat_mem_setup(void)
-- 
1.8.3.2
