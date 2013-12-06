Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 06 Dec 2013 10:21:17 +0100 (CET)
Received: from multi.imgtec.com ([194.200.65.239]:30843 "EHLO multi.imgtec.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6828766Ab3LFJVOdh9uc (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 6 Dec 2013 10:21:14 +0100
From:   Qais Yousef <qais.yousef@imgtec.com>
To:     <linux-mips@linux-mips.org>
CC:     Qais Yousef <qais.yousef@imgtec.com>
Subject: [PATCH] mips/include/asm/mipsregs.h: s/u16/unsigned short/
Date:   Fri, 6 Dec 2013 09:20:59 +0000
Message-ID: <1386321659-30073-1-git-send-email-qais.yousef@imgtec.com>
X-Mailer: git-send-email 1.7.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [192.168.154.36]
X-SEF-Processed: 7_3_0_01192__2013_12_06_09_21_08
Return-Path: <Qais.Yousef@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 38668
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: qais.yousef@imgtec.com
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

I was getting this error when including this header in my driver:

  arch/mips/include/asm/mipsregs.h:644:33: error: unknown type name ‘u16’

since the use of u16 is not really necessary, convert it to unsigned short.

Signed-off-by: Qais Yousef <qais.yousef@imgtec.com>
Reviewed-by: Steven J. Hill <Steven.Hill@imgtec.com>
---
 arch/mips/include/asm/mipsregs.h |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/mips/include/asm/mipsregs.h b/arch/mips/include/asm/mipsregs.h
index e033141..0a2d6ef 100644
--- a/arch/mips/include/asm/mipsregs.h
+++ b/arch/mips/include/asm/mipsregs.h
@@ -641,9 +641,9 @@
  * microMIPS instructions can be 16-bit or 32-bit in length. This
  * returns a 1 if the instruction is 16-bit and a 0 if 32-bit.
  */
-static inline int mm_insn_16bit(u16 insn)
+static inline int mm_insn_16bit(unsigned short insn)
 {
-	u16 opcode = (insn >> 10) & 0x7;
+	unsigned short opcode = (insn >> 10) & 0x7;
 
 	return (opcode >= 1 && opcode <= 3) ? 1 : 0;
 }
-- 
1.7.1
