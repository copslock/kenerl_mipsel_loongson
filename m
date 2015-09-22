Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 22 Sep 2015 20:13:01 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:19877 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27009093AbbIVSM73zjoU (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 22 Sep 2015 20:12:59 +0200
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id 14D38A316CC7E;
        Tue, 22 Sep 2015 19:12:50 +0100 (IST)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 KLMAIL01.kl.imgtec.org (192.168.5.35) with Microsoft SMTP Server (TLS) id
 14.3.195.1; Tue, 22 Sep 2015 19:12:53 +0100
Received: from localhost (192.168.159.189) by LEMAIL01.le.imgtec.org
 (192.168.152.62) with Microsoft SMTP Server (TLS) id 14.3.210.2; Tue, 22 Sep
 2015 19:12:52 +0100
From:   Paul Burton <paul.burton@imgtec.com>
To:     <linux-mips@linux-mips.org>
CC:     Paul Burton <paul.burton@imgtec.com>,
        Markos Chandras <markos.chandras@imgtec.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH 01/10] MIPS: CPS: set Status.BEV bit during early boot
Date:   Tue, 22 Sep 2015 11:12:09 -0700
Message-ID: <1442945538-26141-2-git-send-email-paul.burton@imgtec.com>
X-Mailer: git-send-email 2.5.3
In-Reply-To: <1442945538-26141-1-git-send-email-paul.burton@imgtec.com>
References: <1442945538-26141-1-git-send-email-paul.burton@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.159.189]
Return-Path: <Paul.Burton@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 49302
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

Set the Status.BEV bit throughout the early startup of a secondary core
such that if an exception occurs the core branches to one of the
exception vector entries from cps-vec.S, rather than branching to
whatever is set in EBase.

Signed-off-by: Paul Burton <paul.burton@imgtec.com>
---

 arch/mips/kernel/cps-vec.S | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/mips/kernel/cps-vec.S b/arch/mips/kernel/cps-vec.S
index 9f71c06..9710db5 100644
--- a/arch/mips/kernel/cps-vec.S
+++ b/arch/mips/kernel/cps-vec.S
@@ -70,7 +70,7 @@ not_nmi:
 	mtc0	t0, CP0_CAUSE
 
 	/* Setup Status */
-	li	t0, ST0_CU1 | ST0_CU0
+	li	t0, ST0_CU1 | ST0_CU0 | ST0_BEV
 	mtc0	t0, CP0_STATUS
 
 	/*
-- 
2.5.3
