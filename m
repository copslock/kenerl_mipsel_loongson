Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 23 Aug 2017 20:22:57 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:52733 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23993958AbdHWSV6yi9nI (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 23 Aug 2017 20:21:58 +0200
Received: from hhmail02.hh.imgtec.org (unknown [10.100.10.20])
        by Forcepoint Email with ESMTPS id 5257C1398A59A;
        Wed, 23 Aug 2017 19:21:48 +0100 (IST)
Received: from localhost (10.20.1.88) by hhmail02.hh.imgtec.org (10.100.10.21)
 with Microsoft SMTP Server (TLS) id 14.3.294.0; Wed, 23 Aug 2017 19:21:52
 +0100
From:   Paul Burton <paul.burton@imgtec.com>
To:     <linux-mips@linux-mips.org>, Ralf Baechle <ralf@linux-mips.org>,
        <trivial@kernel.org>
CC:     Paul Burton <paul.burton@imgtec.com>
Subject: [PATCH 11/11] MIPS: Declare various variables & functions static
Date:   Wed, 23 Aug 2017 11:17:54 -0700
Message-ID: <20170823181754.24044-12-paul.burton@imgtec.com>
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
X-archive-position: 59787
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

We currently have various variables & functions which are only used
within a single translation unit, but which we don't declare static.
This causes various sparse warnings of the form:

  arch/mips/kernel/mips-r2-to-r6-emul.c:49:1: warning: symbol
    'mipsr2emustats' was not declared. Should it be static?

  arch/mips/kernel/unaligned.c:1381:11: warning: symbol 'reg16to32st'
    was not declared. Should it be static?

  arch/mips/mm/mmap.c:146:15: warning: symbol 'arch_mmap_rnd' was not
    declared. Should it be static?

Fix these & others by declaring various affected variables & functions
static, avoiding the sparse warnings & redundant symbols.

Signed-off-by: Paul Burton <paul.burton@imgtec.com>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: linux-mips@linux-mips.org

---

 arch/mips/kernel/cpu-probe.c          | 2 +-
 arch/mips/kernel/mips-r2-to-r6-emul.c | 6 +++---
 arch/mips/kernel/pm-cps.c             | 2 +-
 arch/mips/kernel/unaligned.c          | 2 +-
 arch/mips/mm/dma-default.c            | 4 ++--
 5 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/arch/mips/kernel/cpu-probe.c b/arch/mips/kernel/cpu-probe.c
index d08afc7dc507..17df18b87b9d 100644
--- a/arch/mips/kernel/cpu-probe.c
+++ b/arch/mips/kernel/cpu-probe.c
@@ -326,7 +326,7 @@ static int __init fpu_disable(char *s)
 
 __setup("nofpu", fpu_disable);
 
-int mips_dsp_disabled;
+static int mips_dsp_disabled;
 
 static int __init dsp_disable(char *s)
 {
diff --git a/arch/mips/kernel/mips-r2-to-r6-emul.c b/arch/mips/kernel/mips-r2-to-r6-emul.c
index ae64c8f56a8c..ac23b4f09f02 100644
--- a/arch/mips/kernel/mips-r2-to-r6-emul.c
+++ b/arch/mips/kernel/mips-r2-to-r6-emul.c
@@ -46,9 +46,9 @@
 #define LL	"ll "
 #define SC	"sc "
 
-DEFINE_PER_CPU(struct mips_r2_emulator_stats, mipsr2emustats);
-DEFINE_PER_CPU(struct mips_r2_emulator_stats, mipsr2bdemustats);
-DEFINE_PER_CPU(struct mips_r2br_emulator_stats, mipsr2bremustats);
+static DEFINE_PER_CPU(struct mips_r2_emulator_stats, mipsr2emustats);
+static DEFINE_PER_CPU(struct mips_r2_emulator_stats, mipsr2bdemustats);
+static DEFINE_PER_CPU(struct mips_r2br_emulator_stats, mipsr2bremustats);
 
 extern const unsigned int fpucondbit[8];
 
diff --git a/arch/mips/kernel/pm-cps.c b/arch/mips/kernel/pm-cps.c
index d99416094ba9..2121ed635824 100644
--- a/arch/mips/kernel/pm-cps.c
+++ b/arch/mips/kernel/pm-cps.c
@@ -49,7 +49,7 @@ static DEFINE_PER_CPU_READ_MOSTLY(cps_nc_entry_fn[CPS_PM_STATE_COUNT],
 				  nc_asm_enter);
 
 /* Bitmap indicating which states are supported by the system */
-DECLARE_BITMAP(state_support, CPS_PM_STATE_COUNT);
+static DECLARE_BITMAP(state_support, CPS_PM_STATE_COUNT);
 
 /*
  * Indicates the number of coupled VPEs ready to operate in a non-coherent
diff --git a/arch/mips/kernel/unaligned.c b/arch/mips/kernel/unaligned.c
index 5eaf2578ac04..2d0b912f9e3e 100644
--- a/arch/mips/kernel/unaligned.c
+++ b/arch/mips/kernel/unaligned.c
@@ -1378,7 +1378,7 @@ static void emulate_load_store_insn(struct pt_regs *regs,
 const int reg16to32[] = { 16, 17, 2, 3, 4, 5, 6, 7 };
 
 /* Recode table from 16-bit STORE register notation to 32-bit GPR. */
-const int reg16to32st[] = { 0, 17, 2, 3, 4, 5, 6, 7 };
+static const int reg16to32st[] = { 0, 17, 2, 3, 4, 5, 6, 7 };
 
 static void emulate_load_store_microMIPS(struct pt_regs *regs,
 					 void __user *addr)
diff --git a/arch/mips/mm/dma-default.c b/arch/mips/mm/dma-default.c
index 8e78251eccc2..81bd6b7b9282 100644
--- a/arch/mips/mm/dma-default.c
+++ b/arch/mips/mm/dma-default.c
@@ -409,12 +409,12 @@ static void mips_dma_sync_sg_for_device(struct device *dev,
 	}
 }
 
-int mips_dma_mapping_error(struct device *dev, dma_addr_t dma_addr)
+static int mips_dma_mapping_error(struct device *dev, dma_addr_t dma_addr)
 {
 	return 0;
 }
 
-int mips_dma_supported(struct device *dev, u64 mask)
+static int mips_dma_supported(struct device *dev, u64 mask)
 {
 	return plat_dma_supported(dev, mask);
 }
-- 
2.14.1
