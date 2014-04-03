Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 04 Apr 2014 00:18:25 +0200 (CEST)
Received: from mail-ob0-f172.google.com ([209.85.214.172]:63354 "EHLO
        mail-ob0-f172.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6822272AbaDCWRfPOxzl (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 4 Apr 2014 00:17:35 +0200
Received: by mail-ob0-f172.google.com with SMTP id wm4so2654460obc.17
        for <multiple recipients>; Thu, 03 Apr 2014 15:17:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=CQUj3exbzSM7AN2QmvRP06zVys0JRc+L294HvAznqxE=;
        b=zbwmlisgKH+GNUeyGUqiSLVid20WTm7lZxwLn2HRuFYapTUwSP4pU6a/Y9em/FLiFi
         lfuZayvFD6soUk8yns/e/j1WXyjp9vlIRYO8Z7VUeqGaYZWotkp5Uud8taZop3/bIq1M
         yzyb6rLeBTrMPxMXqpJks1bVFXmhjd+jDShBQ6MVYTz8uiw3zLUXDhKnEVYrGhYzMH8v
         h/squngnhQTYFbn+Dheig1XgwoIvs7K3DAnHE6zBnhnk6VIJ83KPmDSAbKd/FlCWDgvU
         n66Kn9DsomDNTPhEuFO3hyLbSJSBQVIYsAWtikioOTHjlzEJycZKXISpr4Ftm9LFyVT+
         XcPw==
X-Received: by 10.60.39.131 with SMTP id p3mr8738957oek.44.1396563447743;
        Thu, 03 Apr 2014 15:17:27 -0700 (PDT)
Received: from localhost.localdomain (72-48-77-163.dyn.grandenetworks.net. [72.48.77.163])
        by mx.google.com with ESMTPSA id dh8sm27577997oeb.10.2014.04.03.15.17.26
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Thu, 03 Apr 2014 15:17:26 -0700 (PDT)
From:   Rob Herring <robherring2@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Grant Likely <grant.likely@linaro.org>,
        Rob Herring <robh@kernel.org>,
        Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org
Subject: [PATCH 02/20] mips: lantiq: copy built-in DTB out of init section
Date:   Thu,  3 Apr 2014 17:16:45 -0500
Message-Id: <1396563423-30893-3-git-send-email-robherring2@gmail.com>
X-Mailer: git-send-email 1.8.3.2
In-Reply-To: <1396563423-30893-1-git-send-email-robherring2@gmail.com>
References: <1396563423-30893-1-git-send-email-robherring2@gmail.com>
Return-Path: <robherring2@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 39634
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
1.8.3.2
