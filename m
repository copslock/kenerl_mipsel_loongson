Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 15 Jan 2018 21:55:09 +0100 (CET)
Received: from mail.kernel.org ([198.145.29.99]:37196 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23994630AbeAOUzBmDSdx (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 15 Jan 2018 21:55:01 +0100
Received: from localhost.localdomain (jahogan.plus.com [212.159.75.221])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 22A7E21781;
        Mon, 15 Jan 2018 20:54:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 22A7E21781
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=jhogan@kernel.org
From:   James Hogan <jhogan@kernel.org>
To:     Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org
Cc:     James Hogan <jhogan@kernel.org>, John Crispin <john@phrozen.org>,
        Hauke Mehrtens <hauke@hauke-m.de>,
        Paul Burton <paul.burton@mips.com>,
        Matt Redfearn <matt.redfearn@imgtec.com>,
        Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH for-4.15] MIPS: Fix undefined reference to physical_memsize
Date:   Mon, 15 Jan 2018 20:54:35 +0000
Message-Id: <20180115205435.8745-1-jhogan@kernel.org>
X-Mailer: git-send-email 2.13.6
Return-Path: <jhogan@kernel.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 62138
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jhogan@kernel.org
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

Since commit d41e6858ba58 ("MIPS: Kconfig: Set default MIPS system type
as generic") switched the default platform to the "generic" platform,
allmodconfig has been failing with the following linker error (among
other errors):

arch/mips/kernel/vpe-mt.o In function `vpe_run':
(.text+0x59c): undefined reference to `physical_memsize'

The Lantiq platform already worked around the same issue in commit
9050d50e2244 ("MIPS: lantiq: Set physical_memsize") by declaring
physical_memsize with the initial value of 0 (on the assumption that the
actual memory size will be hard-coded in the loaded VPE firmware), and
the Malta platform already provided physical_memsize.

Since all other platforms will fail to link with the VPE loader enabled,
only allow Lantiq and Malta platforms to enable it, by way of a
SYS_SUPPORTS_VPE_LOADER which is selected by those two platforms and
which MIPS_VPE_LOADER depends on. SYS_SUPPORTS_MULTITHREADING is now a
dependency of SYS_SUPPORTS_VPE_LOADER so that Kconfig emits a warning if
SYS_SUPPORTS_VPE_LOADER is selected without SYS_SUPPORTS_MULTITHREADING.

Fixes: d41e6858ba58 ("MIPS: Kconfig: Set default MIPS system type as generic")
Signed-off-by: James Hogan <jhogan@kernel.org>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: John Crispin <john@phrozen.org>
Cc: Hauke Mehrtens <hauke@hauke-m.de>
Cc: Paul Burton <paul.burton@mips.com>
Cc: Matt Redfearn <matt.redfearn@imgtec.com>
Cc: Guenter Roeck <linux@roeck-us.net>
Cc: linux-mips@linux-mips.org
---
 arch/mips/Kconfig | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index 659e0079487f..8e0b3702f1c0 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -390,6 +390,7 @@ config LANTIQ
 	select SYS_SUPPORTS_32BIT_KERNEL
 	select SYS_SUPPORTS_MIPS16
 	select SYS_SUPPORTS_MULTITHREADING
+	select SYS_SUPPORTS_VPE_LOADER
 	select SYS_HAS_EARLY_PRINTK
 	select GPIOLIB
 	select SWAP_IO_SPACE
@@ -517,6 +518,7 @@ config MIPS_MALTA
 	select SYS_SUPPORTS_MIPS16
 	select SYS_SUPPORTS_MULTITHREADING
 	select SYS_SUPPORTS_SMARTMIPS
+	select SYS_SUPPORTS_VPE_LOADER
 	select SYS_SUPPORTS_ZBOOT
 	select SYS_SUPPORTS_RELOCATABLE
 	select USE_OF
@@ -2282,9 +2284,16 @@ config MIPSR2_TO_R6_EMULATOR
 	  The only reason this is a build-time option is to save ~14K from the
 	  final kernel image.
 
+config SYS_SUPPORTS_VPE_LOADER
+	bool
+	depends on SYS_SUPPORTS_MULTITHREADING
+	help
+	  Indicates that the platform supports the VPE loader, and provides
+	  physical_memsize.
+
 config MIPS_VPE_LOADER
 	bool "VPE loader support."
-	depends on SYS_SUPPORTS_MULTITHREADING && MODULES
+	depends on SYS_SUPPORTS_VPE_LOADER && MODULES
 	select CPU_MIPSR2_IRQ_VI
 	select CPU_MIPSR2_IRQ_EI
 	select MIPS_MT
-- 
2.13.6
