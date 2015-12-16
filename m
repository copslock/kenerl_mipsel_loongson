Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 17 Dec 2015 00:52:44 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:25497 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27014073AbbLPXuPMiOy0 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 17 Dec 2015 00:50:15 +0100
Received: from hhmail02.hh.imgtec.org (unknown [10.100.10.20])
        by Websense Email Security Gateway with ESMTPS id 86F9A3D7A0015;
        Wed, 16 Dec 2015 23:50:05 +0000 (GMT)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 hhmail02.hh.imgtec.org (10.100.10.20) with Microsoft SMTP Server (TLS) id
 14.3.235.1; Wed, 16 Dec 2015 23:50:09 +0000
Received: from jhogan-linux.le.imgtec.org (192.168.154.110) by
 LEMAIL01.le.imgtec.org (192.168.152.62) with Microsoft SMTP Server (TLS) id
 14.3.210.2; Wed, 16 Dec 2015 23:50:09 +0000
From:   James Hogan <james.hogan@imgtec.com>
To:     Ralf Baechle <ralf@linux-mips.org>,
        Paolo Bonzini <pbonzini@redhat.com>
CC:     Gleb Natapov <gleb@kernel.org>, <linux-mips@linux-mips.org>,
        <kvm@vger.kernel.org>, James Hogan <james.hogan@imgtec.com>
Subject: [PATCH 09/16] MIPS: Update trap codes
Date:   Wed, 16 Dec 2015 23:49:34 +0000
Message-ID: <1450309781-28030-10-git-send-email-james.hogan@imgtec.com>
X-Mailer: git-send-email 2.4.10
In-Reply-To: <1450309781-28030-1-git-send-email-james.hogan@imgtec.com>
References: <1450309781-28030-1-git-send-email-james.hogan@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.154.110]
Return-Path: <James.Hogan@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 50656
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

Add a few missing trap codes, and drop a couple of unused definitions
for virtual coherency that aren't in the latest architecture revisions.

Signed-off-by: James Hogan <james.hogan@imgtec.com>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: linux-mips@linux-mips.org
---
 arch/mips/include/asm/mipsregs.h | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/arch/mips/include/asm/mipsregs.h b/arch/mips/include/asm/mipsregs.h
index eb89b877c6c9..3ad19ad04d8a 100644
--- a/arch/mips/include/asm/mipsregs.h
+++ b/arch/mips/include/asm/mipsregs.h
@@ -420,12 +420,20 @@
 #define EXCCODE_CPU		11	/* Coprocessor unusable */
 #define EXCCODE_OV		12	/* Arithmetic overflow */
 #define EXCCODE_TR		13	/* Trap instruction */
-#define EXCCODE_VCEI		14	/* Virtual coherency exception */
 #define EXCCODE_MSAFPE		14	/* MSA floating point exception */
 #define EXCCODE_FPE		15	/* Floating point exception */
+#define EXCCODE_TLBRI		19	/* TLB Read-Inhibit exception */
+#define EXCCODE_TLBXI		20	/* TLB Execution-Inhibit exception */
 #define EXCCODE_MSADIS		21	/* MSA disabled exception */
+#define EXCCODE_MDMX		22	/* MDMX unusable exception */
 #define EXCCODE_WATCH		23	/* Watch address reference */
-#define EXCCODE_VCED		31	/* Virtual coherency data */
+#define EXCCODE_MCHECK		24	/* Machine check */
+#define EXCCODE_THREAD		25	/* Thread exceptions (MT) */
+#define EXCCODE_DSPDIS		26	/* DSP disabled exception */
+#define EXCCODE_GE		27	/* Virtualized guest exception (VZ) */
+
+/* Implementation specific trap codes used by MIPS cores */
+#define MIPS_EXCCODE_TLBPAR	16	/* TLB parity error exception */
 
 /*
  * Bits in the coprocessor 0 config register.
-- 
2.4.10
