Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 04 Apr 2014 00:18:46 +0200 (CEST)
Received: from mail-oa0-f54.google.com ([209.85.219.54]:48378 "EHLO
        mail-oa0-f54.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6822273AbaDCWRguVsDo (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 4 Apr 2014 00:17:36 +0200
Received: by mail-oa0-f54.google.com with SMTP id n16so2743654oag.27
        for <multiple recipients>; Thu, 03 Apr 2014 15:17:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=q+prfR6MNhp8/7QW7afD5f3t3UD1roUQSBKsS37Bf9k=;
        b=lA3vs17S58H5/JOqaEetPIus/OGtAtsNgVhQ8l4TCSU04mX1mzJyd4NJFznMnSnquE
         kSFC641jE9G5Ibh8qEG98POU847AhR3bItMrBxnIO9hfV8eLVW1FZTpGtmDIfnqKo+2R
         lSpbtyf8ipc6q2qOjhztsy65pcE4nrryoP0Ajfg8C56O+xTLouRCFCXiskrovGzItVTH
         /VMpRKqNUFg4TFCC/DkVazpvrOxl+a/Dl0J9zgyctvr6s/QaAHZO/9NYJyhzXHVJRptM
         I4QCwsVZ93pV6277N4o2tvCCM/iHYe3RgYx9AaJ1uTdY6vAxYoQhNKFM250zJinNoJpR
         Lizw==
X-Received: by 10.60.62.178 with SMTP id z18mr6071205oer.61.1396563450693;
        Thu, 03 Apr 2014 15:17:30 -0700 (PDT)
Received: from localhost.localdomain (72-48-77-163.dyn.grandenetworks.net. [72.48.77.163])
        by mx.google.com with ESMTPSA id dh8sm27577997oeb.10.2014.04.03.15.17.28
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Thu, 03 Apr 2014 15:17:28 -0700 (PDT)
From:   Rob Herring <robherring2@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Grant Likely <grant.likely@linaro.org>,
        Rob Herring <robh@kernel.org>,
        Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org
Subject: [PATCH 03/20] mips: xlp: copy built-in DTB out of init section
Date:   Thu,  3 Apr 2014 17:16:46 -0500
Message-Id: <1396563423-30893-4-git-send-email-robherring2@gmail.com>
X-Mailer: git-send-email 1.8.3.2
In-Reply-To: <1396563423-30893-1-git-send-email-robherring2@gmail.com>
References: <1396563423-30893-1-git-send-email-robherring2@gmail.com>
Return-Path: <robherring2@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 39635
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
1.8.3.2
