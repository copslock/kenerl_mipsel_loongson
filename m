Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 16 Jul 2015 17:43:45 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:57185 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27010713AbbGPPnntpKSh (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 16 Jul 2015 17:43:43 +0200
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id 57966EB629F22
        for <linux-mips@linux-mips.org>; Thu, 16 Jul 2015 16:43:35 +0100 (IST)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 KLMAIL01.kl.imgtec.org (192.168.5.35) with Microsoft SMTP Server (TLS) id
 14.3.195.1; Thu, 16 Jul 2015 16:43:37 +0100
Received: from mchandras-linux.le.imgtec.org (192.168.154.48) by
 LEMAIL01.le.imgtec.org (192.168.152.62) with Microsoft SMTP Server (TLS) id
 14.3.210.2; Thu, 16 Jul 2015 16:43:37 +0100
From:   Markos Chandras <markos.chandras@imgtec.com>
To:     <linux-mips@linux-mips.org>
CC:     Markos Chandras <markos.chandras@imgtec.com>
Subject: [PATCH v2] MIPS: math-emu: ieee754int.h: Fix indentation
Date:   Thu, 16 Jul 2015 16:43:33 +0100
Message-ID: <1437061413-8385-1-git-send-email-markos.chandras@imgtec.com>
X-Mailer: git-send-email 2.4.5
In-Reply-To: <1437049656-4436-1-git-send-email-markos.chandras@imgtec.com>
References: <1437049656-4436-1-git-send-email-markos.chandras@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.154.48]
Return-Path: <Markos.Chandras@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 48330
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

Fix indentation for the final 'else' blocks.

Signed-off-by: Markos Chandras <markos.chandras@imgtec.com>
---
Changes since v1:
- Fix one more case
---
 arch/mips/math-emu/ieee754int.h | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/mips/math-emu/ieee754int.h b/arch/mips/math-emu/ieee754int.h
index 05389d5e3a93..6383e2c5c1ad 100644
--- a/arch/mips/math-emu/ieee754int.h
+++ b/arch/mips/math-emu/ieee754int.h
@@ -65,8 +65,8 @@ static inline int ieee754_class_nan(int xc)
 			vc = IEEE754_CLASS_INF;				\
 		else if (vm & SP_MBIT(SP_FBITS-1))			\
 			vc = IEEE754_CLASS_SNAN;			\
-	else								\
-		vc = IEEE754_CLASS_QNAN;				\
+		else							\
+			vc = IEEE754_CLASS_QNAN;			\
 	} else if (ve == SP_EMIN-1+SP_EBIAS) {				\
 		if (vm) {						\
 			ve = SP_EMIN;					\
@@ -105,8 +105,8 @@ static inline int ieee754_class_nan(int xc)
 		if (vm) {						\
 			ve = DP_EMIN;					\
 			vc = IEEE754_CLASS_DNORM;			\
-	} else								\
-		vc = IEEE754_CLASS_ZERO;				\
+		} else							\
+			vc = IEEE754_CLASS_ZERO;			\
 	} else {							\
 		ve -= DP_EBIAS;						\
 		vm |= DP_HIDDEN_BIT;					\
-- 
2.4.5
