Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 25 Mar 2010 11:43:18 +0100 (CET)
Received: from zmc.proxad.net ([212.27.53.206]:46228 "EHLO zmc.proxad.net"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1491897Ab0CYKnE (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 25 Mar 2010 11:43:04 +0100
Received: from localhost (localhost [127.0.0.1])
        by zmc.proxad.net (Postfix) with ESMTP id 46EAA34181AA;
        Thu, 25 Mar 2010 11:43:04 +0100 (CET)
X-Virus-Scanned: amavisd-new at 
Received: from zmc.proxad.net ([127.0.0.1])
        by localhost (zmc.proxad.net [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id ofTybMLMfipS; Thu, 25 Mar 2010 11:43:04 +0100 (CET)
Received: from flexo.localnet (bobafett.staff.proxad.net [213.228.1.121])
        by zmc.proxad.net (Postfix) with ESMTPSA id C76DF3418193;
        Thu, 25 Mar 2010 11:43:02 +0100 (CET)
From:   Florian Fainelli <ffainelli@freebox.fr>
Date:   Thu, 25 Mar 2010 11:42:41 +0100
Subject: [PATCH 2/2] MIPS: make broadcom SoC support naming consistent
MIME-Version: 1.0
X-UID:  26409
X-Length: 1192
Organization: Freebox
To:     linux-mips@linux-mips.org
Cc:     ralf@linux-mips.org
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <201003251142.41335.ffainelli@freebox.fr>
Return-Path: <ffainelli@freebox.fr>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 26312
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ffainelli@freebox.fr
Precedence: bulk
X-list: linux-mips


Signed-off-by: Florian Fainelli <ffainelli@freebox.fr>
---
diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index 29e8692..7297d10 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -49,7 +49,7 @@ config AR7
 	  family: TNETD7100, 7200 and 7300.
 
 config BCM47XX
-	bool "BCM47XX based boards"
+	bool "Broadcom BCM47XX based boards"
 	select CEVT_R4K
 	select CSRC_R4K
 	select DMA_NONCOHERENT
