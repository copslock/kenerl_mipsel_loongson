Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 14 Mar 2017 11:19:33 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:32640 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23994793AbdCNKSLTYwxU (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 14 Mar 2017 11:18:11 +0100
Received: from hhmail02.hh.imgtec.org (unknown [10.100.10.20])
        by Forcepoint Email with ESMTPS id 58B6511B8F5ED;
        Tue, 14 Mar 2017 10:18:02 +0000 (GMT)
Received: from jhogan-linux.le.imgtec.org (192.168.154.110) by
 hhmail02.hh.imgtec.org (10.100.10.21) with Microsoft SMTP Server (TLS) id
 14.3.294.0; Tue, 14 Mar 2017 10:18:04 +0000
From:   James Hogan <james.hogan@imgtec.com>
To:     <linux-mips@linux-mips.org>, <kvm@vger.kernel.org>
CC:     James Hogan <james.hogan@imgtec.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>
Subject: [PATCH v2 3/33] MIPS: Probe guest CP0_UserLocal
Date:   Tue, 14 Mar 2017 10:15:10 +0000
Message-ID: <8b5f3265efeeb0257c0aa00fe87ba480cc323d23.1489485940.git-series.james.hogan@imgtec.com>
X-Mailer: git-send-email 2.11.1
MIME-Version: 1.0
In-Reply-To: <cover.26e10ec77a4ed0d3177ccf4fabf57bc95ea030f8.1489485940.git-series.james.hogan@imgtec.com>
References: <cover.26e10ec77a4ed0d3177ccf4fabf57bc95ea030f8.1489485940.git-series.james.hogan@imgtec.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [192.168.154.110]
Return-Path: <James.Hogan@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 57203
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

Probe for presence of guest CP0_UserLocal register and expose via
cpu_guest_has_userlocal. This register is optional pre-r6, so this will
allow KVM to only save/restore/expose the guest CP0_UserLocal register
if it exists.

Signed-off-by: James Hogan <james.hogan@imgtec.com>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: "Radim Krčmář" <rkrcmar@redhat.com>
Cc: linux-mips@linux-mips.org
Cc: kvm@vger.kernel.org
---
 arch/mips/include/asm/cpu-features.h | 3 +++
 arch/mips/kernel/cpu-probe.c         | 6 +++++-
 2 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/arch/mips/include/asm/cpu-features.h b/arch/mips/include/asm/cpu-features.h
index e12d4ec6854d..e898f441cc22 100644
--- a/arch/mips/include/asm/cpu-features.h
+++ b/arch/mips/include/asm/cpu-features.h
@@ -547,6 +547,9 @@
 #ifndef cpu_guest_has_maar
 #define cpu_guest_has_maar	(cpu_data[0].guest.options & MIPS_CPU_MAAR)
 #endif
+#ifndef cpu_guest_has_userlocal
+#define cpu_guest_has_userlocal	(cpu_data[0].guest.options & MIPS_CPU_ULRI)
+#endif
 
 /*
  * Guest dynamic capabilities
diff --git a/arch/mips/kernel/cpu-probe.c b/arch/mips/kernel/cpu-probe.c
index 708f5913a8fe..29dfdb64ad0b 100644
--- a/arch/mips/kernel/cpu-probe.c
+++ b/arch/mips/kernel/cpu-probe.c
@@ -1005,7 +1005,8 @@ static inline unsigned int decode_guest_config3(struct cpuinfo_mips *c)
 	unsigned int config3, config3_dyn;
 
 	probe_gc0_config_dyn(config3, config3, config3_dyn,
-			     MIPS_CONF_M | MIPS_CONF3_MSA | MIPS_CONF3_CTXTC);
+			     MIPS_CONF_M | MIPS_CONF3_MSA | MIPS_CONF3_ULRI |
+			     MIPS_CONF3_CTXTC);
 
 	if (config3 & MIPS_CONF3_CTXTC)
 		c->guest.options |= MIPS_CPU_CTXTC;
@@ -1015,6 +1016,9 @@ static inline unsigned int decode_guest_config3(struct cpuinfo_mips *c)
 	if (config3 & MIPS_CONF3_PW)
 		c->guest.options |= MIPS_CPU_HTW;
 
+	if (config3 & MIPS_CONF3_ULRI)
+		c->guest.options |= MIPS_CPU_ULRI;
+
 	if (config3 & MIPS_CONF3_SC)
 		c->guest.options |= MIPS_CPU_SEGMENTS;
 
-- 
git-series 0.8.10
