Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 17 Jul 2014 10:24:30 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:38856 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S6861303AbaGQIWBUfA6b (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 17 Jul 2014 10:22:01 +0200
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id 73559701B3D8D
        for <linux-mips@linux-mips.org>; Thu, 17 Jul 2014 09:21:52 +0100 (IST)
Received: from KLMAIL02.kl.imgtec.org (10.40.60.222) by KLMAIL01.kl.imgtec.org
 (192.168.5.35) with Microsoft SMTP Server (TLS) id 14.3.195.1; Thu, 17 Jul
 2014 09:21:54 +0100
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 klmail02.kl.imgtec.org (10.40.60.222) with Microsoft SMTP Server (TLS) id
 14.3.195.1; Thu, 17 Jul 2014 09:21:54 +0100
Received: from mchandras-linux.le.imgtec.org (192.168.154.67) by
 LEMAIL01.le.imgtec.org (192.168.152.62) with Microsoft SMTP Server (TLS) id
 14.3.195.1; Thu, 17 Jul 2014 09:21:53 +0100
From:   Markos Chandras <markos.chandras@imgtec.com>
To:     <linux-mips@linux-mips.org>
CC:     Jeffrey Deans <jeffrey.deans@imgtec.com>,
        Markos Chandras <markos.chandras@imgtec.com>
Subject: [PATCH 7/7] MIPS: GIC: Fix GICBIS macro
Date:   Thu, 17 Jul 2014 09:20:59 +0100
Message-ID: <1405585259-24941-8-git-send-email-markos.chandras@imgtec.com>
X-Mailer: git-send-email 2.0.0
In-Reply-To: <1405585259-24941-1-git-send-email-markos.chandras@imgtec.com>
References: <1405585259-24941-1-git-send-email-markos.chandras@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.154.67]
Return-Path: <Markos.Chandras@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 41264
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

From: Jeffrey Deans <jeffrey.deans@imgtec.com>

The GICBIS macro could update the GIC registers incorrectly, depending
on the data value passed in:

* Bits were only OR'd into the register data, so register fields could
  not be cleared.

* Bits were OR'd into the register data without masking the data to the
  correct field width, corrupting adjacent bits.

Signed-off-by: Jeffrey Deans <jeffrey.deans@imgtec.com>
Signed-off-by: Markos Chandras <markos.chandras@imgtec.com>
---
 arch/mips/include/asm/gic.h | 21 +++++++++++----------
 1 file changed, 11 insertions(+), 10 deletions(-)

diff --git a/arch/mips/include/asm/gic.h b/arch/mips/include/asm/gic.h
index 8b30befd99d6..3f20b2111d56 100644
--- a/arch/mips/include/asm/gic.h
+++ b/arch/mips/include/asm/gic.h
@@ -43,18 +43,17 @@
 #ifdef GICISBYTELITTLEENDIAN
 #define GICREAD(reg, data)	((data) = (reg), (data) = le32_to_cpu(data))
 #define GICWRITE(reg, data)	((reg) = cpu_to_le32(data))
-#define GICBIS(reg, bits)			\
-	({unsigned int data;			\
-		GICREAD(reg, data);		\
-		data |= bits;			\
-		GICWRITE(reg, data);		\
-	})
-
 #else
 #define GICREAD(reg, data)	((data) = (reg))
 #define GICWRITE(reg, data)	((reg) = (data))
-#define GICBIS(reg, bits)	((reg) |= (bits))
 #endif
+#define GICBIS(reg, mask, bits)			\
+	do { u32 data;				\
+		GICREAD((reg), data);		\
+		data &= ~(mask);		\
+		data |= ((bits) & (mask));	\
+		GICWRITE((reg), data);		\
+	} while (0)
 
 
 /* GIC Address Space */
@@ -170,13 +169,15 @@
 #define GIC_SH_SET_POLARITY_OFS		0x0100
 #define GIC_SET_POLARITY(intr, pol) \
 	GICBIS(GIC_REG_ADDR(SHARED, GIC_SH_SET_POLARITY_OFS + \
-		GIC_INTR_OFS(intr)), (pol) << GIC_INTR_BIT(intr))
+		GIC_INTR_OFS(intr)), (1 << GIC_INTR_BIT(intr)), \
+		(pol) << GIC_INTR_BIT(intr))
 
 /* Triggering : Reset Value is always 0 */
 #define GIC_SH_SET_TRIGGER_OFS		0x0180
 #define GIC_SET_TRIGGER(intr, trig) \
 	GICBIS(GIC_REG_ADDR(SHARED, GIC_SH_SET_TRIGGER_OFS + \
-		GIC_INTR_OFS(intr)), (trig) << GIC_INTR_BIT(intr))
+		GIC_INTR_OFS(intr)), (1 << GIC_INTR_BIT(intr)), \
+		(trig) << GIC_INTR_BIT(intr))
 
 /* Mask manipulation */
 #define GIC_SH_SMASK_OFS		0x0380
-- 
2.0.0
