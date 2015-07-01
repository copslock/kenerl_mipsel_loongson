Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 01 Jul 2015 10:14:42 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:25017 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27009476AbbGAIOOd5-b4 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 1 Jul 2015 10:14:14 +0200
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id 8C8926FD9AC1;
        Wed,  1 Jul 2015 09:14:07 +0100 (IST)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 KLMAIL01.kl.imgtec.org (192.168.5.35) with Microsoft SMTP Server (TLS) id
 14.3.195.1; Wed, 1 Jul 2015 09:14:08 +0100
Received: from mchandras-linux.le.imgtec.org (192.168.154.48) by
 LEMAIL01.le.imgtec.org (192.168.152.62) with Microsoft SMTP Server (TLS) id
 14.3.210.2; Wed, 1 Jul 2015 09:14:08 +0100
From:   Markos Chandras <markos.chandras@imgtec.com>
To:     <linux-mips@linux-mips.org>
CC:     Markos Chandras <markos.chandras@imgtec.com>,
        <stable@vger.kernel.org>
Subject: [PATCH 3/7] MIPS: kernel: cps-vec: Replace mips32r2 ISA level with mips64r2
Date:   Wed, 1 Jul 2015 09:13:30 +0100
Message-ID: <1435738414-30944-4-git-send-email-markos.chandras@imgtec.com>
X-Mailer: git-send-email 2.4.5
In-Reply-To: <1435738414-30944-1-git-send-email-markos.chandras@imgtec.com>
References: <1435738414-30944-1-git-send-email-markos.chandras@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.154.48]
Return-Path: <Markos.Chandras@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 48049
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

mips32r2 is a subset of mips64r2, so we replace mips32r2 with mips64r2
in preparation for 64-bit CPS support.

Cc: <stable@vger.kernel.org> # 3.16+
Reviewed-by: Paul Burton <paul.burton@imgtec.com>
Signed-off-by: Markos Chandras <markos.chandras@imgtec.com>
---
 arch/mips/kernel/cps-vec.S | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/mips/kernel/cps-vec.S b/arch/mips/kernel/cps-vec.S
index a4b2d81f45dd..bbbd88e994f0 100644
--- a/arch/mips/kernel/cps-vec.S
+++ b/arch/mips/kernel/cps-vec.S
@@ -229,7 +229,7 @@ LEAF(mips_cps_core_init)
 	 nop
 
 	.set	push
-	.set	mips32r2
+	.set	mips64r2
 	.set	mt
 
 	/* Only allow 1 TC per VPE to execute... */
@@ -346,7 +346,7 @@ LEAF(mips_cps_boot_vpes)
 	 nop
 
 	.set	push
-	.set	mips32r2
+	.set	mips64r2
 	.set	mt
 
 1:	/* Enter VPE configuration state */
-- 
2.4.5
