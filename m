Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 23 Apr 2014 03:20:50 +0200 (CEST)
Received: from mail-oa0-f47.google.com ([209.85.219.47]:50094 "EHLO
        mail-oa0-f47.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6834672AbaDWBS7eNXiO (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 23 Apr 2014 03:18:59 +0200
Received: by mail-oa0-f47.google.com with SMTP id i11so296930oag.6
        for <multiple recipients>; Tue, 22 Apr 2014 18:18:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=O1Kh3vw+1ic6/vXw7Mm+7OKbZvYttz1LZajwZoyEvYs=;
        b=HBM+DQADo8HnROlkjlttPmMFR6JQiITxSjQj1Dp7ZgBROWv9kMOCLC1g/JJBQKpfDX
         aBg8gkRMiDKu/dOn+hbAaV8AZWyivXW3CHl8cxnf3WahnKQvKUYEdPjbglaBoLD2Frmy
         /gYwK83G3nQJe4HQcyPEdOuTg4G8yms5y4B3sx12Hl5AFwNCKa2vZvT25lbLS0FFhhWY
         CGzSyMJPcqpnxYuLZ2Uw/yc5FUbtqNTwiXbWUhy41Hl+K3GuiQKdb3NicGSms50LvkmC
         4Fn/h+QNtpuFWVEizNbcDdkwTyFYvt6SmBv5eEoZ026/TixXn8Bq7DOD1+xGMwNwKXuW
         t6cg==
X-Received: by 10.182.33.73 with SMTP id p9mr34868151obi.37.1398215933545;
        Tue, 22 Apr 2014 18:18:53 -0700 (PDT)
Received: from localhost.localdomain (72-48-77-163.dyn.grandenetworks.net. [72.48.77.163])
        by mx.google.com with ESMTPSA id f1sm184735295oej.5.2014.04.22.18.18.51
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 22 Apr 2014 18:18:52 -0700 (PDT)
From:   Rob Herring <robherring2@gmail.com>
To:     Grant Likely <grant.likely@linaro.org>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Cc:     Rob Herring <robh@kernel.org>, Ralf Baechle <ralf@linux-mips.org>,
        linux-mips@linux-mips.org
Subject: [PATCH v2 04/21] mips: ralink: convert to use unflatten_and_copy_device_tree
Date:   Tue, 22 Apr 2014 20:18:04 -0500
Message-Id: <1398215901-25609-5-git-send-email-robherring2@gmail.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1398215901-25609-1-git-send-email-robherring2@gmail.com>
References: <1398215901-25609-1-git-send-email-robherring2@gmail.com>
Return-Path: <robherring2@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 39904
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
v2: no change

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
1.9.1
