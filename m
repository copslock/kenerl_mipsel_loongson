Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 24 Jun 2015 10:29:31 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:8084 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27006697AbbFXI3a11FJx (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 24 Jun 2015 10:29:30 +0200
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id E8C27E1A2ABE6
        for <linux-mips@linux-mips.org>; Wed, 24 Jun 2015 09:29:22 +0100 (IST)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 KLMAIL01.kl.imgtec.org (192.168.5.35) with Microsoft SMTP Server (TLS) id
 14.3.195.1; Wed, 24 Jun 2015 09:29:24 +0100
Received: from mchandras-linux.le.imgtec.org (192.168.154.48) by
 LEMAIL01.le.imgtec.org (192.168.152.62) with Microsoft SMTP Server (TLS) id
 14.3.210.2; Wed, 24 Jun 2015 09:29:23 +0100
From:   Markos Chandras <markos.chandras@imgtec.com>
To:     <linux-mips@linux-mips.org>
CC:     Markos Chandras <markos.chandras@imgtec.com>
Subject: [PATCH] MIPS: kernel: traps: Fix broken indentation
Date:   Wed, 24 Jun 2015 09:29:20 +0100
Message-ID: <1435134560-5840-1-git-send-email-markos.chandras@imgtec.com>
X-Mailer: git-send-email 2.4.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.154.48]
Return-Path: <Markos.Chandras@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 48017
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

Fix broken indentation caused by the SMTC removal
commit b633648c5ad3cfbda0b3daea50d2135d44899259
("MIPS: MT: Remove SMTC support")

Fixes: b633648c5ad3c ("MIPS: MT: Remove SMTC support")
Signed-off-by: Markos Chandras <markos.chandras@imgtec.com>
---
 arch/mips/kernel/traps.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/mips/kernel/traps.c b/arch/mips/kernel/traps.c
index d2d1c1933bc9..232a6a942b8b 100644
--- a/arch/mips/kernel/traps.c
+++ b/arch/mips/kernel/traps.c
@@ -2129,10 +2129,10 @@ void per_cpu_trap_init(bool is_boot_cpu)
 	BUG_ON(current->mm);
 	enter_lazy_tlb(&init_mm, current);
 
-		/* Boot CPU's cache setup in setup_arch(). */
-		if (!is_boot_cpu)
-			cpu_cache_init();
-		tlb_init();
+	/* Boot CPU's cache setup in setup_arch(). */
+	if (!is_boot_cpu)
+		cpu_cache_init();
+	tlb_init();
 	TLBMISS_HANDLER_SETUP();
 }
 
-- 
2.4.4
