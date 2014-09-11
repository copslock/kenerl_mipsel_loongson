Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 11 Sep 2014 10:39:09 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:16085 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27008712AbaIKIhhw99Bq (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 11 Sep 2014 10:37:37 +0200
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id 6252312F26FC7;
        Thu, 11 Sep 2014 09:37:29 +0100 (IST)
Received: from KLMAIL02.kl.imgtec.org (10.40.60.222) by KLMAIL01.kl.imgtec.org
 (192.168.5.35) with Microsoft SMTP Server (TLS) id 14.3.195.1; Thu, 11 Sep
 2014 09:37:30 +0100
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 klmail02.kl.imgtec.org (10.40.60.222) with Microsoft SMTP Server (TLS) id
 14.3.195.1; Thu, 11 Sep 2014 08:32:29 +0100
Received: from pburton-laptop.home (192.168.159.78) by LEMAIL01.le.imgtec.org
 (192.168.152.62) with Microsoft SMTP Server (TLS) id 14.3.195.1; Thu, 11 Sep
 2014 08:32:29 +0100
From:   Paul Burton <paul.burton@imgtec.com>
To:     <linux-mips@linux-mips.org>
CC:     Alexander Viro <viro@zeniv.linux.org.uk>,
        <linux-fsdevel@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Paul Burton <paul.burton@imgtec.com>
Subject: [PATCH 05/10] MIPS: detect presence of the FRE & UFR bits
Date:   Thu, 11 Sep 2014 08:30:18 +0100
Message-ID: <1410420623-11691-6-git-send-email-paul.burton@imgtec.com>
X-Mailer: git-send-email 2.0.4
In-Reply-To: <1410420623-11691-1-git-send-email-paul.burton@imgtec.com>
References: <1410420623-11691-1-git-send-email-paul.burton@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.159.78]
Return-Path: <Paul.Burton@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 42508
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

Detect the presence of the Config5 FRE & UFE bits, as indicated by the
FREP bit in FPIR. Record this as a CPU option bit, and provide a
cpu_has_fre macro to ease checking of that option bit.

Signed-off-by: Paul Burton <paul.burton@imgtec.com>
---
 arch/mips/include/asm/cpu-features.h | 4 ++++
 arch/mips/include/asm/cpu.h          | 1 +
 arch/mips/kernel/cpu-probe.c         | 2 ++
 3 files changed, 7 insertions(+)

diff --git a/arch/mips/include/asm/cpu-features.h b/arch/mips/include/asm/cpu-features.h
index e079598..b9420d8 100644
--- a/arch/mips/include/asm/cpu-features.h
+++ b/arch/mips/include/asm/cpu-features.h
@@ -334,4 +334,8 @@
 # define cpu_has_msa		0
 #endif
 
+#ifndef cpu_has_fre
+# define cpu_has_fre		(cpu_data[0].options & MIPS_CPU_FRE)
+#endif
+
 #endif /* __ASM_CPU_FEATURES_H */
diff --git a/arch/mips/include/asm/cpu.h b/arch/mips/include/asm/cpu.h
index dfdc77e..11025bf 100644
--- a/arch/mips/include/asm/cpu.h
+++ b/arch/mips/include/asm/cpu.h
@@ -368,6 +368,7 @@ enum cpu_type_enum {
 #define MIPS_CPU_HTW		0x100000000ull /* CPU support Hardware Page Table Walker */
 #define MIPS_CPU_RIXIEX		0x200000000ull /* CPU has unique exception codes for {Read, Execute}-Inhibit exceptions */
 #define MIPS_CPU_MAAR		0x400000000ull /* MAAR(I) registers are present */
+#define MIPS_CPU_FRE		0x800000000ull /* FRE & UFE bits implemented */
 
 /*
  * CPU ASE encodings
diff --git a/arch/mips/kernel/cpu-probe.c b/arch/mips/kernel/cpu-probe.c
index e34b10b..db929a0 100644
--- a/arch/mips/kernel/cpu-probe.c
+++ b/arch/mips/kernel/cpu-probe.c
@@ -1233,6 +1233,8 @@ void cpu_probe(void)
 				    MIPS_CPU_ISA_M64R1 | MIPS_CPU_ISA_M64R2)) {
 			if (c->fpu_id & MIPS_FPIR_3D)
 				c->ases |= MIPS_ASE_MIPS3D;
+			if (c->fpu_id & MIPS_FPIR_FREP)
+				c->options |= MIPS_CPU_FRE;
 		}
 	}
 
-- 
2.0.4
