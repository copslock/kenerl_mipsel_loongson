Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 13 May 2015 17:17:31 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:44708 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27013241AbbEMPR3lL1Qs (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 13 May 2015 17:17:29 +0200
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id A2C33E5CD2BE;
        Wed, 13 May 2015 16:17:23 +0100 (IST)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 KLMAIL01.kl.imgtec.org (192.168.5.35) with Microsoft SMTP Server (TLS) id
 14.3.195.1; Wed, 13 May 2015 16:17:26 +0100
Received: from jhogan-linux.le.imgtec.org (192.168.154.110) by
 LEMAIL01.le.imgtec.org (192.168.152.62) with Microsoft SMTP Server (TLS) id
 14.3.210.2; Wed, 13 May 2015 16:17:25 +0100
From:   James Hogan <james.hogan@imgtec.com>
To:     Ralf Baechle <ralf@linux-mips.org>, <linux-mips@linux-mips.org>
CC:     James Hogan <james.hogan@imgtec.com>,
        Markos Chandras <markos.chandras@imgtec.com>
Subject: [PATCH 1/2] MIPS: cpu: Alter MIPS_CPU_* definitions to fill gap
Date:   Wed, 13 May 2015 16:17:13 +0100
Message-ID: <1431530234-32460-2-git-send-email-james.hogan@imgtec.com>
X-Mailer: git-send-email 2.3.6
In-Reply-To: <1431530234-32460-1-git-send-email-james.hogan@imgtec.com>
References: <1431530234-32460-1-git-send-email-james.hogan@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.154.110]
Return-Path: <James.Hogan@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 47375
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

The MIPS_CPU_* definitions accidentally missed bits 27..30 when
MIPS_CPU_EVA was added, and further definitions have continued from
there.

Shift all the definitions since MIPS_CPU_EVA right by 4 so there are no
gaps.

Signed-off-by: James Hogan <james.hogan@imgtec.com>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: Markos Chandras <markos.chandras@imgtec.com>
Cc: linux-mips@linux-mips.org
---
 arch/mips/include/asm/cpu.h | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/arch/mips/include/asm/cpu.h b/arch/mips/include/asm/cpu.h
index e3adca1d0b99..c45c20db460d 100644
--- a/arch/mips/include/asm/cpu.h
+++ b/arch/mips/include/asm/cpu.h
@@ -371,14 +371,14 @@ enum cpu_type_enum {
 #define MIPS_CPU_MICROMIPS	0x01000000ull /* CPU has microMIPS capability */
 #define MIPS_CPU_TLBINV		0x02000000ull /* CPU supports TLBINV/F */
 #define MIPS_CPU_SEGMENTS	0x04000000ull /* CPU supports Segmentation Control registers */
-#define MIPS_CPU_EVA		0x80000000ull /* CPU supports Enhanced Virtual Addressing */
-#define MIPS_CPU_HTW		0x100000000ull /* CPU support Hardware Page Table Walker */
-#define MIPS_CPU_RIXIEX		0x200000000ull /* CPU has unique exception codes for {Read, Execute}-Inhibit exceptions */
-#define MIPS_CPU_MAAR		0x400000000ull /* MAAR(I) registers are present */
-#define MIPS_CPU_FRE		0x800000000ull /* FRE & UFE bits implemented */
-#define MIPS_CPU_RW_LLB		0x1000000000ull /* LLADDR/LLB writes are allowed */
-#define MIPS_CPU_XPA		0x2000000000ull /* CPU supports Extended Physical Addressing */
-#define MIPS_CPU_CDMM		0x4000000000ull	/* CPU has Common Device Memory Map */
+#define MIPS_CPU_EVA		0x08000000ull /* CPU supports Enhanced Virtual Addressing */
+#define MIPS_CPU_HTW		0x10000000ull /* CPU support Hardware Page Table Walker */
+#define MIPS_CPU_RIXIEX		0x20000000ull /* CPU has unique exception codes for {Read, Execute}-Inhibit exceptions */
+#define MIPS_CPU_MAAR		0x40000000ull /* MAAR(I) registers are present */
+#define MIPS_CPU_FRE		0x80000000ull /* FRE & UFE bits implemented */
+#define MIPS_CPU_RW_LLB		0x100000000ull /* LLADDR/LLB writes are allowed */
+#define MIPS_CPU_XPA		0x200000000ull /* CPU supports Extended Physical Addressing */
+#define MIPS_CPU_CDMM		0x400000000ull	/* CPU has Common Device Memory Map */
 
 /*
  * CPU ASE encodings
-- 
2.3.6
