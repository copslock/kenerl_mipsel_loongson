Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 02 Nov 2017 12:17:40 +0100 (CET)
Received: from mx2.rt-rk.com ([89.216.37.149]:51387 "EHLO mail.rt-rk.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23993418AbdKBLQiVfWCI (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 2 Nov 2017 12:16:38 +0100
Received: from localhost (localhost [127.0.0.1])
        by mail.rt-rk.com (Postfix) with ESMTP id AF8211A4AAE;
        Thu,  2 Nov 2017 12:16:32 +0100 (CET)
X-Virus-Scanned: amavisd-new at rt-rk.com
Received: from rtrkw774-lin.domain.local (rtrkw774-lin.domain.local [10.10.13.111])
        by mail.rt-rk.com (Postfix) with ESMTPSA id 937791A1D20;
        Thu,  2 Nov 2017 12:16:32 +0100 (CET)
From:   Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
To:     linux-mips@linux-mips.org
Cc:     Aleksandar Markovic <aleksandar.markovic@mips.com>,
        Douglas Leung <douglas.leung@imgtec.com>,
        Douglas Leung <douglas.leung@mips.com>,
        Goran Ferenc <goran.ferenc@imgtec.com>,
        Goran Ferenc <goran.ferenc@mips.com>,
        James Hogan <james.hogan@mips.com>,
        linux-kernel@vger.kernel.org,
        Miodrag Dinic <miodrag.dinic@imgtec.com>,
        Miodrag Dinic <miodrag.dinic@mips.com>,
        Paul Burton <paul.burton@mips.com>,
        Petar Jovanovic <petar.jovanovic@mips.com>,
        Raghu Gandham <raghu.gandham@mips.com>,
        Ralf Baechle <ralf@linux-mips.org>
Subject: [PATCH v3 5/8] MIPS: math-emu: Declare function srl128() as static
Date:   Thu,  2 Nov 2017 12:14:02 +0100
Message-Id: <1509621287-32198-6-git-send-email-aleksandar.markovic@rt-rk.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1509621287-32198-1-git-send-email-aleksandar.markovic@rt-rk.com>
References: <1509621287-32198-1-git-send-email-aleksandar.markovic@rt-rk.com>
Return-Path: <aleksandar.markovic@rt-rk.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 60667
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: aleksandar.markovic@rt-rk.com
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

From: Aleksandar Markovic <aleksandar.markovic@mips.com>

Declare function srl128() as static, since it it used just locally
to the source file.

This also removes a sparse warning for corresponding file.

Signed-off-by: Aleksandar Markovic <aleksandar.markovic@mips.com>
---
 arch/mips/math-emu/dp_maddf.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/mips/math-emu/dp_maddf.c b/arch/mips/math-emu/dp_maddf.c
index 28b90fd..5c4ad8e 100644
--- a/arch/mips/math-emu/dp_maddf.c
+++ b/arch/mips/math-emu/dp_maddf.c
@@ -16,7 +16,7 @@
 
 
 /* 128 bits shift right logical with rounding. */
-void srl128(u64 *hptr, u64 *lptr, int count)
+static void srl128(u64 *hptr, u64 *lptr, int count)
 {
 	u64 low;
 
-- 
2.7.4
