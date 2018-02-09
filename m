Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 09 Feb 2018 23:12:01 +0100 (CET)
Received: from mail.kernel.org ([198.145.29.99]:39808 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23992830AbeBIWL11D0nC (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 9 Feb 2018 23:11:27 +0100
Received: from localhost.localdomain (jahogan.plus.com [212.159.75.221])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B184C217B2;
        Fri,  9 Feb 2018 22:11:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B184C217B2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=jhogan@kernel.org
From:   James Hogan <jhogan@kernel.org>
To:     linux-mips@linux-mips.org
Cc:     James Hogan <jhogan@kernel.org>,
        Marcin Nowakowski <marcin.nowakowski@mips.com>,
        Ralf Baechle <ralf@linux-mips.org>
Subject: [PATCH v3 1/3] MIPS: Add crc instruction support flag to elf_hwcap
Date:   Fri,  9 Feb 2018 22:11:05 +0000
Message-Id: <19b1dbe3109f8526906312d134158db98a4e5763.1518214143.git-series.jhogan@kernel.org>
X-Mailer: git-send-email 2.13.6
In-Reply-To: <cover.a1aaa0593f5afd4b00e8131611adda3a02c060d1.1518214143.git-series.jhogan@kernel.org>
References: <cover.a1aaa0593f5afd4b00e8131611adda3a02c060d1.1518214143.git-series.jhogan@kernel.org>
In-Reply-To: <cover.a1aaa0593f5afd4b00e8131611adda3a02c060d1.1518214143.git-series.jhogan@kernel.org>
References: <cover.a1aaa0593f5afd4b00e8131611adda3a02c060d1.1518214143.git-series.jhogan@kernel.org>
Return-Path: <jhogan@kernel.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 62481
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jhogan@kernel.org
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

From: Marcin Nowakowski <marcin.nowakowski@mips.com>

Indicate that CRC32 and CRC32C instuctions are supported by the CPU
through elf_hwcap flags.

This will be used by a follow-up commit that introduces crc32(c) crypto
acceleration modules and is required by GENERIC_CPU_AUTOPROBE feature.

Signed-off-by: Marcin Nowakowski <marcin.nowakowski@mips.com>
Signed-off-by: James Hogan <jhogan@kernel.org>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: linux-mips@linux-mips.org
---
 arch/mips/include/asm/mipsregs.h   | 1 +
 arch/mips/include/uapi/asm/hwcap.h | 1 +
 arch/mips/kernel/cpu-probe.c       | 3 +++
 3 files changed, 5 insertions(+)

diff --git a/arch/mips/include/asm/mipsregs.h b/arch/mips/include/asm/mipsregs.h
index 858752dac337..f65859784a4c 100644
--- a/arch/mips/include/asm/mipsregs.h
+++ b/arch/mips/include/asm/mipsregs.h
@@ -664,6 +664,7 @@
 #define MIPS_CONF5_FRE		(_ULCAST_(1) << 8)
 #define MIPS_CONF5_UFE		(_ULCAST_(1) << 9)
 #define MIPS_CONF5_CA2		(_ULCAST_(1) << 14)
+#define MIPS_CONF5_CRCP		(_ULCAST_(1) << 18)
 #define MIPS_CONF5_MSAEN	(_ULCAST_(1) << 27)
 #define MIPS_CONF5_EVA		(_ULCAST_(1) << 28)
 #define MIPS_CONF5_CV		(_ULCAST_(1) << 29)
diff --git a/arch/mips/include/uapi/asm/hwcap.h b/arch/mips/include/uapi/asm/hwcap.h
index 600ad8fd6835..a2aba4b059e6 100644
--- a/arch/mips/include/uapi/asm/hwcap.h
+++ b/arch/mips/include/uapi/asm/hwcap.h
@@ -5,5 +5,6 @@
 /* HWCAP flags */
 #define HWCAP_MIPS_R6		(1 << 0)
 #define HWCAP_MIPS_MSA		(1 << 1)
+#define HWCAP_MIPS_CRC32	(1 << 2)
 
 #endif /* _UAPI_ASM_HWCAP_H */
diff --git a/arch/mips/kernel/cpu-probe.c b/arch/mips/kernel/cpu-probe.c
index cf3fd549e16d..6b07b739f914 100644
--- a/arch/mips/kernel/cpu-probe.c
+++ b/arch/mips/kernel/cpu-probe.c
@@ -848,6 +848,9 @@ static inline unsigned int decode_config5(struct cpuinfo_mips *c)
 	if (config5 & MIPS_CONF5_CA2)
 		c->ases |= MIPS_ASE_MIPS16E2;
 
+	if (config5 & MIPS_CONF5_CRCP)
+		elf_hwcap |= HWCAP_MIPS_CRC32;
+
 	return config5 & MIPS_CONF_M;
 }
 
-- 
git-series 0.9.1
