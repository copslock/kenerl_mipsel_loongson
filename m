Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 02 Mar 2017 10:39:33 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:21170 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23993871AbdCBJhZvBV4t (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 2 Mar 2017 10:37:25 +0100
Received: from hhmail02.hh.imgtec.org (unknown [10.100.10.20])
        by Forcepoint Email with ESMTPS id CF315E94E8284;
        Thu,  2 Mar 2017 09:37:17 +0000 (GMT)
Received: from jhogan-linux.le.imgtec.org (192.168.154.110) by
 hhmail02.hh.imgtec.org (10.100.10.21) with Microsoft SMTP Server (TLS) id
 14.3.294.0; Thu, 2 Mar 2017 09:37:19 +0000
From:   James Hogan <james.hogan@imgtec.com>
To:     <linux-mips@linux-mips.org>, <kvm@vger.kernel.org>
CC:     James Hogan <james.hogan@imgtec.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>,
        Ralf Baechle <ralf@linux-mips.org>
Subject: [PATCH 4/32] MIPS: Probe guest MVH
Date:   Thu, 2 Mar 2017 09:36:31 +0000
Message-ID: <afc2f8cb8b899b0590e2392cf11e27e4e69b32fe.1488447004.git-series.james.hogan@imgtec.com>
X-Mailer: git-send-email 2.11.1
MIME-Version: 1.0
In-Reply-To: <cover.5cfb5298ebc2f5308f4f56aaac7fa31c39a8ab58.1488447004.git-series.james.hogan@imgtec.com>
References: <cover.5cfb5298ebc2f5308f4f56aaac7fa31c39a8ab58.1488447004.git-series.james.hogan@imgtec.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [192.168.154.110]
Return-Path: <James.Hogan@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 56964
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

Probe for availablility of M{T,F}HC0 instructions used with e.g. XPA in
the VZ guest context, and make it available via cpu_guest_has_mvh. This
will be helpful in properly emulating the MAAR registers in KVM for MIPS
VZ.

Signed-off-by: James Hogan <james.hogan@imgtec.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: "Radim Krčmář" <rkrcmar@redhat.com>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: linux-mips@linux-mips.org
Cc: kvm@vger.kernel.org
---
 arch/mips/include/asm/cpu-features.h | 3 +++
 arch/mips/kernel/cpu-probe.c         | 5 ++++-
 2 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/arch/mips/include/asm/cpu-features.h b/arch/mips/include/asm/cpu-features.h
index e898f441cc22..494d38274142 100644
--- a/arch/mips/include/asm/cpu-features.h
+++ b/arch/mips/include/asm/cpu-features.h
@@ -532,6 +532,9 @@
 #ifndef cpu_guest_has_htw
 #define cpu_guest_has_htw	(cpu_data[0].guest.options & MIPS_CPU_HTW)
 #endif
+#ifndef cpu_guest_has_mvh
+#define cpu_guest_has_mvh	(cpu_data[0].guest.options & MIPS_CPU_MVH)
+#endif
 #ifndef cpu_guest_has_msa
 #define cpu_guest_has_msa	(cpu_data[0].guest.ases & MIPS_ASE_MSA)
 #endif
diff --git a/arch/mips/kernel/cpu-probe.c b/arch/mips/kernel/cpu-probe.c
index 29dfdb64ad0b..c72a4cda389c 100644
--- a/arch/mips/kernel/cpu-probe.c
+++ b/arch/mips/kernel/cpu-probe.c
@@ -1057,7 +1057,7 @@ static inline unsigned int decode_guest_config5(struct cpuinfo_mips *c)
 	unsigned int config5, config5_dyn;
 
 	probe_gc0_config_dyn(config5, config5, config5_dyn,
-			 MIPS_CONF_M | MIPS_CONF5_MRP);
+			 MIPS_CONF_M | MIPS_CONF5_MVH | MIPS_CONF5_MRP);
 
 	if (config5 & MIPS_CONF5_MRP)
 		c->guest.options |= MIPS_CPU_MAAR;
@@ -1067,6 +1067,9 @@ static inline unsigned int decode_guest_config5(struct cpuinfo_mips *c)
 	if (config5 & MIPS_CONF5_LLB)
 		c->guest.options |= MIPS_CPU_RW_LLB;
 
+	if (config5 & MIPS_CONF5_MVH)
+		c->guest.options |= MIPS_CPU_MVH;
+
 	if (config5 & MIPS_CONF_M)
 		c->guest.conf |= BIT(6);
 	return config5 & MIPS_CONF_M;
-- 
git-series 0.8.10
