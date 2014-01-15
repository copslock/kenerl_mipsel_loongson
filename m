Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 15 Jan 2014 11:37:16 +0100 (CET)
Received: from multi.imgtec.com ([194.200.65.239]:9565 "EHLO multi.imgtec.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6827443AbaAOKhOpF9Yd (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 15 Jan 2014 11:37:14 +0100
From:   Paul Burton <paul.burton@imgtec.com>
To:     <linux-mips@linux-mips.org>
CC:     Paul Burton <paul.burton@imgtec.com>
Subject: [PATCH 10/15] MIPS: Malta: probe CPC when supported
Date:   Wed, 15 Jan 2014 10:31:55 +0000
Message-ID: <1389781920-31151-11-git-send-email-paul.burton@imgtec.com>
X-Mailer: git-send-email 1.7.12.4
In-Reply-To: <1389781920-31151-1-git-send-email-paul.burton@imgtec.com>
References: <1389781920-31151-1-git-send-email-paul.burton@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.152.22]
X-SEF-Processed: 7_3_0_01192__2014_01_15_10_37_09
Return-Path: <Paul.Burton@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 38993
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

When CPC support is compiled into the kernel (ie. CONFIG_MIPS_CPC=y),
probe the CPC on boot for Malta in order to allow any users of the CPC
to detect its presence & function correctly.

Signed-off-by: Paul Burton <paul.burton@imgtec.com>
---
 arch/mips/include/asm/mips-boards/malta.h | 5 +++++
 arch/mips/mti-malta/malta-init.c          | 7 +++++++
 2 files changed, 12 insertions(+)

diff --git a/arch/mips/include/asm/mips-boards/malta.h b/arch/mips/include/asm/mips-boards/malta.h
index 722bc88..fd97742 100644
--- a/arch/mips/include/asm/mips-boards/malta.h
+++ b/arch/mips/include/asm/mips-boards/malta.h
@@ -64,6 +64,11 @@ static inline unsigned long get_msc_port_base(unsigned long reg)
 #define GIC_ADDRSPACE_SZ		(128 * 1024)
 
 /*
+ * CPC Specific definitions
+ */
+#define CPC_BASE_ADDR			0x1bde0000
+
+/*
  * MSC01 BIU Specific definitions
  * FIXME : These should be elsewhere ?
  */
diff --git a/arch/mips/mti-malta/malta-init.c b/arch/mips/mti-malta/malta-init.c
index 85a62b0..1381365 100644
--- a/arch/mips/mti-malta/malta-init.c
+++ b/arch/mips/mti-malta/malta-init.c
@@ -21,6 +21,7 @@
 #include <asm/traps.h>
 #include <asm/fw/fw.h>
 #include <asm/mips-cm.h>
+#include <asm/mips-cpc.h>
 #include <asm/mips-boards/generic.h>
 #include <asm/mips-boards/malta.h>
 
@@ -110,6 +111,11 @@ static void __init mips_ejtag_setup(void)
 	flush_icache_range((unsigned long)base, (unsigned long)base + 0x80);
 }
 
+phys_t mips_cpc_default_phys_base(void)
+{
+	return CPC_BASE_ADDR;
+}
+
 extern struct plat_smp_ops msmtc_smp_ops;
 
 void __init prom_init(void)
@@ -277,6 +283,7 @@ mips_pci_controller:
 #endif
 	/* Early detection of CMP support */
 	mips_cm_probe();
+	mips_cpc_probe();
 
 	if (!register_cmp_smp_ops())
 		return;
-- 
1.8.4.2
