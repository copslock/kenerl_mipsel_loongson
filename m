Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 18 Dec 2014 16:17:57 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:30281 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27009175AbaLRPMDel3rX (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 18 Dec 2014 16:12:03 +0100
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id 49B38876084CA
        for <linux-mips@linux-mips.org>; Thu, 18 Dec 2014 15:11:55 +0000 (GMT)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 KLMAIL01.kl.imgtec.org (192.168.5.35) with Microsoft SMTP Server (TLS) id
 14.3.195.1; Thu, 18 Dec 2014 15:11:57 +0000
Received: from mchandras-linux.le.imgtec.org (192.168.154.125) by
 LEMAIL01.le.imgtec.org (192.168.152.62) with Microsoft SMTP Server (TLS) id
 14.3.210.2; Thu, 18 Dec 2014 15:11:57 +0000
From:   Markos Chandras <markos.chandras@imgtec.com>
To:     <linux-mips@linux-mips.org>
CC:     Leonid Yegoshin <Leonid.Yegoshin@imgtec.com>,
        Markos Chandras <markos.chandras@imgtec.com>
Subject: [PATCH RFC 25/67] MIPS: kernel: cpu-bugs64: Do not check R6 cores for existing 64-bit bugs
Date:   Thu, 18 Dec 2014 15:09:34 +0000
Message-ID: <1418915416-3196-26-git-send-email-markos.chandras@imgtec.com>
X-Mailer: git-send-email 2.2.0
In-Reply-To: <1418915416-3196-1-git-send-email-markos.chandras@imgtec.com>
References: <1418915416-3196-1-git-send-email-markos.chandras@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.154.125]
Return-Path: <Markos.Chandras@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 44760
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

From: Leonid Yegoshin <Leonid.Yegoshin@imgtec.com>

The current HW bugs checked in cpu-bugs64, do not apply to R6 cores
and they cause compilation problems due to removed <R6 instructions,
so do not check for them for the time being.

Signed-off-by: Leonid Yegoshin <Leonid.Yegoshin@imgtec.com>
Signed-off-by: Markos Chandras <markos.chandras@imgtec.com>
---
 arch/mips/kernel/cpu-bugs64.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/arch/mips/kernel/cpu-bugs64.c b/arch/mips/kernel/cpu-bugs64.c
index 2d80b5f1aeae..09f4034f239f 100644
--- a/arch/mips/kernel/cpu-bugs64.c
+++ b/arch/mips/kernel/cpu-bugs64.c
@@ -244,7 +244,7 @@ static inline void check_daddi(void)
 	panic(bug64hit, !DADDI_WAR ? daddiwar : nowar);
 }
 
-int daddiu_bug	= -1;
+int daddiu_bug	= config_enabled(CONFIG_CPU_MIPSR6) ? 0 : -1;
 
 static inline void check_daddiu(void)
 {
@@ -314,11 +314,14 @@ static inline void check_daddiu(void)
 
 void __init check_bugs64_early(void)
 {
-	check_mult_sh();
-	check_daddiu();
+	if (!config_enabled(CONFIG_CPU_MIPSR6)) {
+		check_mult_sh();
+		check_daddiu();
+	}
 }
 
 void __init check_bugs64(void)
 {
-	check_daddi();
+	if (!config_enabled(CONFIG_CPU_MIPSR6))
+		check_daddi();
 }
-- 
2.2.0
