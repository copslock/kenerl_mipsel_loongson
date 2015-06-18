Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 18 Jun 2015 16:05:36 +0200 (CEST)
Received: from mail-pa0-f51.google.com ([209.85.220.51]:33148 "EHLO
        mail-pa0-f51.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27008525AbbFROFd6H5uP (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 18 Jun 2015 16:05:33 +0200
Received: by padev16 with SMTP id ev16so62253238pad.0;
        Thu, 18 Jun 2015 07:05:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:mime-version:content-type
         :content-disposition:user-agent;
        bh=UNmhsRjQS6SKIstEzdYRGEVtenkCwBrDTfBeJmUDMzk=;
        b=ziAK4tujSgqtFVEqvFLQ/lljPkuF+KHSBnQcMZ7czJjVAzMPBzSVSTuS7FG8ZaZTbC
         EruXxRfo/e1XYHlkeTwHBHH40v+8oAfJtu/G84FJS+rQTkfAPOeRfqY5E9hOu3GWyLtC
         wC5LOmRAMBbnTODjI9thLW/Olpv5AyNnNgP9kdgIb80Lrgf086QoyQJH/99E1C13CwK0
         Xdte6tkqgCLIeHj2VDvDNqKddgoWPVxJwAqq08taw5OUcufS7id3Xv2xVDfPm0HRAX3z
         dMdDL38VwVxRrXIzt8u9YAQP/40hWN4UksKZAyiJkPFwQnb+OAYPrL41aIVJ26LvNHCb
         Z0wA==
X-Received: by 10.66.236.226 with SMTP id ux2mr21949383pac.64.1434636327579;
        Thu, 18 Jun 2015 07:05:27 -0700 (PDT)
Received: from yggdrasil (114-25-189-158.dynamic.hinet.net. [114.25.189.158])
        by mx.google.com with ESMTPSA id mb4sm8232360pdb.63.2015.06.18.07.05.25
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 18 Jun 2015 07:05:26 -0700 (PDT)
Date:   Thu, 18 Jun 2015 22:05:21 +0800
From:   Tony Wu <tung7970@gmail.com>
To:     linux-mips@linux-mips.org, ralf@linux-mips.org
Cc:     James Hogan <james.hogan@imgtec.com>,
        Paul Burton <paul.burton@imgtec.com>
Subject: [PATCH] MIPS: Add platform specific secondary core init
Message-ID: <20150618220254-tung7970@googlemail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.23 (2014-03-12)
Return-Path: <tung7970@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 47966
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: tung7970@gmail.com
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

Define plat_smp_init_secondary() API, and move platform specific
secondary core initialization to each platform.

Signed-off-by: Tony Wu <tung7970@gmail.com>
Cc: James Hogan <james.hogan@imgtec.com>
Cc: Paul Burton <paul.burton@imgtec.com>
Cc: linux-mips@linux-mips.org
---
 arch/mips/include/asm/smp-ops.h  |    1 +
 arch/mips/kernel/smp-cmp.c       |    8 ++------
 arch/mips/kernel/smp-cps.c       |    4 ++--
 arch/mips/kernel/smp-mt.c        |   12 ++----------
 arch/mips/mti-malta/malta-init.c |   13 +++++++++++++
 5 files changed, 20 insertions(+), 18 deletions(-)

diff --git a/arch/mips/include/asm/smp-ops.h b/arch/mips/include/asm/smp-ops.h
index 6ba1fb8..53ce7e1 100644
--- a/arch/mips/include/asm/smp-ops.h
+++ b/arch/mips/include/asm/smp-ops.h
@@ -36,6 +36,7 @@ struct plat_smp_ops {
 };
 
 extern void register_smp_ops(struct plat_smp_ops *ops);
+extern void plat_smp_init_secondary(void)
 
 static inline void plat_smp_setup(void)
 {
diff --git a/arch/mips/kernel/smp-cmp.c b/arch/mips/kernel/smp-cmp.c
index d5e0f94..e8c0258 100644
--- a/arch/mips/kernel/smp-cmp.c
+++ b/arch/mips/kernel/smp-cmp.c
@@ -43,17 +43,13 @@ static void cmp_init_secondary(void)
 {
 	struct cpuinfo_mips *c __maybe_unused = &current_cpu_data;
 
-	/* Assume GIC is present */
-	change_c0_status(ST0_IM, STATUSF_IP2 | STATUSF_IP3 | STATUSF_IP4 |
-				 STATUSF_IP5 | STATUSF_IP6 | STATUSF_IP7);
-
-	/* Enable per-cpu interrupts: platform specific */
-
 #ifdef CONFIG_MIPS_MT_SMP
 	if (cpu_has_mipsmt)
 		c->vpe_id = (read_c0_tcbind() >> TCBIND_CURVPE_SHIFT) &
 			TCBIND_CURVPE;
 #endif
+	/* Call platform specific init secondary */
+	plat_smp_init_secondary();
 }
 
 static void cmp_smp_finish(void)
diff --git a/arch/mips/kernel/smp-cps.c b/arch/mips/kernel/smp-cps.c
index 4251d39..5570bc8 100644
--- a/arch/mips/kernel/smp-cps.c
+++ b/arch/mips/kernel/smp-cps.c
@@ -279,8 +279,8 @@ static void cps_init_secondary(void)
 	if (cpu_has_mipsmt)
 		dmt();
 
-	change_c0_status(ST0_IM, STATUSF_IP2 | STATUSF_IP3 | STATUSF_IP4 |
-				 STATUSF_IP5 | STATUSF_IP6 | STATUSF_IP7);
+	/* Call platform specific init secondary */
+	plat_smp_init_secondary();
 }
 
 static void cps_smp_finish(void)
diff --git a/arch/mips/kernel/smp-mt.c b/arch/mips/kernel/smp-mt.c
index 86311a1..3d1e32a 100644
--- a/arch/mips/kernel/smp-mt.c
+++ b/arch/mips/kernel/smp-mt.c
@@ -158,16 +158,8 @@ static void vsmp_send_ipi_mask(const struct cpumask *mask, unsigned int action)
 
 static void vsmp_init_secondary(void)
 {
-#ifdef CONFIG_MIPS_GIC
-	/* This is Malta specific: IPI,performance and timer interrupts */
-	if (gic_present)
-		change_c0_status(ST0_IM, STATUSF_IP2 | STATUSF_IP3 |
-					 STATUSF_IP4 | STATUSF_IP5 |
-					 STATUSF_IP6 | STATUSF_IP7);
-	else
-#endif
-		change_c0_status(ST0_IM, STATUSF_IP0 | STATUSF_IP1 |
-					 STATUSF_IP6 | STATUSF_IP7);
+	/* Call platform specific init secondary */
+	plat_smp_init_secondary();
 }
 
 static void vsmp_smp_finish(void)
diff --git a/arch/mips/mti-malta/malta-init.c b/arch/mips/mti-malta/malta-init.c
index cec3e18..3385ad9 100644
--- a/arch/mips/mti-malta/malta-init.c
+++ b/arch/mips/mti-malta/malta-init.c
@@ -116,6 +116,19 @@ phys_addr_t mips_cpc_default_phys_base(void)
 	return CPC_BASE_ADDR;
 }
 
+void plat_smp_init_secondary(void)
+{
+#ifdef CONFIG_MIPS_GIC
+	if (gic_present)
+		change_c0_status(ST0_IM, STATUSF_IP2 | STATUSF_IP3 |
+					 STATUSF_IP4 | STATUSF_IP5 |
+					 STATUSF_IP6 | STATUSF_IP7);
+	else
+#endif
+		change_c0_status(ST0_IM, STATUSF_IP0 | STATUSF_IP1 |
+					 STATUSF_IP6 | STATUSF_IP7);
+}
+
 void __init prom_init(void)
 {
 	mips_display_message("LINUX");
-- 
1.7.5
