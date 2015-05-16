Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 16 May 2015 16:34:49 +0200 (CEST)
Received: from aserp1040.oracle.com ([141.146.126.69]:40123 "EHLO
        aserp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27012778AbbEPOeZDrhVl (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 16 May 2015 16:34:25 +0200
Received: from userv0022.oracle.com (userv0022.oracle.com [156.151.31.74])
        by aserp1040.oracle.com (Sentrion-MTA-4.3.2/Sentrion-MTA-4.3.2) with ESMTP id t4GEYHGS007050
        (version=TLSv1 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK);
        Sat, 16 May 2015 14:34:17 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userv0022.oracle.com (8.13.8/8.13.8) with ESMTP id t4GEYG8M006162
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=FAIL);
        Sat, 16 May 2015 14:34:16 GMT
Received: from abhmp0020.oracle.com (abhmp0020.oracle.com [141.146.116.26])
        by aserv0122.oracle.com (8.13.8/8.13.8) with ESMTP id t4GEYGiT012923;
        Sat, 16 May 2015 14:34:16 GMT
Received: from lappy.hsd1.nh.comcast.net (/10.159.239.59)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Sat, 16 May 2015 07:34:16 -0700
From:   Sasha Levin <sasha.levin@oracle.com>
To:     stable@vger.kernel.org, stable-commits@vger.kernel.org
Cc:     Markos Chandras <markos.chandras@imgtec.com>,
        linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>,
        Sasha Levin <sasha.levin@oracle.com>
Subject: [added to the 3.18 stable tree] MIPS: kernel: entry.S: Set correct ISA level for mips_ihb
Date:   Sat, 16 May 2015 10:33:17 -0400
Message-Id: <1431786833-25487-9-git-send-email-sasha.levin@oracle.com>
X-Mailer: git-send-email 2.1.0
In-Reply-To: <1431786833-25487-1-git-send-email-sasha.levin@oracle.com>
References: <1431786833-25487-1-git-send-email-sasha.levin@oracle.com>
X-Source-IP: userv0022.oracle.com [156.151.31.74]
Return-Path: <sasha.levin@oracle.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 47437
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sasha.levin@oracle.com
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

From: Markos Chandras <markos.chandras@imgtec.com>

This patch has been added to the 3.18 stable tree. If you have any
objections, please let us know.

===============

[ Upstream commit aebac99384f7a6d83a3dcd42bf2481eed2670083 ]

Commit 6ebb496ffc7e("MIPS: kernel: entry.S: Add MIPS R6 related
definitions") added the MIPSR6 definition but it did not update the
ISA level of the actual assembly code so a pre-MIPSR6 jr.hb instruction
was generated instead. Fix this by using the MISP_ISA_LEVEL_RAW macro.

Signed-off-by: Markos Chandras <markos.chandras@imgtec.com>
Fixes: 6ebb496ffc7e("MIPS: kernel: entry.S: Add MIPS R6 related definitions")
Cc: linux-mips@linux-mips.org
Patchwork: https://patchwork.linux-mips.org/patch/9386/
Signed-off-by: Ralf Baechle <ralf@linux-mips.org>
Signed-off-by: Sasha Levin <sasha.levin@oracle.com>
---
 arch/mips/kernel/entry.S | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/mips/kernel/entry.S b/arch/mips/kernel/entry.S
index 4353d32..39d6829 100644
--- a/arch/mips/kernel/entry.S
+++ b/arch/mips/kernel/entry.S
@@ -10,6 +10,7 @@
 
 #include <asm/asm.h>
 #include <asm/asmmacro.h>
+#include <asm/compiler.h>
 #include <asm/regdef.h>
 #include <asm/mipsregs.h>
 #include <asm/stackframe.h>
@@ -166,7 +167,7 @@ syscall_exit_work:
  * For C code use the inline version named instruction_hazard().
  */
 LEAF(mips_ihb)
-	.set	mips32r2
+	.set	MIPS_ISA_LEVEL_RAW
 	jr.hb	ra
 	nop
 	END(mips_ihb)
-- 
2.1.0
