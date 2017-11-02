Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 02 Nov 2017 12:16:49 +0100 (CET)
Received: from mx2.rt-rk.com ([89.216.37.149]:50995 "EHLO mail.rt-rk.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23993420AbdKBLQEmeHeI (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 2 Nov 2017 12:16:04 +0100
Received: from localhost (localhost [127.0.0.1])
        by mail.rt-rk.com (Postfix) with ESMTP id 547C81A21AC;
        Thu,  2 Nov 2017 12:15:59 +0100 (CET)
X-Virus-Scanned: amavisd-new at rt-rk.com
Received: from rtrkw774-lin.domain.local (rtrkw774-lin.domain.local [10.10.13.111])
        by mail.rt-rk.com (Postfix) with ESMTPSA id 370D71A1D20;
        Thu,  2 Nov 2017 12:15:59 +0100 (CET)
From:   Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
To:     linux-mips@linux-mips.org
Cc:     Aleksandar Markovic <aleksandar.markovic@mips.com>,
        Douglas Leung <douglas.leung@mips.com>,
        Goran Ferenc <goran.ferenc@mips.com>,
        James Hogan <james.hogan@mips.com>,
        linux-kernel@vger.kernel.org,
        Miodrag Dinic <miodrag.dinic@mips.com>,
        Paul Burton <paul.burton@mips.com>,
        Petar Jovanovic <petar.jovanovic@mips.com>,
        Raghu Gandham <raghu.gandham@mips.com>,
        Ralf Baechle <ralf@linux-mips.org>
Subject: [PATCH v3 3/8] MIPS: math-emu: Remove an unnecessary header inclusion
Date:   Thu,  2 Nov 2017 12:14:00 +0100
Message-Id: <1509621287-32198-4-git-send-email-aleksandar.markovic@rt-rk.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1509621287-32198-1-git-send-email-aleksandar.markovic@rt-rk.com>
References: <1509621287-32198-1-git-send-email-aleksandar.markovic@rt-rk.com>
Return-Path: <aleksandar.markovic@rt-rk.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 60665
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

Remove an unnecessary header inclusion of "ieee754dp.h".

Signed-off-by: Aleksandar Markovic <aleksandar.markovic@mips.com>
---
 arch/mips/math-emu/sp_tlong.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/mips/math-emu/sp_tlong.c b/arch/mips/math-emu/sp_tlong.c
index a2450c7..bca5ac9 100644
--- a/arch/mips/math-emu/sp_tlong.c
+++ b/arch/mips/math-emu/sp_tlong.c
@@ -20,7 +20,6 @@
  */
 
 #include "ieee754sp.h"
-#include "ieee754dp.h"
 
 s64 ieee754sp_tlong(union ieee754sp x)
 {
-- 
2.7.4
