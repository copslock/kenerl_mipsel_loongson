Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 21 Apr 2016 15:08:30 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:56203 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27027124AbcDUNHoNFPNj (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 21 Apr 2016 15:07:44 +0200
Received: from hhmail02.hh.imgtec.org (unknown [10.100.10.20])
        by Websense Email with ESMTPS id 63590F87951B;
        Thu, 21 Apr 2016 14:07:32 +0100 (IST)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 hhmail02.hh.imgtec.org (10.100.10.20) with Microsoft SMTP Server (TLS) id
 14.3.266.1; Thu, 21 Apr 2016 14:07:38 +0100
Received: from localhost (10.100.200.79) by LEMAIL01.le.imgtec.org
 (192.168.152.62) with Microsoft SMTP Server (TLS) id 14.3.266.1; Thu, 21 Apr
 2016 14:07:37 +0100
From:   Paul Burton <paul.burton@imgtec.com>
To:     <linux-mips@linux-mips.org>, Ralf Baechle <ralf@linux-mips.org>
CC:     Paul Burton <paul.burton@imgtec.com>,
        Markos Chandras <markos.chandras@imgtec.com>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH 09/11] MIPS: math-emu: Fix code indentation
Date:   Thu, 21 Apr 2016 14:04:53 +0100
Message-ID: <1461243895-30371-10-git-send-email-paul.burton@imgtec.com>
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
X-archive-position: 53164
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

A line incrementing the re variable was indented a level too deep in
ieee754dp_mul, making the code unclear to read. Fix the indentation.
This appears to have been copied verbatim along with the rest of the
multiplication code to ieee754dp_maddf, now _dp_maddf, too so fix the
indentation there too.

Signed-off-by: Paul Burton <paul.burton@imgtec.com>
---

 arch/mips/math-emu/dp_maddf.c | 2 +-
 arch/mips/math-emu/dp_mul.c   | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/mips/math-emu/dp_maddf.c b/arch/mips/math-emu/dp_maddf.c
index dc83fdd..4a2d03c 100644
--- a/arch/mips/math-emu/dp_maddf.c
+++ b/arch/mips/math-emu/dp_maddf.c
@@ -203,7 +203,7 @@ static union ieee754dp _dp_maddf(union ieee754dp z, union ieee754dp x,
 	if ((s64) rm < 0) {
 		rm = (rm >> (64 - (DP_FBITS + 1 + 3))) |
 		     ((rm << (DP_FBITS + 1 + 3)) != 0);
-			re++;
+		re++;
 	} else {
 		rm = (rm >> (64 - (DP_FBITS + 1 + 3 + 1))) |
 		     ((rm << (DP_FBITS + 1 + 3 + 1)) != 0);
diff --git a/arch/mips/math-emu/dp_mul.c b/arch/mips/math-emu/dp_mul.c
index d6a7573..87d0b44 100644
--- a/arch/mips/math-emu/dp_mul.c
+++ b/arch/mips/math-emu/dp_mul.c
@@ -163,7 +163,7 @@ union ieee754dp ieee754dp_mul(union ieee754dp x, union ieee754dp y)
 	if ((s64) rm < 0) {
 		rm = (rm >> (64 - (DP_FBITS + 1 + 3))) |
 		     ((rm << (DP_FBITS + 1 + 3)) != 0);
-			re++;
+		re++;
 	} else {
 		rm = (rm >> (64 - (DP_FBITS + 1 + 3 + 1))) |
 		     ((rm << (DP_FBITS + 1 + 3 + 1)) != 0);
-- 
2.8.0
