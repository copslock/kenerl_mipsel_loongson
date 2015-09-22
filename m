Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 22 Sep 2015 20:59:09 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:46549 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27008792AbbIVS7IdHKhP (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 22 Sep 2015 20:59:08 +0200
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id 155A434BE9F08;
        Tue, 22 Sep 2015 19:58:59 +0100 (IST)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 KLMAIL01.kl.imgtec.org (192.168.5.35) with Microsoft SMTP Server (TLS) id
 14.3.195.1; Tue, 22 Sep 2015 19:59:02 +0100
Received: from localhost (192.168.159.189) by LEMAIL01.le.imgtec.org
 (192.168.152.62) with Microsoft SMTP Server (TLS) id 14.3.210.2; Tue, 22 Sep
 2015 19:59:01 +0100
From:   Paul Burton <paul.burton@imgtec.com>
To:     <linux-mips@linux-mips.org>
CC:     Paul Burton <paul.burton@imgtec.com>,
        Peter Hurley <peter@hurleysoftware.com>,
        Rob Herring <robh@kernel.org>, <linux-kernel@vger.kernel.org>,
        Markos Chandras <markos.chandras@imgtec.com>,
        Ralf Baechle <ralf@linux-mips.org>
Subject: [PATCH] MIPS: malta: register UP SMP ops if all else fails
Date:   Tue, 22 Sep 2015 11:58:43 -0700
Message-ID: <1442948323-14856-1-git-send-email-paul.burton@imgtec.com>
X-Mailer: git-send-email 2.5.3
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.159.189]
Return-Path: <Paul.Burton@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 49328
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

If we fail to register any real SMP implementations, fall back to
registering the dummy UP implementation. Otherwise when we build an SMP
kernel & run it on a system where the SMP implementations fail to probe
(eg. QEMU) the kernel will perform a NULL dereference attempting to call
mp_ops->smp_setup() from plat_smp_setup().

Notably this fixes booting kernels with CPS SMP enabled on QEMU, which
doesn't currently implement the CM, CPC or GIC.

Signed-off-by: Paul Burton <paul.burton@imgtec.com>
---

 arch/mips/Kconfig                | 1 +
 arch/mips/mti-malta/malta-init.c | 1 +
 2 files changed, 2 insertions(+)

diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index e3aa5b0..71d2a88 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -424,6 +424,7 @@ config MIPS_MALTA
 	select MIPS_L1_CACHE_SHIFT_6
 	select PCI_GT64XXX_PCI0
 	select MIPS_MSC
+	select SMP_UP if SMP
 	select SWAP_IO_SPACE
 	select SYS_HAS_CPU_MIPS32_R1
 	select SYS_HAS_CPU_MIPS32_R2
diff --git a/arch/mips/mti-malta/malta-init.c b/arch/mips/mti-malta/malta-init.c
index 53c2478..571148c 100644
--- a/arch/mips/mti-malta/malta-init.c
+++ b/arch/mips/mti-malta/malta-init.c
@@ -302,6 +302,7 @@ mips_pci_controller:
 		return;
 	if (!register_vsmp_smp_ops())
 		return;
+	register_up_smp_ops();
 }
 
 void platform_early_l2_init(void)
-- 
2.5.3
