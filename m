Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 05 Sep 2016 16:44:06 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:46125 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23992232AbcIEOoAR7Zvd (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 5 Sep 2016 16:44:00 +0200
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Forcepoint Email with ESMTPS id 56DDBC26DC0D4;
        Mon,  5 Sep 2016 15:43:41 +0100 (IST)
Received: from mredfearn-linux.le.imgtec.org (10.150.130.83) by
 HHMAIL01.hh.imgtec.org (10.100.10.21) with Microsoft SMTP Server (TLS) id
 14.3.294.0; Mon, 5 Sep 2016 15:43:44 +0100
From:   Matt Redfearn <matt.redfearn@imgtec.com>
To:     Ralf Baechle <ralf@linux-mips.org>, <linux-mips@linux-mips.org>
CC:     Matt Redfearn <matt.redfearn@imgtec.com>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH] MIPS: paravirt: Fix undefined reference to smp_bootstrap
Date:   Mon, 5 Sep 2016 15:43:40 +0100
Message-ID: <1473086620-21007-1-git-send-email-matt.redfearn@imgtec.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.150.130.83]
Return-Path: <Matt.Redfearn@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 55038
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

If the paravirt machine is compiles without CONFIG_SMP, the following
linker error occurs

arch/mips/kernel/head.o: In function `kernel_entry':
(.ref.text+0x10): undefined reference to `smp_bootstrap'

due to the kernel entry macro always including SMP startup code.
Wrap this code in CONFIG_SMP to fix the error.

Signed-off-by: Matt Redfearn <matt.redfearn@imgtec.com>

---

 arch/mips/include/asm/mach-paravirt/kernel-entry-init.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/mips/include/asm/mach-paravirt/kernel-entry-init.h b/arch/mips/include/asm/mach-paravirt/kernel-entry-init.h
index 2f82bfa3a773..c9f5769dfc8f 100644
--- a/arch/mips/include/asm/mach-paravirt/kernel-entry-init.h
+++ b/arch/mips/include/asm/mach-paravirt/kernel-entry-init.h
@@ -11,11 +11,13 @@
 #define CP0_EBASE $15, 1
 
 	.macro  kernel_entry_setup
+#ifdef CONFIG_SMP
 	mfc0	t0, CP0_EBASE
 	andi	t0, t0, 0x3ff		# CPUNum
 	beqz	t0, 1f
 	# CPUs other than zero goto smp_bootstrap
 	j	smp_bootstrap
+#endif /* CONFIG_SMP */
 
 1:
 	.endm
-- 
2.7.4
