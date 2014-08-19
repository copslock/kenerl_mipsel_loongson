Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 19 Aug 2014 22:01:26 +0200 (CEST)
Received: from elvis.franken.de ([193.175.24.41]:60698 "EHLO elvis.franken.de"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6855209AbaHSUBYDBuwA (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 19 Aug 2014 22:01:24 +0200
Received: from uucp (helo=solo.franken.de)
        by elvis.franken.de with local-bsmtp (Exim 3.36 #1)
        id 1XJpat-00060S-00; Tue, 19 Aug 2014 22:01:23 +0200
Received: by solo.franken.de (Postfix, from userid 1000)
        id C75831D26C; Tue, 19 Aug 2014 22:00:07 +0200 (CEST)
From:   Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Subject: [PATCH] SGI-IP28: select correct L1_CACHE_SHIFT
To:     linux-mips@linux-mips.org,
cc:     ralf@linux-mips.org
Message-Id: <20140819200007.C75831D26C@solo.franken.de>
Date:   Tue, 19 Aug 2014 22:00:07 +0200 (CEST)
Return-Path: <tsbogend@alpha.franken.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 42150
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

IP28 has 128 byte cache lines.

Signed-off-by: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
---

 arch/mips/Kconfig |    1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index 748126a..01c0389 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -546,6 +546,7 @@ config SGI_IP28
 	# select SYS_HAS_EARLY_PRINTK
 	select SYS_SUPPORTS_64BIT_KERNEL
 	select SYS_SUPPORTS_BIG_ENDIAN
+	select MIPS_L1_CACHE_SHIFT_7
       help
         This is the SGI Indigo2 with R10000 processor.  To compile a Linux
         kernel that runs on these, say Y here.
