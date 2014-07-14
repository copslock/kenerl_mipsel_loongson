Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 14 Jul 2014 11:33:14 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:33899 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S6860083AbaGNJcoLr8B9 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 14 Jul 2014 11:32:44 +0200
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id 25404BCE16720
        for <linux-mips@linux-mips.org>; Mon, 14 Jul 2014 10:32:35 +0100 (IST)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 KLMAIL01.kl.imgtec.org (192.168.5.35) with Microsoft SMTP Server (TLS) id
 14.3.195.1; Mon, 14 Jul 2014 10:32:37 +0100
Received: from pburton-laptop.home (192.168.79.188) by LEMAIL01.le.imgtec.org
 (192.168.152.62) with Microsoft SMTP Server (TLS) id 14.3.195.1; Mon, 14 Jul
 2014 10:32:36 +0100
From:   Paul Burton <paul.burton@imgtec.com>
To:     <linux-mips@linux-mips.org>
CC:     Paul Burton <paul.burton@imgtec.com>
Subject: [PATCH 2/4] MIPS: detect presence of MAARs
Date:   Mon, 14 Jul 2014 10:32:14 +0100
Message-ID: <1405330336-18167-3-git-send-email-paul.burton@imgtec.com>
X-Mailer: git-send-email 2.0.1
In-Reply-To: <1405330336-18167-1-git-send-email-paul.burton@imgtec.com>
References: <1405330336-18167-1-git-send-email-paul.burton@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.79.188]
Return-Path: <Paul.Burton@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 41179
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

Detect the presence of MAAR using the MRP bit in Config5, and record
that presence using a CPU option bit. A cpu_has_maar macro will then
allow code to conditionalise upon the presence of MAARs.

Signed-off-by: Paul Burton <paul.burton@imgtec.com>
---
 arch/mips/include/asm/cpu-features.h | 3 +++
 arch/mips/include/asm/cpu.h          | 1 +
 arch/mips/kernel/cpu-probe.c         | 2 ++
 3 files changed, 6 insertions(+)

diff --git a/arch/mips/include/asm/cpu-features.h b/arch/mips/include/asm/cpu-features.h
index c7d8c99..2101618 100644
--- a/arch/mips/include/asm/cpu-features.h
+++ b/arch/mips/include/asm/cpu-features.h
@@ -29,6 +29,9 @@
 #ifndef cpu_has_eva
 #define cpu_has_eva		(cpu_data[0].options & MIPS_CPU_EVA)
 #endif
+#ifndef cpu_has_maar
+#define cpu_has_maar		(cpu_data[0].options & MIPS_CPU_MAAR)
+#endif
 
 /*
  * For the moment we don't consider R6000 and R8000 so we can assume that
diff --git a/arch/mips/include/asm/cpu.h b/arch/mips/include/asm/cpu.h
index 3b8d993..000bb9e 100644
--- a/arch/mips/include/asm/cpu.h
+++ b/arch/mips/include/asm/cpu.h
@@ -363,6 +363,7 @@ enum cpu_type_enum {
 #define MIPS_CPU_TLBINV		0x02000000ull /* CPU supports TLBINV/F */
 #define MIPS_CPU_SEGMENTS	0x04000000ull /* CPU supports Segmentation Control registers */
 #define MIPS_CPU_EVA		0x80000000ull /* CPU supports Enhanced Virtual Addressing */
+#define MIPS_CPU_MAAR		0x200000000ull /* MAAR(I) registers are present */
 
 /*
  * CPU ASE encodings
diff --git a/arch/mips/kernel/cpu-probe.c b/arch/mips/kernel/cpu-probe.c
index d74f957..e818547 100644
--- a/arch/mips/kernel/cpu-probe.c
+++ b/arch/mips/kernel/cpu-probe.c
@@ -389,6 +389,8 @@ static inline unsigned int decode_config5(struct cpuinfo_mips *c)
 
 	if (config5 & MIPS_CONF5_EVA)
 		c->options |= MIPS_CPU_EVA;
+	if (config5 & MIPS_CONF5_MRP)
+		c->options |= MIPS_CPU_MAAR;
 
 	return config5 & MIPS_CONF_M;
 }
-- 
2.0.1
