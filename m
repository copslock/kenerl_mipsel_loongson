Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 21 Mar 2017 15:39:41 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:44599 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23993883AbdCUOjedVCe6 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 21 Mar 2017 15:39:34 +0100
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Forcepoint Email with ESMTPS id C0A56CA5BF75B;
        Tue, 21 Mar 2017 14:39:24 +0000 (GMT)
Received: from mredfearn-linux.le.imgtec.org (10.150.130.83) by
 HHMAIL01.hh.imgtec.org (10.100.10.21) with Microsoft SMTP Server (TLS) id
 14.3.294.0; Tue, 21 Mar 2017 14:39:27 +0000
From:   Matt Redfearn <matt.redfearn@imgtec.com>
To:     Ralf Baechle <ralf@linux-mips.org>
CC:     <linux-mips@linux-mips.org>,
        Matt Redfearn <matt.redfearn@imgtec.com>,
        <linux-kernel@vger.kernel.org>,
        Paul Burton <paul.burton@imgtec.com>
Subject: [PATCH] MIPS: smp-cps: Fix retrieval of VPE mask on big endian CPUs
Date:   Tue, 21 Mar 2017 14:39:19 +0000
Message-ID: <1490107159-2659-1-git-send-email-matt.redfearn@imgtec.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.150.130.83]
Return-Path: <Matt.Redfearn@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 57402
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

The vpe_mask member of struct core_boot_config is of type atomic_t,
which is a 32bit type. In cps-vec.S this member was being retrieved by a
PTR_L macro, which on 64bit systems is a 64bit load. On little endian
systems this is OK, since the double word that is retrieved will have
the required less significant word in the correct position. However, on
big endian systems the less significant word of the load is retrieved
from address+4, and the more significant from address+0. The destination
register therefore ends up with the required word in the more
significant word
e.g. when starting the second VP of a big endian 64bit system, the load

PTR_L    ta2, COREBOOTCFG_VPEMASK(a0)

ends up setting register ta2 to 0x0000000300000000

When this value is written to the CPC it is ignored, since it is
invalid to write anything larger than 4 bits. This results in any VP
other than VP0 in a core failing to start in 64bit big endian systems.

Change the load to a 32bit load word instruction to fix the bug.

Fixes: f12401d7219f ("MIPS: smp-cps: Pull boot config retrieval out of mips_cps_boot_vpes")
Signed-off-by: Matt Redfearn <matt.redfearn@imgtec.com>

---

 arch/mips/kernel/cps-vec.S | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/mips/kernel/cps-vec.S b/arch/mips/kernel/cps-vec.S
index 59476a607add..a00e87b0256d 100644
--- a/arch/mips/kernel/cps-vec.S
+++ b/arch/mips/kernel/cps-vec.S
@@ -361,7 +361,7 @@ LEAF(mips_cps_get_bootcfg)
 	END(mips_cps_get_bootcfg)
 
 LEAF(mips_cps_boot_vpes)
-	PTR_L	ta2, COREBOOTCFG_VPEMASK(a0)
+	lw	ta2, COREBOOTCFG_VPEMASK(a0)
 	PTR_L	ta3, COREBOOTCFG_VPECONFIG(a0)
 
 #if defined(CONFIG_CPU_MIPSR6)
-- 
2.7.4
