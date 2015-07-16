Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 16 Jul 2015 14:24:59 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:9822 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27010433AbbGPMY546s4- (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 16 Jul 2015 14:24:57 +0200
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id D95DEBEEB7EEA
        for <linux-mips@linux-mips.org>; Thu, 16 Jul 2015 13:24:49 +0100 (IST)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 KLMAIL01.kl.imgtec.org (192.168.5.35) with Microsoft SMTP Server (TLS) id
 14.3.195.1; Thu, 16 Jul 2015 13:24:52 +0100
Received: from mchandras-linux.le.imgtec.org (192.168.154.48) by
 LEMAIL01.le.imgtec.org (192.168.152.62) with Microsoft SMTP Server (TLS) id
 14.3.210.2; Thu, 16 Jul 2015 13:24:51 +0100
From:   Markos Chandras <markos.chandras@imgtec.com>
To:     <linux-mips@linux-mips.org>
CC:     Markos Chandras <markos.chandras@imgtec.com>
Subject: [PATCH] MIPS: Kconfig: Drop the EXPERIMENTAL tag from MIPS R6
Date:   Thu, 16 Jul 2015 13:24:46 +0100
Message-ID: <1437049486-4170-1-git-send-email-markos.chandras@imgtec.com>
X-Mailer: git-send-email 2.4.5
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.154.48]
Return-Path: <Markos.Chandras@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 48324
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

The MIPS R6 ISA support has been part of mainline since v4.0
and it should be in a good shape nowadays so it is not an
experimental feature anymore.

Signed-off-by: Markos Chandras <markos.chandras@imgtec.com>
---
 arch/mips/Kconfig | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index 51bc4873e7e8..885414ece0ac 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -1368,7 +1368,7 @@ config CPU_MIPS32_R2
 	  otherwise CPU_MIPS32_R1 is a safe bet for any MIPS32 system.
 
 config CPU_MIPS32_R6
-	bool "MIPS32 Release 6 (EXPERIMENTAL)"
+	bool "MIPS32 Release 6"
 	depends on SYS_HAS_CPU_MIPS32_R6
 	select CPU_HAS_PREFETCH
 	select CPU_SUPPORTS_32BIT_KERNEL
@@ -1419,7 +1419,7 @@ config CPU_MIPS64_R2
 	  otherwise CPU_MIPS64_R1 is a safe bet for any MIPS64 system.
 
 config CPU_MIPS64_R6
-	bool "MIPS64 Release 6 (EXPERIMENTAL)"
+	bool "MIPS64 Release 6"
 	depends on SYS_HAS_CPU_MIPS64_R6
 	select CPU_HAS_PREFETCH
 	select CPU_SUPPORTS_32BIT_KERNEL
-- 
2.4.5
