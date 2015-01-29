Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 29 Jan 2015 12:16:16 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:49116 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27012181AbbA2LOkN9159 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 29 Jan 2015 12:14:40 +0100
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id A1C63DCDE4DD3;
        Thu, 29 Jan 2015 11:14:32 +0000 (GMT)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 KLMAIL01.kl.imgtec.org (192.168.5.35) with Microsoft SMTP Server (TLS) id
 14.3.195.1; Thu, 29 Jan 2015 11:14:34 +0000
Received: from jhogan-linux.le.imgtec.org (192.168.154.110) by
 LEMAIL01.le.imgtec.org (192.168.152.62) with Microsoft SMTP Server (TLS) id
 14.3.210.2; Thu, 29 Jan 2015 11:14:33 +0000
From:   James Hogan <james.hogan@imgtec.com>
To:     Ralf Baechle <ralf@linux-mips.org>, <linux-mips@linux-mips.org>
CC:     <linux-kernel@vger.kernel.org>,
        James Hogan <james.hogan@imgtec.com>
Subject: [PATCH 6/9] MIPS: idle: Workaround wait + FDC problems
Date:   Thu, 29 Jan 2015 11:14:11 +0000
Message-ID: <1422530054-7976-7-git-send-email-james.hogan@imgtec.com>
X-Mailer: git-send-email 2.0.5
In-Reply-To: <1422530054-7976-1-git-send-email-james.hogan@imgtec.com>
References: <1422530054-7976-1-git-send-email-james.hogan@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.154.110]
Return-Path: <James.Hogan@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 45529
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: james.hogan@imgtec.com
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

On certain cores (namely proAptiv and P5600) incoming data via a Fast
Debug Channel (FDC) while the core is blocked on a wait instruction will
cause the wait not to wake up even when another interrupt is received.
This makes an idle target stop as soon as you send FDC data to it, until
the debug probe interrupts it and restarts the wait instruction.

This is worked around by avoiding using r4k_wait on these cores if
CONFIG_MIPS_EJTAG_FDC_TTY is enabled (which would imply the user intends
to use the FDC).

Signed-off-by: James Hogan <james.hogan@imgtec.com>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: linux-mips@linux-mips.org
---
 arch/mips/kernel/idle.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/arch/mips/kernel/idle.c b/arch/mips/kernel/idle.c
index 0b9082b6b683..3db277ea9e8d 100644
--- a/arch/mips/kernel/idle.c
+++ b/arch/mips/kernel/idle.c
@@ -176,6 +176,17 @@ void __init check_wait(void)
 		cpu_wait = rm7k_wait_irqoff;
 		break;
 
+	case CPU_PROAPTIV:
+	case CPU_P5600:
+		/*
+		 * Incoming Fast Debug Channel (FDC) data during a wait
+		 * instruction causes the wait never to resume, even if an
+		 * interrupt is received. Avoid using wait at all if FDC data is
+		 * likely to be received.
+		 */
+		if (IS_ENABLED(CONFIG_MIPS_EJTAG_FDC_TTY))
+			break;
+		/* fall through */
 	case CPU_M14KC:
 	case CPU_M14KEC:
 	case CPU_24K:
@@ -183,8 +194,6 @@ void __init check_wait(void)
 	case CPU_1004K:
 	case CPU_1074K:
 	case CPU_INTERAPTIV:
-	case CPU_PROAPTIV:
-	case CPU_P5600:
 	case CPU_M5150:
 		cpu_wait = r4k_wait;
 		if (read_c0_config7() & MIPS_CONF7_WII)
-- 
2.0.5
