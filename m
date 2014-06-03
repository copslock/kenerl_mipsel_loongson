Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 03 Jun 2014 10:46:41 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:25298 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S6822330AbaFCIqcAdLSR (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 3 Jun 2014 10:46:32 +0200
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id 5A3B2F5192CB5
        for <linux-mips@linux-mips.org>; Tue,  3 Jun 2014 09:46:23 +0100 (IST)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 KLMAIL01.kl.imgtec.org (192.168.5.35) with Microsoft SMTP Server (TLS) id
 14.3.181.6; Tue, 3 Jun 2014 09:46:25 +0100
Received: from mchandras-linux.le.imgtec.org (192.168.154.47) by
 LEMAIL01.le.imgtec.org (192.168.152.62) with Microsoft SMTP Server (TLS) id
 14.3.174.1; Tue, 3 Jun 2014 09:46:24 +0100
From:   Markos Chandras <markos.chandras@imgtec.com>
To:     <linux-mips@linux-mips.org>
CC:     Markos Chandras <markos.chandras@imgtec.com>
Subject: [PATCH] MIPS: Kconfig: microMIPS and SmartMIPS are mutually exclusive
Date:   Tue, 3 Jun 2014 09:46:17 +0100
Message-ID: <1401785177-7904-1-git-send-email-markos.chandras@imgtec.com>
X-Mailer: git-send-email 2.0.0
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.154.47]
Return-Path: <Markos.Chandras@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 40411
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

Fixes the following build problem on randconfig:

Warning: the 32-bit microMIPS architecture does not support the `smartmips'
extension
arch/mips/kernel/entry.S:90: Error: unrecognized opcode `mtlhx $24'
[...]
arch/mips/kernel/entry.S:109: Error: unrecognized opcode `mtlhx $24'

Link: https://dmz-portal.mips.com/bugz/show_bug.cgi?id=1021
Reviewed-by: Steven J. Hill <Steven.Hill@imgtec.com>
Signed-off-by: Markos Chandras <markos.chandras@imgtec.com>
---
 arch/mips/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index 2fe8e60..ffde3d6 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -2063,7 +2063,7 @@ config ARCH_PHYS_ADDR_T_64BIT
        def_bool 64BIT_PHYS_ADDR
 
 config CPU_HAS_SMARTMIPS
-	depends on SYS_SUPPORTS_SMARTMIPS
+	depends on SYS_SUPPORTS_SMARTMIPS && !CPU_MICROMIPS
 	bool "Support for the SmartMIPS ASE"
 	help
 	  SmartMIPS is a extension of the MIPS32 architecture aimed at
-- 
1.9.3
