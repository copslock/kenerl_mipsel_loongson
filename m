Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 07 Oct 2013 18:47:09 +0200 (CEST)
Received: from multi.imgtec.com ([194.200.65.239]:62104 "EHLO multi.imgtec.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6868729Ab3JGQqPhYilK (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 7 Oct 2013 18:46:15 +0200
From:   Deng-Cheng Zhu <dengcheng.zhu@imgtec.com>
To:     <linux-mips@linux-mips.org>, <ralf@linux-mips.org>
CC:     <james.hogan@imgtec.com>, <paul.burton@imgtec.com>,
        <Steven.Hill@imgtec.com>, Deng-Cheng Zhu <dengcheng.zhu@imgtec.com>
Subject: [PATCH v2 2/2] MIPS: Remove unused defines in piix4.h
Date:   Mon, 7 Oct 2013 09:45:05 -0700
Message-ID: <1381164305-28500-3-git-send-email-dengcheng.zhu@imgtec.com>
X-Mailer: git-send-email 1.7.1
In-Reply-To: <1381164305-28500-1-git-send-email-dengcheng.zhu@imgtec.com>
References: <1381164305-28500-1-git-send-email-dengcheng.zhu@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.136.61]
X-SEF-Processed: 7_3_0_01192__2013_10_07_17_45_28
Return-Path: <DengCheng.Zhu@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 38234
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dengcheng.zhu@imgtec.com
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

From: Deng-Cheng Zhu <dengcheng.zhu@imgtec.com>

The PIIX4_ICTLR* and PIIX4_OCW* defines are not used by any other files.
Remove them.

The only file (other than fixup-malta.c which includes piix4.h in patch #1)
containing "#include <asm/mips-boards/piix4.h>" is
arch/mips/mti-malta/malta-int.c whose first version is actually
"1da177e4c3:arch/mips/mips-boards/malta/malta_int.c". In that version, in
the function get_int(), things in piix4.h are used. But now malta-int.c no
longer needs those stuff.

Cc: Steven J. Hill <Steven.Hill@imgtec.com>
Reviewed-by: James Hogan <james.hogan@imgtec.com>
Reviewed-by: Paul Burton <paul.burton@imgtec.com>
Signed-off-by: Deng-Cheng Zhu <dengcheng.zhu@imgtec.com>
---
Changes:
v2 - v1:
o Remove "#include <asm/mips-boards/piix4.h>" from malta-int.c.

 arch/mips/include/asm/mips-boards/piix4.h |   57 -----------------------------
 arch/mips/mti-malta/malta-int.c           |    1 -
 2 files changed, 0 insertions(+), 58 deletions(-)

diff --git a/arch/mips/include/asm/mips-boards/piix4.h b/arch/mips/include/asm/mips-boards/piix4.h
index 06d4831..e332279 100644
--- a/arch/mips/include/asm/mips-boards/piix4.h
+++ b/arch/mips/include/asm/mips-boards/piix4.h
@@ -43,61 +43,4 @@
 #define PIIX4_FUNC1_IDETIM_SECONDARY_HI		0x43
 #define   PIIX4_FUNC1_IDETIM_SECONDARY_HI_IDE_DECODE_EN	(1 << 7)
 
-/************************************************************************
- *  IO register offsets
- ************************************************************************/
-#define PIIX4_ICTLR1_ICW1	0x20
-#define PIIX4_ICTLR1_ICW2	0x21
-#define PIIX4_ICTLR1_ICW3	0x21
-#define PIIX4_ICTLR1_ICW4	0x21
-#define PIIX4_ICTLR2_ICW1	0xa0
-#define PIIX4_ICTLR2_ICW2	0xa1
-#define PIIX4_ICTLR2_ICW3	0xa1
-#define PIIX4_ICTLR2_ICW4	0xa1
-#define PIIX4_ICTLR1_OCW1	0x21
-#define PIIX4_ICTLR1_OCW2	0x20
-#define PIIX4_ICTLR1_OCW3	0x20
-#define PIIX4_ICTLR1_OCW4	0x20
-#define PIIX4_ICTLR2_OCW1	0xa1
-#define PIIX4_ICTLR2_OCW2	0xa0
-#define PIIX4_ICTLR2_OCW3	0xa0
-#define PIIX4_ICTLR2_OCW4	0xa0
-
-
-/************************************************************************
- *  Register encodings.
- ************************************************************************/
-#define PIIX4_OCW2_NSEOI	(0x1 << 5)
-#define PIIX4_OCW2_SEOI		(0x3 << 5)
-#define PIIX4_OCW2_RNSEOI	(0x5 << 5)
-#define PIIX4_OCW2_RAEOIS	(0x4 << 5)
-#define PIIX4_OCW2_RAEOIC	(0x0 << 5)
-#define PIIX4_OCW2_RSEOI	(0x7 << 5)
-#define PIIX4_OCW2_SP		(0x6 << 5)
-#define PIIX4_OCW2_NOP		(0x2 << 5)
-
-#define PIIX4_OCW2_SEL		(0x0 << 3)
-
-#define PIIX4_OCW2_ILS_0	0
-#define PIIX4_OCW2_ILS_1	1
-#define PIIX4_OCW2_ILS_2	2
-#define PIIX4_OCW2_ILS_3	3
-#define PIIX4_OCW2_ILS_4	4
-#define PIIX4_OCW2_ILS_5	5
-#define PIIX4_OCW2_ILS_6	6
-#define PIIX4_OCW2_ILS_7	7
-#define PIIX4_OCW2_ILS_8	0
-#define PIIX4_OCW2_ILS_9	1
-#define PIIX4_OCW2_ILS_10	2
-#define PIIX4_OCW2_ILS_11	3
-#define PIIX4_OCW2_ILS_12	4
-#define PIIX4_OCW2_ILS_13	5
-#define PIIX4_OCW2_ILS_14	6
-#define PIIX4_OCW2_ILS_15	7
-
-#define PIIX4_OCW3_SEL		(0x1 << 3)
-
-#define PIIX4_OCW3_IRR		0x2
-#define PIIX4_OCW3_ISR		0x3
-
 #endif /* __ASM_MIPS_BOARDS_PIIX4_H */
diff --git a/arch/mips/mti-malta/malta-int.c b/arch/mips/mti-malta/malta-int.c
index c69da37..be4a109 100644
--- a/arch/mips/mti-malta/malta-int.c
+++ b/arch/mips/mti-malta/malta-int.c
@@ -37,7 +37,6 @@
 #include <asm/irq_regs.h>
 #include <asm/mips-boards/malta.h>
 #include <asm/mips-boards/maltaint.h>
-#include <asm/mips-boards/piix4.h>
 #include <asm/gt64120.h>
 #include <asm/mips-boards/generic.h>
 #include <asm/mips-boards/msc01_pci.h>
-- 
1.7.1
