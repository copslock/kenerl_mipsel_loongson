Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 03 Aug 2017 21:16:34 +0200 (CEST)
Received: from mail.free-electrons.com ([62.4.15.54]:59915 "EHLO
        mail.free-electrons.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23994907AbdHCTQYuoAs0 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 3 Aug 2017 21:16:24 +0200
Received: by mail.free-electrons.com (Postfix, from userid 110)
        id CE78021ED8; Thu,  3 Aug 2017 21:16:16 +0200 (CEST)
Received: from localhost (LFbn-1-10680-2.w90-89.abo.wanadoo.fr [90.89.33.2])
        by mail.free-electrons.com (Postfix) with ESMTPSA id A909B208E5;
        Thu,  3 Aug 2017 21:16:16 +0200 (CEST)
From:   Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
To:     Ralf Baechle <ralf@linux-mips.org>,
        David Daney <david.daney@cavium.com>
Cc:     linux-mips@linux-mips.org, linux-kernel@vger.kernel.org,
        Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Subject: [PATCH] mips: mm: remove duplicate "const" qualifier on insn_table
Date:   Thu,  3 Aug 2017 21:16:15 +0200
Message-Id: <20170803191615.16874-1-thomas.petazzoni@free-electrons.com>
X-Mailer: git-send-email 2.9.4
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-Path: <thomas.petazzoni@free-electrons.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 59350
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: thomas.petazzoni@free-electrons.com
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

Fixes the following gcc 7.x build error:

arch/mips/mm/uasm-mips.c:51:26: error: duplicate ‘const’ declaration specifier [-Werror=duplicate-decl-specifier]
 static const struct insn const insn_table[insn_invalid] = {

Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
---
 arch/mips/mm/uasm-mips.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/mips/mm/uasm-mips.c b/arch/mips/mm/uasm-mips.c
index 3f74f6c..9fea6c6 100644
--- a/arch/mips/mm/uasm-mips.c
+++ b/arch/mips/mm/uasm-mips.c
@@ -48,7 +48,7 @@
 
 #include "uasm.c"
 
-static const struct insn const insn_table[insn_invalid] = {
+static const struct insn insn_table[insn_invalid] = {
 	[insn_addiu]	= {M(addiu_op, 0, 0, 0, 0, 0), RS | RT | SIMM},
 	[insn_addu]	= {M(spec_op, 0, 0, 0, 0, addu_op), RS | RT | RD},
 	[insn_and]	= {M(spec_op, 0, 0, 0, 0, and_op), RS | RT | RD},
-- 
2.9.4
