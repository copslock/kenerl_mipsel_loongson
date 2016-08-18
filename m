Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 18 Aug 2016 16:08:00 +0200 (CEST)
Received: from mail.linuxfoundation.org ([140.211.169.12]:53624 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23993352AbcHROHrYbM-I (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 18 Aug 2016 16:07:47 +0200
Received: from localhost (pes75-3-78-192-101-3.fbxo.proxad.net [78.192.101.3])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 65D8A9F1;
        Thu, 18 Aug 2016 14:07:40 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Matt Redfearn <matt.redfearn@imgtec.com>,
        linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>
Subject: [PATCH 4.4 128/138] MIPS: mm: Fix definition of R6 cache instruction
Date:   Thu, 18 Aug 2016 15:58:58 +0200
Message-Id: <20160818135612.547057146@linuxfoundation.org>
X-Mailer: git-send-email 2.9.3
In-Reply-To: <20160818135553.377018690@linuxfoundation.org>
References: <20160818135553.377018690@linuxfoundation.org>
User-Agent: quilt/0.64
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-Path: <gregkh@linuxfoundation.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 54644
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: gregkh@linuxfoundation.org
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

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Matt Redfearn <matt.redfearn@imgtec.com>

commit 4f53989b0652ffe2605221c81ca8ffcfc90aed2a upstream.

Commit a168b8f1cde6 ("MIPS: mm: Add MIPS R6 instruction encodings") added
an incorrect definition of the redefined MIPSr6 cache instruction.

Executing any kernel code including this instuction results in a
reserved instruction exception and kernel panic.

Fix the instruction definition.

Fixes: a168b8f1cde6588ff7a67699fa11e01bc77a5ddd
Signed-off-by: Matt Redfearn <matt.redfearn@imgtec.com>
Cc: linux-mips@linux-mips.org
Cc: linux-kernel@vger.kernel.org
Patchwork: https://patchwork.linux-mips.org/patch/13663/
Signed-off-by: Ralf Baechle <ralf@linux-mips.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/mips/mm/uasm-mips.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/arch/mips/mm/uasm-mips.c
+++ b/arch/mips/mm/uasm-mips.c
@@ -65,7 +65,7 @@ static struct insn insn_table[] = {
 #ifndef CONFIG_CPU_MIPSR6
 	{ insn_cache,  M(cache_op, 0, 0, 0, 0, 0),  RS | RT | SIMM },
 #else
-	{ insn_cache,  M6(cache_op, 0, 0, 0, cache6_op),  RS | RT | SIMM9 },
+	{ insn_cache,  M6(spec3_op, 0, 0, 0, cache6_op),  RS | RT | SIMM9 },
 #endif
 	{ insn_daddiu, M(daddiu_op, 0, 0, 0, 0, 0), RS | RT | SIMM },
 	{ insn_daddu, M(spec_op, 0, 0, 0, 0, daddu_op), RS | RT | RD },
