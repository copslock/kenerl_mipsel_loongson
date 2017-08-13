Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 13 Aug 2017 04:52:54 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:22906 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23992036AbdHMCv5OCcw6 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 13 Aug 2017 04:51:57 +0200
Received: from hhmail02.hh.imgtec.org (unknown [10.100.10.20])
        by Forcepoint Email with ESMTPS id 6D67FF0D4C63B;
        Sun, 13 Aug 2017 03:51:49 +0100 (IST)
Received: from localhost (10.20.79.142) by hhmail02.hh.imgtec.org
 (10.100.10.21) with Microsoft SMTP Server (TLS) id 14.3.294.0; Sun, 13 Aug
 2017 03:51:50 +0100
From:   Paul Burton <paul.burton@imgtec.com>
To:     <linux-mips@linux-mips.org>
CC:     Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@imgtec.com>
Subject: [PATCH 06/19] MIPS: CPS: Introduce register modify (set/clear/change) accessors
Date:   Sat, 12 Aug 2017 19:49:30 -0700
Message-ID: <20170813024943.14989-7-paul.burton@imgtec.com>
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
X-archive-position: 59502
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

For read-write registers introduce accessor functions that simplify the
task of modifying a subset of bits within the register. set_* functions
set bits to 1, clear_* functions clear bits to 0 & change_* functions
set bits specified in a mask to an arbitrary value.

Signed-off-by: Paul Burton <paul.burton@imgtec.com>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: linux-mips@linux-mips.org
---

 arch/mips/include/asm/mips-cps.h | 23 ++++++++++++++++++++++-
 1 file changed, 22 insertions(+), 1 deletion(-)

diff --git a/arch/mips/include/asm/mips-cps.h b/arch/mips/include/asm/mips-cps.h
index 6ced7ba102b6..7ae32ad15599 100644
--- a/arch/mips/include/asm/mips-cps.h
+++ b/arch/mips/include/asm/mips-cps.h
@@ -71,6 +71,26 @@ static inline void write_##unit##_##name(uint##sz##_t val)		\
 	}								\
 }
 
+#define CPS_ACCESSOR_M(unit, sz, name)					\
+static inline void change_##unit##_##name(uint##sz##_t mask,		\
+					  uint##sz##_t val)		\
+{									\
+	uint##sz##_t reg_val = read_##unit##_##name();			\
+	reg_val &= ~mask;						\
+	reg_val |= val;							\
+	write_##unit##_##name(reg_val);					\
+}									\
+									\
+static inline void set_##unit##_##name(uint##sz##_t val)		\
+{									\
+	change_##unit##_##name(val, val);				\
+}									\
+									\
+static inline void clear_##unit##_##name(uint##sz##_t val)		\
+{									\
+	change_##unit##_##name(val, 0);					\
+}
+
 #define CPS_ACCESSOR_RO(unit, sz, off, name)				\
 	CPS_ACCESSOR_A(unit, off, name)					\
 	CPS_ACCESSOR_R(unit, sz, name)
@@ -82,6 +102,7 @@ static inline void write_##unit##_##name(uint##sz##_t val)		\
 #define CPS_ACCESSOR_RW(unit, sz, off, name)				\
 	CPS_ACCESSOR_A(unit, off, name)					\
 	CPS_ACCESSOR_R(unit, sz, name)					\
-	CPS_ACCESSOR_W(unit, sz, name)
+	CPS_ACCESSOR_W(unit, sz, name)					\
+	CPS_ACCESSOR_M(unit, sz, name)
 
 #endif /* __MIPS_ASM_MIPS_CPS_H__ */
-- 
2.14.0
