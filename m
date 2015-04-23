Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 23 Apr 2015 14:28:49 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:58761 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27010762AbbDWM2sT9WsA (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 23 Apr 2015 14:28:48 +0200
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id EA3C2F5288452;
        Thu, 23 Apr 2015 13:28:41 +0100 (IST)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 KLMAIL01.kl.imgtec.org (192.168.5.35) with Microsoft SMTP Server (TLS) id
 14.3.195.1; Thu, 23 Apr 2015 13:28:44 +0100
Received: from mchandras-linux.le.imgtec.org (192.168.154.77) by
 LEMAIL01.le.imgtec.org (192.168.152.62) with Microsoft SMTP Server (TLS) id
 14.3.210.2; Thu, 23 Apr 2015 13:28:43 +0100
From:   Markos Chandras <markos.chandras@imgtec.com>
To:     <linux-mips@linux-mips.org>
CC:     Markos Chandras <markos.chandras@imgtec.com>,
        =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <zajec5@gmail.com>
Subject: [PATCH] MIPS: bcm47xx: Move the BCM47XX board types under a choice symbol
Date:   Thu, 23 Apr 2015 13:28:13 +0100
Message-ID: <1429792093-8160-1-git-send-email-markos.chandras@imgtec.com>
X-Mailer: git-send-email 2.3.5
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [192.168.154.77]
Return-Path: <Markos.Chandras@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 47014
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

Since the build system expects one of the two types to be selected,
it's better if we move these symbols under a new choice symbol.
Moreover, this fixes the following build problem when no board is
selected:

In file included from arch/mips/bcm47xx/irq.c:32:0:
./arch/mips/include/asm/mach-bcm47xx/bcm47xx.h:34:1: error: expected identifier
before '}' token };
                 ^
Cc: "Rafał Miłecki" <zajec5@gmail.com>
Signed-off-by: Markos Chandras <markos.chandras@imgtec.com>
---
 arch/mips/bcm47xx/Kconfig | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/mips/bcm47xx/Kconfig b/arch/mips/bcm47xx/Kconfig
index fc21d3659fa0..39e24407709e 100644
--- a/arch/mips/bcm47xx/Kconfig
+++ b/arch/mips/bcm47xx/Kconfig
@@ -1,5 +1,9 @@
 if BCM47XX
 
+choice
+	prompt "Board type"
+	default BCM47XX_SSB
+
 config BCM47XX_SSB
 	bool "SSB Support for Broadcom BCM47XX"
 	select SYS_HAS_CPU_BMIPS32_3300
@@ -34,4 +38,6 @@ config BCM47XX_BCMA
 
 	 This will generate an image with support for BCMA and MIPS32 R2 instruction set.
 
+endchoice
+
 endif
-- 
2.3.5
