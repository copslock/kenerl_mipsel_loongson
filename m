Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 03 Feb 2016 04:16:42 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:62160 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27008653AbcBCDQijd6h0 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 3 Feb 2016 04:16:38 +0100
Received: from hhmail02.hh.imgtec.org (unknown [10.100.10.20])
        by Websense Email Security Gateway with ESMTPS id 7E9D82A842AA7;
        Wed,  3 Feb 2016 03:16:31 +0000 (GMT)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 hhmail02.hh.imgtec.org (10.100.10.20) with Microsoft SMTP Server (TLS) id
 14.3.266.1; Wed, 3 Feb 2016 03:16:32 +0000
Received: from localhost (10.100.200.215) by LEMAIL01.le.imgtec.org
 (192.168.152.62) with Microsoft SMTP Server (TLS) id 14.3.210.2; Wed, 3 Feb
 2016 03:16:31 +0000
From:   Paul Burton <paul.burton@imgtec.com>
To:     <linux-mips@linux-mips.org>, Ralf Baechle <ralf@linux-mips.org>
CC:     Paul Burton <paul.burton@imgtec.com>,
        "Maciej W. Rozycki" <macro@imgtec.com>,
        Joshua Kinard <kumba@gentoo.org>,
        "Steven J. Hill" <Steven.Hill@imgtec.com>,
        Leonid Yegoshin <Leonid.Yegoshin@imgtec.com>,
        <linux-kernel@vger.kernel.org>,
        James Hogan <james.hogan@imgtec.com>,
        "Markos Chandras" <markos.chandras@imgtec.com>
Subject: [PATCH 01/15] MIPS: Detect MIPSr6 Virtual Processor support
Date:   Wed, 3 Feb 2016 03:15:21 +0000
Message-ID: <1454469335-14778-2-git-send-email-paul.burton@imgtec.com>
X-Mailer: git-send-email 2.7.0
In-Reply-To: <1454469335-14778-1-git-send-email-paul.burton@imgtec.com>
References: <1454469335-14778-1-git-send-email-paul.burton@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.100.200.215]
Return-Path: <Paul.Burton@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 51629
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

MIPSr6 introduces support for "Virtual Processors", which are
conceptually similar to VPEs from the now-deprecated MT ASE. Detect
whether the system supports VPs using the VP bit in Config5, adding
cpu_has_vp for use by later patches.

Signed-off-by: Paul Burton <paul.burton@imgtec.com>
---

 arch/mips/include/asm/cpu-features.h | 4 ++++
 arch/mips/include/asm/cpu.h          | 1 +
 arch/mips/include/asm/mipsregs.h     | 1 +
 arch/mips/kernel/cpu-probe.c         | 2 ++
 4 files changed, 8 insertions(+)

diff --git a/arch/mips/include/asm/cpu-features.h b/arch/mips/include/asm/cpu-features.h
index eeec8c8..57cdc5b 100644
--- a/arch/mips/include/asm/cpu-features.h
+++ b/arch/mips/include/asm/cpu-features.h
@@ -311,6 +311,10 @@
 #define cpu_has_mipsmt		(cpu_data[0].ases & MIPS_ASE_MIPSMT)
 #endif
 
+#ifndef cpu_has_vp
+#define cpu_has_vp		(cpu_data[0].options & MIPS_CPU_VP)
+#endif
+
 #ifndef cpu_has_userlocal
 #define cpu_has_userlocal	(cpu_data[0].options & MIPS_CPU_ULRI)
 #endif
diff --git a/arch/mips/include/asm/cpu.h b/arch/mips/include/asm/cpu.h
index a97ca97..82a26ed 100644
--- a/arch/mips/include/asm/cpu.h
+++ b/arch/mips/include/asm/cpu.h
@@ -388,6 +388,7 @@ enum cpu_type_enum {
 #define MIPS_CPU_FTLB		0x20000000000ull /* CPU has Fixed-page-size TLB */
 #define MIPS_CPU_NAN_LEGACY	0x40000000000ull /* Legacy NaN implemented */
 #define MIPS_CPU_NAN_2008	0x80000000000ull /* 2008 NaN implemented */
+#define MIPS_CPU_VP		0x100000000000ull /* MIPSr6 Virtual Processors (multi-threading) */
 
 /*
  * CPU ASE encodings
diff --git a/arch/mips/include/asm/mipsregs.h b/arch/mips/include/asm/mipsregs.h
index 3ad19ad..ca251f6 100644
--- a/arch/mips/include/asm/mipsregs.h
+++ b/arch/mips/include/asm/mipsregs.h
@@ -623,6 +623,7 @@
 #define MIPS_CONF5_MRP		(_ULCAST_(1) << 3)
 #define MIPS_CONF5_LLB		(_ULCAST_(1) << 4)
 #define MIPS_CONF5_MVH		(_ULCAST_(1) << 5)
+#define MIPS_CONF5_VP		(_ULCAST_(1) << 7)
 #define MIPS_CONF5_FRE		(_ULCAST_(1) << 8)
 #define MIPS_CONF5_UFE		(_ULCAST_(1) << 9)
 #define MIPS_CONF5_MSAEN	(_ULCAST_(1) << 27)
diff --git a/arch/mips/kernel/cpu-probe.c b/arch/mips/kernel/cpu-probe.c
index b725b71..e38442d 100644
--- a/arch/mips/kernel/cpu-probe.c
+++ b/arch/mips/kernel/cpu-probe.c
@@ -796,6 +796,8 @@ static inline unsigned int decode_config5(struct cpuinfo_mips *c)
 	if (config5 & MIPS_CONF5_MVH)
 		c->options |= MIPS_CPU_XPA;
 #endif
+	if (cpu_has_mips_r6 && (config5 & MIPS_CONF5_VP))
+		c->options |= MIPS_CPU_VP;
 
 	return config5 & MIPS_CONF_M;
 }
-- 
2.7.0
