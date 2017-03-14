Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 14 Mar 2017 11:18:37 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:8617 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23994786AbdCNKSGX0fmU (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 14 Mar 2017 11:18:06 +0100
Received: from hhmail02.hh.imgtec.org (unknown [10.100.10.20])
        by Forcepoint Email with ESMTPS id 3CECE4D48FBCA;
        Tue, 14 Mar 2017 10:17:57 +0000 (GMT)
Received: from jhogan-linux.le.imgtec.org (192.168.154.110) by
 hhmail02.hh.imgtec.org (10.100.10.21) with Microsoft SMTP Server (TLS) id
 14.3.294.0; Tue, 14 Mar 2017 10:17:59 +0000
From:   James Hogan <james.hogan@imgtec.com>
To:     <linux-mips@linux-mips.org>, <kvm@vger.kernel.org>
CC:     James Hogan <james.hogan@imgtec.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@imgtec.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>
Subject: [PATCH v2 1/33] MIPS: Add defs & probing of UFR
Date:   Tue, 14 Mar 2017 10:15:08 +0000
Message-ID: <b8af4d2922b177d08bc5dc111931b177805f6c54.1489485940.git-series.james.hogan@imgtec.com>
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
X-archive-position: 57201
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

Add definitions and probing of the UFR bit in Config5. This bit allows
user mode control of the FR bit (floating point register mode). It is
present if the UFRP bit is set in the floating point implementation
register.

This is a capability KVM may want to expose to guest kernels, even
though Linux is unlikely to ever use it due to the implications for
multi-threaded programs.

Signed-off-by: James Hogan <james.hogan@imgtec.com>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: Paul Burton <paul.burton@imgtec.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: "Radim Krčmář" <rkrcmar@redhat.com>
Cc: linux-mips@linux-mips.org
Cc: kvm@vger.kernel.org
---
 arch/mips/include/asm/cpu-features.h | 4 ++++
 arch/mips/include/asm/cpu.h          | 1 +
 arch/mips/kernel/cpu-probe.c         | 2 ++
 3 files changed, 7 insertions(+), 0 deletions(-)

diff --git a/arch/mips/include/asm/cpu-features.h b/arch/mips/include/asm/cpu-features.h
index e961c8a7ea66..e12d4ec6854d 100644
--- a/arch/mips/include/asm/cpu-features.h
+++ b/arch/mips/include/asm/cpu-features.h
@@ -444,6 +444,10 @@
 # define cpu_has_msa		0
 #endif
 
+#ifndef cpu_has_ufr
+# define cpu_has_ufr		(cpu_data[0].options & MIPS_CPU_UFR)
+#endif
+
 #ifndef cpu_has_fre
 # define cpu_has_fre		(cpu_data[0].options & MIPS_CPU_FRE)
 #endif
diff --git a/arch/mips/include/asm/cpu.h b/arch/mips/include/asm/cpu.h
index 9a8372484edc..98f59307e6a3 100644
--- a/arch/mips/include/asm/cpu.h
+++ b/arch/mips/include/asm/cpu.h
@@ -415,6 +415,7 @@ enum cpu_type_enum {
 #define MIPS_CPU_GUESTCTL2	MBIT_ULL(50)	/* CPU has VZ GuestCtl2 register */
 #define MIPS_CPU_GUESTID	MBIT_ULL(51)	/* CPU uses VZ ASE GuestID feature */
 #define MIPS_CPU_DRG		MBIT_ULL(52)	/* CPU has VZ Direct Root to Guest (DRG) */
+#define MIPS_CPU_UFR		MBIT_ULL(53)	/* CPU supports User mode FR switching */
 
 /*
  * CPU ASE encodings
diff --git a/arch/mips/kernel/cpu-probe.c b/arch/mips/kernel/cpu-probe.c
index 07718bb5fc9d..708f5913a8fe 100644
--- a/arch/mips/kernel/cpu-probe.c
+++ b/arch/mips/kernel/cpu-probe.c
@@ -289,6 +289,8 @@ static void cpu_set_fpu_opts(struct cpuinfo_mips *c)
 			    MIPS_CPU_ISA_M32R6 | MIPS_CPU_ISA_M64R6)) {
 		if (c->fpu_id & MIPS_FPIR_3D)
 			c->ases |= MIPS_ASE_MIPS3D;
+		if (c->fpu_id & MIPS_FPIR_UFRP)
+			c->options |= MIPS_CPU_UFR;
 		if (c->fpu_id & MIPS_FPIR_FREP)
 			c->options |= MIPS_CPU_FRE;
 	}
-- 
git-series 0.8.10
