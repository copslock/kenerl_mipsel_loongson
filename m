Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 18 Dec 2015 13:47:34 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:38377 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27008631AbbLRMrdEdL5C (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 18 Dec 2015 13:47:33 +0100
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Websense Email Security Gateway with ESMTPS id BB0A8A70AE5D8
        for <linux-mips@linux-mips.org>; Fri, 18 Dec 2015 12:47:24 +0000 (GMT)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 HHMAIL01.hh.imgtec.org (10.100.10.19) with Microsoft SMTP Server (TLS) id
 14.3.235.1; Fri, 18 Dec 2015 12:47:26 +0000
Received: from mredfearn-linux.le.imgtec.org (192.168.154.116) by
 LEMAIL01.le.imgtec.org (192.168.152.62) with Microsoft SMTP Server (TLS) id
 14.3.210.2; Fri, 18 Dec 2015 12:47:26 +0000
From:   Matt Redfearn <matt.redfearn@imgtec.com>
To:     <linux-mips@linux-mips.org>
CC:     <paul.burton@imgtec.com>, Matt Redfearn <matt.redfearn@imgtec.com>
Subject: [PATCH] MIPS: smp-cps: Ensure secondary cores start with EVA disabled
Date:   Fri, 18 Dec 2015 12:47:00 +0000
Message-ID: <1450442820-14690-1-git-send-email-matt.redfearn@imgtec.com>
X-Mailer: git-send-email 2.1.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.154.116]
Return-Path: <Matt.Redfearn@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 50686
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: matt.redfearn@imgtec.com
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

The kernel currently assumes that a core will start up in legacy mode
using the exception base provided through the CM GCR registers. If a
core has been configured in hardware to start in EVA mode, these
assumptions will fail.

This patch ensures that secondary cores are initialized to meet these
assumptions.

Signed-off-by: Matt Redfearn <matt.redfearn@imgtec.com>
Reviewed-by: Paul Burton <paul.burton@imgtec.com>
---
 arch/mips/include/asm/mips-cm.h | 4 ++++
 arch/mips/kernel/smp-cps.c      | 3 +++
 2 files changed, 7 insertions(+)

diff --git a/arch/mips/include/asm/mips-cm.h b/arch/mips/include/asm/mips-cm.h
index 1f1927ab4269..0dc8618aeb5e 100644
--- a/arch/mips/include/asm/mips-cm.h
+++ b/arch/mips/include/asm/mips-cm.h
@@ -230,6 +230,10 @@ BUILD_CM_Cx_R_(tcid_8_priority,	0x80)
 #define  CM_GCR_BASE_CMDEFTGT_IOCU0		2
 #define  CM_GCR_BASE_CMDEFTGT_IOCU1		3
 
+/* GCR_RESET_EXT_BASE register fields */
+#define CM_GCR_RESET_EXT_BASE_EVARESET		BIT(31)
+#define CM_GCR_RESET_EXT_BASE_UEB		BIT(30)
+
 /* GCR_ACCESS register fields */
 #define CM_GCR_ACCESS_ACCESSEN_SHF		0
 #define CM_GCR_ACCESS_ACCESSEN_MSK		(_ULCAST_(0xff) << 0)
diff --git a/arch/mips/kernel/smp-cps.c b/arch/mips/kernel/smp-cps.c
index c88937745b4e..db1da4d905b4 100644
--- a/arch/mips/kernel/smp-cps.c
+++ b/arch/mips/kernel/smp-cps.c
@@ -201,6 +201,9 @@ static void boot_core(unsigned core)
 	/* Ensure its coherency is disabled */
 	write_gcr_co_coherence(0);
 
+	/* Start it with the legacy memory map and exception base */
+	write_gcr_co_reset_ext_base(CM_GCR_RESET_EXT_BASE_UEB);
+
 	/* Ensure the core can access the GCRs */
 	access = read_gcr_access();
 	access |= 1 << (CM_GCR_ACCESS_ACCESSEN_SHF + core);
-- 
2.1.4
