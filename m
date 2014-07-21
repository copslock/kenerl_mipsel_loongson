Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 21 Jul 2014 09:46:30 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:14676 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S6860080AbaGUHq04gwI8 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 21 Jul 2014 09:46:26 +0200
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id 0EA18C5207CEA
        for <linux-mips@linux-mips.org>; Mon, 21 Jul 2014 08:46:18 +0100 (IST)
Received: from KLMAIL02.kl.imgtec.org (10.40.60.222) by KLMAIL01.kl.imgtec.org
 (192.168.5.35) with Microsoft SMTP Server (TLS) id 14.3.195.1; Mon, 21 Jul
 2014 08:46:19 +0100
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 klmail02.kl.imgtec.org (10.40.60.222) with Microsoft SMTP Server (TLS) id
 14.3.195.1; Mon, 21 Jul 2014 08:46:19 +0100
Received: from mchandras-linux.le.imgtec.org (192.168.154.145) by
 LEMAIL01.le.imgtec.org (192.168.152.62) with Microsoft SMTP Server (TLS) id
 14.3.195.1; Mon, 21 Jul 2014 08:46:18 +0100
From:   Markos Chandras <markos.chandras@imgtec.com>
To:     <linux-mips@linux-mips.org>
CC:     Markos Chandras <markos.chandras@imgtec.com>
Subject: [PATCH v2] MIPS: Kconfig: Add choice symbol to select microMIPS or SmartMIPS
Date:   Mon, 21 Jul 2014 08:46:14 +0100
Message-ID: <1405928774-20630-1-git-send-email-markos.chandras@imgtec.com>
X-Mailer: git-send-email 2.0.0
In-Reply-To: <1401785177-7904-1-git-send-email-markos.chandras@imgtec.com>
References: <1401785177-7904-1-git-send-email-markos.chandras@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.154.145]
Return-Path: <Markos.Chandras@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 41354
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

microMIPS and SmartMIPS can't be used together. This fixes the
following build problem:

Warning: the 32-bit microMIPS architecture does not support the `smartmips'
extension
arch/mips/kernel/entry.S:90: Error: unrecognized opcode `mtlhx $24'
[...]
arch/mips/kernel/entry.S:109: Error: unrecognized opcode `mtlhx $24'

Link: https://dmz-portal.mips.com/bugz/show_bug.cgi?id=1021
Signed-off-by: Markos Chandras <markos.chandras@imgtec.com>
---
Hi Ralf,

Here is v2 of that patch, making SmartMIPS and microMIPS a
choice symbol as you requested in
http://www.linux-mips.org/archives/linux-mips/2014-06/msg00011.html

However, I still feel this is wrong since these two ASEs are completely
unrelated. The v1 of the patch is probably better in my opinion.
If the user fails to find the 'smartmips' option due to having 'micromips'
enabled, he/she can always search for the 'smartmips' symbol in the
menuconfig and he/she will notice the dependency on !micromips.
And if the user knows what he is doing he will probably never want to
use 'smartmips' and 'micromips' together.
---

 arch/mips/Kconfig | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index 4e238e6e661c..f30a43a52a09 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -2090,9 +2090,17 @@ config 64BIT_PHYS_ADDR
 config ARCH_PHYS_ADDR_T_64BIT
        def_bool 64BIT_PHYS_ADDR
 
+choice
+	prompt "SmartMIPS or microMIPS ASE support"
+
+config CPU_NEEDS_NO_SMARTMIPS_OR_MICROMIPS
+	bool "None"
+	help
+	  Select this if you want neither microMIPS nor SmartMIPS support
+
 config CPU_HAS_SMARTMIPS
 	depends on SYS_SUPPORTS_SMARTMIPS
-	bool "Support for the SmartMIPS ASE"
+	bool "SmartMIPS"
 	help
 	  SmartMIPS is a extension of the MIPS32 architecture aimed at
 	  increased security at both hardware and software level for
@@ -2104,11 +2112,13 @@ config CPU_HAS_SMARTMIPS
 
 config CPU_MICROMIPS
 	depends on SYS_SUPPORTS_MICROMIPS
-	bool "Build kernel using microMIPS ISA"
+	bool "microMIPS"
 	help
 	  When this option is enabled the kernel will be built using the
 	  microMIPS ISA
 
+endchoice
+
 config CPU_HAS_MSA
 	bool "Support for the MIPS SIMD Architecture"
 	depends on CPU_SUPPORTS_MSA
-- 
2.0.0
