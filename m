Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 09 Apr 2015 10:57:31 +0200 (CEST)
Received: from mail.kernel.org ([198.145.29.136]:46178 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27024674AbbDII5QDUIOz (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 9 Apr 2015 10:57:16 +0200
Received: from mail.kernel.org (localhost [127.0.0.1])
        by mail.kernel.org (Postfix) with ESMTP id 89C2E2043C;
        Thu,  9 Apr 2015 08:57:15 +0000 (UTC)
Received: from localhost.localdomain (unknown [183.247.163.231])
        (using TLSv1.2 with cipher AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id ABBBF203E3;
        Thu,  9 Apr 2015 08:57:12 +0000 (UTC)
From:   lizf@kernel.org
To:     stable@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, David Daney <david.daney@cavium.com>,
        Leonid Yegoshin <Leonid.Yegoshin@imgtec.com>,
        linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>,
        Zefan Li <lizefan@huawei.com>
Subject: [PATCH 3.4 145/176] MIPS: Fix C0_Pagegrain[IEC] support.
Date:   Thu,  9 Apr 2015 16:46:33 +0800
Message-Id: <1428569224-23820-145-git-send-email-lizf@kernel.org>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1428569028-23762-1-git-send-email-lizf@kernel.org>
References: <1428569028-23762-1-git-send-email-lizf@kernel.org>
X-Virus-Scanned: ClamAV using ClamSMTP
Return-Path: <lizf@kernel.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 46845
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: lizf@kernel.org
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

From: David Daney <david.daney@cavium.com>

3.4.107-rc1 review patch.  If anyone has any objections, please let me know.

------------------


commit 9ead8632bbf454cfc709b6205dc9cd8582fb0d64 upstream.

The following commits:

  5890f70f15c52d (MIPS: Use dedicated exception handler if CPU supports RI/XI exceptions)
  6575b1d4173eae (MIPS: kernel: cpu-probe: Detect unique RI/XI exceptions)

break the kernel for *all* existing MIPS CPUs that implement the
CP0_PageGrain[IEC] bit.  They cause the TLB exception handlers to be
generated without the legacy execute-inhibit handling, but never set
the CP0_PageGrain[IEC] bit to activate the use of dedicated exception
vectors for execute-inhibit exceptions.  The result is that upon
detection of an execute-inhibit violation, we loop forever in the TLB
exception handlers instead of sending SIGSEGV to the task.

If we are generating TLB exception handlers expecting separate
vectors, we must also enable the CP0_PageGrain[IEC] feature.

The bug was introduced in kernel version 3.17.

Signed-off-by: David Daney <david.daney@cavium.com>
Cc: Leonid Yegoshin <Leonid.Yegoshin@imgtec.com>
Cc: linux-mips@linux-mips.org
Patchwork: http://patchwork.linux-mips.org/patch/8880/
Signed-off-by: Ralf Baechle <ralf@linux-mips.org>
Signed-off-by: Zefan Li <lizefan@huawei.com>
---
 arch/mips/mm/tlb-r4k.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/mips/mm/tlb-r4k.c b/arch/mips/mm/tlb-r4k.c
index d2572cb..6ac2e87 100644
--- a/arch/mips/mm/tlb-r4k.c
+++ b/arch/mips/mm/tlb-r4k.c
@@ -410,6 +410,8 @@ void __cpuinit tlb_init(void)
 #ifdef CONFIG_64BIT
 		pg |= PG_ELPA;
 #endif
+		if (cpu_has_rixiex)
+			pg |= PG_IEC;
 		write_c0_pagegrain(pg);
 	}
 
-- 
1.9.1
