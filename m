Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 17 Apr 2015 11:45:05 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:38467 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27025679AbbDQJoaYfBUx (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 17 Apr 2015 11:44:30 +0200
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id 7E5A1F24941BC;
        Fri, 17 Apr 2015 10:44:24 +0100 (IST)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 KLMAIL01.kl.imgtec.org (192.168.5.35) with Microsoft SMTP Server (TLS) id
 14.3.195.1; Fri, 17 Apr 2015 10:44:26 +0100
Received: from jhogan-linux.le.imgtec.org (192.168.154.110) by
 LEMAIL01.le.imgtec.org (192.168.152.62) with Microsoft SMTP Server (TLS) id
 14.3.210.2; Fri, 17 Apr 2015 10:44:25 +0100
From:   James Hogan <james.hogan@imgtec.com>
To:     Ralf Baechle <ralf@linux-mips.org>,
        Andrew Bresticker <abrestic@chromium.org>
CC:     James Hartley <james.hartley@imgtec.com>,
        James Hogan <james.hogan@imgtec.com>,
        <linux-mips@linux-mips.org>
Subject: [PATCH 2/2] MIPS: Pistachio: Support CDMM & Fast Debug Channel
Date:   Fri, 17 Apr 2015 10:44:16 +0100
Message-ID: <1429263856-30471-3-git-send-email-james.hogan@imgtec.com>
X-Mailer: git-send-email 2.0.5
In-Reply-To: <1429263856-30471-1-git-send-email-james.hogan@imgtec.com>
References: <1429263856-30471-1-git-send-email-james.hogan@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.154.110]
Return-Path: <James.Hogan@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 46878
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

Implement the mips_cdmm_phys_base() platform callback to provide a
default Common Device Memory Map (CDMM) physical base address for the
Pistachio SoC. This allows the CDMM in each VPE to be configured and
probed for devices, such as the Fast Debug Channel (FDC).

The physical address chosen is just below the default CPC address, which
appears to also be unallocated.

The FDC IRQ is also usable on Pistachio, and is routed through the GIC,
so implement the get_c0_fdc_int() platform callback using
gic_get_c0_fdc_int(), so the FDC driver doesn't have to fall back to
polling.

Signed-off-by: James Hogan <james.hogan@imgtec.com>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: Andrew Bresticker <abrestic@chromium.org>
Cc: James Hartley <james.hartley@imgtec.com>
Cc: linux-mips@linux-mips.org
---
 arch/mips/pistachio/init.c | 8 +++++++-
 arch/mips/pistachio/time.c | 5 +++++
 2 files changed, 12 insertions(+), 1 deletion(-)

diff --git a/arch/mips/pistachio/init.c b/arch/mips/pistachio/init.c
index d2dc836523a3..8bd8ebb20a72 100644
--- a/arch/mips/pistachio/init.c
+++ b/arch/mips/pistachio/init.c
@@ -63,13 +63,19 @@ void __init plat_mem_setup(void)
 	plat_setup_iocoherency();
 }
 
-#define DEFAULT_CPC_BASE_ADDR 0x1bde0000
+#define DEFAULT_CPC_BASE_ADDR	0x1bde0000
+#define DEFAULT_CDMM_BASE_ADDR	0x1bdd0000
 
 phys_addr_t mips_cpc_default_phys_base(void)
 {
 	return DEFAULT_CPC_BASE_ADDR;
 }
 
+phys_addr_t mips_cdmm_phys_base(void)
+{
+	return DEFAULT_CDMM_BASE_ADDR;
+}
+
 static void __init mips_nmi_setup(void)
 {
 	void *base;
diff --git a/arch/mips/pistachio/time.c b/arch/mips/pistachio/time.c
index 67889fcea8aa..7c73fcb92a10 100644
--- a/arch/mips/pistachio/time.c
+++ b/arch/mips/pistachio/time.c
@@ -27,6 +27,11 @@ int get_c0_perfcount_int(void)
 	return gic_get_c0_perfcount_int();
 }
 
+int get_c0_fdc_int(void)
+{
+	return gic_get_c0_fdc_int();
+}
+
 void __init plat_time_init(void)
 {
 	struct device_node *np;
-- 
2.0.5
