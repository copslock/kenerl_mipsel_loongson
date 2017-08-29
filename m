Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 29 Aug 2017 22:06:19 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:47040 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23995072AbdH2UGLG8x00 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 29 Aug 2017 22:06:11 +0200
Received: from hhmail02.hh.imgtec.org (unknown [10.100.10.20])
        by Forcepoint Email with ESMTPS id 01C4B9473B7FF;
        Tue, 29 Aug 2017 21:06:00 +0100 (IST)
Received: from localhost (10.20.1.88) by hhmail02.hh.imgtec.org (10.100.10.21)
 with Microsoft SMTP Server (TLS) id 14.3.294.0; Tue, 29 Aug 2017 21:06:03
 +0100
From:   Paul Burton <paul.burton@imgtec.com>
To:     <linux-mips@linux-mips.org>
CC:     Paul Burton <paul.burton@imgtec.com>,
        Ralf Baechle <ralf@linux-mips.org>
Subject: [PATCH] fixup: MIPS: CM: Use BIT/GENMASK for register fields, order & drop shifts
Date:   Tue, 29 Aug 2017 13:05:37 -0700
Message-ID: <20170829200537.353-1-paul.burton@imgtec.com>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <20170813024943.14989-4-paul.burton@imgtec.com>
References: <20170813024943.14989-4-paul.burton@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.20.1.88]
Return-Path: <Paul.Burton@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 59883
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

This patch fixes an incorrectly fixed up use of __ffs() on a 64 bit
integer, and a missed usage of CM_GCR_GIC_STATUS_GICEX.

Signed-off-by: Paul Burton <paul.burton@imgtec.com>
Fixes: 4f1f490f010b ("MIPS: CM: Use BIT/GENMASK for register fields, order & drop shifts")
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: linux-mips@linux-mips.org
---

 arch/mips/kernel/mips-cm.c         | 2 +-
 arch/mips/mti-malta/malta-dtshim.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/mips/kernel/mips-cm.c b/arch/mips/kernel/mips-cm.c
index b0d670af5cb1..e91c8c4e2eb5 100644
--- a/arch/mips/kernel/mips-cm.c
+++ b/arch/mips/kernel/mips-cm.c
@@ -391,7 +391,7 @@ void mips_cm_error_report(void)
 		ulong core_id_bits, vp_id_bits, cmd_bits, cmd_group_bits;
 		ulong cm3_cca_bits, mcp_bits, cm3_tr_bits, sched_bit;
 
-		cause = cm_error >> __ffs(CM3_GCR_ERROR_CAUSE_ERRTYPE);
+		cause = cm_error >> __ffs64(CM3_GCR_ERROR_CAUSE_ERRTYPE);
 		ocause = cm_other >> __ffs(CM_GCR_ERROR_MULT_ERR2ND);
 
 		if (!cause)
diff --git a/arch/mips/mti-malta/malta-dtshim.c b/arch/mips/mti-malta/malta-dtshim.c
index 59a723d9a95a..361f7c146b75 100644
--- a/arch/mips/mti-malta/malta-dtshim.c
+++ b/arch/mips/mti-malta/malta-dtshim.c
@@ -236,7 +236,7 @@ static void __init remove_gic(void *fdt)
 
 	/* if we have a CM which reports a GIC is present, leave the DT alone */
 	err = mips_cm_probe();
-	if (!err && (read_gcr_gic_status() & CM_GCR_GIC_STATUS_GICEX))
+	if (!err && (read_gcr_gic_status() & CM_GCR_GIC_STATUS_EX))
 		return;
 
 	if (malta_scon() == MIPS_REVISION_SCON_ROCIT) {
-- 
2.14.1
