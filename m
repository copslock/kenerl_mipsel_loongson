Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 24 Feb 2015 16:26:18 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:16343 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27007143AbbBXPZtwruTL (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 24 Feb 2015 16:25:49 +0100
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id CEAA097B9515D;
        Tue, 24 Feb 2015 15:25:41 +0000 (GMT)
Received: from metadesk01.kl.imgtec.org (192.168.14.177) by
 KLMAIL01.kl.imgtec.org (192.168.5.35) with Microsoft SMTP Server (TLS) id
 14.3.195.1; Tue, 24 Feb 2015 15:25:44 +0000
From:   Daniel Sanders <daniel.sanders@imgtec.com>
CC:     Toma Tabacu <toma.tabacu@imgtec.com>,
        Daniel Sanders <daniel.sanders@imgtec.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        <linux-mips@linux-mips.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 4/4] MIPS: LLVMLinux: Silence variable self-assignment warnings.
Date:   Tue, 24 Feb 2015 15:25:11 +0000
Message-ID: <1424791511-11407-5-git-send-email-daniel.sanders@imgtec.com>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1424791511-11407-1-git-send-email-daniel.sanders@imgtec.com>
References: <1424791511-11407-1-git-send-email-daniel.sanders@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.14.177]
To:     unlisted-recipients:; (no To-header on input)
Return-Path: <Daniel.Sanders@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 45930
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: daniel.sanders@imgtec.com
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

From: Toma Tabacu <toma.tabacu@imgtec.com>

Remove variable self-assignments.
This silences a bunch of -Wself-assign warnings reported by clang.
The changed code can be compiled without warnings by both gcc and clang.

Signed-off-by: Toma Tabacu <toma.tabacu@imgtec.com>
Signed-off-by: Daniel Sanders <daniel.sanders@imgtec.com>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: linux-mips@linux-mips.org
Cc: linux-kernel@vger.kernel.org
---
v2 refreshes the patch.

 arch/mips/math-emu/dp_add.c | 5 -----
 arch/mips/math-emu/dp_sub.c | 5 -----
 arch/mips/math-emu/sp_add.c | 5 -----
 arch/mips/math-emu/sp_sub.c | 5 -----
 4 files changed, 20 deletions(-)

diff --git a/arch/mips/math-emu/dp_add.c b/arch/mips/math-emu/dp_add.c
index 7f64577..58b2795 100644
--- a/arch/mips/math-emu/dp_add.c
+++ b/arch/mips/math-emu/dp_add.c
@@ -150,8 +150,6 @@ union ieee754dp ieee754dp_add(union ieee754dp x, union ieee754dp y)
 		 * leaving result in xm, xs and xe.
 		 */
 		xm = xm + ym;
-		xe = xe;
-		xs = xs;
 
 		if (xm >> (DP_FBITS + 1 + 3)) { /* carry out */
 			xm = XDPSRS1(xm);
@@ -160,11 +158,8 @@ union ieee754dp ieee754dp_add(union ieee754dp x, union ieee754dp y)
 	} else {
 		if (xm >= ym) {
 			xm = xm - ym;
-			xe = xe;
-			xs = xs;
 		} else {
 			xm = ym - xm;
-			xe = xe;
 			xs = ys;
 		}
 		if (xm == 0)
diff --git a/arch/mips/math-emu/dp_sub.c b/arch/mips/math-emu/dp_sub.c
index 7a17402..2eb87cd2 100644
--- a/arch/mips/math-emu/dp_sub.c
+++ b/arch/mips/math-emu/dp_sub.c
@@ -153,8 +153,6 @@ union ieee754dp ieee754dp_sub(union ieee754dp x, union ieee754dp y)
 		/* generate 28 bit result of adding two 27 bit numbers
 		 */
 		xm = xm + ym;
-		xe = xe;
-		xs = xs;
 
 		if (xm >> (DP_FBITS + 1 + 3)) { /* carry out */
 			xm = XDPSRS1(xm);	/* shift preserving sticky */
@@ -163,11 +161,8 @@ union ieee754dp ieee754dp_sub(union ieee754dp x, union ieee754dp y)
 	} else {
 		if (xm >= ym) {
 			xm = xm - ym;
-			xe = xe;
-			xs = xs;
 		} else {
 			xm = ym - xm;
-			xe = xe;
 			xs = ys;
 		}
 		if (xm == 0) {
diff --git a/arch/mips/math-emu/sp_add.c b/arch/mips/math-emu/sp_add.c
index 2d84d46..7a33af4 100644
--- a/arch/mips/math-emu/sp_add.c
+++ b/arch/mips/math-emu/sp_add.c
@@ -148,8 +148,6 @@ union ieee754sp ieee754sp_add(union ieee754sp x, union ieee754sp y)
 		 * leaving result in xm, xs and xe.
 		 */
 		xm = xm + ym;
-		xe = xe;
-		xs = xs;
 
 		if (xm >> (SP_FBITS + 1 + 3)) { /* carry out */
 			SPXSRSX1();
@@ -157,11 +155,8 @@ union ieee754sp ieee754sp_add(union ieee754sp x, union ieee754sp y)
 	} else {
 		if (xm >= ym) {
 			xm = xm - ym;
-			xe = xe;
-			xs = xs;
 		} else {
 			xm = ym - xm;
-			xe = xe;
 			xs = ys;
 		}
 		if (xm == 0)
diff --git a/arch/mips/math-emu/sp_sub.c b/arch/mips/math-emu/sp_sub.c
index 8592e49..1189bc5 100644
--- a/arch/mips/math-emu/sp_sub.c
+++ b/arch/mips/math-emu/sp_sub.c
@@ -148,8 +148,6 @@ union ieee754sp ieee754sp_sub(union ieee754sp x, union ieee754sp y)
 		/* generate 28 bit result of adding two 27 bit numbers
 		 */
 		xm = xm + ym;
-		xe = xe;
-		xs = xs;
 
 		if (xm >> (SP_FBITS + 1 + 3)) { /* carry out */
 			SPXSRSX1();	/* shift preserving sticky */
@@ -157,11 +155,8 @@ union ieee754sp ieee754sp_sub(union ieee754sp x, union ieee754sp y)
 	} else {
 		if (xm >= ym) {
 			xm = xm - ym;
-			xe = xe;
-			xs = xs;
 		} else {
 			xm = ym - xm;
-			xe = xe;
 			xs = ys;
 		}
 		if (xm == 0) {
-- 
2.1.4
