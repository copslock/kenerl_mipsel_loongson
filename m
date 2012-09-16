Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 16 Sep 2012 16:49:12 +0200 (CEST)
Received: from server19320154104.serverpool.info ([193.201.54.104]:46462 "EHLO
        hauke-m.de" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S1903242Ab2IPOso (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 16 Sep 2012 16:48:44 +0200
Received: from localhost (localhost [127.0.0.1])
        by hauke-m.de (Postfix) with ESMTP id 2238E87B9;
        Sun, 16 Sep 2012 16:48:44 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at hauke-m.de 
Received: from hauke-m.de ([127.0.0.1])
        by localhost (hauke-m.de [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id AjfuMfz-vWit; Sun, 16 Sep 2012 16:48:40 +0200 (CEST)
Received: from hauke.lan (unknown [134.102.133.158])
        by hauke-m.de (Postfix) with ESMTPSA id 188088880;
        Sun, 16 Sep 2012 16:48:40 +0200 (CEST)
From:   Hauke Mehrtens <hauke@hauke-m.de>
To:     ralf@linux-mips.org, john@phrozen.org
Cc:     linux-mips@linux-mips.org, Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 2/2] MIPS BCM47XX: select NO_EXCEPT_FILL
Date:   Sun, 16 Sep 2012 16:48:35 +0200
Message-Id: <1347806915-25132-2-git-send-email-hauke@hauke-m.de>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <1347806915-25132-1-git-send-email-hauke@hauke-m.de>
References: <1347806915-25132-1-git-send-email-hauke@hauke-m.de>
X-archive-position: 34518
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: hauke@hauke-m.de
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

The kernel is loaded to 0x80001000 so there is some space left for the
exception handlers and the kernel do not have to reserve some extra
space for them.

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 arch/mips/Kconfig |    1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index 564a06f..e372fe3 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -108,6 +108,7 @@ config BCM47XX
 	select DMA_NONCOHERENT
 	select HW_HAS_PCI
 	select IRQ_CPU
+	select NO_EXCEPT_FILL
 	select SYS_SUPPORTS_32BIT_KERNEL
 	select SYS_SUPPORTS_LITTLE_ENDIAN
 	select SYS_HAS_EARLY_PRINTK
-- 
1.7.9.5
