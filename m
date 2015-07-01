Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 01 Jul 2015 10:15:19 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:43836 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27009567AbbGAIORUygo4 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 1 Jul 2015 10:14:17 +0200
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id C9669D8284D88;
        Wed,  1 Jul 2015 09:14:09 +0100 (IST)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 KLMAIL01.kl.imgtec.org (192.168.5.35) with Microsoft SMTP Server (TLS) id
 14.3.195.1; Wed, 1 Jul 2015 09:14:11 +0100
Received: from mchandras-linux.le.imgtec.org (192.168.154.48) by
 LEMAIL01.le.imgtec.org (192.168.152.62) with Microsoft SMTP Server (TLS) id
 14.3.210.2; Wed, 1 Jul 2015 09:14:11 +0100
From:   Markos Chandras <markos.chandras@imgtec.com>
To:     <linux-mips@linux-mips.org>
CC:     Markos Chandras <markos.chandras@imgtec.com>,
        <stable@vger.kernel.org>
Subject: [PATCH 5/7] MIPS: kernel: cps-vec: Replace KSEG0 with CKSEG0
Date:   Wed, 1 Jul 2015 09:13:32 +0100
Message-ID: <1435738414-30944-6-git-send-email-markos.chandras@imgtec.com>
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
X-archive-position: 48051
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

In preparation for 64-bit CPS support, we replace KSEG0 with CKSEG0
so 64-bit kernels can be supported.

Cc: <stable@vger.kernel.org> # 3.16+
Reviewed-by: Paul Burton <paul.burton@imgtec.com>
Signed-off-by: Markos Chandras <markos.chandras@imgtec.com>
---
 arch/mips/kernel/cps-vec.S | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/mips/kernel/cps-vec.S b/arch/mips/kernel/cps-vec.S
index 21f714a81ebd..2f95568e0da5 100644
--- a/arch/mips/kernel/cps-vec.S
+++ b/arch/mips/kernel/cps-vec.S
@@ -107,7 +107,7 @@ not_nmi:
 	mul	t1, t1, t0
 	mul	t1, t1, t2
 
-	li	a0, KSEG0
+	li	a0, CKSEG0
 	add	a1, a0, t1
 1:	cache	Index_Store_Tag_I, 0(a0)
 	add	a0, a0, t0
@@ -134,7 +134,7 @@ icache_done:
 	mul	t1, t1, t0
 	mul	t1, t1, t2
 
-	li	a0, KSEG0
+	li	a0, CKSEG0
 	addu	a1, a0, t1
 	subu	a1, a1, t0
 1:	cache	Index_Store_Tag_D, 0(a0)
-- 
2.4.5
