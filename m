Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 23 Feb 2014 17:37:52 +0100 (CET)
Received: from mail-ea0-f175.google.com ([209.85.215.175]:54527 "EHLO
        mail-ea0-f175.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6823121AbaBWQhuHrmiP (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 23 Feb 2014 17:37:50 +0100
Received: by mail-ea0-f175.google.com with SMTP id z10so2258511ead.6
        for <linux-mips@linux-mips.org>; Sun, 23 Feb 2014 08:37:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=1daTD3SaDIKH6Xm7RwnvKF6KTCctqi+aTglO4KjUDcY=;
        b=qNcpsqxU2ppetXCTwl5UriMyUOq92hHxOfS4srdmklDb0n82qdMm3PTWv0sWHtTI34
         PnzLAIP96Gdq+3pY36lzdxB3i/DS/b0ASymRAidL2OZXKGQqgKv7NDfb9XbXnmxNXICK
         so4jdsPVE8Di/y1WNKA3JdoXthJXEOCLPuv4Lwf7oMO05gLOBauykNaUE8dqwSA2+0fE
         IyJ67HxR0LH2dL3YgkXbnhVXcMg+ynXu8Nh7+1lOQwacAsEx9kj4TTbu7HCDuL9OzD+F
         ft1hQrmtonvccHoRc+ySCGjQWlLv6SkOQIG6s4WL54RBiKW4vURpSdLlJ8gepht9bKFe
         e4Mw==
X-Received: by 10.14.216.193 with SMTP id g41mr19966773eep.13.1393173464832;
        Sun, 23 Feb 2014 08:37:44 -0800 (PST)
Received: from localhost.localdomain (p4FD8DB84.dip0.t-ipconnect.de. [79.216.219.132])
        by mx.google.com with ESMTPSA id m9sm52893505eeh.3.2014.02.23.08.37.43
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 23 Feb 2014 08:37:44 -0800 (PST)
From:   Manuel Lauss <manuel.lauss@gmail.com>
To:     Linux-MIPS <linux-mips@linux-mips.org>
Cc:     Manuel Lauss <manuel.lauss@gmail.com>
Subject: [PATCH] MIPS: remove SYS_SUPPORTS_APM_EMULATION
Date:   Sun, 23 Feb 2014 17:37:40 +0100
Message-Id: <1393173460-840-1-git-send-email-manuel.lauss@gmail.com>
X-Mailer: git-send-email 1.9.0
Return-Path: <manuel.lauss@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 39376
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: manuel.lauss@gmail.com
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

nothing in the MIPS tree needs it, so get rid of it.

Signed-off-by: Manuel Lauss <manuel.lauss@gmail.com>
---
 arch/mips/Kconfig | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index 623fd96..2bf36d8 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -65,7 +65,6 @@ config MIPS_ALCHEMY
 	select DMA_MAYBE_COHERENT	# Au1000,1500,1100 aren't, rest is
 	select SYS_HAS_CPU_MIPS32_R1
 	select SYS_SUPPORTS_32BIT_KERNEL
-	select SYS_SUPPORTS_APM_EMULATION
 	select ARCH_REQUIRE_GPIOLIB
 	select SYS_SUPPORTS_ZBOOT
 	select USB_ARCH_HAS_OHCI
@@ -995,9 +994,6 @@ endchoice
 config EXPORT_UASM
 	bool
 
-config SYS_SUPPORTS_APM_EMULATION
-	bool
-
 config SYS_SUPPORTS_BIG_ENDIAN
 	bool
 
-- 
1.9.0
