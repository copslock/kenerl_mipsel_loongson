Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 09 Jul 2015 11:44:55 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:52919 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27009603AbbGIJltTaveh (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 9 Jul 2015 11:41:49 +0200
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id 9B5EB3D9D4476
        for <linux-mips@linux-mips.org>; Thu,  9 Jul 2015 10:41:41 +0100 (IST)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 KLMAIL01.kl.imgtec.org (192.168.5.35) with Microsoft SMTP Server (TLS) id
 14.3.195.1; Thu, 9 Jul 2015 10:41:43 +0100
Received: from mchandras-linux.le.imgtec.org (192.168.154.48) by
 LEMAIL01.le.imgtec.org (192.168.152.62) with Microsoft SMTP Server (TLS) id
 14.3.210.2; Thu, 9 Jul 2015 10:41:43 +0100
From:   Markos Chandras <markos.chandras@imgtec.com>
To:     <linux-mips@linux-mips.org>
CC:     Markos Chandras <markos.chandras@imgtec.com>
Subject: [PATCH 12/19] MIPS: kernel: mips-cpc: Fix type for GCR CPC base reg for 64-bit
Date:   Thu, 9 Jul 2015 10:40:46 +0100
Message-ID: <1436434853-30001-13-git-send-email-markos.chandras@imgtec.com>
X-Mailer: git-send-email 2.4.5
In-Reply-To: <1436434853-30001-1-git-send-email-markos.chandras@imgtec.com>
References: <1436434853-30001-1-git-send-email-markos.chandras@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.154.48]
Return-Path: <Markos.Chandras@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 48149
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: markos.chandras@imgtec.com
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

The GCR CPC base register is 64-bit on 64-bit processors so use the
appropriate field.

Signed-off-by: Markos Chandras <markos.chandras@imgtec.com>
---
 arch/mips/kernel/mips-cpc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/mips/kernel/mips-cpc.c b/arch/mips/kernel/mips-cpc.c
index 11964501c4b0..e05aca41e087 100644
--- a/arch/mips/kernel/mips-cpc.c
+++ b/arch/mips/kernel/mips-cpc.c
@@ -23,7 +23,7 @@ static DEFINE_PER_CPU_ALIGNED(unsigned long, cpc_core_lock_flags);
 
 phys_addr_t __weak mips_cpc_phys_base(void)
 {
-	u32 cpc_base;
+	unsigned long cpc_base;
 
 	if (!mips_cm_present())
 		return 0;
-- 
2.4.5
