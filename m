Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 02 Nov 2017 12:17:13 +0100 (CET)
Received: from mx2.rt-rk.com ([89.216.37.149]:51142 "EHLO mail.rt-rk.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23993637AbdKBLQ3tc1-I (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 2 Nov 2017 12:16:29 +0100
Received: from localhost (localhost [127.0.0.1])
        by mail.rt-rk.com (Postfix) with ESMTP id 70C091A4AAE;
        Thu,  2 Nov 2017 12:16:24 +0100 (CET)
X-Virus-Scanned: amavisd-new at rt-rk.com
Received: from rtrkw774-lin.domain.local (rtrkw774-lin.domain.local [10.10.13.111])
        by mail.rt-rk.com (Postfix) with ESMTPSA id 548EC1A1D20;
        Thu,  2 Nov 2017 12:16:24 +0100 (CET)
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
Subject: [PATCH v3 4/8] MIPS: math-emu: Avoid definition duplication for macro DPXMULT()
Date:   Thu,  2 Nov 2017 12:14:01 +0100
Message-Id: <1509621287-32198-5-git-send-email-aleksandar.markovic@rt-rk.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1509621287-32198-1-git-send-email-aleksandar.markovic@rt-rk.com>
References: <1509621287-32198-1-git-send-email-aleksandar.markovic@rt-rk.com>
Return-Path: <aleksandar.markovic@rt-rk.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 60666
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

Avoid duplicate definition of macro DPXMULT(). Move its definition
to a header.

Signed-off-by: Aleksandar Markovic <aleksandar.markovic@mips.com>
---
 arch/mips/math-emu/dp_maddf.c  | 3 ---
 arch/mips/math-emu/dp_mul.c    | 3 ---
 arch/mips/math-emu/ieee754dp.h | 3 +++
 3 files changed, 3 insertions(+), 6 deletions(-)

diff --git a/arch/mips/math-emu/dp_maddf.c b/arch/mips/math-emu/dp_maddf.c
index 7ad79ed..28b90fd 100644
--- a/arch/mips/math-emu/dp_maddf.c
+++ b/arch/mips/math-emu/dp_maddf.c
@@ -201,9 +201,6 @@ static union ieee754dp _dp_maddf(union ieee754dp z, union ieee754dp x,
 	 * Multiply 64 bits xm and ym to give 128 bits result in hrm:lrm.
 	 */
 
-	/* 32 * 32 => 64 */
-#define DPXMULT(x, y)	((u64)(x) * (u64)y)
-
 	lxm = xm;
 	hxm = xm >> 32;
 	lym = ym;
diff --git a/arch/mips/math-emu/dp_mul.c b/arch/mips/math-emu/dp_mul.c
index 60c8bfe..7bc5dde 100644
--- a/arch/mips/math-emu/dp_mul.c
+++ b/arch/mips/math-emu/dp_mul.c
@@ -128,9 +128,6 @@ union ieee754dp ieee754dp_mul(union ieee754dp x, union ieee754dp y)
 	 * Multiply 64 bits xm, ym to give high 64 bits rm with stickness.
 	 */
 
-	/* 32 * 32 => 64 */
-#define DPXMULT(x, y)	((u64)(x) * (u64)y)
-
 	lxm = xm;
 	hxm = xm >> 32;
 	lym = ym;
diff --git a/arch/mips/math-emu/ieee754dp.h b/arch/mips/math-emu/ieee754dp.h
index 9ba0230..a56707b 100644
--- a/arch/mips/math-emu/ieee754dp.h
+++ b/arch/mips/math-emu/ieee754dp.h
@@ -55,6 +55,9 @@ static inline int ieee754dp_finite(union ieee754dp x)
 #define XDPSRS1(v)	\
 	(((v) >> 1) | ((v) & 1))
 
+/* 32bit * 32bit => 64bit unsigned integer multiplication */
+#define DPXMULT(x, y)	((u64)(x) * (u64)y)
+
 /* convert denormal to normalized with extended exponent */
 #define DPDNORMx(m,e) \
 	while ((m >> DP_FBITS) == 0) { m <<= 1; e--; }
-- 
2.7.4
