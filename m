Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 29 Jun 2013 22:18:22 +0200 (CEST)
Received: from mail.nanl.de ([217.115.11.12]:44526 "EHLO mail.nanl.de"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6819780Ab3F2USUt0hLe (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Sat, 29 Jun 2013 22:18:20 +0200
Received: from shaker64.lan (unknown [IPv6:2001:470:9e39:0:a00:27ff:fee0:c7df])
        by mail.nanl.de (Postfix) with ESMTPSA id F1CBE45FC0;
        Sat, 29 Jun 2013 20:18:08 +0000 (UTC)
From:   Jonas Gorski <jogo@openwrt.org>
To:     linux-mips@linux-mips.org
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        John Crispin <blogic@openwrt.org>,
        Maxime Bizon <mbizon@freebox.fr>,
        Florian Fainelli <florian@openwrt.org>,
        Kevin Cernekee <cernekee@gmail.com>
Subject: [PATCH 01/10] MIPS: bmips: fix compilation for BMIPS5000
Date:   Sat, 29 Jun 2013 22:17:43 +0200
Message-Id: <1372537073-27370-2-git-send-email-jogo@openwrt.org>
X-Mailer: git-send-email 1.7.10.4
In-Reply-To: <1372537073-27370-1-git-send-email-jogo@openwrt.org>
References: <1372537073-27370-1-git-send-email-jogo@openwrt.org>
Return-Path: <jogo@openwrt.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 37222
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

Replace the macro names in strings with actual macro invocation.

Fixes the following build error:

  CC      arch/mips/kernel/smp-bmips.o
{standard input}: Assembler messages:
{standard input}:951: Error: Unrecognized opcode `_ssnop'
{standard input}:952: Error: Unrecognized opcode `_ssnop'
(...)
make[6]: *** [arch/mips/kernel/smp-bmips.o] Error 1

Signed-off-by: Jonas Gorski <jogo@openwrt.org>
---
 arch/mips/include/asm/bmips.h |   28 ++++++++++++++--------------
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
1.7.10.4
