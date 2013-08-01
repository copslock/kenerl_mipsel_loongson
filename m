Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 01 Aug 2013 11:55:43 +0200 (CEST)
Received: from mail.nanl.de ([217.115.11.12]:45204 "EHLO mail.nanl.de"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6816521Ab3HAJzkI9SlY (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 1 Aug 2013 11:55:40 +0200
Received: from shaker64.lan (unknown [IPv6:2001:470:9e39:0:a00:27ff:fee0:c7df])
        by mail.nanl.de (Postfix) with ESMTPSA id 5575C45FB3;
        Thu,  1 Aug 2013 09:55:02 +0000 (UTC)
From:   Jonas Gorski <jogo@openwrt.org>
To:     linux-mips@linux-mips.org
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        John Crispin <blogic@openwrt.org>,
        Florian Fainelli <florian@openwrt.org>,
        Kevin Cernekee <cernekee@gmail.com>
Subject: [PATCH V2] MIPS: BMIPS: fix compilation for BMIPS5000
Date:   Thu,  1 Aug 2013 11:55:38 +0200
Message-Id: <1375350938-16554-1-git-send-email-jogo@openwrt.org>
X-Mailer: git-send-email 1.8.3.2
Return-Path: <jogo@openwrt.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 37412
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jogo@openwrt.org
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

Commit 02b849f7613003fe5f9e58bf233d49b0ebd4a5e8 ("MIPS: Get rid of the
use of .macro in C code.") replaced the macro usage but missed
the accessors in bmips.h, causing the following build error:

  CC      arch/mips/kernel/smp-bmips.o
{standard input}: Assembler messages:
{standard input}:951: Error: Unrecognized opcode `_ssnop'
{standard input}:952: Error: Unrecognized opcode `_ssnop'
(...)
make[6]: *** [arch/mips/kernel/smp-bmips.o] Error 1

Fix this by also replacing the macros here, fixing the last occurrence
in mips.

Signed-off-by: Jonas Gorski <jogo@openwrt.org>
---
* V1 -> V2
  Reworded and split out of patchset after finding the commmit
  introducing the build failure.

While this is technically a regression introduced in 3.10, the code requires
OOT arch code to get compiled, so I'm not sure if that is critical enough to
warrant a stable tag.

 arch/mips/include/asm/bmips.h | 28 ++++++++++++++--------------
 1 file changed, 14 insertions(+), 14 deletions(-)

diff --git a/arch/mips/include/asm/bmips.h b/arch/mips/include/asm/bmips.h
index 552a65a..87a253d 100644
--- a/arch/mips/include/asm/bmips.h
+++ b/arch/mips/include/asm/bmips.h
@@ -70,15 +70,15 @@ static inline unsigned long bmips_read_zscm_reg(unsigned int offset)
 		".set noreorder\n"
 		"cache %1, 0(%2)\n"
 		"sync\n"
-		"_ssnop\n"
-		"_ssnop\n"
-		"_ssnop\n"
-		"_ssnop\n"
-		"_ssnop\n"
-		"_ssnop\n"
-		"_ssnop\n"
+		__stringify(___ssnop) "\n"
+		__stringify(___ssnop) "\n"
+		__stringify(___ssnop) "\n"
+		__stringify(___ssnop) "\n"
+		__stringify(___ssnop) "\n"
+		__stringify(___ssnop) "\n"
+		__stringify(___ssnop) "\n"
 		"mfc0 %0, $28, 3\n"
-		"_ssnop\n"
+		__stringify(___ssnop) "\n"
 		".set pop\n"
 		: "=&r" (ret)
 		: "i" (Index_Load_Tag_S), "r" (ZSCM_REG_BASE + offset)
@@ -92,13 +92,13 @@ static inline void bmips_write_zscm_reg(unsigned int offset, unsigned long data)
 		".set push\n"
 		".set noreorder\n"
 		"mtc0 %0, $28, 3\n"
-		"_ssnop\n"
-		"_ssnop\n"
-		"_ssnop\n"
+		__stringify(___ssnop) "\n"
+		__stringify(___ssnop) "\n"
+		__stringify(___ssnop) "\n"
 		"cache %1, 0(%2)\n"
-		"_ssnop\n"
-		"_ssnop\n"
-		"_ssnop\n"
+		__stringify(___ssnop) "\n"
+		__stringify(___ssnop) "\n"
+		__stringify(___ssnop) "\n"
 		: /* no outputs */
 		: "r" (data),
 		  "i" (Index_Store_Tag_S), "r" (ZSCM_REG_BASE + offset)
-- 
1.8.3.2
