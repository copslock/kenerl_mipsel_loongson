Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 23 Jul 2014 14:42:32 +0200 (CEST)
Received: from ducie-dc1.codethink.co.uk ([185.25.241.215]:50531 "EHLO
        ducie-dc1.codethink.co.uk" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6822058AbaGWMmQ0EP2W (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 23 Jul 2014 14:42:16 +0200
Received: from localhost (localhost [127.0.0.1])
        by ducie-dc1.codethink.co.uk (Postfix) with ESMTP id 0271A464DAE;
        Wed, 23 Jul 2014 13:42:08 +0100 (BST)
X-Virus-Scanned: Debian amavisd-new at ducie-dc1.codethink.co.uk
Received: from ducie-dc1.codethink.co.uk ([127.0.0.1])
        by localhost (ducie-dc1.codethink.co.uk [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id AUSNG3+w6V5d; Wed, 23 Jul 2014 13:42:03 +0100 (BST)
Received: from humdrum (unknown [10.24.1.221])
        by ducie-dc1.codethink.co.uk (Postfix) with ESMTPSA id B2224462A92;
        Wed, 23 Jul 2014 13:42:03 +0100 (BST)
Date:   Wed, 23 Jul 2014 13:41:58 +0100
From:   Rob Kendrick <rob.kendrick@codethink.co.uk>
To:     linux-mips@linux-mips.org
Cc:     Markos Chandras <markos.chandras@imgtec.com>,
        Paul Burton <paul.burton@imgtec.com>
Subject: [PATCH 1/1] MIPS: math-emu: cp1emu: Fix typo when returning to
 register file
Message-ID: <20140723124154.GA8378@humdrum>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
Return-Path: <rob.kendrick@codethink.co.uk>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 41515
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: rob.kendrick@codethink.co.uk
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

The commit 08a07904e182895e1205f399465a3d622c0115b8 (v3.16-rc1)
entitled "MIPS: math-emu: Remove most ifdefery":

switched from build time to runtime detection for the CPU ISA level.

However, along the way, a typo was introduced in the code path
to return the value to the register file. Previously, the
MIPSInst_FD macro was used but the above commit switched to
MIPSInst_RT leading to regressions.

Link: http://www.linux-mips.org/archives/linux-mips/2014-07/msg00484.html
Reported-by: Rob Kendrick <rob.kendrick@codethink.co.uk>
Reviewed-by: Paul Burton <paul.burton@imgtec.com>
Signed-off-by: Markos Chandras <markos.chandras@imgtec.com>
Signed-off-by: Rob Kendrick <rob.kendrick@codethink.co.uk>
---
 arch/mips/math-emu/cp1emu.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/mips/math-emu/cp1emu.c b/arch/mips/math-emu/cp1emu.c
index 736c17a..bf0fc6b 100644
--- a/arch/mips/math-emu/cp1emu.c
+++ b/arch/mips/math-emu/cp1emu.c
@@ -1827,7 +1827,7 @@ dcopuop:
 	case -1:
 
 		if (cpu_has_mips_4_5_r)
-			cbit = fpucondbit[MIPSInst_RT(ir) >> 2];
+			cbit = fpucondbit[MIPSInst_FD(ir) >> 2];
 		else
 			cbit = FPU_CSR_COND;
 		if (rv.w)
-- 
1.7.10.4
