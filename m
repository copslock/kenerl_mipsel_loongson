Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 14 Dec 2016 16:10:06 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:14431 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23992240AbcLNPJ4ZPob4 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 14 Dec 2016 16:09:56 +0100
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Forcepoint Email with ESMTPS id C18166FCC26FD;
        Wed, 14 Dec 2016 15:09:46 +0000 (GMT)
Received: from mredfearn-linux.le.imgtec.org (10.150.130.83) by
 HHMAIL01.hh.imgtec.org (10.100.10.21) with Microsoft SMTP Server (TLS) id
 14.3.294.0; Wed, 14 Dec 2016 15:09:49 +0000
From:   Matt Redfearn <matt.redfearn@imgtec.com>
To:     Ralf Baechle <ralf@linux-mips.org>
CC:     <linux-mips@linux-mips.org>,
        Matt Redfearn <matt.redfearn@imgtec.com>,
        David Howells <dhowells@redhat.com>,
        Borislav Petkov <bp@suse.de>, <linux-kernel@vger.kernel.org>
Subject: [PATCH 1/2] MIPS: Kconfig: Set default MIPS system type as generic
Date:   Wed, 14 Dec 2016 15:09:42 +0000
Message-ID: <1481728183-16776-1-git-send-email-matt.redfearn@imgtec.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.150.130.83]
Return-Path: <Matt.Redfearn@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 56046
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: matt.redfearn@imgtec.com
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

The generic MIPS system type allows building a board agnostic kernel and
should be the default starting point for users, so set it as the default
system type in Kconfig.
Since ip22 is no longer the default, update ip22_defconfig to select
CONFIG_SGI_IP22.

Signed-off-by: Matt Redfearn <matt.redfearn@imgtec.com>

---

This patch "fixes" the build errors reported by kernelci.org for the
allnoconfig, generic_defconfig and tinyconfig targets.

There is another workaround for the actual build failure in patchwork
here https://patchwork.linux-mips.org/patch/14397/, but since that patch
just works around a toolchain bug it is not ideal either. Since
toolchains that produce failures here are out in the wild, banning
binutils 2.25 & 2.26 doesn't seem helpful as that will just trigger more
problems.

So perhaps the best thing to do is to update the default system to
something which does not suffer the issue and is additionally more modern
and actively maintained.

---
 arch/mips/Kconfig                | 2 +-
 arch/mips/configs/ip22_defconfig | 1 +
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index b3c5bde43d34..005085e75a66 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -71,7 +71,7 @@ menu "Machine selection"
 
 choice
 	prompt "System type"
-	default SGI_IP22
+	default MIPS_GENERIC
 
 config MIPS_GENERIC
 	bool "Generic board-agnostic MIPS kernel"
diff --git a/arch/mips/configs/ip22_defconfig b/arch/mips/configs/ip22_defconfig
index 5d83ff755547..4b9e759d8b87 100644
--- a/arch/mips/configs/ip22_defconfig
+++ b/arch/mips/configs/ip22_defconfig
@@ -1,3 +1,4 @@
+CONFIG_SGI_IP22=y
 CONFIG_ARC_CONSOLE=y
 CONFIG_CPU_R5000=y
 CONFIG_NO_HZ=y
-- 
2.7.4
