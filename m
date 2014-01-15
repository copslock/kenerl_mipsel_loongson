Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 15 Jan 2014 15:02:16 +0100 (CET)
Received: from multi.imgtec.com ([194.200.65.239]:38397 "EHLO multi.imgtec.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6827443AbaAOOA45zZrc (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 15 Jan 2014 15:00:56 +0100
From:   Paul Burton <paul.burton@imgtec.com>
To:     <linux-mips@linux-mips.org>
CC:     Paul Burton <paul.burton@imgtec.com>
Subject: [PATCH 07/10] MIPS: uasm: add a label variant of beq
Date:   Wed, 15 Jan 2014 13:55:34 +0000
Message-ID: <1389794137-11361-8-git-send-email-paul.burton@imgtec.com>
X-Mailer: git-send-email 1.7.12.4
In-Reply-To: <1389794137-11361-1-git-send-email-paul.burton@imgtec.com>
References: <1389794137-11361-1-git-send-email-paul.burton@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.152.22]
X-SEF-Processed: 7_3_0_01192__2014_01_15_14_00_56
Return-Path: <Paul.Burton@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 39008
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

This patch allows for use of the beq instruction with labels from uasm,
much as bne & others already do. It will be used by a subsequent patch.

Signed-off-by: Paul Burton <paul.burton@imgtec.com>
---
 arch/mips/include/asm/uasm.h | 2 ++
 arch/mips/mm/uasm.c          | 8 ++++++++
 2 files changed, 10 insertions(+)

diff --git a/arch/mips/include/asm/uasm.h b/arch/mips/include/asm/uasm.h
index 86c3535..53bb110 100644
--- a/arch/mips/include/asm/uasm.h
+++ b/arch/mips/include/asm/uasm.h
@@ -269,6 +269,8 @@ void uasm_il_bbit0(u32 **p, struct uasm_reloc **r, unsigned int reg,
 		   unsigned int bit, int lid);
 void uasm_il_bbit1(u32 **p, struct uasm_reloc **r, unsigned int reg,
 		   unsigned int bit, int lid);
+void uasm_il_beq(u32 **p, struct uasm_reloc **r, unsigned int reg1,
+		 unsigned int reg2, int lid);
 void uasm_il_beqz(u32 **p, struct uasm_reloc **r, unsigned int reg, int lid);
 void uasm_il_beqzl(u32 **p, struct uasm_reloc **r, unsigned int reg, int lid);
 void uasm_il_bgezl(u32 **p, struct uasm_reloc **r, unsigned int reg, int lid);
diff --git a/arch/mips/mm/uasm.c b/arch/mips/mm/uasm.c
index 99cb34b..15fc233 100644
--- a/arch/mips/mm/uasm.c
+++ b/arch/mips/mm/uasm.c
@@ -474,6 +474,14 @@ void ISAFUNC(uasm_il_b)(u32 **p, struct uasm_reloc **r, int lid)
 }
 UASM_EXPORT_SYMBOL(ISAFUNC(uasm_il_b));
 
+void ISAFUNC(uasm_il_beq)(u32 **p, struct uasm_reloc **r, unsigned int reg1,
+			  unsigned int reg2, int lid)
+{
+	uasm_r_mips_pc16(r, *p, lid);
+	ISAFUNC(uasm_i_beq)(p, reg1, reg2, 0);
+}
+UASM_EXPORT_SYMBOL(ISAFUNC(uasm_il_beq));
+
 void ISAFUNC(uasm_il_beqz)(u32 **p, struct uasm_reloc **r, unsigned int reg,
 			   int lid)
 {
-- 
1.8.4.2
