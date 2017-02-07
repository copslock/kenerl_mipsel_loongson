Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 07 Feb 2017 06:59:04 +0100 (CET)
Received: from smtp.gentoo.org ([140.211.166.183]:33444 "EHLO smtp.gentoo.org"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23991932AbdBGF6L3oPLr (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 7 Feb 2017 06:58:11 +0100
Received: from helcaraxe.arda (c-73-201-78-97.hsd1.md.comcast.net [73.201.78.97])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kumba)
        by smtp.gentoo.org (Postfix) with ESMTPSA id F417C34169B;
        Tue,  7 Feb 2017 05:58:04 +0000 (UTC)
From:   Joshua Kinard <kumba@gentoo.org>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     Linux/MIPS <linux-mips@linux-mips.org>
Subject: [PATCH 2/3] MIPS: Xtalk: Clean-up xtalk.h macros
Date:   Tue,  7 Feb 2017 00:57:50 -0500
Message-Id: <20170207055751.8134-3-kumba@gentoo.org>
X-Mailer: git-send-email 2.11.1
In-Reply-To: <20170207055751.8134-1-kumba@gentoo.org>
References: <20170207055751.8134-1-kumba@gentoo.org>
Return-Path: <kumba@gentoo.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 56672
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: kumba@gentoo.org
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

From: Joshua Kinard <kumba@gentoo.org>

Clean-up several macros in arch/mips/include/asm/xtalk/xtalk.h:
 - Hex addresses are lowercased.
 - Added whitespace around several operators.
 - Removed bridge_probe declaration.

Signed-off-by: Joshua Kinard <kumba@gentoo.org>
---
 arch/mips/include/asm/xtalk/xtalk.h | 23 +++++++----------------
 1 file changed, 7 insertions(+), 16 deletions(-)

diff --git a/arch/mips/include/asm/xtalk/xtalk.h b/arch/mips/include/asm/xtalk/xtalk.h
index 9125bd85514d..627ed91b2880 100644
--- a/arch/mips/include/asm/xtalk/xtalk.h
+++ b/arch/mips/include/asm/xtalk/xtalk.h
@@ -21,24 +21,15 @@
 #define XWIDGET_MFG_NUM_NONE	-1
 
 /* It is often convenient to fold the XIO target port */
-#define XIO_NOWHERE	(0xFFFFFFFFFFFFFFFFull)
-#define XIO_ADDR_BITS	(0x0000FFFFFFFFFFFFull)
-#define XIO_PORT_BITS	(0xF000000000000000ull)
+#define XIO_NOWHERE	(0xffffffffffffffffULL)
+#define XIO_ADDR_BITS	(0x0000ffffffffffffULL)
+#define XIO_PORT_BITS	(0xf000000000000000ULL)
 #define XIO_PORT_SHIFT	(60)
 
-#define XIO_PACKED(x)	(((x)&XIO_PORT_BITS) != 0)
-#define XIO_ADDR(x)	((x)&XIO_ADDR_BITS)
-#define XIO_PORT(x)	((s8)(((x)&XIO_PORT_BITS) >> XIO_PORT_SHIFT))
-#define XIO_PACK(p, o)	((((uint64_t)(p))<<XIO_PORT_SHIFT) | ((o)&XIO_ADDR_BITS))
-
-#ifdef CONFIG_PCI
-extern int bridge_probe(nasid_t nasid, int widget, int masterwid);
-#else
-static inline int bridge_probe(nasid_t nasid, int widget, int masterwid)
-{
-	return 0;
-}
-#endif
+#define XIO_PACKED(x)	(((x) & XIO_PORT_BITS) != 0)
+#define XIO_ADDR(x)	((x) & XIO_ADDR_BITS)
+#define XIO_PORT(x)	((s8)(((x) & XIO_PORT_BITS) >> XIO_PORT_SHIFT))
+#define XIO_PACK(p, o)	((((u64)(p)) << XIO_PORT_SHIFT) | ((o) & XIO_ADDR_BITS))
 
 #endif /* !__ASSEMBLY__ */
 
-- 
2.11.1
