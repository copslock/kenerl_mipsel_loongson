Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 19 Nov 2013 18:34:20 +0100 (CET)
Received: from multi.imgtec.com ([194.200.65.239]:2626 "EHLO multi.imgtec.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6821114Ab3KSRc1xqpt6 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 19 Nov 2013 18:32:27 +0100
From:   Paul Burton <paul.burton@imgtec.com>
To:     <linux-mips@linux-mips.org>
CC:     Paul Burton <paul.burton@imgtec.com>
Subject: [PATCH 6/6] mips: update outdated comment
Date:   Tue, 19 Nov 2013 17:30:39 +0000
Message-ID: <1384882239-17965-7-git-send-email-paul.burton@imgtec.com>
X-Mailer: git-send-email 1.7.10
In-Reply-To: <1384882239-17965-1-git-send-email-paul.burton@imgtec.com>
References: <1384882239-17965-1-git-send-email-paul.burton@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.152.22]
X-SEF-Processed: 7_3_0_01192__2013_11_19_17_32_23
Return-Path: <Paul.Burton@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 38556
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

The hard-coded offsets mentioned in this comment seem to not exist
anymore, so remove mention of them from the comment.

Signed-off-by: Paul Burton <paul.burton@imgtec.com>
Reviewed-by: Qais Yousef <qais.yousef@imgtec.com>
---
 arch/mips/include/asm/processor.h | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/arch/mips/include/asm/processor.h b/arch/mips/include/asm/processor.h
index 622b2ba..4cf6dbf 100644
--- a/arch/mips/include/asm/processor.h
+++ b/arch/mips/include/asm/processor.h
@@ -126,10 +126,9 @@ BUILD_FPR_ACCESS(32)
 BUILD_FPR_ACCESS(64)
 
 /*
- * It would be nice to add some more fields for emulator statistics, but there
- * are a number of fixed offsets in offset.h and elsewhere that would have to
- * be recalculated by hand.  So the additional information will be private to
- * the FPU emulator for now.  See asm-mips/fpu_emulator.h.
+ * It would be nice to add some more fields for emulator statistics,
+ * the additional information is private to the FPU emulator for now.
+ * See arch/mips/include/asm/fpu_emulator.h.
  */
 
 struct mips_fpu_struct {
-- 
1.8.4.2
