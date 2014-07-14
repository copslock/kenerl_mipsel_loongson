Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 14 Jul 2014 11:32:53 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:13157 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S6856084AbaGNJcmRho6a (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 14 Jul 2014 11:32:42 +0200
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id 1873B8F5DD94A
        for <linux-mips@linux-mips.org>; Mon, 14 Jul 2014 10:32:34 +0100 (IST)
Received: from KLMAIL02.kl.imgtec.org (10.40.60.222) by KLMAIL01.kl.imgtec.org
 (192.168.5.35) with Microsoft SMTP Server (TLS) id 14.3.195.1; Mon, 14 Jul
 2014 10:32:35 +0100
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 klmail02.kl.imgtec.org (10.40.60.222) with Microsoft SMTP Server (TLS) id
 14.3.195.1; Mon, 14 Jul 2014 10:32:35 +0100
Received: from pburton-laptop.home (192.168.79.188) by LEMAIL01.le.imgtec.org
 (192.168.152.62) with Microsoft SMTP Server (TLS) id 14.3.195.1; Mon, 14 Jul
 2014 10:32:34 +0100
From:   Paul Burton <paul.burton@imgtec.com>
To:     <linux-mips@linux-mips.org>
CC:     Paul Burton <paul.burton@imgtec.com>
Subject: [PATCH 1/4] MIPS: define MAAR register accessors & bits
Date:   Mon, 14 Jul 2014 10:32:13 +0100
Message-ID: <1405330336-18167-2-git-send-email-paul.burton@imgtec.com>
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
X-archive-position: 41178
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

Add accessor macros for the Memory Accessibility Attribute Registers
(MAARs), the bits contained within the MAARs & the Config5.MRP bit
indicating their presence. The only current use of the MAARs is to
enable speculative accesses to regions of memory. Besides the potential
performance benefits of speculative accesses, they are a requirement
for the P5600 core to handle non-128b-aligned MSA vector loads & stores
rather than generating an address error.

Signed-off-by: Paul Burton <paul.burton@imgtec.com>
---
 arch/mips/include/asm/mipsregs.h | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/mips/include/asm/mipsregs.h b/arch/mips/include/asm/mipsregs.h
index 98e9754..b21f5a3 100644
--- a/arch/mips/include/asm/mipsregs.h
+++ b/arch/mips/include/asm/mipsregs.h
@@ -652,6 +652,7 @@
 
 #define MIPS_CONF5_NF		(_ULCAST_(1) << 0)
 #define MIPS_CONF5_UFR		(_ULCAST_(1) << 2)
+#define MIPS_CONF5_MRP		(_ULCAST_(1) << 3)
 #define MIPS_CONF5_MSAEN	(_ULCAST_(1) << 27)
 #define MIPS_CONF5_EVA		(_ULCAST_(1) << 28)
 #define MIPS_CONF5_CV		(_ULCAST_(1) << 29)
@@ -668,6 +669,12 @@
 #define MIPS_CONF7_IAR		(_ULCAST_(1) << 10)
 #define MIPS_CONF7_AR		(_ULCAST_(1) << 16)
 
+/* MAAR bit definitions */
+#define MIPS_MAAR_ADDR		((BIT_ULL(BITS_PER_LONG - 12) - 1) << 12)
+#define MIPS_MAAR_ADDR_SHIFT	12
+#define MIPS_MAAR_S		(_ULCAST_(1) << 1)
+#define MIPS_MAAR_V		(_ULCAST_(1) << 0)
+
 /*  EntryHI bit definition */
 #define MIPS_ENTRYHI_EHINV	(_ULCAST_(1) << 10)
 
@@ -1044,6 +1051,11 @@ do {									\
 #define write_c0_config6(val)	__write_32bit_c0_register($16, 6, val)
 #define write_c0_config7(val)	__write_32bit_c0_register($16, 7, val)
 
+#define read_c0_maar()		__read_ulong_c0_register($17, 1)
+#define write_c0_maar(val)	__write_ulong_c0_register($17, 1, val)
+#define read_c0_maari()		__read_32bit_c0_register($17, 2)
+#define write_c0_maari(val)	__write_32bit_c0_register($17, 2, val)
+
 /*
  * The WatchLo register.  There may be up to 8 of them.
  */
-- 
2.0.1
