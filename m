Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 23 Aug 2017 20:18:55 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:50775 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23993921AbdHWSSl0S04I (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 23 Aug 2017 20:18:41 +0200
Received: from hhmail02.hh.imgtec.org (unknown [10.100.10.20])
        by Forcepoint Email with ESMTPS id 54A53E5309C8D;
        Wed, 23 Aug 2017 19:18:31 +0100 (IST)
Received: from localhost (10.20.1.88) by hhmail02.hh.imgtec.org (10.100.10.21)
 with Microsoft SMTP Server (TLS) id 14.3.294.0; Wed, 23 Aug 2017 19:18:35
 +0100
From:   Paul Burton <paul.burton@imgtec.com>
To:     <linux-mips@linux-mips.org>, Ralf Baechle <ralf@linux-mips.org>,
        <trivial@kernel.org>
CC:     Paul Burton <paul.burton@imgtec.com>,
        Matt Redfearn <matt.redfearn@imgtec.com>
Subject: [PATCH 01/11] MIPS: generic: Include asm/bootinfo.h for plat_fdt_relocated()
Date:   Wed, 23 Aug 2017 11:17:44 -0700
Message-ID: <20170823181754.24044-2-paul.burton@imgtec.com>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <20170823181754.24044-1-paul.burton@imgtec.com>
References: <20170823181754.24044-1-paul.burton@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.20.1.88]
Return-Path: <Paul.Burton@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 59777
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: paul.burton@imgtec.com
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

arch/mips/generic/init.c provides an implementation of the
plat_fdt_relocated() function, but doesn't include the asm/bootinfo.h
header which declares it. This leads to a warning from sparse:

arch/mips/generic/init.c:94:13: warning: symbol 'plat_fdt_relocated' was
  not declared. Should it be static?

Fix this by including asm/bootinfo.h to get the declaration of
plat_fdt_relocated(). We also #ifdef our definition of
plat_fdt_relocated() such that it is only provided when
CONFIG_RELOCATABLE is set, matching the header & avoiding the redundant
function for non-relocatable kernels.

Signed-off-by: Paul Burton <paul.burton@imgtec.com>
Cc: Matt Redfearn <matt.redfearn@imgtec.com>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: linux-mips@linux-mips.org
---

 arch/mips/generic/init.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/mips/generic/init.c b/arch/mips/generic/init.c
index 3f32b376d30e..15a7fb8e2a2e 100644
--- a/arch/mips/generic/init.c
+++ b/arch/mips/generic/init.c
@@ -16,6 +16,7 @@
 #include <linux/of_fdt.h>
 #include <linux/of_platform.h>
 
+#include <asm/bootinfo.h>
 #include <asm/fw/fw.h>
 #include <asm/irq_cpu.h>
 #include <asm/machine.h>
@@ -88,6 +89,8 @@ void __init *plat_get_fdt(void)
 	return (void *)fdt;
 }
 
+#ifdef CONFIG_RELOCATABLE
+
 void __init plat_fdt_relocated(void *new_location)
 {
 	/*
@@ -101,6 +104,8 @@ void __init plat_fdt_relocated(void *new_location)
 		fw_arg1 = (unsigned long)new_location;
 }
 
+#endif /* CONFIG_RELOCATABLE */
+
 void __init plat_mem_setup(void)
 {
 	if (mach && mach->fixup_fdt)
-- 
2.14.1
