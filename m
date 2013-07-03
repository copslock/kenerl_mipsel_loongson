Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 03 Jul 2013 20:26:00 +0200 (CEST)
Received: from home.bethel-hill.org ([63.228.164.32]:37613 "EHLO
        home.bethel-hill.org" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S6827447Ab3GCSZ7E4n2w (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 3 Jul 2013 20:25:59 +0200
Received: by home.bethel-hill.org with esmtpsa (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
        (Exim 4.72)
        (envelope-from <Steven.Hill@imgtec.com>)
        id 1UuRkU-0006FW-TR; Wed, 03 Jul 2013 13:25:50 -0500
From:   "Steven J. Hill" <Steven.Hill@imgtec.com>
To:     linux-mips@linux-mips.org
Cc:     "Steven J. Hill" <Steven.Hill@imgtec.com>, ralf@linux-mips.org
Subject: [PATCH v3] MIPS: Fix multiple definitions of UNCAC_BASE.
Date:   Wed,  3 Jul 2013 13:25:46 -0500
Message-Id: <1372875946-17311-1-git-send-email-Steven.Hill@imgtec.com>
X-Mailer: git-send-email 1.7.9.5
Return-Path: <Steven.Hill@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 37263
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: Steven.Hill@imgtec.com
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

From: "Steven J. Hill" <Steven.Hill@imgtec.com>

Fix build error below:

arch/mips/include/asm/mach-generic/spaces.h:29:0: warning:
"UNCAC_BASE" redefined [enabled by default]
In file included from arch/mips/include/asm/addrspace.h:13:0,
                 from arch/mips/include/asm/barrier.h:11,
                 from arch/mips/include/asm/bitops.h:18,
                 from include/linux/bitops.h:22,
                 from include/linux/kernel.h:10,
                 from include/asm-generic/bug.h:13,
                 from arch/mips/include/asm/bug.h:41,
                 from include/linux/bug.h:4,
                 from include/linux/page-flags.h:9,
                 from kernel/bounds.c:9:
arch/mips/include/asm/mach-ar7/spaces.h:20:0: note: this is the
location of the previous definition

Signed-off-by: Steven J. Hill <Steven.Hill@imgtec.com>
---
Changes in v3: Fix up multiple definiition errors for 32-bit.

 arch/mips/include/asm/mach-generic/spaces.h |    4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/mips/include/asm/mach-generic/spaces.h b/arch/mips/include/asm/mach-generic/spaces.h
index 5b2f2e6..9488fa5 100644
--- a/arch/mips/include/asm/mach-generic/spaces.h
+++ b/arch/mips/include/asm/mach-generic/spaces.h
@@ -25,8 +25,12 @@
 #else
 #define CAC_BASE		_AC(0x80000000, UL)
 #endif
+#ifndef IO_BASE
 #define IO_BASE			_AC(0xa0000000, UL)
+#endif
+#ifndef UNCAC_BASE
 #define UNCAC_BASE		_AC(0xa0000000, UL)
+#endif
 
 #ifndef MAP_BASE
 #ifdef CONFIG_KVM_GUEST
-- 
1.7.9.5
