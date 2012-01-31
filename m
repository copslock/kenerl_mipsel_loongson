Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 31 Jan 2012 18:22:22 +0100 (CET)
Received: from zmc.proxad.net ([212.27.53.206]:57808 "EHLO zmc.proxad.net"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1904032Ab2AaRTa (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 31 Jan 2012 18:19:30 +0100
Received: from localhost (localhost [127.0.0.1])
        by zmc.proxad.net (Postfix) with ESMTP id 7D47B434D36;
        Tue, 31 Jan 2012 18:19:30 +0100 (CET)
X-Virus-Scanned: amavisd-new at 
Received: from zmc.proxad.net ([127.0.0.1])
        by localhost (zmc.proxad.net [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id NtNrM15GgxIW; Tue, 31 Jan 2012 18:19:30 +0100 (CET)
Received: from flexo.iliad.local (freebox.vlq16.iliad.fr [213.36.7.13])
        by zmc.proxad.net (Postfix) with ESMTPSA id 132E8448602;
        Tue, 31 Jan 2012 18:19:30 +0100 (CET)
From:   Florian Fainelli <florian@openwrt.org>
To:     ralf@linux-mips.org
Cc:     linux-mips@linux-mips.org, Florian Fainelli <florian@openwrt.org>
Subject: [PATCH 4/6] MIPS: TX49XX: use IS_ENABLED()
Date:   Tue, 31 Jan 2012 18:19:06 +0100
Message-Id: <1328030348-21967-5-git-send-email-florian@openwrt.org>
X-Mailer: git-send-email 1.7.5.4
In-Reply-To: <1328030348-21967-1-git-send-email-florian@openwrt.org>
References: <1328030348-21967-1-git-send-email-florian@openwrt.org>
X-archive-position: 32373
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: florian@openwrt.org
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>

Signed-off-by: Florian Fainelli <florian@openwrt.org>
---
 arch/mips/include/asm/mach-tx49xx/mangle-port.h |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/mips/include/asm/mach-tx49xx/mangle-port.h b/arch/mips/include/asm/mach-tx49xx/mangle-port.h
index 5e6912f..490867b 100644
--- a/arch/mips/include/asm/mach-tx49xx/mangle-port.h
+++ b/arch/mips/include/asm/mach-tx49xx/mangle-port.h
@@ -9,7 +9,7 @@
 #define ioswabb(a, x)		(x)
 #define __mem_ioswabb(a, x)	(x)
 #if defined(CONFIG_TOSHIBA_RBTX4939) && \
-	(defined(CONFIG_SMC91X) || defined(CONFIG_SMC91X_MODULE)) && \
+	IS_ENABLED(CONFIG_SMC91X) && \
 	defined(__BIG_ENDIAN)
 #define NEEDS_TXX9_IOSWABW
 extern u16 (*ioswabw)(volatile u16 *a, u16 x);
-- 
1.7.5.4
