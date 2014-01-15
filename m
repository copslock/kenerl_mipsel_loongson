Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 15 Jan 2014 11:32:34 +0100 (CET)
Received: from multi.imgtec.com ([194.200.65.239]:10806 "EHLO multi.imgtec.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6827335AbaAOKcTHEQJ6 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 15 Jan 2014 11:32:19 +0100
From:   Paul Burton <paul.burton@imgtec.com>
To:     <linux-mips@linux-mips.org>
CC:     Paul Burton <paul.burton@imgtec.com>
Subject: [PATCH 01/15] MIPS: define Config1 cache field shifts & sizes
Date:   Wed, 15 Jan 2014 10:31:46 +0000
Message-ID: <1389781920-31151-2-git-send-email-paul.burton@imgtec.com>
X-Mailer: git-send-email 1.7.12.4
In-Reply-To: <1389781920-31151-1-git-send-email-paul.burton@imgtec.com>
References: <1389781920-31151-1-git-send-email-paul.burton@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.152.22]
X-SEF-Processed: 7_3_0_01192__2014_01_15_10_32_13
Return-Path: <Paul.Burton@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 38985
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

These fields will be used from assembly code in a subsequent commit, and
defining the size & offset of each field makes that use easier.

Signed-off-by: Paul Burton <paul.burton@imgtec.com>
---
 arch/mips/include/asm/mipsregs.h | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/mips/include/asm/mipsregs.h b/arch/mips/include/asm/mipsregs.h
index bbc3dd4..5302696 100644
--- a/arch/mips/include/asm/mipsregs.h
+++ b/arch/mips/include/asm/mipsregs.h
@@ -568,11 +568,23 @@
 #define MIPS_CONF1_PC		(_ULCAST_(1) <<	 4)
 #define MIPS_CONF1_MD		(_ULCAST_(1) <<	 5)
 #define MIPS_CONF1_C2		(_ULCAST_(1) <<	 6)
+#define MIPS_CONF1_DA_SHF	7
+#define MIPS_CONF1_DA_SZ	3
 #define MIPS_CONF1_DA		(_ULCAST_(7) <<	 7)
+#define MIPS_CONF1_DL_SHF	10
+#define MIPS_CONF1_DL_SZ	3
 #define MIPS_CONF1_DL		(_ULCAST_(7) << 10)
+#define MIPS_CONF1_DS_SHF	13
+#define MIPS_CONF1_DS_SZ	3
 #define MIPS_CONF1_DS		(_ULCAST_(7) << 13)
+#define MIPS_CONF1_IA_SHF	16
+#define MIPS_CONF1_IA_SZ	3
 #define MIPS_CONF1_IA		(_ULCAST_(7) << 16)
+#define MIPS_CONF1_IL_SHF	19
+#define MIPS_CONF1_IL_SZ	3
 #define MIPS_CONF1_IL		(_ULCAST_(7) << 19)
+#define MIPS_CONF1_IS_SHF	22
+#define MIPS_CONF1_IS_SZ	3
 #define MIPS_CONF1_IS		(_ULCAST_(7) << 22)
 #define MIPS_CONF1_TLBS_SHIFT   (25)
 #define MIPS_CONF1_TLBS_SIZE    (6)
-- 
1.8.4.2
