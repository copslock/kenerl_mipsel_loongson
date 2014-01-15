Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 15 Jan 2014 11:34:04 +0100 (CET)
Received: from multi.imgtec.com ([194.200.65.239]:10819 "EHLO multi.imgtec.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6827348AbaAOKdAoDDc8 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 15 Jan 2014 11:33:00 +0100
From:   Paul Burton <paul.burton@imgtec.com>
To:     <linux-mips@linux-mips.org>
CC:     Paul Burton <paul.burton@imgtec.com>
Subject: [PATCH 04/15] MIPS: introduce _EXT assembler macro
Date:   Wed, 15 Jan 2014 10:31:49 +0000
Message-ID: <1389781920-31151-5-git-send-email-paul.burton@imgtec.com>
X-Mailer: git-send-email 1.7.12.4
In-Reply-To: <1389781920-31151-1-git-send-email-paul.burton@imgtec.com>
References: <1389781920-31151-1-git-send-email-paul.burton@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.152.22]
X-SEF-Processed: 7_3_0_01192__2014_01_15_10_32_53
Return-Path: <Paul.Burton@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 38988
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

This patch adds a simple macro to wrap the ext instruction which was
introduced with MIPSR2, and fall back to a shift & and pair for
pre-MIPSR2 CPUs. This will be used in a subsequent patch.

Signed-off-by: Paul Burton <paul.burton@imgtec.com>
---
 arch/mips/include/asm/asmmacro.h | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/arch/mips/include/asm/asmmacro.h b/arch/mips/include/asm/asmmacro.h
index 6c8342a..1d2c9c2 100644
--- a/arch/mips/include/asm/asmmacro.h
+++ b/arch/mips/include/asm/asmmacro.h
@@ -62,6 +62,17 @@
 	.endm
 #endif /* CONFIG_MIPS_MT_SMTC */
 
+#ifdef CONFIG_CPU_MIPSR2
+	.macro	_EXT	rd, rs, p, s
+	ext	\rd, \rs, \p, \s
+	.endm
+#else /* !CONFIG_CPU_MIPSR2 */
+	.macro	_EXT	rd, rs, p, s
+	srl	\rd, \rs, \p
+	andi	\rd, \rd, (1 << \s) - 1
+	.endm
+#endif /* !CONFIG_CPU_MIPSR2 */
+
 /*
  * Temporary until all gas have MT ASE support
  */
-- 
1.8.4.2
