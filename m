Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 04 Oct 2017 12:49:33 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:35621 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23990483AbdJDKtJhObNR (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 4 Oct 2017 12:49:09 +0200
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Forcepoint Email with ESMTPS id CDE25CCA06B11;
        Wed,  4 Oct 2017 11:49:00 +0100 (IST)
Received: from WR-NOWAKOWSKI.hh.imgtec.org (10.100.200.3) by
 HHMAIL01.hh.imgtec.org (10.100.10.21) with Microsoft SMTP Server (TLS) id
 14.3.361.1; Wed, 4 Oct 2017 11:49:03 +0100
From:   Marcin Nowakowski <marcin.nowakowski@imgtec.com>
To:     Linux MIPS Mailing List <linux-mips@linux-mips.org>
CC:     Ralf Baechle <ralf@linux-mips.org>,
        Marcin Nowakowski <marcin.nowakowski@imgtec.com>
Subject: [PATCH v2 1/2] MIPS: add crc instruction support flag to elf_hwcap
Date:   Wed, 4 Oct 2017 12:48:52 +0200
Message-ID: <1507114133-9129-2-git-send-email-marcin.nowakowski@imgtec.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1507114133-9129-1-git-send-email-marcin.nowakowski@imgtec.com>
References: <1507114133-9129-1-git-send-email-marcin.nowakowski@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.100.200.3]
Return-Path: <Marcin.Nowakowski@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 60249
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: marcin.nowakowski@imgtec.com
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

Indicate that CRC32 and CRC32C instuctions are supported by the CPU
through elf_hwcap flags.

This will be used by a follow-up commit that introduces crc32(c) crypto
acceleration modules and is required by GENERIC_CPU_AUTOPROBE feature.

Signed-off-by: Marcin Nowakowski <marcin.nowakowski@imgtec.com>
---
 arch/mips/include/asm/mipsregs.h   | 1 +
 arch/mips/include/uapi/asm/hwcap.h | 1 +
 arch/mips/kernel/cpu-probe.c       | 3 +++
 3 files changed, 5 insertions(+)

diff --git a/arch/mips/include/asm/mipsregs.h b/arch/mips/include/asm/mipsregs.h
index a681092..9db53cc 100644
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
index c7484a7..c7d2cb6 100644
--- a/arch/mips/include/uapi/asm/hwcap.h
+++ b/arch/mips/include/uapi/asm/hwcap.h
@@ -4,5 +4,6 @@
 /* HWCAP flags */
 #define HWCAP_MIPS_R6		(1 << 0)
 #define HWCAP_MIPS_MSA		(1 << 1)
+#define HWCAP_MIPS_CRC32	(1 << 2)
 
 #endif /* _UAPI_ASM_HWCAP_H */
diff --git a/arch/mips/kernel/cpu-probe.c b/arch/mips/kernel/cpu-probe.c
index cf3fd54..6b07b73 100644
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
2.7.4
