Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 15 Jan 2014 11:33:18 +0100 (CET)
Received: from multi.imgtec.com ([194.200.65.239]:10809 "EHLO multi.imgtec.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6827341AbaAOKcXS3B55 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 15 Jan 2014 11:32:23 +0100
From:   Paul Burton <paul.burton@imgtec.com>
To:     <linux-mips@linux-mips.org>
CC:     Paul Burton <paul.burton@imgtec.com>
Subject: [PATCH 02/15] MIPS: add CP0 CMGCRBase definitions & accessor
Date:   Wed, 15 Jan 2014 10:31:47 +0000
Message-ID: <1389781920-31151-3-git-send-email-paul.burton@imgtec.com>
X-Mailer: git-send-email 1.7.12.4
In-Reply-To: <1389781920-31151-1-git-send-email-paul.burton@imgtec.com>
References: <1389781920-31151-1-git-send-email-paul.burton@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.152.22]
X-SEF-Processed: 7_3_0_01192__2014_01_15_10_32_17
Return-Path: <Paul.Burton@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 38986
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

The CMGCRBase register is defined by the PRA specification as an optional
register which indicates the physical base of the MIPS Coherence Manager
Global Control Register block. This patch simply adds a definition for
the base address field within the register, along with an accessor
function for reading the register.

Signed-off-by: Paul Burton <paul.burton@imgtec.com>
---
 arch/mips/include/asm/mipsregs.h | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/mips/include/asm/mipsregs.h b/arch/mips/include/asm/mipsregs.h
index 5302696..3401128 100644
--- a/arch/mips/include/asm/mipsregs.h
+++ b/arch/mips/include/asm/mipsregs.h
@@ -668,6 +668,10 @@
 /*  EntryHI bit definition */
 #define MIPS_ENTRYHI_EHINV	(_ULCAST_(1) << 10)
 
+/* CMGCRBase bit definitions */
+#define MIPS_CMGCRB_BASE	11
+#define MIPS_CMGCRF_BASE	(~_ULCAST_((1 << MIPS_CMGCRB_BASE) - 1))
+
 /*
  * Bits in the MIPS32/64 coprocessor 1 (FPU) revision register.
  */
@@ -1022,6 +1026,8 @@ do {									\
 
 #define read_c0_prid()		__read_32bit_c0_register($15, 0)
 
+#define read_c0_cmgcrbase()	__read_ulong_c0_register($15, 3)
+
 #define read_c0_config()	__read_32bit_c0_register($16, 0)
 #define read_c0_config1()	__read_32bit_c0_register($16, 1)
 #define read_c0_config2()	__read_32bit_c0_register($16, 2)
-- 
1.8.4.2
