Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 07 Dec 2017 08:14:38 +0100 (CET)
Received: from mail.kernel.org ([198.145.29.99]:54488 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23990409AbdLGHO3UZGP2 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 7 Dec 2017 08:14:29 +0100
Received: from localhost.localdomain (jahogan.plus.com [212.159.75.221])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2611C21882;
        Thu,  7 Dec 2017 07:14:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2611C21882
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=jhogan@kernel.org
From:   jhogan@kernel.org
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     James Hogan <jhogan@kernel.org>,
        David Daney <david.daney@cavium.com>, linux-mips@linux-mips.org
Subject: [PATCH] MIPS: mm: Fix duplicate "const" on insn_table_MM
Date:   Thu,  7 Dec 2017 07:14:17 +0000
Message-Id: <20171207071417.30501-1-jhogan@kernel.org>
X-Mailer: git-send-email 2.13.6
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-Path: <jhogan@kernel.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 61331
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jhogan@kernel.org
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

From: James Hogan <jhogan@kernel.org>

Fix the following gcc 7.x build error on microMIPS builds:

arch/mips/mm/uasm-micromips.c:43:26: error: duplicate ‘const’ declaration specifier [-Werror=duplicate-decl-specifier]
 static const struct insn const insn_table_MM[insn_invalid] = {
                          ^~~~~

The same issue has already been fixed in uasm-mips by commit
00e06297b351 ("MIPS: mm: remove duplicate "const" qualifier on
insn_table").

Signed-off-by: James Hogan <jhogan@kernel.org>
Fixes: ce807d5f67ed ("MIPS: Optimize uasm insn lookup.")
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: David Daney <david.daney@cavium.com>
Cc: linux-mips@linux-mips.org
---
 arch/mips/mm/uasm-micromips.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/mips/mm/uasm-micromips.c b/arch/mips/mm/uasm-micromips.c
index cdb5a191b9d5..9bb6baa45da3 100644
--- a/arch/mips/mm/uasm-micromips.c
+++ b/arch/mips/mm/uasm-micromips.c
@@ -40,7 +40,7 @@
 
 #include "uasm.c"
 
-static const struct insn const insn_table_MM[insn_invalid] = {
+static const struct insn insn_table_MM[insn_invalid] = {
 	[insn_addu]	= {M(mm_pool32a_op, 0, 0, 0, 0, mm_addu32_op), RT | RS | RD},
 	[insn_addiu]	= {M(mm_addiu32_op, 0, 0, 0, 0, 0), RT | RS | SIMM},
 	[insn_and]	= {M(mm_pool32a_op, 0, 0, 0, 0, mm_and_op), RT | RS | RD},
-- 
2.13.6
