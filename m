Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 28 Jul 2011 13:29:12 +0200 (CEST)
Received: from mail-yi0-f49.google.com ([209.85.218.49]:46165 "EHLO
        mail-yi0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491056Ab1G1L2u (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 28 Jul 2011 13:28:50 +0200
Received: by yib17 with SMTP id 17so1980771yib.36
        for <linux-mips@linux-mips.org>; Thu, 28 Jul 2011 04:28:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=GvOW4YfYHDwrK3a0y6FY5o6D9Y5rKn/fzxoYloQhG6I=;
        b=pQ8egot34WUJ0L0LLj0mCPxPlRe11jhieAQVGfkmU1yF9kdTnlAEsofWz3dByDxc8A
         6O8QFcCfwkBhQr3btHZf0Gu59ngakGpiIzxdMlQD0ad/rRbu+gFqY2fNq7GJ7PuDnkG0
         03m+xTsul1m14v2q6FmhEPSqSVIRyI4h9vk9g=
Received: by 10.91.207.20 with SMTP id j20mr702088agq.102.1311852524435;
        Thu, 28 Jul 2011 04:28:44 -0700 (PDT)
Received: from localhost.localdomain ([210.13.118.102])
        by mx.google.com with ESMTPS id p6sm678491ank.28.2011.07.28.04.28.41
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 28 Jul 2011 04:28:44 -0700 (PDT)
From:   Deng-Cheng Zhu <dengcheng.zhu@gmail.com>
To:     jbarnes@virtuousgeek.org, torvalds@linux-foundation.org
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mips@linux-mips.org, eyal@mips.com, zenon@mips.com,
        dengcheng.zhu@gmail.com
Subject: [PATCH 1/2] PCI: make pci_claim_resource() work with conflict resources as appropriate
Date:   Thu, 28 Jul 2011 19:28:31 +0800
Message-Id: <1311852512-7340-2-git-send-email-dengcheng.zhu@gmail.com>
X-Mailer: git-send-email 1.7.1
In-Reply-To: <1311852512-7340-1-git-send-email-dengcheng.zhu@gmail.com>
References: <1311852512-7340-1-git-send-email-dengcheng.zhu@gmail.com>
X-archive-position: 30753
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dengcheng.zhu@gmail.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 20660

In resolving a network driver issue with the MIPS Malta platform, the root
cause was traced into pci_claim_resource():

MIPS System Controller's PCI I/O resources stay in 0x1000-0xffffff. When
PCI quirks start claiming resources using request_resource_conflict(),
collisions happen and -EBUSY is returned, thereby rendering the onboard AMD
PCnet32 NIC unaware of quirks' region and preventing the NIC from functioning.
For PCI quirks, PIIX4 ACPI is expected to claim 0x1000-0x103f, and PIIX4 SMB to
claim 0x1100-0x110f, both of which fall into the MSC I/O range. Certainly, we
can increase the start point of this range in arch/mips/mti-malta/malta-pci.c to
avoid the collisions. But a fix in here looks more justified, though it seems to
have a wider impact. Using insert_xxx as opposed to request_xxx will register
PCI quirks' resources as children of MSC I/O and return OK, instead of seeing
collisions which are actually resolvable.

Signed-off-by: Deng-Cheng Zhu <dengcheng.zhu@gmail.com>
---
 drivers/pci/setup-res.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/pci/setup-res.c b/drivers/pci/setup-res.c
index bc0e6ee..40d767e 100644
--- a/drivers/pci/setup-res.c
+++ b/drivers/pci/setup-res.c
@@ -102,7 +102,7 @@ int pci_claim_resource(struct pci_dev *dev, int resource)
 		return -EINVAL;
 	}
 
-	conflict = request_resource_conflict(root, res);
+	conflict = insert_resource_conflict(root, res);
 	if (conflict) {
 		dev_info(&dev->dev,
 			 "address space collision: %pR conflicts with %s %pR\n",
-- 
1.7.1
