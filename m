Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 21 Apr 2016 15:08:13 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:4841 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27027262AbcDUNH3onBrj (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 21 Apr 2016 15:07:29 +0200
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Websense Email with ESMTPS id DD6B7668CC032;
        Thu, 21 Apr 2016 14:07:17 +0100 (IST)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 HHMAIL01.hh.imgtec.org (10.100.10.19) with Microsoft SMTP Server (TLS) id
 14.3.266.1; Thu, 21 Apr 2016 14:07:23 +0100
Received: from localhost (10.100.200.79) by LEMAIL01.le.imgtec.org
 (192.168.152.62) with Microsoft SMTP Server (TLS) id 14.3.266.1; Thu, 21 Apr
 2016 14:07:23 +0100
From:   Paul Burton <paul.burton@imgtec.com>
To:     <linux-mips@linux-mips.org>, Ralf Baechle <ralf@linux-mips.org>
CC:     Paul Burton <paul.burton@imgtec.com>,
        Markos Chandras <markos.chandras@imgtec.com>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH 08/11] MIPS: math-emu: Fix bit-width in ieee754dp_{mul,maddf,msubf} comments
Date:   Thu, 21 Apr 2016 14:04:52 +0100
Message-ID: <1461243895-30371-9-git-send-email-paul.burton@imgtec.com>
X-Mailer: git-send-email 2.8.0
In-Reply-To: <1461243895-30371-1-git-send-email-paul.burton@imgtec.com>
References: <1461243895-30371-1-git-send-email-paul.burton@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.100.200.79]
Return-Path: <Paul.Burton@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 53163
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

A comment in ieee754dp_mul indicates that the code is about to perform a
32b x 32b multiplication & keep the high 32b of the result. It appears
this was copied from the single-precision multiplication code, since the
code actually goes on to perform a 64b x 64b multiplication & keep the
high 64b of the result. Fix the comment to indicate 64b.

It appears also that this comment was copied verbatim along with the
rest of the multiplication code into ieee754dp_maddf, which has since
been renamed _dp_maddf. Fix the same issue there.

Signed-off-by: Paul Burton <paul.burton@imgtec.com>
---

 arch/mips/math-emu/dp_maddf.c | 2 +-
 arch/mips/math-emu/dp_mul.c   | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/mips/math-emu/dp_maddf.c b/arch/mips/math-emu/dp_maddf.c
index 0e1d4d8..dc83fdd 100644
--- a/arch/mips/math-emu/dp_maddf.c
+++ b/arch/mips/math-emu/dp_maddf.c
@@ -165,7 +165,7 @@ static union ieee754dp _dp_maddf(union ieee754dp z, union ieee754dp x,
 	ym <<= 64 - (DP_FBITS + 1);
 
 	/*
-	 * Multiply 32 bits xm, ym to give high 32 bits rm with stickness.
+	 * Multiply 64 bits xm, ym to give high 64 bits rm with stickness.
 	 */
 
 	/* 32 * 32 => 64 */
diff --git a/arch/mips/math-emu/dp_mul.c b/arch/mips/math-emu/dp_mul.c
index d0901f0..d6a7573 100644
--- a/arch/mips/math-emu/dp_mul.c
+++ b/arch/mips/math-emu/dp_mul.c
@@ -125,7 +125,7 @@ union ieee754dp ieee754dp_mul(union ieee754dp x, union ieee754dp y)
 	ym <<= 64 - (DP_FBITS + 1);
 
 	/*
-	 * Multiply 32 bits xm, ym to give high 32 bits rm with stickness.
+	 * Multiply 64 bits xm, ym to give high 64 bits rm with stickness.
 	 */
 
 	/* 32 * 32 => 64 */
-- 
2.8.0
