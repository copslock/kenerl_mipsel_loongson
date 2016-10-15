Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 16 Oct 2016 00:04:15 +0200 (CEST)
Received: from mailapp02.imgtec.com ([217.156.133.132]:62961 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S23992121AbcJOWEIqiiKW (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 16 Oct 2016 00:04:08 +0200
Received: from HHMAIL03.hh.imgtec.org (unknown [10.44.0.21])
        by Forcepoint Email with ESMTPS id 477068D423236;
        Sat, 15 Oct 2016 23:03:58 +0100 (IST)
Received: from HHMAIL01.hh.imgtec.org (10.100.10.19) by HHMAIL03.hh.imgtec.org
 (10.44.0.21) with Microsoft SMTP Server (TLS) id 14.3.294.0; Sat, 15 Oct 2016
 23:04:02 +0100
Received: from localhost (10.100.200.108) by HHMAIL01.hh.imgtec.org
 (10.100.10.21) with Microsoft SMTP Server (TLS) id 14.3.294.0; Sat, 15 Oct
 2016 23:04:01 +0100
From:   Paul Burton <paul.burton@imgtec.com>
To:     <linux-mips@linux-mips.org>
CC:     Paul Burton <paul.burton@imgtec.com>,
        Ralf Baechle <ralf@linux-mips.org>
Subject: [PATCH] MIPS: CPC: Provide default mips_cpc_default_phys_base to ignore CPC
Date:   Sat, 15 Oct 2016 23:03:43 +0100
Message-ID: <20161015220343.14512-1-paul.burton@imgtec.com>
X-Mailer: git-send-email 2.10.0
In-Reply-To: <201610160506.fUCu3h9s%fengguang.wu@intel.com>
References: <201610160506.fUCu3h9s%fengguang.wu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.100.200.108]
Return-Path: <Paul.Burton@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 55436
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: paul.burton@imgtec.com
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

Provide a default implementation of mips_cpc_default_phys_base() which
simply returns 0, and adjust mips_cpc_phys_base() to allow for
mips_cpc_default_phys_base() returning 0. This allows kernels which
include CPC support to be built without platform code & simply ignore
the CPC if it wasn't already enabled by the bootloader.

This fixes link failures such as the following from generic defconfigs:

   arch/mips/built-in.o: In function `mips_cpc_phys_base':
   arch/mips/kernel/mips-cpc.c:47: undefined reference to `mips_cpc_default_phys_base'

Signed-off-by: Paul Burton <paul.burton@imgtec.com>
Reported-by: kbuild test robot <fengguang.wu@intel.com>
Cc: linux-mips@linux-mips.org
Cc: Ralf Baechle <ralf@linux-mips.org>
---
Hi Ralf,

Please could this one be merged for v4.9 - it fixes some fallout due to
the CPC parts of the generic kernel series not being merged, which I had
overlooked when we discussed the series previously.
---
 arch/mips/kernel/mips-cpc.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/arch/mips/kernel/mips-cpc.c b/arch/mips/kernel/mips-cpc.c
index 2a45867..da64cd5 100644
--- a/arch/mips/kernel/mips-cpc.c
+++ b/arch/mips/kernel/mips-cpc.c
@@ -21,6 +21,11 @@ static DEFINE_PER_CPU_ALIGNED(spinlock_t, cpc_core_lock);
 
 static DEFINE_PER_CPU_ALIGNED(unsigned long, cpc_core_lock_flags);
 
+__weak phys_addr_t mips_cpc_default_phys_base(void)
+{
+	return 0;
+}
+
 /**
  * mips_cpc_phys_base - retrieve the physical base address of the CPC
  *
@@ -43,8 +48,12 @@ static phys_addr_t mips_cpc_phys_base(void)
 	if (cpc_base & CM_GCR_CPC_BASE_CPCEN_MSK)
 		return cpc_base & CM_GCR_CPC_BASE_CPCBASE_MSK;
 
-	/* Otherwise, give it the default address & enable it */
+	/* Otherwise, use the default address */
 	cpc_base = mips_cpc_default_phys_base();
+	if (!cpc_base)
+		return cpc_base;
+
+	/* Enable the CPC, mapped at the default address */
 	write_gcr_cpc_base(cpc_base | CM_GCR_CPC_BASE_CPCEN_MSK);
 	return cpc_base;
 }
-- 
2.10.0
