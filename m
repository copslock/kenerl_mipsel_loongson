Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 17 Jul 2015 11:36:16 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:52950 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27009681AbbGQJgOthpwb (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 17 Jul 2015 11:36:14 +0200
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id 9D44278BF7479;
        Fri, 17 Jul 2015 10:36:06 +0100 (IST)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 KLMAIL01.kl.imgtec.org (192.168.5.35) with Microsoft SMTP Server (TLS) id
 14.3.195.1; Fri, 17 Jul 2015 10:36:08 +0100
Received: from mchandras-linux.le.imgtec.org (192.168.154.48) by
 LEMAIL01.le.imgtec.org (192.168.152.62) with Microsoft SMTP Server (TLS) id
 14.3.210.2; Fri, 17 Jul 2015 10:36:08 +0100
From:   Markos Chandras <markos.chandras@imgtec.com>
To:     <linux-mips@linux-mips.org>
CC:     Markos Chandras <markos.chandras@imgtec.com>,
        <stable@vger.kernel.org>
Subject: [PATCH] MIPS: math-emu: cp1emu: Allow m{f,t}hc emulation on MIPS R6
Date:   Fri, 17 Jul 2015 10:36:03 +0100
Message-ID: <1437125763-12527-1-git-send-email-markos.chandras@imgtec.com>
X-Mailer: git-send-email 2.4.5
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.154.48]
Return-Path: <Markos.Chandras@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 48338
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: markos.chandras@imgtec.com
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

The mfhc/mthc instructions are supported on MIPS R6 so emulate
them if needed.

Cc: <stable@vger.kernel.org> # 4.0+
Signed-off-by: Markos Chandras <markos.chandras@imgtec.com>
---
 arch/mips/math-emu/cp1emu.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/mips/math-emu/cp1emu.c b/arch/mips/math-emu/cp1emu.c
index 712f17a2ecf2..70e88efee45b 100644
--- a/arch/mips/math-emu/cp1emu.c
+++ b/arch/mips/math-emu/cp1emu.c
@@ -1137,7 +1137,7 @@ emul:
 			break;
 
 		case mfhc_op:
-			if (!cpu_has_mips_r2)
+			if (!cpu_has_mips_r2_r6)
 				goto sigill;
 
 			/* copregister rd -> gpr[rt] */
@@ -1148,7 +1148,7 @@ emul:
 			break;
 
 		case mthc_op:
-			if (!cpu_has_mips_r2)
+			if (!cpu_has_mips_r2_r6)
 				goto sigill;
 
 			/* copregister rd <- gpr[rt] */
-- 
2.4.5
