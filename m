Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 18 Feb 2015 14:30:33 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:48594 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27012995AbbBRNabAySWF (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 18 Feb 2015 14:30:31 +0100
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id EC23E2AC88763;
        Wed, 18 Feb 2015 13:30:22 +0000 (GMT)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 KLMAIL01.kl.imgtec.org (192.168.5.35) with Microsoft SMTP Server (TLS) id
 14.3.195.1; Wed, 18 Feb 2015 13:30:25 +0000
Received: from mchandras-linux.le.imgtec.org (192.168.154.96) by
 LEMAIL01.le.imgtec.org (192.168.152.62) with Microsoft SMTP Server (TLS) id
 14.3.210.2; Wed, 18 Feb 2015 13:30:24 +0000
From:   Markos Chandras <markos.chandras@imgtec.com>
To:     <linux-mips@linux-mips.org>
CC:     Markos Chandras <markos.chandras@imgtec.com>,
        Huacai Chen <chenhc@lemote.com>,
        "Maciej W. Rozycki" <macro@linux-mips.org>,
        "Matthew Fortune" <Matthew.Fortune@imgtec.com>
Subject: [PATCH v2 2/2] MIPS: Makefile: Pass -march option on Loongson3A cores
Date:   Wed, 18 Feb 2015 13:30:18 +0000
Message-ID: <1424266218-11320-1-git-send-email-markos.chandras@imgtec.com>
X-Mailer: git-send-email 2.3.0
In-Reply-To: <1422891662-13838-2-git-send-email-markos.chandras@imgtec.com>
References: <1422891662-13838-2-git-send-email-markos.chandras@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.154.96]
Return-Path: <Markos.Chandras@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 45851
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

The loongson 3A cores do not select a suitable -march option so the
build system uses the default one from the toolchain. This may or may
not be suitable for a loongson 3A build. In order to avoid that, we
explicitly set a suitable -march option for that core.

Cc: Huacai Chen <chenhc@lemote.com>
Cc: Maciej W. Rozycki <macro@linux-mips.org>
Cc: Matthew Fortune <Matthew.Fortune@imgtec.com>
Signed-off-by: Markos Chandras <markos.chandras@imgtec.com>
---
Changes since v1:
- Drop second part of the original patch http://patchwork.linux-mips.org/patch/9181/
since the $(CONFIG_*) symbols were not evaluated when doing 'make foo_defconfig'
leading to bogus build failures.
---
 arch/mips/Makefile | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/mips/Makefile b/arch/mips/Makefile
index aaee9a0b89bf..aaa0426b3867 100644
--- a/arch/mips/Makefile
+++ b/arch/mips/Makefile
@@ -166,6 +166,7 @@ cflags-$(CONFIG_CPU_CAVIUM_OCTEON) += -Wa,-march=octeon
 endif
 cflags-$(CONFIG_CAVIUM_CN63XXP1) += -Wa,-mfix-cn63xxp1
 cflags-$(CONFIG_CPU_BMIPS)	+= -march=mips32 -Wa,-mips32 -Wa,--trap
+cflags-$(CONFIG_CPU_LOONGSON3)	+= $(call cc-option,-march=loongson3a,-march=mips64r2) -Wa,--trap
 
 cflags-$(CONFIG_CPU_R4000_WORKAROUNDS)	+= $(call cc-option,-mfix-r4000,)
 cflags-$(CONFIG_CPU_R4400_WORKAROUNDS)	+= $(call cc-option,-mfix-r4400,)
-- 
2.3.0
