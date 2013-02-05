Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 05 Feb 2013 23:53:37 +0100 (CET)
Received: from home.bethel-hill.org ([63.228.164.32]:49923 "EHLO
        home.bethel-hill.org" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S6824764Ab3BEWwTHBA7C (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 5 Feb 2013 23:52:19 +0100
Received: by home.bethel-hill.org with esmtpsa (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
        (Exim 4.72)
        (envelope-from <sjhill@mips.com>)
        id 1U2rN6-0008Ky-Sg; Tue, 05 Feb 2013 16:52:12 -0600
From:   "Steven J. Hill" <sjhill@mips.com>
To:     linux-mips@linux-mips.org
Cc:     "Steven J. Hill" <sjhill@mips.com>, ralf@linux-mips.org,
        cernekee@gmail.com, kevink@paralogos.com, ddaney.cavm@gmail.com
Subject: [PATCH 4/4] MIPS: microMIPS: Add instruction utility macros.
Date:   Tue,  5 Feb 2013 16:52:03 -0600
Message-Id: <1360104723-29529-5-git-send-email-sjhill@mips.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <1360104723-29529-1-git-send-email-sjhill@mips.com>
References: <1360104723-29529-1-git-send-email-sjhill@mips.com>
X-archive-position: 35712
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sjhill@mips.com
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
Return-Path: <linux-mips-bounce@linux-mips.org>

From: "Steven J. Hill" <sjhill@mips.com>

Add two new macros for microMIPS. One checks if an exception was
taken in either microMIPS or classic MIPS mode. The other checks
if a microMIPS instruction is 16-bit or 32-bit in length.

Signed-off-by: Steven J. Hill <sjhill@mips.com>
---
 arch/mips/include/asm/mipsregs.h |   18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/arch/mips/include/asm/mipsregs.h b/arch/mips/include/asm/mipsregs.h
index f206ef2..13e1d68 100644
--- a/arch/mips/include/asm/mipsregs.h
+++ b/arch/mips/include/asm/mipsregs.h
@@ -622,6 +622,24 @@
 #ifndef __ASSEMBLY__
 
 /*
+ * Macros for handling the ISA mode bit for microMIPS.
+ */
+#define get_isa16_mode(x)		((x) & 0x1)
+#define msk_isa16_mode(x)		((x) & ~0x1)
+#define set_isa16_mode(x)		do { (x) |= 0x1; } while(0)
+
+/*
+ * microMIPS instructions can be 16-bit or 32-bit in length. This
+ * returns a 1 if the instruction is 16-bit and a 0 if 32-bit.
+ */
+static inline int mm_insn_16bit(u16 insn)
+{
+	u16 opcode = (insn >> 10) & 0x7;
+
+	return ((opcode >= 1 && opcode <= 3) ? 1 : 0);
+}
+
+/*
  * Functions to access the R10000 performance counters.	 These are basically
  * mfc0 and mtc0 instructions from and to coprocessor register with a 5-bit
  * performance counter number encoded into bits 1 ... 5 of the instruction.
-- 
1.7.9.5
