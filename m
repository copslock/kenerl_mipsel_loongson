Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 23 Jan 2017 15:08:36 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:2714 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23992123AbdAWOIYuLV4F (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 23 Jan 2017 15:08:24 +0100
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Forcepoint Email with ESMTPS id 550722B62F7;
        Mon, 23 Jan 2017 14:08:15 +0000 (GMT)
Received: from mredfearn-linux.le.imgtec.org (10.150.130.83) by
 HHMAIL01.hh.imgtec.org (10.100.10.21) with Microsoft SMTP Server (TLS) id
 14.3.294.0; Mon, 23 Jan 2017 14:08:18 +0000
From:   Matt Redfearn <matt.redfearn@imgtec.com>
To:     Ralf Baechle <ralf@linux-mips.org>
CC:     <linux-mips@linux-mips.org>,
        Matt Redfearn <matt.redfearn@imgtec.com>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH] MIPS: Generic: Fix big endian CPUs on generic machine
Date:   Mon, 23 Jan 2017 14:08:13 +0000
Message-ID: <1485180493-22949-1-git-send-email-matt.redfearn@imgtec.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.150.130.83]
Return-Path: <Matt.Redfearn@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 56469
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

Big endian CPUs require SWAP_IO_SPACE enabled to swap accesses to little
endian peripherals.

Without this patch, big endian kernels fail to communicate with little
endian periperals, such as PCI devices, on QEMU and FPGA based
platforms.

Signed-off-by: Matt Redfearn <matt.redfearn@imgtec.com>
Fixes: eed0eabd12ef ("MIPS: generic: Introduce generic DT-based board support")

---

 arch/mips/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index b3c5bde43d34..82dff20edaf9 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -94,6 +94,7 @@ config MIPS_GENERIC
 	select PCI_DRIVERS_GENERIC
 	select PINCTRL
 	select SMP_UP if SMP
+	select SWAP_IO_SPACE
 	select SYS_HAS_CPU_MIPS32_R1
 	select SYS_HAS_CPU_MIPS32_R2
 	select SYS_HAS_CPU_MIPS32_R6
-- 
2.7.4
