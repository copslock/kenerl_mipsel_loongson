Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 26 Dec 2012 22:07:03 +0100 (CET)
Received: from server19320154104.serverpool.info ([193.201.54.104]:52771 "EHLO
        hauke-m.de" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S6823426Ab2LZVGlxhaYH (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 26 Dec 2012 22:06:41 +0100
Received: from localhost (localhost [127.0.0.1])
        by hauke-m.de (Postfix) with ESMTP id 206058F62;
        Wed, 26 Dec 2012 22:06:41 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at hauke-m.de 
Received: from hauke-m.de ([127.0.0.1])
        by localhost (hauke-m.de [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id k0CQJ6mDoOyz; Wed, 26 Dec 2012 22:06:34 +0100 (CET)
Received: from hauke-desktop.lan (spit-414.wohnheim.uni-bremen.de [134.102.133.158])
        by hauke-m.de (Postfix) with ESMTPSA id 582248F60;
        Wed, 26 Dec 2012 22:06:34 +0100 (CET)
From:   Hauke Mehrtens <hauke@hauke-m.de>
To:     john@phrozen.org, ralf@linux-mips.org
Cc:     linux-mips@linux-mips.org, cernekee@gmail.com,
        Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH resend 2/2] MIPS: BCM47XX: select NO_EXCEPT_FILL
Date:   Wed, 26 Dec 2012 22:06:18 +0100
Message-Id: <1356555978-2660-2-git-send-email-hauke@hauke-m.de>
X-Mailer: git-send-email 1.7.10.4
In-Reply-To: <1356555978-2660-1-git-send-email-hauke@hauke-m.de>
References: <1356555978-2660-1-git-send-email-hauke@hauke-m.de>
X-archive-position: 35333
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
index 8e1fd8a..08c93f8 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -116,6 +116,7 @@ config BCM47XX
 	select FW_CFE
 	select HW_HAS_PCI
 	select IRQ_CPU
+	select NO_EXCEPT_FILL
 	select SYS_SUPPORTS_32BIT_KERNEL
 	select SYS_SUPPORTS_LITTLE_ENDIAN
 	select SYS_HAS_EARLY_PRINTK
-- 
1.7.10.4
