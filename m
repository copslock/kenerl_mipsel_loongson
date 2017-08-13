Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 13 Aug 2017 04:54:08 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:10519 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23992127AbdHMCwvdtLX6 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 13 Aug 2017 04:52:51 +0200
Received: from hhmail02.hh.imgtec.org (unknown [10.100.10.20])
        by Forcepoint Email with ESMTPS id BBC48FBB5EB0C;
        Sun, 13 Aug 2017 03:52:43 +0100 (IST)
Received: from localhost (10.20.79.142) by hhmail02.hh.imgtec.org
 (10.100.10.21) with Microsoft SMTP Server (TLS) id 14.3.294.0; Sun, 13 Aug
 2017 03:52:45 +0100
From:   Paul Burton <paul.burton@imgtec.com>
To:     <linux-mips@linux-mips.org>
CC:     Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@imgtec.com>
Subject: [PATCH 09/19] MIPS: Add accessor & bit definitions for GlobalNumber
Date:   Sat, 12 Aug 2017 19:49:33 -0700
Message-ID: <20170813024943.14989-10-paul.burton@imgtec.com>
X-Mailer: git-send-email 2.14.0
In-Reply-To: <20170813024943.14989-1-paul.burton@imgtec.com>
References: <20170813024943.14989-1-paul.burton@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.20.79.142]
Return-Path: <Paul.Burton@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 59505
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

MIPSr6 introduces a GlobalNumber register, which is required when VPs
are implemented (ie. when multi-threading is supported) but otherwise
optional. The register contains sufficient information to uniquely
identify a VP within a system using its cluster number, core number & VP
ID.

In preparation for using this register & its fields, introduce an
accessor macro for it & define its various bits with the typical style
preprocessor macros.

Signed-off-by: Paul Burton <paul.burton@imgtec.com>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: linux-mips@linux-mips.org
---

 arch/mips/include/asm/mipsregs.h | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/arch/mips/include/asm/mipsregs.h b/arch/mips/include/asm/mipsregs.h
index dbb0eceda2c6..e4ed1bc9a734 100644
--- a/arch/mips/include/asm/mipsregs.h
+++ b/arch/mips/include/asm/mipsregs.h
@@ -48,6 +48,7 @@
 #define CP0_ENTRYLO0 $2
 #define CP0_ENTRYLO1 $3
 #define CP0_CONF $3
+#define CP0_GLOBALNUMBER $3, 1
 #define CP0_CONTEXT $4
 #define CP0_PAGEMASK $5
 #define CP0_SEGCTL0 $5, 2
@@ -147,6 +148,16 @@
 #define MIPS_ENTRYLO_XI		(_ULCAST_(1) << (BITS_PER_LONG - 2))
 #define MIPS_ENTRYLO_RI		(_ULCAST_(1) << (BITS_PER_LONG - 1))
 
+/*
+ * MIPSr6+ GlobalNumber register definitions
+ */
+#define MIPS_GLOBALNUMBER_VP_SHF	0
+#define MIPS_GLOBALNUMBER_VP		(_ULCAST_(0xff) << MIPS_GLOBALNUMBER_VP_SHF)
+#define MIPS_GLOBALNUMBER_CORE_SHF	8
+#define MIPS_GLOBALNUMBER_CORE		(_ULCAST_(0xff) << MIPS_GLOBALNUMBER_CORE_SHF)
+#define MIPS_GLOBALNUMBER_CLUSTER_SHF	16
+#define MIPS_GLOBALNUMBER_CLUSTER	(_ULCAST_(0xf) << MIPS_GLOBALNUMBER_CLUSTER_SHF)
+
 /*
  * Values for PageMask register
  */
@@ -1446,6 +1457,8 @@ do {									\
 #define read_c0_conf()		__read_32bit_c0_register($3, 0)
 #define write_c0_conf(val)	__write_32bit_c0_register($3, 0, val)
 
+#define read_c0_globalnumber()	__read_32bit_c0_register($3, 1)
+
 #define read_c0_context()	__read_ulong_c0_register($4, 0)
 #define write_c0_context(val)	__write_ulong_c0_register($4, 0, val)
 
-- 
2.14.0
