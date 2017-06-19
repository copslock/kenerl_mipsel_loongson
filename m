Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 19 Jun 2017 17:58:31 +0200 (CEST)
Received: from mx2.rt-rk.com ([89.216.37.149]:58936 "EHLO mail.rt-rk.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23993949AbdFSPuaNy9sH (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 19 Jun 2017 17:50:30 +0200
Received: from localhost (localhost [127.0.0.1])
        by mail.rt-rk.com (Postfix) with ESMTP id E7DF91A4670;
        Mon, 19 Jun 2017 17:50:19 +0200 (CEST)
X-Virus-Scanned: amavisd-new at rt-rk.com
Received: from rtrkw197-lin.ba.imgtec.org (unknown [82.117.201.26])
        by mail.rt-rk.com (Postfix) with ESMTPSA id C75741A45F2;
        Mon, 19 Jun 2017 17:50:19 +0200 (CEST)
From:   Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
To:     linux-mips@linux-mips.org, James.Hogan@imgtec.com,
        Paul.Burton@imgtec.com
Cc:     Raghu.Gandham@imgtec.com, Leonid.Yegoshin@imgtec.com,
        Douglas.Leung@imgtec.com, Petar.Jovanovic@imgtec.com,
        Miodrag.Dinic@imgtec.com, Goran.Ferenc@imgtec.com
Subject: [PATCH 5/8] MIPS: math-emu: Handle zero accumulator case in MADDF and MSUBF separately
Date:   Mon, 19 Jun 2017 17:50:12 +0200
Message-Id: <1497887415-13825-6-git-send-email-aleksandar.markovic@rt-rk.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1497887415-13825-1-git-send-email-aleksandar.markovic@rt-rk.com>
References: <1497887415-13825-1-git-send-email-aleksandar.markovic@rt-rk.com>
Return-Path: <aleksandar.markovic@rt-rk.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 58631
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

From: Aleksandar Markovic <aleksandar.markovic@imgtec.com>

If accumulator value is zero, just return the value of previously
calculated product. This brings logic in MADDf/MSUBF implementation
closer to the logic in ADD/SUB case.

Signed-off-by: Miodrag Dinic <miodrag.dinic@imgtec.com>
Signed-off-by: Goran Ferenc <goran.ferenc@imgtec.com>
Signed-off-by: Aleksandar Markovic <aleksandar.markovic@imgtec.com>
---
 arch/mips/math-emu/dp_maddf.c | 5 ++++-
 arch/mips/math-emu/sp_maddf.c | 5 ++++-
 2 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/arch/mips/math-emu/dp_maddf.c b/arch/mips/math-emu/dp_maddf.c
index 4a2d03c..caa62f2 100644
--- a/arch/mips/math-emu/dp_maddf.c
+++ b/arch/mips/math-emu/dp_maddf.c
@@ -54,7 +54,7 @@ static union ieee754dp _dp_maddf(union ieee754dp z, union ieee754dp x,
 		return ieee754dp_nanxcpt(z);
 	case IEEE754_CLASS_DNORM:
 		DPDNORMZ;
-	/* QNAN is handled separately below */
+	/* QNAN and ZERO cases are handled separately below */
 	}
 
 	switch (CLPAIR(xc, yc)) {
@@ -210,6 +210,9 @@ static union ieee754dp _dp_maddf(union ieee754dp z, union ieee754dp x,
 	}
 	assert(rm & (DP_HIDDEN_BIT << 3));
 
+	if (zc == IEEE754_CLASS_ZERO)
+		return ieee754dp_format(rs, re, rm);
+
 	/* And now the addition */
 	assert(zm & DP_HIDDEN_BIT);
 
diff --git a/arch/mips/math-emu/sp_maddf.c b/arch/mips/math-emu/sp_maddf.c
index a8cd8b4..c91d5e5 100644
--- a/arch/mips/math-emu/sp_maddf.c
+++ b/arch/mips/math-emu/sp_maddf.c
@@ -54,7 +54,7 @@ static union ieee754sp _sp_maddf(union ieee754sp z, union ieee754sp x,
 		return ieee754sp_nanxcpt(z);
 	case IEEE754_CLASS_DNORM:
 		SPDNORMZ;
-	/* QNAN is handled separately below */
+	/* QNAN and ZERO cases are handled separately below */
 	}
 
 	switch (CLPAIR(xc, yc)) {
@@ -203,6 +203,9 @@ static union ieee754sp _sp_maddf(union ieee754sp z, union ieee754sp x,
 	}
 	assert(rm & (SP_HIDDEN_BIT << 3));
 
+	if (zc == IEEE754_CLASS_ZERO)
+		return ieee754sp_format(rs, re, rm);
+
 	/* And now the addition */
 
 	assert(zm & SP_HIDDEN_BIT);
-- 
2.7.4
