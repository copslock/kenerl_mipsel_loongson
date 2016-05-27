Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 27 May 2016 23:25:58 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:16345 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27036603AbcE0VZkAmlx8 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 27 May 2016 23:25:40 +0200
Received: from hhmail02.hh.imgtec.org (unknown [10.100.10.20])
        by Websense Email with ESMTPS id EED25E904ECA1;
        Fri, 27 May 2016 22:25:28 +0100 (IST)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 hhmail02.hh.imgtec.org (10.100.10.20) with Microsoft SMTP Server (TLS) id
 14.3.294.0; Fri, 27 May 2016 22:25:33 +0100
Received: from jhogan-linux.le.imgtec.org (192.168.154.110) by
 LEMAIL01.le.imgtec.org (192.168.152.62) with Microsoft SMTP Server (TLS) id
 14.3.266.1; Fri, 27 May 2016 22:25:33 +0100
From:   James Hogan <james.hogan@imgtec.com>
To:     Ralf Baechle <ralf@linux-mips.org>
CC:     James Hogan <james.hogan@imgtec.com>,
        Paul Burton <paul.burton@imgtec.com>,
        <linux-mips@linux-mips.org>
Subject: [PATCH 1/2] MIPS: Add 64-bit HTW fields
Date:   Fri, 27 May 2016 22:25:22 +0100
Message-ID: <1464384323-4520-2-git-send-email-james.hogan@imgtec.com>
X-Mailer: git-send-email 2.4.10
In-Reply-To: <1464384323-4520-1-git-send-email-james.hogan@imgtec.com>
References: <1464384323-4520-1-git-send-email-james.hogan@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.154.110]
Return-Path: <James.Hogan@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 53678
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: james.hogan@imgtec.com
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

Add field definitions for some of the 64-bit specific Hardware page
Table Walker (HTW) register fields in PWSize and PWCtl, in preparation
for fixing the 64-bit HTW configuration.

Also print these fields out along with the others in print_htw_config().

Signed-off-by: James Hogan <james.hogan@imgtec.com>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: Paul Burton <paul.burton@imgtec.com>
Cc: linux-mips@linux-mips.org
---
 arch/mips/include/asm/mipsregs.h | 8 ++++++++
 arch/mips/mm/tlbex.c             | 8 ++++++--
 2 files changed, 14 insertions(+), 2 deletions(-)

diff --git a/arch/mips/include/asm/mipsregs.h b/arch/mips/include/asm/mipsregs.h
index 3a062ae933a4..e1ca65c62f6a 100644
--- a/arch/mips/include/asm/mipsregs.h
+++ b/arch/mips/include/asm/mipsregs.h
@@ -729,6 +729,8 @@
 #define MIPS_PWFIELD_PTEI_SHIFT	0
 #define MIPS_PWFIELD_PTEI_MASK	0x0000003f
 
+#define MIPS_PWSIZE_PS_SHIFT	30
+#define MIPS_PWSIZE_PS_MASK	0x40000000
 #define MIPS_PWSIZE_GDW_SHIFT	24
 #define MIPS_PWSIZE_GDW_MASK	0x3f000000
 #define MIPS_PWSIZE_UDW_SHIFT	18
@@ -742,6 +744,12 @@
 
 #define MIPS_PWCTL_PWEN_SHIFT	31
 #define MIPS_PWCTL_PWEN_MASK	0x80000000
+#define MIPS_PWCTL_XK_SHIFT	28
+#define MIPS_PWCTL_XK_MASK	0x10000000
+#define MIPS_PWCTL_XS_SHIFT	27
+#define MIPS_PWCTL_XS_MASK	0x08000000
+#define MIPS_PWCTL_XU_SHIFT	26
+#define MIPS_PWCTL_XU_MASK	0x04000000
 #define MIPS_PWCTL_DPH_SHIFT	7
 #define MIPS_PWCTL_DPH_MASK	0x00000080
 #define MIPS_PWCTL_HUGEPG_SHIFT	6
diff --git a/arch/mips/mm/tlbex.c b/arch/mips/mm/tlbex.c
index 274da90adf0d..c363890368cd 100644
--- a/arch/mips/mm/tlbex.c
+++ b/arch/mips/mm/tlbex.c
@@ -2361,8 +2361,9 @@ static void print_htw_config(void)
 		(config & MIPS_PWFIELD_PTEI_MASK) >> MIPS_PWFIELD_PTEI_SHIFT);
 
 	config = read_c0_pwsize();
-	pr_debug("PWSize  (0x%0*lx): GDW: 0x%02lx  UDW: 0x%02lx  MDW: 0x%02lx  PTW: 0x%02lx  PTEW: 0x%02lx\n",
+	pr_debug("PWSize  (0x%0*lx): PS: 0x%lx  GDW: 0x%02lx  UDW: 0x%02lx  MDW: 0x%02lx  PTW: 0x%02lx  PTEW: 0x%02lx\n",
 		field, config,
+		(config & MIPS_PWSIZE_PS_MASK) >> MIPS_PWSIZE_PS_SHIFT,
 		(config & MIPS_PWSIZE_GDW_MASK) >> MIPS_PWSIZE_GDW_SHIFT,
 		(config & MIPS_PWSIZE_UDW_MASK) >> MIPS_PWSIZE_UDW_SHIFT,
 		(config & MIPS_PWSIZE_MDW_MASK) >> MIPS_PWSIZE_MDW_SHIFT,
@@ -2370,9 +2371,12 @@ static void print_htw_config(void)
 		(config & MIPS_PWSIZE_PTEW_MASK) >> MIPS_PWSIZE_PTEW_SHIFT);
 
 	pwctl = read_c0_pwctl();
-	pr_debug("PWCtl   (0x%x): PWEn: 0x%x  DPH: 0x%x  HugePg: 0x%x  Psn: 0x%x\n",
+	pr_debug("PWCtl   (0x%x): PWEn: 0x%x  XK: 0x%x  XS: 0x%x  XU: 0x%x  DPH: 0x%x  HugePg: 0x%x  Psn: 0x%x\n",
 		pwctl,
 		(pwctl & MIPS_PWCTL_PWEN_MASK) >> MIPS_PWCTL_PWEN_SHIFT,
+		(pwctl & MIPS_PWCTL_XK_MASK) >> MIPS_PWCTL_XK_SHIFT,
+		(pwctl & MIPS_PWCTL_XS_MASK) >> MIPS_PWCTL_XS_SHIFT,
+		(pwctl & MIPS_PWCTL_XU_MASK) >> MIPS_PWCTL_XU_SHIFT,
 		(pwctl & MIPS_PWCTL_DPH_MASK) >> MIPS_PWCTL_DPH_SHIFT,
 		(pwctl & MIPS_PWCTL_HUGEPG_MASK) >> MIPS_PWCTL_HUGEPG_SHIFT,
 		(pwctl & MIPS_PWCTL_PSN_MASK) >> MIPS_PWCTL_PSN_SHIFT);
-- 
2.4.10
