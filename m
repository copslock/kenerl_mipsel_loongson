Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 19 Aug 2014 22:01:46 +0200 (CEST)
Received: from elvis.franken.de ([193.175.24.41]:60699 "EHLO elvis.franken.de"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6855312AbaHSUBYD2bwG (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 19 Aug 2014 22:01:24 +0200
Received: from uucp (helo=solo.franken.de)
        by elvis.franken.de with local-bsmtp (Exim 3.36 #1)
        id 1XJpat-00060S-01; Tue, 19 Aug 2014 22:01:23 +0200
Received: by solo.franken.de (Postfix, from userid 1000)
        id 28DA01D270; Tue, 19 Aug 2014 22:00:11 +0200 (CEST)
From:   Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Subject: [PATCH] SGI-IP28: fix/clean spaces.h
To:     linux-mips@linux-mips.org,
cc:     ralf@linux-mips.org
Message-Id: <20140819200011.28DA01D270@solo.franken.de>
Date:   Tue, 19 Aug 2014 22:00:11 +0200 (CEST)
Return-Path: <tsbogend@alpha.franken.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 42151
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: tsbogend@alpha.franken.de
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

Broken values for UNCAC_BASE/IO_BASE caused complete breakage of IP28
builds. Only set special PHY_OFFSET and take everything else from
generic spaces.h

Signed-off-by: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
---
 arch/mips/include/asm/mach-ip28/spaces.h |    7 -------
 1 file changed, 7 deletions(-)

diff --git a/arch/mips/include/asm/mach-ip28/spaces.h b/arch/mips/include/asm/mach-ip28/spaces.h
index 5d6a764..c4a9127 100644
--- a/arch/mips/include/asm/mach-ip28/spaces.h
+++ b/arch/mips/include/asm/mach-ip28/spaces.h
@@ -11,15 +11,8 @@
 #ifndef _ASM_MACH_IP28_SPACES_H
 #define _ASM_MACH_IP28_SPACES_H
 
-#define CAC_BASE	_AC(0xa800000000000000, UL)
-
-#define HIGHMEM_START	(~0UL)
-
 #define PHYS_OFFSET	_AC(0x20000000, UL)
 
-#define UNCAC_BASE	_AC(0xc0000000, UL)     /* 0xa0000000 + PHYS_OFFSET */
-#define IO_BASE		UNCAC_BASE
-
 #include <asm/mach-generic/spaces.h>
 
 #endif /* _ASM_MACH_IP28_SPACES_H */
