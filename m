Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 05 Dec 2017 23:39:27 +0100 (CET)
Received: from 9pmail.ess.barracuda.com ([64.235.154.211]:33965 "EHLO
        9pmail.ess.barracuda.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990502AbdLEWjUAbjTU (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 5 Dec 2017 23:39:20 +0100
Received: from MIPSMAIL01.mipstec.com (mailrelay.mips.com [12.201.5.28]) by mx1403.ess.rzc.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NO); Tue, 05 Dec 2017 22:30:43 +0000
Received: from jhogan-linux.mipstec.com (192.168.154.110) by
 MIPSMAIL01.mipstec.com (10.20.43.31) with Microsoft SMTP Server (TLS) id
 14.3.361.1; Tue, 5 Dec 2017 14:28:53 -0800
From:   James Hogan <james.hogan@mips.com>
To:     Ralf Baechle <ralf@linux-mips.org>
CC:     Paul Burton <paul.burton@mips.com>,
        James Hogan <jhogan@kernel.org>, <linux-mips@linux-mips.org>,
        <stable@vger.kernel.org>
Subject: [PATCH] MIPS: CM: Drop WARN_ON(vp != 0)
Date:   Tue, 5 Dec 2017 22:28:22 +0000
Message-ID: <20171205222822.15034-1-james.hogan@mips.com>
X-Mailer: git-send-email 2.14.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.154.110]
X-BESS-ID: 1512513043-321459-5107-10372-7
X-BESS-VER: 2017.14-r1710272128
X-BESS-Apparent-Source-IP: 12.201.5.28
X-BESS-BRTS-Status: 1
Return-Path: <James.Hogan@mips.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 61312
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: james.hogan@mips.com
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

From: James Hogan <jhogan@kernel.org>

Since commit 68923cdc2eb3 ("MIPS: CM: Add cluster & block args to
mips_cm_lock_other()"), mips_smp_send_ipi_mask() has used
mips_cm_lock_other_cpu() with each CPU number, rather than
mips_cm_lock_other() with the first VPE in each core. Prior to r6,
multicore multithreaded systems such as dual-core dual-thread
interAptivs with CPU Idle enabled (e.g. MIPS Creator Ci40) results in
mips_cm_lock_other() repeatedly hitting WARN_ON(vp != 0).

There doesn't appear to be anything fundamentally wrong about passing a
non-zero VP/VPE number, even if it is a core's region that is locked
into the other region before r6, so remove that particular WARN_ON().

Fixes: 68923cdc2eb3 ("MIPS: CM: Add cluster & block args to mips_cm_lock_other()")
Signed-off-by: James Hogan <jhogan@kernel.org>
Reviewed-by: Paul Burton <paul.burton@mips.com>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: linux-mips@linux-mips.org
Cc: <stable@vger.kernel.org> # 4.14+
---
 arch/mips/kernel/mips-cm.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/mips/kernel/mips-cm.c b/arch/mips/kernel/mips-cm.c
index dd5567b1e305..8f5bd04f320a 100644
--- a/arch/mips/kernel/mips-cm.c
+++ b/arch/mips/kernel/mips-cm.c
@@ -292,7 +292,6 @@ void mips_cm_lock_other(unsigned int cluster, unsigned int core,
 				  *this_cpu_ptr(&cm_core_lock_flags));
 	} else {
 		WARN_ON(cluster != 0);
-		WARN_ON(vp != 0);
 		WARN_ON(block != CM_GCR_Cx_OTHER_BLOCK_LOCAL);
 
 		/*
-- 
2.14.1
