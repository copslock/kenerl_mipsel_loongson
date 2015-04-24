Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 24 Apr 2015 15:19:52 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:20829 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27026019AbbDXNTfrxBZd (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 24 Apr 2015 15:19:35 +0200
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id E8112C3C88680;
        Fri, 24 Apr 2015 14:19:28 +0100 (IST)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 KLMAIL01.kl.imgtec.org (192.168.5.35) with Microsoft SMTP Server (TLS) id
 14.3.195.1; Fri, 24 Apr 2015 14:19:31 +0100
Received: from localhost (192.168.159.76) by LEMAIL01.le.imgtec.org
 (192.168.152.62) with Microsoft SMTP Server (TLS) id 14.3.210.2; Fri, 24 Apr
 2015 14:19:30 +0100
From:   Paul Burton <paul.burton@imgtec.com>
To:     <linux-mips@linux-mips.org>
CC:     Paul Burton <paul.burton@imgtec.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Ralf Baechle <ralf@linux-mips.org>
Subject: [PATCH v4 04/37] MIPS: ingenic: add newer vendor IDs
Date:   Fri, 24 Apr 2015 14:17:04 +0100
Message-ID: <1429881457-16016-5-git-send-email-paul.burton@imgtec.com>
X-Mailer: git-send-email 2.3.5
In-Reply-To: <1429881457-16016-1-git-send-email-paul.burton@imgtec.com>
References: <1429881457-16016-1-git-send-email-paul.burton@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.159.76]
Return-Path: <Paul.Burton@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 47038
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

Ingenic have actually varied the vendor/company ID of the XBurst cores
across their range of SoCs, whilst keeping the product ID & revision
constant... Add definitions for vendor IDs known to be used in some of
Ingenic's newer SoCs, and handle them in the same way as the existing
Ingenic vendor ID from the JZ4740.

Signed-off-by: Paul Burton <paul.burton@imgtec.com>
Co-authored-by: Paul Cercueil <paul@crapouillou.net>
Cc: Lars-Peter Clausen <lars@metafoo.de>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: linux-mips@linux-mips.org
---
Changes in v4:
  - None.

Changes in v3:
  - New patch, encompassing patch 31 "MIPS: add jz4780 Ingenic vendor
    ID" of v2.

  - Give up on associating vendor IDs with unique SoCs.
---
 arch/mips/include/asm/cpu.h  | 6 ++++--
 arch/mips/kernel/cpu-probe.c | 4 +++-
 2 files changed, 7 insertions(+), 3 deletions(-)

diff --git a/arch/mips/include/asm/cpu.h b/arch/mips/include/asm/cpu.h
index e3adca1..73dd357 100644
--- a/arch/mips/include/asm/cpu.h
+++ b/arch/mips/include/asm/cpu.h
@@ -42,7 +42,9 @@
 #define PRID_COMP_LEXRA		0x0b0000
 #define PRID_COMP_NETLOGIC	0x0c0000
 #define PRID_COMP_CAVIUM	0x0d0000
-#define PRID_COMP_INGENIC	0xd00000
+#define PRID_COMP_INGENIC_D0	0xd00000	/* JZ4740, JZ4750 */
+#define PRID_COMP_INGENIC_D1	0xd10000	/* JZ4770, JZ4775 */
+#define PRID_COMP_INGENIC_E1	0xe10000	/* JZ4780 */
 
 /*
  * Assigned Processor ID (implementation) values for bits 15:8 of the PRId
@@ -168,7 +170,7 @@
 #define PRID_IMP_CAVIUM_CN70XX 0x9600
 
 /*
- * These are the PRID's for when 23:16 == PRID_COMP_INGENIC
+ * These are the PRID's for when 23:16 == PRID_COMP_INGENIC_*
  */
 
 #define PRID_IMP_JZRISC	       0x0200
diff --git a/arch/mips/kernel/cpu-probe.c b/arch/mips/kernel/cpu-probe.c
index e36515d..0444e69 100644
--- a/arch/mips/kernel/cpu-probe.c
+++ b/arch/mips/kernel/cpu-probe.c
@@ -1444,7 +1444,9 @@ void cpu_probe(void)
 	case PRID_COMP_CAVIUM:
 		cpu_probe_cavium(c, cpu);
 		break;
-	case PRID_COMP_INGENIC:
+	case PRID_COMP_INGENIC_D0:
+	case PRID_COMP_INGENIC_D1:
+	case PRID_COMP_INGENIC_E1:
 		cpu_probe_ingenic(c, cpu);
 		break;
 	case PRID_COMP_NETLOGIC:
-- 
2.3.5
