Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 19 May 2015 10:51:29 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:32684 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27013476AbbESIvLMh2sA (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 19 May 2015 10:51:11 +0200
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id 9B3F1E34B1BC1;
        Tue, 19 May 2015 09:51:05 +0100 (IST)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 KLMAIL01.kl.imgtec.org (192.168.5.35) with Microsoft SMTP Server (TLS) id
 14.3.195.1; Tue, 19 May 2015 09:51:07 +0100
Received: from jhogan-linux.le.imgtec.org (192.168.154.110) by
 LEMAIL01.le.imgtec.org (192.168.152.62) with Microsoft SMTP Server (TLS) id
 14.3.210.2; Tue, 19 May 2015 09:51:07 +0100
From:   James Hogan <james.hogan@imgtec.com>
To:     Ralf Baechle <ralf@linux-mips.org>, <linux-mips@linux-mips.org>
CC:     James Hogan <james.hogan@imgtec.com>,
        "Maciej W. Rozycki" <macro@linux-mips.org>
Subject: [PATCH v2 03/10] MIPS: mipsregs.h: Add EntryLo bit definitions
Date:   Tue, 19 May 2015 09:50:31 +0100
Message-ID: <1432025438-26431-4-git-send-email-james.hogan@imgtec.com>
X-Mailer: git-send-email 2.3.6
In-Reply-To: <1432025438-26431-1-git-send-email-james.hogan@imgtec.com>
References: <1432025438-26431-1-git-send-email-james.hogan@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.154.110]
Return-Path: <James.Hogan@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 47468
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

Add definitions for EntryLo register bits in mipsregs.h. The R4000
compatible ones are prefixed MIPS_ENTRYLO_ and the R3000 compatible ones
are prefixed R3K_ENTRYLO_.

These will be used in later patches.

Signed-off-by: James Hogan <james.hogan@imgtec.com>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: Maciej W. Rozycki <macro@linux-mips.org>
Cc: linux-mips@linux-mips.org
---
Changes in v2:
- New patch (Maceij) including reordered MIPS_ENTRYLO_RI/XI definitions
  from patch 7.
---
 arch/mips/include/asm/mipsregs.h | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/arch/mips/include/asm/mipsregs.h b/arch/mips/include/asm/mipsregs.h
index 764e2756b54d..3b5a145af659 100644
--- a/arch/mips/include/asm/mipsregs.h
+++ b/arch/mips/include/asm/mipsregs.h
@@ -589,6 +589,28 @@
 /*  EntryHI bit definition */
 #define MIPS_ENTRYHI_EHINV	(_ULCAST_(1) << 10)
 
+/* R3000 EntryLo bit definitions */
+#define R3K_ENTRYLO_G		(_ULCAST_(1) << 8)
+#define R3K_ENTRYLO_V		(_ULCAST_(1) << 9)
+#define R3K_ENTRYLO_D		(_ULCAST_(1) << 10)
+#define R3K_ENTRYLO_N		(_ULCAST_(1) << 11)
+
+/* R4000 compatible EntryLo bit definitions */
+#define MIPS_ENTRYLO_G		(_ULCAST_(1) << 0)
+#define MIPS_ENTRYLO_V		(_ULCAST_(1) << 1)
+#define MIPS_ENTRYLO_D		(_ULCAST_(1) << 2)
+#define MIPS_ENTRYLO_C_SHIFT	3
+#define MIPS_ENTRYLO_C		(_ULCAST_(7) << MIPS_ENTRYLO_C_SHIFT)
+#ifdef CONFIG_64BIT
+/* as read by dmfc0 */
+#define MIPS_ENTRYLO_XI		(_ULCAST_(1) << 62)
+#define MIPS_ENTRYLO_RI		(_ULCAST_(1) << 63)
+#else
+/* as read by mfc0 */
+#define MIPS_ENTRYLO_XI		(_ULCAST_(1) << 30)
+#define MIPS_ENTRYLO_RI		(_ULCAST_(1) << 31)
+#endif
+
 /* CMGCRBase bit definitions */
 #define MIPS_CMGCRB_BASE	11
 #define MIPS_CMGCRF_BASE	(~_ULCAST_((1 << MIPS_CMGCRB_BASE) - 1))
-- 
2.3.6
