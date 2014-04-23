Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 23 Apr 2014 03:20:00 +0200 (CEST)
Received: from mail-oa0-f47.google.com ([209.85.219.47]:44371 "EHLO
        mail-oa0-f47.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6834668AbaDWBS5m6PrX (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 23 Apr 2014 03:18:57 +0200
Received: by mail-oa0-f47.google.com with SMTP id i11so296905oag.6
        for <multiple recipients>; Tue, 22 Apr 2014 18:18:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=9l8CM1xr+Vas7MhIoL6R8TorcvllT1GOEqCAhexL1/Q=;
        b=Px5PNQMGYCUNb5fHD9L0BZwghpSu7xIbVB2vmrWpjgE7T8ce4t57A7nBKD0eDbpUUu
         02Pjx5nOqTy4m3bvCvIJweS4yrmgSXYLyrmX/m7at2oUnAaRAU76v9/l6xdz0Ytwvzwf
         K3kpZuJBOiB4WqX/2FPXEJ3CBubEr0giRFZ7ZxHeRfJvsaFwwJqFsqRi7yDMoAtzPDBp
         GhpGYHe942X9TOHNqlu3juAndyzikeXi2A5PCq99ff6zBJt9Obg8o79FSDKsxCfjgMPj
         4by2S6MxtEYsoKgHODlcGqmBq54TubHKk/TSbN7hiUYr7hq6ucQE30WwgeZoCjXgTDTx
         9kjA==
X-Received: by 10.182.158.135 with SMTP id wu7mr39530762obb.28.1398215931686;
        Tue, 22 Apr 2014 18:18:51 -0700 (PDT)
Received: from localhost.localdomain (72-48-77-163.dyn.grandenetworks.net. [72.48.77.163])
        by mx.google.com with ESMTPSA id f1sm184735295oej.5.2014.04.22.18.18.50
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 22 Apr 2014 18:18:51 -0700 (PDT)
From:   Rob Herring <robherring2@gmail.com>
To:     Grant Likely <grant.likely@linaro.org>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Cc:     Rob Herring <robh@kernel.org>, Ralf Baechle <ralf@linux-mips.org>,
        linux-mips@linux-mips.org
Subject: [PATCH v2 03/21] mips: xlp: copy built-in DTB out of init section
Date:   Tue, 22 Apr 2014 20:18:03 -0500
Message-Id: <1398215901-25609-4-git-send-email-robherring2@gmail.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1398215901-25609-1-git-send-email-robherring2@gmail.com>
References: <1398215901-25609-1-git-send-email-robherring2@gmail.com>
Return-Path: <robherring2@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 39903
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
It is also broken because the reserved bootmem was then freed after
unflattening, but the unflattened tree points to data in the flat tree.
Fix this by using the unflatten_and_copy_device_tree function.

This removes all accesses to FDT header data by the arch code.

Signed-off-by: Rob Herring <robh@kernel.org>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: linux-mips@linux-mips.org
---
v2: no change

 arch/mips/netlogic/xlp/dt.c | 17 +----------------
 1 file changed, 1 insertion(+), 16 deletions(-)

diff --git a/arch/mips/netlogic/xlp/dt.c b/arch/mips/netlogic/xlp/dt.c
index 5754097..7f9615a 100644
--- a/arch/mips/netlogic/xlp/dt.c
+++ b/arch/mips/netlogic/xlp/dt.c
@@ -87,22 +87,7 @@ void __init xlp_early_init_devtree(void)
 
 void __init device_tree_init(void)
 {
-	unsigned long base, size;
-	struct boot_param_header *fdtp = xlp_fdt_blob;
-
-	if (!fdtp)
-		return;
-
-	base = virt_to_phys(fdtp);
-	size = be32_to_cpu(fdtp->totalsize);
-
-	/* Before we do anything, lets reserve the dt blob */
-	reserve_bootmem(base, size, BOOTMEM_DEFAULT);
-
-	unflatten_device_tree();
-
-	/* free the space reserved for the dt blob */
-	free_bootmem(base, size);
+	unflatten_and_copy_device_tree();
 }
 
 static struct of_device_id __initdata xlp_ids[] = {
-- 
1.9.1
