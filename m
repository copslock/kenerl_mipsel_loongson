Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 22 Sep 2015 19:11:48 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:16592 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27008556AbbIVRLqjhQ0r (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 22 Sep 2015 19:11:46 +0200
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id C51FF63F90D29;
        Tue, 22 Sep 2015 18:11:35 +0100 (IST)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 KLMAIL01.kl.imgtec.org (192.168.5.35) with Microsoft SMTP Server (TLS) id
 14.3.195.1; Tue, 22 Sep 2015 18:11:39 +0100
Received: from localhost (192.168.159.189) by LEMAIL01.le.imgtec.org
 (192.168.152.62) with Microsoft SMTP Server (TLS) id 14.3.210.2; Tue, 22 Sep
 2015 18:11:36 +0100
From:   Paul Burton <paul.burton@imgtec.com>
To:     <linux-mips@linux-mips.org>
CC:     Paul Burton <paul.burton@imgtec.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH 1/4] MIPS: Introduce API for enabling & disabling L2 prefetch
Date:   Tue, 22 Sep 2015 10:10:53 -0700
Message-ID: <1442941856-31838-2-git-send-email-paul.burton@imgtec.com>
X-Mailer: git-send-email 2.5.3
In-Reply-To: <1442941856-31838-1-git-send-email-paul.burton@imgtec.com>
References: <1442941856-31838-1-git-send-email-paul.burton@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.159.189]
Return-Path: <Paul.Burton@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 49277
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

Introduce new functions in struct bcache_ops to enable & disable L2
cache prefetching, and to retrieve the current state of L2 prefetching.
This will be used in later patches.

Signed-off-by: Paul Burton <paul.burton@imgtec.com>
---

 arch/mips/include/asm/bcache.h | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/arch/mips/include/asm/bcache.h b/arch/mips/include/asm/bcache.h
index 8c34484..a00857b 100644
--- a/arch/mips/include/asm/bcache.h
+++ b/arch/mips/include/asm/bcache.h
@@ -9,6 +9,7 @@
 #ifndef _ASM_BCACHE_H
 #define _ASM_BCACHE_H
 
+#include <linux/types.h>
 
 /* Some R4000 / R4400 / R4600 / R5000 machines may have a non-dma-coherent,
    chipset implemented caches.	On machines with other CPUs the CPU does the
@@ -18,6 +19,9 @@ struct bcache_ops {
 	void (*bc_disable)(void);
 	void (*bc_wback_inv)(unsigned long page, unsigned long size);
 	void (*bc_inv)(unsigned long page, unsigned long size);
+	void (*bc_prefetch_enable)(void);
+	void (*bc_prefetch_disable)(void);
+	bool (*bc_prefetch_is_enabled)(void);
 };
 
 extern void indy_sc_init(void);
@@ -46,6 +50,26 @@ static inline void bc_inv(unsigned long page, unsigned long size)
 	bcops->bc_inv(page, size);
 }
 
+static inline void bc_prefetch_enable(void)
+{
+	if (bcops->bc_prefetch_enable)
+		bcops->bc_prefetch_enable();
+}
+
+static inline void bc_prefetch_disable(void)
+{
+	if (bcops->bc_prefetch_disable)
+		bcops->bc_prefetch_disable();
+}
+
+static inline bool bc_prefetch_is_enabled(void)
+{
+	if (bcops->bc_prefetch_is_enabled)
+		return bcops->bc_prefetch_is_enabled();
+
+	return false;
+}
+
 #else /* !defined(CONFIG_BOARD_SCACHE) */
 
 /* Not R4000 / R4400 / R4600 / R5000.  */
@@ -54,6 +78,9 @@ static inline void bc_inv(unsigned long page, unsigned long size)
 #define bc_disable() do { } while (0)
 #define bc_wback_inv(page, size) do { } while (0)
 #define bc_inv(page, size) do { } while (0)
+#define bc_prefetch_enable() do { } while (0)
+#define bc_prefetch_disable() do { } while (0)
+#define bc_prefetch_is_enabled() 0
 
 #endif /* !defined(CONFIG_BOARD_SCACHE) */
 
-- 
2.5.3
