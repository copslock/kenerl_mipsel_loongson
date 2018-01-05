Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 05 Jan 2018 11:32:44 +0100 (CET)
Received: from 9pmail.ess.barracuda.com ([64.235.150.225]:37555 "EHLO
        9pmail.ess.barracuda.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990435AbeAEKcQQvueu (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 5 Jan 2018 11:32:16 +0100
Received: from MIPSMAIL01.mipstec.com (mailrelay.mips.com [12.201.5.28]) by mx27.ess.sfj.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NO); Fri, 05 Jan 2018 10:32:04 +0000
Received: from mredfearn-linux.mipstec.com (10.150.130.83) by
 MIPSMAIL01.mipstec.com (10.20.43.31) with Microsoft SMTP Server (TLS) id
 14.3.361.1; Fri, 5 Jan 2018 02:32:02 -0800
From:   Matt Redfearn <matt.redfearn@mips.com>
To:     Ralf Baechle <ralf@linux-mips.org>,
        Thomas Gleixner <tglx@linutronix.de>
CC:     <linux-mips@linux-mips.org>,
        Matt Redfearn <matt.redfearn@mips.com>,
        Dengcheng Zhu <dengcheng.zhu@mips.com>,
        <linux-kernel@vger.kernel.org>, Paul Burton <paul.burton@mips.com>,
        Marc Zyngier <marc.zyngier@arm.com>
Subject: [PATCH 2/6] MIPS: CPS: Introduce mips_gic_enable_eic
Date:   Fri, 5 Jan 2018 10:31:06 +0000
Message-ID: <1515148270-9391-3-git-send-email-matt.redfearn@mips.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1515148270-9391-1-git-send-email-matt.redfearn@mips.com>
References: <1515148270-9391-1-git-send-email-matt.redfearn@mips.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.150.130.83]
X-BESS-ID: 1515148323-637137-12098-550431-1
X-BESS-VER: 2017.16-r1712230000
X-BESS-Apparent-Source-IP: 12.201.5.28
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.188674
        Rule breakdown below
         pts rule name              description
        ---- ---------------------- --------------------------------
        0.00 BSF_BESS_OUTBOUND      META: BESS Outbound 
X-BESS-Outbound-Spam-Status: SCORE=0.00 using account:ESS59374 scores of KILL_LEVEL=7.0 tests=BSF_BESS_OUTBOUND
X-BESS-BRTS-Status: 1
Return-Path: <Matt.Redfearn@mips.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 61906
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: matt.redfearn@mips.com
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

The MIPS GIC supports running in External Interrupt Controller (EIC)
mode, in which the GIC can raise up to 64 separate interrupts rather
than the usual 6. This mode is enabled by setting bit GIC_VL_CTL.EIC. If
the bit sticks, then EIC mode is present and becomes enabled. Otherwise
this bit is read-only 0 and setting it will have no effect.
The CP0 register Config3 bit VEIC indicates the status of EIC mode, and
effectively reflects GIC_VL_CTL.EIC. After attempting to enable EIC
mode, read back Config3.VEIC to determine if VEIC mode is present and
has been activated. If so, update the boot CPU flags to reflect that
VEIC mode is now active.

Signed-off-by: Matt Redfearn <matt.redfearn@mips.com>
---

 arch/mips/include/asm/mips-gic.h | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/arch/mips/include/asm/mips-gic.h b/arch/mips/include/asm/mips-gic.h
index 558059a8f218..b8345b117224 100644
--- a/arch/mips/include/asm/mips-gic.h
+++ b/arch/mips/include/asm/mips-gic.h
@@ -314,6 +314,28 @@ static inline bool mips_gic_present(void)
 	return IS_ENABLED(CONFIG_MIPS_GIC) && mips_gic_base;
 }
 
+
+/**
+ * mips_gic_enable_eic() - Enable EIC mode if supported
+ *
+ * Attempt to enable the GICs EIC mode if supported by the hardware.
+ * EIC is enabled via the GIC CTL register. If the bit sticks, then the mode
+ * is supported and active. CP0.Config3.VEIC reflects this state and is read
+ * to determine if the mode has successfully been activated. If it has, update
+ * the boot cpu flags such that cpu_has_veic reflects the new mode.
+ */
+static inline void mips_gic_enable_eic(void)
+{
+	set_gic_vl_ctl(GIC_VX_CTL_EIC);
+	mb();		/* Ensure write to GIC register completes */
+	ehb();		/* Ensure mfc0 does not start early */
+	if (read_c0_config3() & MIPS_CONF3_VEIC) {
+		/* GIC & CPU now in VEIC mode */
+		pr_debug("GIC EIC mode activated\n");
+		boot_cpu_data.options |= MIPS_CPU_VEIC;
+	}
+}
+
 /**
  * gic_get_c0_compare_int() - Return cp0 count/compare interrupt virq
  *
-- 
2.7.4
