Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 08 Feb 2013 11:48:17 +0100 (CET)
Received: from zmc.proxad.net ([212.27.53.206]:35964 "EHLO zmc.proxad.net"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6818020Ab3BHKsPfRrOC (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 8 Feb 2013 11:48:15 +0100
Received: from localhost (localhost [127.0.0.1])
        by zmc.proxad.net (Postfix) with ESMTP id D867A1B43C1;
        Fri,  8 Feb 2013 11:48:14 +0100 (CET)
X-Virus-Scanned: amavisd-new at localhost
Received: from zmc.proxad.net ([127.0.0.1])
        by localhost (zmc.proxad.net [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id lPSpyWiHGz59; Fri,  8 Feb 2013 11:48:14 +0100 (CET)
Received: from flexo.iliad.local (freebox.vlq16.iliad.fr [213.36.7.13])
        by zmc.proxad.net (Postfix) with ESMTPSA id 31C2EC194E3;
        Fri,  8 Feb 2013 11:48:14 +0100 (CET)
From:   Florian Fainelli <florian@openwrt.org>
To:     linux-mips@linux-mips.org
Cc:     ralf@linux-mips.org, blogic@openwrt.org,
        Florian Fainelli <florian@openwrt.org>
Subject: [PATCH] MIPS: SMTC: fix implicit declaration of set_vi_handler
Date:   Fri,  8 Feb 2013 11:45:14 +0100
Message-Id: <1360320314-9255-1-git-send-email-florian@openwrt.org>
X-Mailer: git-send-email 1.7.10.4
X-archive-position: 35727
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: florian@openwrt.org
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
Return-Path: <linux-mips-bounce@linux-mips.org>

This patch fixes the following implicit declaration while building with
MIPS SMTC support enabled:

arch/mips/kernel/smtc.c: In function 'setup_cross_vpe_interrupts':
arch/mips/kernel/smtc.c:1205:2: error: implicit declaration of function
'set_vi_handler' [-Werror=implicit-function-declaration]
cc1: all warnings being treated as errors

Signed-off-by: Florian Fainelli <florian@openwrt.org>
---
Ralf, John,

This is applicable to both mips-for-linux-next and master.

 arch/mips/kernel/smtc.c |    1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/mips/kernel/smtc.c b/arch/mips/kernel/smtc.c
index 1c152a9..7186222 100644
--- a/arch/mips/kernel/smtc.c
+++ b/arch/mips/kernel/smtc.c
@@ -41,6 +41,7 @@
 #include <asm/addrspace.h>
 #include <asm/smtc.h>
 #include <asm/smtc_proc.h>
+#include <asm/setup.h>
 
 /*
  * SMTC Kernel needs to manipulate low-level CPU interrupt mask
-- 
1.7.10.4
