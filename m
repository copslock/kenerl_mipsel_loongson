Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 14 Jul 2014 11:15:24 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:30828 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S6856070AbaGNJOnOS06H (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 14 Jul 2014 11:14:43 +0200
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id E589CC08B37D4
        for <linux-mips@linux-mips.org>; Mon, 14 Jul 2014 10:14:34 +0100 (IST)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 KLMAIL01.kl.imgtec.org (192.168.5.35) with Microsoft SMTP Server (TLS) id
 14.3.195.1; Mon, 14 Jul 2014 10:14:36 +0100
Received: from mchandras-linux.le.imgtec.org (192.168.154.67) by
 LEMAIL01.le.imgtec.org (192.168.152.62) with Microsoft SMTP Server (TLS) id
 14.3.195.1; Mon, 14 Jul 2014 10:14:35 +0100
From:   Markos Chandras <markos.chandras@imgtec.com>
To:     <linux-mips@linux-mips.org>
CC:     Markos Chandras <markos.chandras@imgtec.com>
Subject: [PATCH 3/5] MIPS: asm: Add register definitions for Hardware Table Walker
Date:   Mon, 14 Jul 2014 10:14:04 +0100
Message-ID: <1405329246-21643-4-git-send-email-markos.chandras@imgtec.com>
X-Mailer: git-send-email 2.0.0
In-Reply-To: <1405329246-21643-1-git-send-email-markos.chandras@imgtec.com>
References: <1405329246-21643-1-git-send-email-markos.chandras@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.154.67]
Return-Path: <Markos.Chandras@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 41174
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: markos.chandras@imgtec.com
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

Signed-off-by: Markos Chandras <markos.chandras@imgtec.com>
---
 arch/mips/include/asm/mipsregs.h | 44 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 44 insertions(+)

diff --git a/arch/mips/include/asm/mipsregs.h b/arch/mips/include/asm/mipsregs.h
index 98e9754a4b6b..417125548bde 100644
--- a/arch/mips/include/asm/mipsregs.h
+++ b/arch/mips/include/asm/mipsregs.h
@@ -706,6 +706,37 @@
 #define MIPS_SEGCFG_MK		_ULCAST_(1)
 #define MIPS_SEGCFG_UK		_ULCAST_(0)
 
+#define MIPS_PWFIELD_GDI_SHIFT	24
+#define MIPS_PWFIELD_GDI_MASK	0x3f000000
+#define MIPS_PWFIELD_UDI_SHIFT	18
+#define MIPS_PWFIELD_UDI_MASK	0x00fc0000
+#define MIPS_PWFIELD_MDI_SHIFT	12
+#define MIPS_PWFIELD_MDI_MASK	0x0003f000
+#define MIPS_PWFIELD_PTI_SHIFT	6
+#define MIPS_PWFIELD_PTI_MASK	0x00000fc0
+#define MIPS_PWFIELD_PTEI_SHIFT	0
+#define MIPS_PWFIELD_PTEI_MASK	0x0000003f
+
+#define MIPS_PWSIZE_GDW_SHIFT	24
+#define MIPS_PWSIZE_GDW_MASK	0x3f000000
+#define MIPS_PWSIZE_UDW_SHIFT	18
+#define MIPS_PWSIZE_UDW_MASK	0x00fc0000
+#define MIPS_PWSIZE_MDW_SHIFT	12
+#define MIPS_PWSIZE_MDW_MASK	0x0003f000
+#define MIPS_PWSIZE_PTW_SHIFT	6
+#define MIPS_PWSIZE_PTW_MASK	0x00000fc0
+#define MIPS_PWSIZE_PTEW_SHIFT	0
+#define MIPS_PWSIZE_PTEW_MASK	0x0000003f
+
+#define MIPS_PWCTL_PWEN_SHIFT	31
+#define MIPS_PWCTL_PWEN_MASK	0x80000000
+#define MIPS_PWCTL_DPH_SHIFT	7
+#define MIPS_PWCTL_DPH_MASK	0x00000080
+#define MIPS_PWCTL_HUGEPG_SHIFT	6
+#define MIPS_PWCTL_HUGEPG_MASK	0x00000060
+#define MIPS_PWCTL_PSN_SHIFT	0
+#define MIPS_PWCTL_PSN_MASK	0x0000003f
+
 #ifndef __ASSEMBLY__
 
 /*
@@ -1201,6 +1232,19 @@ do {									\
 #define read_c0_segctl2()	__read_32bit_c0_register($5, 4)
 #define write_c0_segctl2(val)	__write_32bit_c0_register($5, 4, val)
 
+/* Hardware Page Table Walker */
+#define read_c0_pwbase()	__read_ulong_c0_register($5, 5)
+#define write_c0_pwbase(val)	__write_ulong_c0_register($5, 5, val)
+
+#define read_c0_pwfield()	__read_ulong_c0_register($5, 6)
+#define write_c0_pwfield(val)	__write_ulong_c0_register($5, 6, val)
+
+#define read_c0_pwsize()	__read_ulong_c0_register($5, 7)
+#define write_c0_pwsize(val)	__write_ulong_c0_register($5, 7, val)
+
+#define read_c0_pwctl()		__read_32bit_c0_register($6, 6)
+#define write_c0_pwctl(val)	__write_32bit_c0_register($6, 6, val)
+
 /* Cavium OCTEON (cnMIPS) */
 #define read_c0_cvmcount()	__read_ulong_c0_register($9, 6)
 #define write_c0_cvmcount(val)	__write_ulong_c0_register($9, 6, val)
-- 
2.0.0
