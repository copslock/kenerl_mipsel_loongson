Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 16 Jul 2015 15:07:02 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:37617 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27010450AbbGPNHAwVzCG (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 16 Jul 2015 15:07:00 +0200
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id 87B58538CF6DA
        for <linux-mips@linux-mips.org>; Thu, 16 Jul 2015 14:06:52 +0100 (IST)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 KLMAIL01.kl.imgtec.org (192.168.5.35) with Microsoft SMTP Server (TLS) id
 14.3.195.1; Thu, 16 Jul 2015 14:06:55 +0100
Received: from mchandras-linux.le.imgtec.org (192.168.154.48) by
 LEMAIL01.le.imgtec.org (192.168.152.62) with Microsoft SMTP Server (TLS) id
 14.3.210.2; Thu, 16 Jul 2015 14:06:54 +0100
From:   Markos Chandras <markos.chandras@imgtec.com>
To:     <linux-mips@linux-mips.org>
Subject: [PATCH] MIPS: math-emu: cp1emu: Fix closing bracket for the d_fmt case
Date:   Thu, 16 Jul 2015 14:06:45 +0100
Message-ID: <1437052005-14520-1-git-send-email-markos.chandras@imgtec.com>
X-Mailer: git-send-email 2.4.5
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.154.48]
Return-Path: <Markos.Chandras@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 48328
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

The double format (d_fmt) case uses an opening bracket which then
closes at the end of the word format (w_fmt). This can be rather confusing
so add the closing bracket at the end of the d_fmt case and use another one
for the w_fmt one.

Signed-off-by: Markos Chandras <markos.chandras@imgtec.com>
---
 arch/mips/math-emu/cp1emu.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/arch/mips/math-emu/cp1emu.c b/arch/mips/math-emu/cp1emu.c
index 712f17a2ecf2..cd858953a783 100644
--- a/arch/mips/math-emu/cp1emu.c
+++ b/arch/mips/math-emu/cp1emu.c
@@ -2021,8 +2021,11 @@ dcopuop:
 			break;
 		}
 		break;
+	}
+
+	case w_fmt: {
+		union ieee754dp fs;
 
-	case w_fmt:
 		switch (MIPSInst_FUNC(ir)) {
 		case fcvts_op:
 			/* convert word to single precision real */
-- 
2.4.5
