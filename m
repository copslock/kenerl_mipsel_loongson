Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 02 Feb 2015 12:46:07 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:18966 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27012402AbbBBLpsNkIsi (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 2 Feb 2015 12:45:48 +0100
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id C7F965B6B6412;
        Mon,  2 Feb 2015 11:45:37 +0000 (GMT)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 KLMAIL01.kl.imgtec.org (192.168.5.35) with Microsoft SMTP Server (TLS) id
 14.3.195.1; Mon, 2 Feb 2015 11:45:39 +0000
Received: from jhogan-linux.le.imgtec.org (192.168.154.110) by
 LEMAIL01.le.imgtec.org (192.168.152.62) with Microsoft SMTP Server (TLS) id
 14.3.210.2; Mon, 2 Feb 2015 11:45:39 +0000
From:   James Hogan <james.hogan@imgtec.com>
To:     Ralf Baechle <ralf@linux-mips.org>, <linux-mips@linux-mips.org>
CC:     <linux-kernel@vger.kernel.org>,
        James Hogan <james.hogan@imgtec.com>
Subject: [PATCH v2 3/3] MIPS: Malta: Implement mips_cdmm_phys_base()
Date:   Mon, 2 Feb 2015 11:45:10 +0000
Message-ID: <1422877510-29247-4-git-send-email-james.hogan@imgtec.com>
X-Mailer: git-send-email 2.0.5
In-Reply-To: <1422877510-29247-1-git-send-email-james.hogan@imgtec.com>
References: <1422877510-29247-1-git-send-email-james.hogan@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.154.110]
Return-Path: <James.Hogan@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 45604
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: james.hogan@imgtec.com
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

Implement mips_cdmm_phys_base() for Malta, returning the physical base
address 0x1fc10000 which is "typically unused".

This allows the Common Device Memory Map (CDMM) region to be mapped, and
devices in that region (such as the Fast Debug Channel (FDC) hardware
for communication over EJTAG) to be discovered.

Signed-off-by: James Hogan <james.hogan@imgtec.com>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: linux-mips@linux-mips.org
---
 arch/mips/mti-malta/malta-memory.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/mips/mti-malta/malta-memory.c b/arch/mips/mti-malta/malta-memory.c
index 8fddd2cdbff7..32c27cb8e463 100644
--- a/arch/mips/mti-malta/malta-memory.c
+++ b/arch/mips/mti-malta/malta-memory.c
@@ -16,6 +16,7 @@
 #include <linux/string.h>
 
 #include <asm/bootinfo.h>
+#include <asm/cdmm.h>
 #include <asm/maar.h>
 #include <asm/sections.h>
 #include <asm/fw/fw.h>
@@ -196,3 +197,9 @@ unsigned platform_maar_init(unsigned num_pairs)
 
 	return maar_config(cfg, num_cfg, num_pairs);
 }
+
+phys_addr_t mips_cdmm_phys_base(void)
+{
+	/* This address is "typically unused" */
+	return 0x1fc10000;
+}
-- 
2.0.5
