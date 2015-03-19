Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 19 Mar 2015 23:37:41 +0100 (CET)
Received: from youngberry.canonical.com ([91.189.89.112]:57910 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27014169AbbCSWhK081LP (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 19 Mar 2015 23:37:10 +0100
Received: from [10.172.68.52] (helo=fourier)
        by youngberry.canonical.com with esmtpsa (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
        (Exim 4.71)
        (envelope-from <kamal@canonical.com>)
        id 1YYj3u-0006yp-5q; Thu, 19 Mar 2015 22:37:10 +0000
Received: from kamal by fourier with local (Exim 4.82)
        (envelope-from <kamal@whence.com>)
        id 1YYj3r-0000sY-NJ; Thu, 19 Mar 2015 15:37:07 -0700
From:   Kamal Mostafa <kamal@canonical.com>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        kernel-team@lists.ubuntu.com
Cc:     David Daney <david.daney@cavium.com>,
        Leonid Yegoshin <Leonid.Yegoshin@imgtec.com>,
        linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>,
        Kamal Mostafa <kamal@canonical.com>
Subject: [PATCH 3.13.y-ckt 71/80] MIPS: Fix C0_Pagegrain[IEC] support.
Date:   Thu, 19 Mar 2015 15:35:59 -0700
Message-Id: <1426804568-2907-72-git-send-email-kamal@canonical.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1426804568-2907-1-git-send-email-kamal@canonical.com>
References: <1426804568-2907-1-git-send-email-kamal@canonical.com>
X-Extended-Stable: 3.13
Return-Path: <kamal@canonical.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 46465
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: kamal@canonical.com
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

3.13.11-ckt17 -stable review patch.  If anyone has any objections, please let me know.

------------------

From: David Daney <david.daney@cavium.com>

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
Signed-off-by: Kamal Mostafa <kamal@canonical.com>
---
 arch/mips/mm/tlb-r4k.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/mips/mm/tlb-r4k.c b/arch/mips/mm/tlb-r4k.c
index da3b0b9..d04fe4e 100644
--- a/arch/mips/mm/tlb-r4k.c
+++ b/arch/mips/mm/tlb-r4k.c
@@ -429,6 +429,8 @@ void tlb_init(void)
 #ifdef CONFIG_64BIT
 		pg |= PG_ELPA;
 #endif
+		if (cpu_has_rixiex)
+			pg |= PG_IEC;
 		write_c0_pagegrain(pg);
 	}
 
-- 
1.9.1
