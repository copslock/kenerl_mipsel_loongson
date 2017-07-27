Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 27 Jul 2017 18:12:35 +0200 (CEST)
Received: from mx2.rt-rk.com ([89.216.37.149]:57476 "EHLO mail.rt-rk.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23993971AbdG0QL1p0rC9 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 27 Jul 2017 18:11:27 +0200
Received: from localhost (localhost [127.0.0.1])
        by mail.rt-rk.com (Postfix) with ESMTP id 47D421A4923;
        Thu, 27 Jul 2017 18:11:22 +0200 (CEST)
X-Virus-Scanned: amavisd-new at rt-rk.com
Received: from rtrkw197-lin.domain.local (rtrkw197-lin.domain.local [10.10.13.95])
        by mail.rt-rk.com (Postfix) with ESMTPSA id 23CCD1A4772;
        Thu, 27 Jul 2017 18:11:22 +0200 (CEST)
From:   Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
To:     linux-mips@linux-mips.org
Cc:     Goran Ferenc <goran.ferenc@imgtec.com>,
        Miodrag Dinic <miodrag.dinic@imgtec.com>,
        Aleksandar Markovic <aleksandar.markovic@imgtec.com>,
        Bo Hu <bohu@google.com>,
        Douglas Leung <douglas.leung@imgtec.com>,
        James Hogan <james.hogan@imgtec.com>,
        Jin Qian <jinqian@google.com>, linux-kernel@vger.kernel.org,
        Paul Burton <paul.burton@imgtec.com>,
        Petar Jovanovic <petar.jovanovic@imgtec.com>,
        Raghu Gandham <raghu.gandham@imgtec.com>,
        Ralf Baechle <ralf@linux-mips.org>
Subject: [PATCH v4 04/16] MIPS: VDSO: Fix clobber lists in fallback code paths
Date:   Thu, 27 Jul 2017 18:08:47 +0200
Message-Id: <1501171791-23690-5-git-send-email-aleksandar.markovic@rt-rk.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1501171791-23690-1-git-send-email-aleksandar.markovic@rt-rk.com>
References: <1501171791-23690-1-git-send-email-aleksandar.markovic@rt-rk.com>
Return-Path: <aleksandar.markovic@rt-rk.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 59288
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

From: Goran Ferenc <goran.ferenc@imgtec.com>

Extend clobber lists to include all GP registers.

Fixes: 0b523a85e134 ("MIPS: VDSO: Add implementation of gettimeofday() fallback")

Signed-off-by: Miodrag Dinic <miodrag.dinic@imgtec.com>
Signed-off-by: Goran Ferenc <goran.ferenc@imgtec.com>
Signed-off-by: Aleksandar Markovic <aleksandar.markovic@imgtec.com>
Reviewed-by: James Hogan <james.hogan@imgtec.com>
---
 arch/mips/vdso/gettimeofday.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/mips/vdso/gettimeofday.c b/arch/mips/vdso/gettimeofday.c
index 974276e..e2690d7 100644
--- a/arch/mips/vdso/gettimeofday.c
+++ b/arch/mips/vdso/gettimeofday.c
@@ -35,7 +35,8 @@ static __always_inline long gettimeofday_fallback(struct timeval *_tv,
 	"       syscall\n"
 	: "=r" (ret), "=r" (error)
 	: "r" (tv), "r" (tz), "r" (nr)
-	: "memory");
+	: "$1", "$3", "$8", "$9", "$10", "$11", "$12", "$13",
+	  "$14", "$15", "$24", "$25", "hi", "lo", "memory");
 
 	return error ? -ret : ret;
 }
@@ -55,7 +56,8 @@ static __always_inline long clock_gettime_fallback(clockid_t _clkid,
 	"       syscall\n"
 	: "=r" (ret), "=r" (error)
 	: "r" (clkid), "r" (ts), "r" (nr)
-	: "memory");
+	: "$1", "$3", "$8", "$9", "$10", "$11", "$12", "$13",
+	  "$14", "$15", "$24", "$25", "hi", "lo", "memory");
 
 	return error ? -ret : ret;
 }
-- 
2.7.4
