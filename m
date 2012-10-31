Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 31 Oct 2012 14:01:01 +0100 (CET)
Received: from mms2.broadcom.com ([216.31.210.18]:2729 "EHLO mms2.broadcom.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6825874Ab2JaM6vUsZhr (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 31 Oct 2012 13:58:51 +0100
Received: from [10.9.200.133] by mms2.broadcom.com with ESMTP (Broadcom
 SMTP Relay (Email Firewall v6.5)); Wed, 31 Oct 2012 05:56:51 -0700
X-Server-Uuid: 4500596E-606A-40F9-852D-14843D8201B2
Received: from mail-irva-13.broadcom.com (10.11.16.103) by
 IRVEXCHHUB02.corp.ad.broadcom.com (10.9.200.133) with Microsoft SMTP
 Server id 8.2.247.2; Wed, 31 Oct 2012 05:58:09 -0700
Received: from netl-snoppy.ban.broadcom.com (
 netl-snoppy.ban.broadcom.com [10.132.128.129]) by
 mail-irva-13.broadcom.com (Postfix) with ESMTP id C0F9040FE6; Wed, 31
 Oct 2012 05:58:37 -0700 (PDT)
From:   "Jayachandran C" <jchandra@broadcom.com>
To:     linux-mips@linux-mips.org, ralf@linux-mips.org
cc:     "Jayachandran C" <jchandra@broadcom.com>
Subject: [PATCH 10/15] MIPS: Netlogic: Update PIC access functions
Date:   Wed, 31 Oct 2012 18:31:36 +0530
Message-ID: <36ca792088f562ae1e4506e1f8ac21f8b914c7d5.1351688140.git.jchandra@broadcom.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <cover.1351688140.git.jchandra@broadcom.com>
References: <cover.1351688140.git.jchandra@broadcom.com>
MIME-Version: 1.0
X-WSS-ID: 7C8FFF993QC1968438-01-01
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-archive-position: 34802
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jchandra@broadcom.com
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
Return-Path: <linux-mips-bounce@linux-mips.org>

Remove unused and trivial PIC accesss functions, update nlm_pic_send_ipi()
and nlm_set_irt_to_cpu() to use similar logic, and use correct type for
reg in nlm_pic_disable_irt().

Signed-off-by: Jayachandran C <jchandra@broadcom.com>
---
 arch/mips/include/asm/netlogic/xlp-hal/pic.h |   40 +++++---------------------
 1 file changed, 7 insertions(+), 33 deletions(-)

diff --git a/arch/mips/include/asm/netlogic/xlp-hal/pic.h b/arch/mips/include/asm/netlogic/xlp-hal/pic.h
index 49ee15c..061e071 100644
--- a/arch/mips/include/asm/netlogic/xlp-hal/pic.h
+++ b/arch/mips/include/asm/netlogic/xlp-hal/pic.h
@@ -273,36 +273,16 @@ nlm_pic_read_irt(uint64_t base, int irt_index)
 	return nlm_read_pic_reg(base, PIC_IRT(irt_index));
 }
 
-static inline uint64_t
-nlm_pic_read_control(uint64_t base)
-{
-	return nlm_read_pic_reg(base, PIC_CTRL);
-}
-
-static inline void
-nlm_pic_write_control(uint64_t base, uint64_t control)
-{
-	nlm_write_pic_reg(base, PIC_CTRL, control);
-}
-
-static inline void
-nlm_pic_update_control(uint64_t base, uint64_t control)
-{
-	uint64_t val;
-
-	val = nlm_read_pic_reg(base, PIC_CTRL);
-	nlm_write_pic_reg(base, PIC_CTRL, control | val);
-}
-
 static inline void
 nlm_set_irt_to_cpu(uint64_t base, int irt, int cpu)
 {
 	uint64_t val;
 
 	val = nlm_read_pic_reg(base, PIC_IRT(irt));
-	val |= cpu & 0xf;
-	if (cpu > 15)
-		val |= 1 << 16;
+	/* clear cpuset and mask */
+	val &= ~((0x7ull << 16) | 0xffff);
+	/* set DB, cpuset and cpumask */
+	val |= (1 << 19) | ((cpu >> 4) << 16) | (1 << (cpu & 0xf));
 	nlm_write_pic_reg(base, PIC_IRT(irt), val);
 }
 
@@ -369,7 +349,7 @@ nlm_pic_enable_irt(uint64_t base, int irt)
 static inline void
 nlm_pic_disable_irt(uint64_t base, int irt)
 {
-	uint32_t reg;
+	uint64_t reg;
 
 	reg = nlm_read_pic_reg(base, PIC_IRT(irt));
 	nlm_write_pic_reg(base, PIC_IRT(irt), reg & ~((uint64_t)1 << 31));
@@ -379,15 +359,9 @@ static inline void
 nlm_pic_send_ipi(uint64_t base, int hwt, int irq, int nmi)
 {
 	uint64_t ipi;
-	int	node, ncpu;
-
-	node = hwt / 32;
-	ncpu = hwt & 0x1f;
-	ipi = ((uint64_t)nmi << 31) | (irq << 20) | (node << 17) |
-		(1 << (ncpu & 0xf));
-	if (ncpu > 15)
-		ipi |= 0x10000; /* Setting bit 16 to select cpus 16-31 */
 
+	ipi = (nmi << 31) | (irq << 20);
+	ipi |= ((hwt >> 4) << 16) | (1 << (hwt & 0xf)); /* cpuset and mask */
 	nlm_write_pic_reg(base, PIC_IPI_CTL, ipi);
 }
 
-- 
1.7.9.5
