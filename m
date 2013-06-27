Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 27 Jun 2013 18:28:14 +0200 (CEST)
Received: from home.bethel-hill.org ([63.228.164.32]:53249 "EHLO
        home.bethel-hill.org" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S6835024Ab3F0Q2MzTyn8 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 27 Jun 2013 18:28:12 +0200
Received: by home.bethel-hill.org with esmtpsa (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
        (Exim 4.72)
        (envelope-from <Steven.Hill@imgtec.com>)
        id 1UsF3F-0005wa-3D; Thu, 27 Jun 2013 11:28:05 -0500
From:   "Steven J. Hill" <Steven.Hill@imgtec.com>
To:     linux-mips@linux-mips.org
Cc:     "Steven J. Hill" <Steven.Hill@imgtec.com>, ralf@linux-mips.org
Subject: [PATCH] MIPS: sead3: Disable L2 cache on SEAD-3.
Date:   Thu, 27 Jun 2013 11:27:59 -0500
Message-Id: <1372350479-509-1-git-send-email-Steven.Hill@imgtec.com>
X-Mailer: git-send-email 1.7.9.5
Return-Path: <Steven.Hill@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 37181
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

The cores used on the SEAD-3 platform do not have L2 caches, so
this option should not be turned on. Originally fixed on public
'linux-mti-3.8' release branch.

Signed-off-by: Steven J. Hill <Steven.Hill@imgtec.com>
(cherry picked from commit deb520377f74b352cc606099ca640c329a73bacb)
---
 arch/mips/Kconfig |    1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index 8f5e646..d45fd99 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -342,7 +342,6 @@ config MIPS_SEAD3
 	select DMA_NONCOHERENT
 	select IRQ_CPU
 	select IRQ_GIC
-	select MIPS_CPU_SCACHE
 	select MIPS_MSC
 	select SYS_HAS_CPU_MIPS32_R1
 	select SYS_HAS_CPU_MIPS32_R2
-- 
1.7.9.5
