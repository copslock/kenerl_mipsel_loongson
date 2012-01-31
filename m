Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 31 Jan 2012 18:21:14 +0100 (CET)
Received: from zmc.proxad.net ([212.27.53.206]:57812 "EHLO zmc.proxad.net"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1904034Ab2AaRTb (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 31 Jan 2012 18:19:31 +0100
Received: from localhost (localhost [127.0.0.1])
        by zmc.proxad.net (Postfix) with ESMTP id B0517448294;
        Tue, 31 Jan 2012 18:19:30 +0100 (CET)
X-Virus-Scanned: amavisd-new at 
Received: from zmc.proxad.net ([127.0.0.1])
        by localhost (zmc.proxad.net [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id rNAqKFTf4ZSk; Tue, 31 Jan 2012 18:19:30 +0100 (CET)
Received: from flexo.iliad.local (freebox.vlq16.iliad.fr [213.36.7.13])
        by zmc.proxad.net (Postfix) with ESMTPSA id 234BA4487EA;
        Tue, 31 Jan 2012 18:19:30 +0100 (CET)
From:   Florian Fainelli <florian@openwrt.org>
To:     ralf@linux-mips.org
Cc:     linux-mips@linux-mips.org, Florian Fainelli <florian@openwrt.org>
Subject: [PATCH 5/6] MIPS: DEC: use IS_ENABLED()
Date:   Tue, 31 Jan 2012 18:19:07 +0100
Message-Id: <1328030348-21967-6-git-send-email-florian@openwrt.org>
X-Mailer: git-send-email 1.7.5.4
In-Reply-To: <1328030348-21967-1-git-send-email-florian@openwrt.org>
References: <1328030348-21967-1-git-send-email-florian@openwrt.org>
X-archive-position: 32370
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: florian@openwrt.org
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>

Signed-off-by: Florian Fainelli <florian@openwrt.org>
---
 arch/mips/dec/prom/memory.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/mips/dec/prom/memory.c b/arch/mips/dec/prom/memory.c
index e95ff30..8c62316 100644
--- a/arch/mips/dec/prom/memory.c
+++ b/arch/mips/dec/prom/memory.c
@@ -101,7 +101,7 @@ void __init prom_free_prom_memory(void)
 	 * the first page reserved for the exception handlers.
 	 */
 
-#if defined(CONFIG_DECLANCE) || defined(CONFIG_DECLANCE_MODULE)
+#if IS_ENABLED(CONFIG_DECLANCE)
 	/*
 	 * Leave 128 KB reserved for Lance memory for
 	 * IOASIC DECstations.
-- 
1.7.5.4
