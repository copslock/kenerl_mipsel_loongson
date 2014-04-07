Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 08 Apr 2014 00:23:20 +0200 (CEST)
Received: from elvis.franken.de ([193.175.24.41]:51334 "EHLO elvis.franken.de"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6816906AbaDGWW6Hgabg (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 8 Apr 2014 00:22:58 +0200
Received: from uucp (helo=solo.franken.de)
        by elvis.franken.de with local-bsmtp (Exim 3.36 #1)
        id 1WXHwP-0000dj-01; Tue, 08 Apr 2014 00:22:57 +0200
Received: by solo.franken.de (Postfix, from userid 1000)
        id C58981BB731; Tue,  8 Apr 2014 00:22:26 +0200 (CEST)
From:   Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Subject: [PATCH] remove USE_GENERIC_EARLY_PRINTK_8250 for SNI_RM
To:     linux-mips@linux-mips.org,
cc:     ralf@linux-mips.org
Message-Id: <20140407222226.C58981BB731@solo.franken.de>
Date:   Tue,  8 Apr 2014 00:22:26 +0200 (CEST)
Return-Path: <tsbogend@alpha.franken.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 39691
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

SNI RM code has its own EARLY_PRINTK support no need for some generic 8250
stuff.

Signed-off-by: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
---

 arch/mips/Kconfig |    1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index b0e89cd..9f6ba47 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -674,7 +674,6 @@ config SNI_RM
 	select SYS_SUPPORTS_BIG_ENDIAN
 	select SYS_SUPPORTS_HIGHMEM
 	select SYS_SUPPORTS_LITTLE_ENDIAN
-	select USE_GENERIC_EARLY_PRINTK_8250
 	help
 	  The SNI RM200/300/400 are MIPS-based machines manufactured by
 	  Siemens Nixdorf Informationssysteme (SNI), parent company of Pyramid
