Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 17 Oct 2016 12:05:33 +0200 (CEST)
Received: from mailapp02.imgtec.com ([217.156.133.132]:20000 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S23992232AbcJQKFTDBWPU (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 17 Oct 2016 12:05:19 +0200
Received: from HHMAIL03.hh.imgtec.org (unknown [10.44.0.21])
        by Forcepoint Email with ESMTPS id 479A7581C0634;
        Mon, 17 Oct 2016 11:05:10 +0100 (IST)
Received: from HHMAIL01.hh.imgtec.org (10.100.10.19) by HHMAIL03.hh.imgtec.org
 (10.44.0.21) with Microsoft SMTP Server (TLS) id 14.3.294.0; Mon, 17 Oct 2016
 11:05:12 +0100
Received: from mredfearn-linux.le.imgtec.org (10.150.130.83) by
 HHMAIL01.hh.imgtec.org (10.100.10.21) with Microsoft SMTP Server (TLS) id
 14.3.294.0; Mon, 17 Oct 2016 11:05:12 +0100
From:   Matt Redfearn <matt.redfearn@imgtec.com>
To:     Ralf Baechle <ralf@linux-mips.org>
CC:     <linux-mips@linux-mips.org>,
        Matt Redfearn <matt.redfearn@imgtec.com>,
        <linux-kernel@vger.kernel.org>,
        Paul Burton <paul.burton@imgtec.com>
Subject: [PATCH] MIPS: generic: Fix KASLR for generic kernel.
Date:   Mon, 17 Oct 2016 11:05:09 +0100
Message-ID: <1476698709-6771-1-git-send-email-matt.redfearn@imgtec.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.150.130.83]
Return-Path: <Matt.Redfearn@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 55447
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

The KASLR code requires that the plat_get_fdt() function return the
address of the device tree, and it must be available early in the boot,
before prom_init() is called. Move the code determining the address of
the device tree into plat_get_fdt, and call that from prom_init().

The fdt pointer will be set up by plat_get_fdt() called from
relocate_kernel initially and once the relocated kernel has started,
prom_init() will use it again to determine the address in the relocated
image.

Fixes: eed0eabd12ef
Signed-off-by: Matt Redfearn <matt.redfearn@imgtec.com>
---

 arch/mips/generic/init.c | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/arch/mips/generic/init.c b/arch/mips/generic/init.c
index 0ea73e845440..d493ccbf274a 100644
--- a/arch/mips/generic/init.c
+++ b/arch/mips/generic/init.c
@@ -30,9 +30,19 @@ static __initdata const void *mach_match_data;
 
 void __init prom_init(void)
 {
+	plat_get_fdt();
+	BUG_ON(!fdt);
+}
+
+void __init *plat_get_fdt(void)
+{
 	const struct mips_machine *check_mach;
 	const struct of_device_id *match;
 
+	if (fdt)
+		/* Already set up */
+		return (void *)fdt;
+
 	if ((fw_arg0 == -2) && !fdt_check_header((void *)fw_arg1)) {
 		/*
 		 * We booted using the UHI boot protocol, so we have been
@@ -75,12 +85,6 @@ void __init prom_init(void)
 		/* Retrieve the machine's FDT */
 		fdt = mach->fdt;
 	}
-
-	BUG_ON(!fdt);
-}
-
-void __init *plat_get_fdt(void)
-{
 	return (void *)fdt;
 }
 
-- 
2.7.4
